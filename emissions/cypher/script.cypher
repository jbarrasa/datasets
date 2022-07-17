// load instructions

CREATE CONSTRAINT n10s_unique_uri ON (r:Resource) ASSERT r.uri IS UNIQUE

call n10s.graphconfig.init({ handleVocabUris: "IGNORE"})

call n10s.rdf.import.fetch("file:///Users/jb/Downloads/emissions-country.rdf","RDF/XML")

call n10s.rdf.import.fetch("file:///Users/jb/Downloads/emissions-country.ttl","Turtle")
