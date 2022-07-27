//Summary of emissions / gdp for Australia between 2000 and 2010

match (c:Country)<-[:forCountry]-(cad:CountryAnnualData)
where c.countryName = "Australia" and 2000 < cad.year < 2010
    return cad.year as yr, cad.emissions as co2_per_capita, cad.gdp as gdp_per_capita


// Avg emissions and GDP for countries in Insular Oceania

match (co:Continent)<-[:inContinent]-(c:Country)<-[:forCountry]-(cad:CountryAnnualData)
where co.continentName = "Insular Oceania" and 2000 < cad.year < 2010
    return c.countryName as country, avg(cad.emissions) as  avg_co2_per_capita, avg(cad.gdp) as avg_gdp_per_capita


// Analysis of neighbouring countries

match (c:Country)<-[:sharesBorderWith*0..1]-(neighbour)<-[:forCountry]-(cad:CountryAnnualData)
where c.countryName = "Iran" and 2000 < cad.year < 2010
    return neighbour.countryName as country, avg(cad.emissions) as  avg_co2_per_capita, avg(cad.gdp) as avg_gdp_per_capita

    
