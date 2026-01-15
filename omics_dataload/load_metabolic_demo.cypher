// =====================================================================
// Metabolic demo dataset - LOAD CSV import
// Place the CSVs in Neo4j's import directory (e.g., $NEO4J_HOME/import)
// Then run this script.
// =====================================================================

// ----------------------------
// Optional: wipe target labels (comment out if not desired)
// ----------------------------
// MATCH (n) WHERE any(l IN labels(n) WHERE l IN [
//   'Project','Tissue','Disease','EFO','Sample','Experiment','Comparison','Gene','ID','Protein','GO','Pathway'
// ]) DETACH DELETE n;

// ----------------------------
// Constraints (Neo4j 5+ syntax)
// ----------------------------
CREATE CONSTRAINT project_sid IF NOT EXISTS FOR (n:Project) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT tissue_sid  IF NOT EXISTS FOR (n:Tissue)  REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT disease_sid IF NOT EXISTS FOR (n:Disease) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT efo_sid     IF NOT EXISTS FOR (n:EFO)     REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT sample_sid  IF NOT EXISTS FOR (n:Sample)  REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT experiment_sid IF NOT EXISTS FOR (n:Experiment) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT comparison_sid IF NOT EXISTS FOR (n:Comparison) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT gene_sid IF NOT EXISTS FOR (n:Gene) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT gene_symbol IF NOT EXISTS FOR (n:Gene) REQUIRE n.symbol IS UNIQUE;
CREATE CONSTRAINT protein_sid IF NOT EXISTS FOR (n:Protein) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT go_sid IF NOT EXISTS FOR (n:GO) REQUIRE n.sid IS UNIQUE;
CREATE CONSTRAINT pathway_sid IF NOT EXISTS FOR (n:Pathway) REQUIRE n.sid IS UNIQUE;

// IDs are (sid, source)
CREATE CONSTRAINT id_sid_source IF NOT EXISTS
FOR (n:ID)
REQUIRE (n.sid, n.source) IS UNIQUE;

