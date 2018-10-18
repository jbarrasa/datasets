CREATE INDEX ON :Profession(name);

USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM "file:///name.basics.tsv" AS row FIELDTERMINATOR '\t'
WITH row WHERE row.knownForTitles <> "\\N" //we exclude nodes that will be orphan
CREATE (p:Person { pid: row.nconst }) 
SET p.name = row.primaryName, p.yob = toInteger(row.birthYear), p.yod = case when row.deathYear= "\\N" then null else toInteger(row.deathYear) end , p.kf = split(row.knownForTitles,","), p.pp = split(row.primaryProfession,",");

CREATE INDEX ON :Genre(name);

USING PERIODIC COMMIT 10000
load csv with headers from "file:///title.basics.tsv" as row fieldterminator '\t'
with row where row.titleType <> "tvEpisode" //we just want the series, not each episode
create (m:Title { tid: row.tconst }) SET m.title = row.primaryTitle, m.runTimeMinutes = toInteger(row.runtimeMinutes), m.year = row.startYear, m.adult = CASE row.isAdult WHEN '0' THEN false ELSE true END 
WITH row, m, split(row.genres,",") as genres
UNWIND genres as genre 
with m, genre  where genre <> "\\N"
MERGE (g:Genre { name: genre })
CREATE (m)-[:HAS_GENRE]->(g) ;


CREATE INDEX ON :Title(tid);
CREATE INDEX ON :Person(pid);


call apoc.periodic.commit("
MATCH (p:Person) WHERE exists(p.kf)
WITH p LIMIT $batchSize
UNWIND p.kf as titleId
MERGE (m:Title { tid: titleId })
CREATE (p)-[:IN_TITLE]->(m)
WITH DISTINCT p REMOVE p.kf
RETURN COUNT(p)
",{batchSize:10000});


call apoc.periodic.commit("
MATCH (p:Person) WHERE exists(p.pp)
WITH p LIMIT $batchSize
UNWIND p.pp as profession
MERGE (pr:Profession { pname: profession })
CREATE (p)-[:HAS_MAIN_PRO]->(pr)
WITH DISTINCT p REMOVE p.pp
RETURN COUNT(p)
",{batchSize:10000});


CREATE INDEX ON :Title(title);
CREATE INDEX ON :Person(name);
