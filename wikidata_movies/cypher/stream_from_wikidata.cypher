WITH "PREFIX neo4j: <neo4j://graph.schema#> 
CONSTRUCT{ 
   ?item a neo4j:Film; 
            neo4j:name ?movieTitle ; 
            neo4j:pubDate ?pubDate ;  
            neo4j:genre ?genre ;
            neo4j:countryOfOrigin ?countryOfOrigin ;
            neo4j:director ?director ;
            neo4j:castMember ?actor ;
            neo4j:narrativeLocation ?narrativeLocation ;
            neo4j:filmSubject ?filmSubject .
           
           ?genre a neo4j:Genre; neo4j:name ?genreName .
           ?countryOfOrigin a neo4j:Country, neo4j:Place ; neo4j:name ?countryName .
           ?director a neo4j:Person;  neo4j:name ?directorName .          
           ?actor a neo4j:Person;  neo4j:name ?actorName .          
           ?narrativeLocation a neo4j:Place ; neo4j:name ?narrativeLocationName .          
           ?filmSubject  a neo4j:Topic; neo4j:name ?filmSubjectName .
         } 
WHERE { 
  VALUES ?item { 
    
    wd:Q80959 wd:Q81224 wd:Q82949 wd:Q83495 wd:Q83542 wd:Q83612 wd:Q93853 wd:Q93876 wd:Q103569 wd:Q104814 wd:Q105387 wd:Q105598 wd:Q105624 wd:Q105801 wd:Q105993 wd:Q106182 wd:Q106440 wd:Q106871 wd:Q107226 wd:Q107761 wd:Q108006 wd:Q108297 wd:Q108525 wd:Q109110 wd:Q110138 wd:Q110203 wd:Q110206 wd:Q110397 wd:Q114076 wd:Q114819 wd:Q115760 wd:Q115993 wd:Q116468 wd:Q116852 wd:Q116928 wd:Q120484 wd:Q122623 wd:Q123097 wd:Q123742 wd:Q124701 wd:Q126387 wd:Q126652 wd:Q126676 wd:Q127367 wd:Q127421 wd:Q127439 wd:Q128187 wd:Q128486 wd:Q128493 wd:Q128518 wd:Q128582 wd:Q128975 wd:Q129068 wd:Q131074 wd:Q131390 wd:Q132245 wd:Q132351 wd:Q135156 wd:Q135230 wd:Q135298 wd:Q135347 wd:Q135428 wd:Q136264 wd:Q137130 wd:Q137703 wd:Q142751 wd:Q143716 wd:Q143901 wd:Q144970 wd:Q147845 wd:Q148326 wd:Q150047 wd:Q151647 wd:Q151705 wd:Q151904 wd:Q152531 wd:Q155163 wd:Q155476 wd:Q156069 wd:Q156309 wd:Q156539 wd:Q156597 wd:Q156608 wd:Q158474 wd:Q158759 wd:Q159638 wd:Q159870 wd:Q160071 wd:Q160215 wd:Q161087 wd:Q161400 wd:Q162182 wd:Q162255 wd:Q162277 wd:Q162729 wd:Q163872 wd:Q163899 wd:Q164331 wd:Q164804 wd:Q164963 wd:Q165268 wd:Q165817 wd:Q166031 wd:Q166262 wd:Q166716 wd:Q166734 wd:Q167437 wd:Q167726 wd:Q168154 wd:Q168246 wd:Q168849 wd:Q169000 wd:Q169996 wd:Q170268 wd:Q170564 wd:Q171193 wd:Q171453 wd:Q171711 wd:Q174284 wd:Q174369 wd:Q176568 wd:Q177077 wd:Q177930 wd:Q179100 wd:Q179215 wd:Q180098 wd:Q180279 wd:Q180395 wd:Q181069 wd:Q181540 wd:Q181776 wd:Q181795 wd:Q181803 wd:Q182212 wd:Q182218 wd:Q182373 wd:Q182692 wd:Q183066 wd:Q184605 wd:Q184843 wd:Q185064 wd:Q186587 wd:Q187154 wd:Q187414 wd:Q188019 wd:Q188652 wd:Q189054 wd:Q189330 wd:Q189600 wd:Q190145 wd:Q190643 wd:Q191040 wd:Q191100 wd:Q191543 wd:Q192115 wd:Q192686 wd:Q192724 wd:Q192979 wd:Q194346 wd:Q194696 wd:Q194778 wd:Q195710 wd:Q196004 wd:Q196685 wd:Q197491
    
    wd:Q186341 wd:Q193695 wd:Q1621909 wd:Q504697 wd:Q613290 wd:Q183063 wd:Q186341 wd:Q472512 wd:Q3208 wd:Q16782 wd:Q19405 wd:Q22432 wd:Q24075 wd:Q24151 wd:Q26970 wd:Q27338 wd:Q27411 wd:Q27536 wd:Q28267 wd:Q29733 wd:Q31212 wd:Q33671 wd:Q38970 wd:Q39970 wd:Q41754 wd:Q41854 wd:Q45384 wd:Q45386 wd:Q45692 wd:Q45794 wd:Q46637 wd:Q59408 wd:Q60362 wd:Q64017 wd:Q73279 wd:Q83542 wd:Q103569 wd:Q104814 wd:Q108543 wd:Q110043 wd:Q113392 wd:Q116928 wd:Q118914 wd:Q118985 wd:Q122713 wd:Q123097 wd:Q123742 wd:Q124612 wd:Q125058 wd:Q126974 wd:Q127421 wd:Q127427 wd:Q127430 wd:Q127439 wd:Q127536 wd:Q127632 wd:Q129068 wd:Q129073 wd:Q129074 wd:Q129078 wd:Q129082 wd:Q129085 wd:Q129181 wd:Q133654 wd:Q135298 wd:Q135428 wd:Q135932 wd:Q147308 wd:Q151695 wd:Q465732 wd:Q466204 wd:Q466533 wd:Q466792 wd:Q467947 wd:Q467953 wd:Q468253 wd:Q468700 wd:Q468703 wd:Q470771 wd:Q471054 wd:Q471992 wd:Q472165 wd:Q472512 wd:Q472528 wd:Q474093 wd:Q475789 wd:Q476380 wd:Q481264 wd:Q482626 wd:Q483591 wd:Q484987 wd:Q486239 wd:Q493807 wd:Q494367 wd:Q496853 wd:Q497622 wd:Q498383 wd:Q498990 wd:Q499050 wd:Q499678 wd:Q499935 wd:Q500403 wd:Q501995 wd:Q502286 wd:Q503343 wd:Q505325 wd:Q505712 wd:Q508112 wd:Q509523 wd:Q510740 wd:Q514348 wd:Q518863 wd:Q519147 wd:Q521165 wd:Q524971 wd:Q327613 wd:Q329434 wd:Q330247 wd:Q331760 
    
    wd:Q547538 wd:Q549417 wd:Q550520 wd:Q550558 wd:Q564104 wd:Q564893 wd:Q566890 wd:Q570320 wd:Q571480 wd:Q576371 wd:Q577757 wd:Q578391 wd:Q581117 wd:Q581347 wd:Q584509 wd:Q584824 wd:Q586782 wd:Q591953 wd:Q595310 wd:Q595612 wd:Q596583 wd:Q597846 wd:Q600950 wd:Q601537 wd:Q601646 wd:Q603067 wd:Q603440 wd:Q603651 wd:Q603803 wd:Q604424 wd:Q604860 wd:Q605374 wd:Q605413 wd:Q605518 wd:Q611043 wd:Q615028 wd:Q621159 wd:Q626455 wd:Q627346 wd:Q627533 wd:Q632753 wd:Q636534 wd:Q636748 wd:Q637192 wd:Q638085 wd:Q639387 wd:Q640979 wd:Q642410 wd:Q644044 wd:Q644065 wd:Q644250 wd:Q651060 wd:Q656118 wd:Q662679 wd:Q665192 wd:Q667799 wd:Q668948 wd:Q671482 wd:Q679105 wd:Q681269 wd:Q683734 wd:Q685245 wd:Q685885 wd:Q686908 wd:Q687825 wd:Q693798 wd:Q695297 wd:Q698962 wd:Q719471 wd:Q722382 wd:Q726294 wd:Q737861 
    
    wd:Q151898 wd:Q152429 wd:Q155458 wd:Q159063 wd:Q160071 wd:Q160215 wd:Q160618 wd:Q164804 wd:Q164933 wd:Q166425 wd:Q167051 wd:Q168010 wd:Q174559 wd:Q174601 wd:Q175018 wd:Q176517 wd:Q178211 wd:Q179554 wd:Q180125 wd:Q183239 wd:Q185048 wd:Q185061 wd:Q185214 wd:Q185834 wd:Q186490 wd:Q186504 wd:Q187079 wd:Q187999 wd:Q193835 wd:Q193981 wd:Q194346 wd:Q194413 wd:Q195274 wd:Q200482 wd:Q201215 wd:Q203063 wd:Q204212 wd:Q205983 wd:Q206080 wd:Q207588 wd:Q208266 wd:Q212098 wd:Q217010 wd:Q217182 wd:Q218391 wd:Q219442 wd:Q220126 wd:Q220423 wd:Q221594 wd:Q222965 wd:Q223043 wd:Q223374 wd:Q232161 wd:Q237116 wd:Q241391 wd:Q244865 wd:Q244872 wd:Q246656 wd:Q246997 wd:Q247470 wd:Q248289 wd:Q252097 wd:Q252233 wd:Q253566 wd:Q253978 wd:Q256037 wd:Q257486 wd:Q258204 wd:Q258847 wd:Q258979 wd:Q259807 wd:Q264869 wd:Q270385 wd:Q271006 wd:Q272036 wd:Q273704 wd:Q273978 wd:Q275180 wd:Q276299 wd:Q276407 wd:Q277527 wd:Q278550 wd:Q279058 wd:Q280918 wd:Q287385 wd:Q288425 wd:Q300401 wd:Q300566 wd:Q300568 wd:Q301046 wd:Q303719
  }
  
 ?item wdt:P31 wd:Q11424 .
        ?item wdt:P1476 ?movieTitle .
        ?item wdt:P577 ?pubDate .
        ?item wdt:P136 ?genre .       
           ?genre rdfs:label ?genreName 
           filter(lang(?genreName)='en')
        optional {
          ?item wdt:P495 ?countryOfOrigin .
           ?countryOfOrigin rdfs:label ?countryName 
           filter(lang(?countryName)='en')
        }
        optional {  
        ?item wdt:P57 ?director .
           ?director rdfs:label ?directorName 
           filter(lang(?directorName)='en')  
        }                     
        optional {
          ?item wdt:P161 ?actor .
           ?actor rdfs:label ?actorName 
           filter(lang(?actorName)='en')  
        }
        optional {
          ?item wdt:P840 ?narrativeLocation .
           ?narrativeLocation rdfs:label ?narrativeLocationName 
           filter(lang(?narrativeLocationName)='en')  
        }                              
        optional {
          ?item wdt:P921 ?filmSubject .
           ?filmSubject rdfs:label ?filmSubjectName 
           filter(lang(?filmSubjectName)='en')                        
        }                        
      }  
      " as sparql
CALL n10s.rdf.import.fetch(
  "https://query.wikidata.org/sparql","JSON-LD",
  { headerParams: { Accept: "application/ld+json" }, payload:  "query=" + apoc.text.urlencode(sparql) } )
YIELD terminationStatus, triplesLoaded, extraInfo
RETURN terminationStatus, triplesLoaded, extraInfo
