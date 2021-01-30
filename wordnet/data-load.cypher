CREATE CONSTRAINT n10s_unique_uri ON (r:Resource) ASSERT r.uri IS UNIQUE


call n10s.graphconfig.init();

//create namespace prefix definitions from wordnedt file header
call n10s.nsprefixes.addFromText("
@prefix dct: <http://purl.org/dc/terms/> .
@prefix ili: <http://ili.globalwordnet.org/ili/> .
@prefix lime: <http://www.w3.org/ns/lemon/lime#> .
@prefix ontolex: <http://www.w3.org/ns/lemon/ontolex#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix sch: <http://schema.org/> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix synsem: <http://www.w3.org/ns/lemon/synsem#> .
@prefix wn: <https://globalwordnet.github.io/schemas/wn#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix dct: <http://purl.org/dc/terms/> .
@prefix pwnlemma: <https://en-word.net/lemma/> .
@prefix pwnid: <https://en-word.net/id/> .
");

//replace my url with yours
call n10s.rdf.import.fetch("file:///Users/jb/Downloads/english-wordnet-2020.ttl.gz","Turtle");

//Remove lexicon node. It's just a container for all elements. Creates a dense node and adds no value
match (r:Resource { uri: "https://en-word.net/"}) detach delete r ;

//add extra namespace prefix definition
call n10s.nsprefixes.add("li","http://www.lexinfo.net/ontology/2.0/lexinfo#") ;


//convert POS into labels for lexical entries
match (le:ontolex__LexicalEntry)-[:wn__partOfSpeech]->(pos)
with le, apoc.text.join([x in split(apoc.text.replace(pos.uri,".*#(.*)$","$1"),"_") | apoc.text.capitalize(x)],"") as posAsString
set le.wn__partOfSpeech = posAsString
with le, posAsString
call apoc.create.addLabels(le, [n10s.rdf.shortFormFromFullUri("http://www.lexinfo.net/ontology/2.0/lexinfo#" + posAsString)]) yield node
return count(node);

//convert POS into labels for lexical concepts 
match (le:ontolex__LexicalConcept)-[:wn__partOfSpeech]->(pos)
with le, apoc.text.join([x in split(apoc.text.replace(pos.uri,".*#(.*)$","$1"),"_") | apoc.text.capitalize(x)],"") as posAsString
set le.wn__partOfSpeech = posAsString
with le, posAsString
call apoc.create.addLabels(le, [n10s.rdf.shortFormFromFullUri("http://www.lexinfo.net/ontology/2.0/lexinfo#" + posAsString)]) yield node
return count(node);

//now we can clean old POS
match ()-[r:wn__partOfSpeech]->(pos)
delete r, pos ;


//This proves that there's nor reason to not have the canonical form as a property of the LexicalEntry
MATCH (n:ontolex__LexicalEntry)-[:ontolex__canonicalForm]-(cf)
with n, count(distinct cf.ontolex__writtenRep) as can
return count(n),min(can), max(can), avg(can) ;

// So let's do it
MATCH (n:ontolex__LexicalEntry)-[:ontolex__canonicalForm]-(cf)
with n, collect(distinct cf.ontolex__writtenRep) as canonicals
SET n.ontolex__canonicalForm = canonicals[0] ;


// and now let's delete the canonical form nodes 
MATCH (:ontolex__LexicalEntry)-[rel:ontolex__canonicalForm]-(cf)
DELETE rel, cf ;


//this proves that the definition is unique to concepts so no reason not to have it as a property of the concept 
MATCH (n:ontolex__LexicalConcept)-[:wn__definition]-(cf)
with n, count(distinct cf.rdf__value) as can
return count(n),min(can), max(can), avg(can) ;

//So let's do it 
MATCH (n:ontolex__LexicalConcept)-[:wn__definition]-(def)
with n, collect(distinct def.rdf__value) as definitions
SET n.wn__definition = definitions[0] ;


//and now let's delete definition nodes 
MATCH (:ontolex__LexicalConcept)-[rel:wn__definition]-(def)
DELETE rel, def ;

//copying examples as properties 
MATCH (n:ontolex__LexicalConcept)-[:wn__example]->(ex) 
WHERE ex.rdf__value starts with "\"" and ex.rdf__value ends with "\""
WITH n, collect(distinct substring(ex.rdf__value, 1, size(ex.rdf__value)-2)) as examples
SET n.wn__example = examples ;


// deleting example nodes 
MATCH (:ontolex__LexicalConcept)-[rel:wn__example]->(ex) 
DELETE rel, ex ;


// Delete links to global wordnet resources. This is an optional step depending on how you intend to use the graph.
// If it's relevant for your use you should keep them.
MATCH (:Resource)-[r:wn__ili]->(s) 
DELETE r,s ;