// ----------------------------
// Nodes
// ----------------------------
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/projects.csv' AS row
CALL {
  WITH row
  MERGE (p:Project {sid: row.sid})
  SET p.name = row.name
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/tissues.csv' AS row
CALL {
  WITH row
  MERGE (t:Tissue {sid: row.sid})
  SET t.name = row.name
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/diseases.csv' AS row
CALL {
  WITH row
  MERGE (d:Disease {sid: row.sid})
  SET d.name = row.name
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/phenotypes.csv' AS row
CALL {
  WITH row
  MERGE (ph:EFO {sid: row.sid})
  SET ph.name = row.name
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/samples.csv' AS row
CALL {
  WITH row
  MERGE (s:Sample {sid: row.sid})
  SET s.name = row.name,
      s.condition = row.condition
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/experiments.csv' AS row
CALL {
  WITH row
  MERGE (e:Experiment {sid: row.sid})
  SET e.type = row.type,
      e.platform = row.platform,
      e.method = CASE WHEN row.method IS NULL OR row.method = '' THEN null ELSE row.method END
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/comparisons.csv' AS row
CALL {
  WITH row
  MERGE (c:Comparison {sid: row.sid})
  SET c.name = row.name,
      c.type = row.type,
      c.tissue = CASE WHEN row.tissue = '' THEN null ELSE row.tissue END,
      c.n_case = CASE WHEN row.n_case = '' THEN null ELSE toInteger(row.n_case) END,
      c.n_control = CASE WHEN row.n_control = '' THEN null ELSE toInteger(row.n_control) END,
      c.analysis_date = CASE WHEN row.analysis_date = '' THEN null ELSE date(row.analysis_date) END,
      c.description = CASE WHEN row.description = '' THEN null ELSE row.description END,
      c.stratification = CASE WHEN row.stratification = '' THEN null ELSE row.stratification END,
      c.diseases = CASE WHEN row.diseases = '' THEN null ELSE row.diseases END
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/genes.csv' AS row
CALL {
  WITH row
  MERGE (g:Gene {sid: row.sid})
  SET g.symbol = row.symbol,
      g.name = row.name,
      g.source = row.source
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/ids.csv' AS row
CALL {
  WITH row
  MERGE (i:ID {sid: row.sid, source: row.source})
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/proteins.csv' AS row
CALL {
  WITH row
  MERGE (p:Protein {sid: row.sid})
  SET p.source = row.source,
      p.name = row.name,
      p.gene_name = row.gene_name
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/go_terms.csv' AS row
CALL {
  WITH row
  MERGE (go:GO {sid: row.sid})
  SET go.name = row.name
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/pathways.csv' AS row
CALL {
  WITH row
  MERGE (pw:Pathway {sid: row.sid})
  SET pw.name = row.name,
      pw.source = row.source
} IN TRANSACTIONS OF 1000 ROWS;

// ----------------------------
// Relationships (simple)
// ----------------------------
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_project_samples.csv' AS row
CALL {
  WITH row
  MATCH (p:Project {sid: row.project_sid})
  MATCH (s:Sample  {sid: row.sample_sid})
  MERGE (p)-[:HAS_SAMPLE]->(s)
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_sample_tissues.csv' AS row
CALL {
  WITH row
  MATCH (s:Sample {sid: row.sample_sid})
  MATCH (t:Tissue {sid: row.tissue_sid})
  MERGE (s)-[:TAKEN_FROM]->(t)
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_sample_phenotypes.csv' AS row
CALL {
  WITH row
  MATCH (s:Sample {sid: row.sample_sid})
  MATCH (ph:EFO {sid: row.phenotype_sid})
  MERGE (s)-[:HAS_PHENOTYPE]->(ph)
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_sample_experiments.csv' AS row
CALL {
  WITH row
  MATCH (s:Sample {sid: row.sample_sid})
  MATCH (e:Experiment {sid: row.experiment_sid})
  MERGE (s)-[:HAS_EXPERIMENT]->(e)
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_comparison_experiments.csv' AS row
CALL {
  WITH row
  MATCH (c:Comparison {sid: row.comparison_sid})
  MATCH (e:Experiment {sid: row.experiment_sid})
  MERGE (c)-[:COMPARES]->(e)
} IN TRANSACTIONS OF 1000 ROWS;

// Comparison->Sample with role deciding relationship type
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_comparison_samples.csv' AS row
CALL {
  WITH row
  MATCH (c:Comparison {sid: row.comparison_sid})
  MATCH (s:Sample {sid: row.sample_sid})
  FOREACH (_ IN CASE WHEN row.role = 'case' THEN [1] ELSE [] END |
    MERGE (c)-[:INCLUDES_CASE]->(s)
  )
  FOREACH (_ IN CASE WHEN row.role = 'control' THEN [1] ELSE [] END |
    MERGE (c)-[:INCLUDES_CONTROL]->(s)
  )
} IN TRANSACTIONS OF 1000 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_comparison_diseases.csv' AS row
CALL {
  WITH row
  MATCH (c:Comparison {sid: row.comparison_sid})
  MATCH (d:Disease {sid: row.disease_sid})
  MERGE (c)-[:STUDIES_DISEASE]->(d)
} IN TRANSACTIONS OF 1000 ROWS;

// ----------------------------
// Relationships with properties
// ----------------------------

// Experiment -> Gene (expression)
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_experiment_gene_values.csv' AS row
CALL {
  WITH row
  MATCH (e:Experiment {sid: row.experiment_sid})
  MATCH (g:Gene {symbol: row.gene_symbol})
  MERGE (e)-[r:HAS_VALUE]->(g)
  SET r.logFC = toFloat(row.logFC),
      r.pValue = toFloat(row.pValue),
      r.regulated = row.regulated,
      r.baseMean = toFloat(row.baseMean)
} IN TRANSACTIONS OF 1000 ROWS;

// Experiment -> Protein (proteomics)
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_experiment_protein_values.csv' AS row
CALL {
  WITH row
  MATCH (e:Experiment {sid: row.experiment_sid})
  MATCH (p:Protein {sid: row.protein_sid})
  MERGE (e)-[r:HAS_VALUE]->(p)
  SET r.logFC = toFloat(row.logFC),
      r.pValue = toFloat(row.pValue),
      r.regulated = row.regulated,
      r.intensity = toFloat(row.intensity),
      r.peptides = toInteger(row.peptides),
      r.coverage = toFloat(row.coverage)
} IN TRANSACTIONS OF 1000 ROWS;

// Comparison -> Gene (DGE)
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_comparison_gene_diff.csv' AS row
CALL {
  WITH row
  MATCH (c:Comparison {sid: row.comparison_sid})
  MATCH (g:Gene {symbol: row.gene_symbol})
  MERGE (c)-[r:FOUND_DIFFERENTIAL]->(g)
  SET r.logFC = toFloat(row.logFC),
      r.pValue = toFloat(row.pValue),
      r.adjPValue = toFloat(row.adjPValue),
      r.regulated = row.regulated,
      r.significance = row.significance,
      r.data_type = row.data_type,
      r.note = CASE WHEN row.note = '' THEN null ELSE row.note END,
      r.correlation = CASE WHEN row.correlation = '' THEN null ELSE toFloat(row.correlation) END
} IN TRANSACTIONS OF 1000 ROWS;

// Comparison -> Protein (DPE)
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_comparison_protein_diff.csv' AS row
CALL {
  WITH row
  MATCH (c:Comparison {sid: row.comparison_sid})
  MATCH (p:Protein {sid: row.protein_sid})
  MERGE (c)-[r:FOUND_DIFFERENTIAL]->(p)
  SET r.logFC = toFloat(row.logFC),
      r.pValue = toFloat(row.pValue),
      r.adjPValue = toFloat(row.adjPValue),
      r.regulated = row.regulated,
      r.significance = row.significance,
      r.data_type = row.data_type,
      r.note = CASE WHEN row.note = '' THEN null ELSE row.note END,
      r.correlation = CASE WHEN row.correlation = '' THEN null ELSE toFloat(row.correlation) END
} IN TRANSACTIONS OF 1000 ROWS;

// Gene -> Protein
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_gene_protein.csv' AS row
CALL {
  WITH row
  MATCH (g:Gene {symbol: row.gene_symbol})
  MATCH (p:Protein {sid: row.protein_sid})
  MERGE (g)-[:CODES]->(p)
} IN TRANSACTIONS OF 1000 ROWS;

// Gene -> ID
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_gene_id.csv' AS row
CALL {
  WITH row
  MATCH (g:Gene {symbol: row.gene_symbol})
  MATCH (i:ID {sid: row.id_sid, source: row.id_source})
  MERGE (g)-[:MAPPED]->(i)
} IN TRANSACTIONS OF 1000 ROWS;

// Gene -> Disease (associations)
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_gene_disease.csv' AS row
CALL {
  WITH row
  MATCH (g:Gene {symbol: row.gene_symbol})
  MATCH (d:Disease {sid: row.disease_sid})
  MERGE (g)-[r:RELATED_TO {source: row.source}]->(d)
  SET r.score = toFloat(row.score)
} IN TRANSACTIONS OF 1000 ROWS;

// Protein -> GO
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_protein_go.csv' AS row
CALL {
  WITH row
  MATCH (p:Protein {sid: row.protein_sid})
  MATCH (go:GO {sid: row.go_sid})
  MERGE (p)-[r:ASSOCIATED_WITH]->(go)
  SET r.source = row.source
} IN TRANSACTIONS OF 1000 ROWS;

// GO -> Pathway
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_go_pathway.csv' AS row
CALL {
  WITH row
  MATCH (go:GO {sid: row.go_sid})
  MATCH (pw:Pathway {sid: row.pathway_sid})
  MERGE (go)-[:IS_PART_OF]->(pw)
} IN TRANSACTIONS OF 1000 ROWS;

// Disease -> Pathway
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_disease_pathway.csv' AS row
CALL {
  WITH row
  MATCH (d:Disease {sid: row.disease_sid})
  MATCH (pw:Pathway {sid: row.pathway_sid})
  MERGE (d)-[r:INVOLVES_PATHWAY]->(pw)
  SET r.evidence = row.evidence
} IN TRANSACTIONS OF 1000 ROWS;

// Protein-protein interactions
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/jbarrasa/datasets/refs/heads/master/omics_dataload/rel_ppi.csv' AS row
CALL {
  WITH row
  MATCH (p1:Protein {sid: row.protein1_sid})
  MATCH (p2:Protein {sid: row.protein2_sid})
  MERGE (p1)-[r:INTERACTS_WITH]->(p2)
  SET r.source = row.source,
      r.score = toFloat(row.score),
      r.evidence = CASE WHEN row.evidence = '' THEN null ELSE row.evidence END
} IN TRANSACTIONS OF 1000 ROWS;

// Done.
