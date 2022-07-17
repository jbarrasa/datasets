// load dataset

CREATE CONSTRAINT n10s_unique_uri ON (r:Resource) ASSERT r.uri IS UNIQUE

call n10s.graphconfig.init({ handleVocabUris: "IGNORE"})

//load only one of them, they are different serialisations of the same dataset

call n10s.rdf.import.fetch("https://github.com/jbarrasa/datasets/raw/master/emissions/rdf/emissions-country.rdf","RDF/XML")


call n10s.rdf.import.fetch("https://github.com/jbarrasa/datasets/raw/master/emissions/rdf/emissions-country.ttl","Turtle")
