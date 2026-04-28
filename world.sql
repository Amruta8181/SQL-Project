use world;
select * from city;
select * from country;
select * from countrylanguage;

Select 
row_number() over(order by(code)) as Sr_number,
Code,Country_Name,Continent,Country_pop,lifeExpectancy,GNP,surfacearea from Country;

## rank  densrank
Select 
rank() over(order by GNP desc) as Rank_GNP,
rank() over(order by Country_pop desc) as Rank_pop,
Code,Country_Name,Continent,Country_pop,lifeExpectancy,GNP,surfacearea from Country;

Select 
rank() over(order by Country_pop desc) as Rank_pop,
rank() over(order by lifeExpectancy desc) as Rank_LE,
Code,Country_Name,Continent,Country_pop,lifeExpectancy,GNP,surfacearea from Country;

Select 
rank() over(order by lifeExpectancy desc) as Rank_LE,
dense_rank() over(order by lifeExpectancy desc) as DRank_LE,
Code,Country_Name,Continent,Country_pop,lifeExpectancy,GNP,surfacearea from Country;

#Ntile
Select 
ntile(4) over(order by GNP desc) as Cluster,
ntile(4) over(partition by continent order by GNP desc) as Con_cluster,
Code,Country_Name,Continent,Country_pop,lifeExpectancy,GNP,surfacearea from Country;

Select 
code,Country_Name,Continent,Country_pop,lifeExpectancy,surfacearea,
GNP,
lag(GNP) over(order by GNP desc) as Lag_GNP,
Lead(GNP) over(order by GNP desc) as Lead_GNP
from Country;

Select * from city
where district like "N%";

Select * from city c
join countrylanguage cl 
on c.countrycode = cl.countryCode
where Language = "English";

Select * from city;
Select * from countrylanguage;

with Contitnent_average as 
(select continent, round(avg(country_pop),0) as Avg_pop
from country
group by Continent)
select code,
country_name,
c.Continent, country_pop,
Avg_pop from country c
left join continent_average ca
on ca.continent = c.continent
where country_pop > avg_pop;

select * from city 
where countrycode in (select countrycode 
from countrylanguage
where Language = "english");

##Question 1 : Count how many cities are there in each country
select c.Country_name,count(ci.ID) as No_city from country c
left join city ci on ci.CountryCode = c. Code
group by c.country_name
order by No_city desc;

select * from country;
select * from city;

##Question 2 : Display all continents having more than 30 countries.
select continent, count(*) as Continent_country
from country
group by Continent
having count(*) > 30
order by continent_country;

select * from country
where continent = "North America";

##Question 3 : List regions whose total population exceeds 200 million.
select region, sum(Country_pop) as Total_pop
from country
group by region
having sum(Country_pop) > 200000000
order by Total_pop;

##Question 4 : Find the top 5 continents by average GNP per country
select continent,round(avg(GNP),0) as Avg_GNP
From country
group by Continent
order by Avg_Gnp desc
Limit 5;

##Question 5 : Find the total number of official languages spoken in each continent.
select c.continent,count(distinct cl.language) as Total_official_lang
from country c
left join countrylanguage cl on cl.countrycode = c.Code
AND cl.IsOfficial = "T"
group by c.continent
order by Total_official_lang desc;

##Question 6 : Find the maximum and minimum GNP for each continent
select continent,
max(GNP) as Max_GNP,
min(GNP) as Min_GNP
From country
group by continent
order by Continent;

##Question 7 : Find the country with the highest average city population
select c.country_name, round(avg(ci.population),0) as Avg_city_pop
from country c
left join city ci on ci.CountryCode = c.Code
group by c.Country_Name
order by Avg_city_pop desc
Limit 1;

##Question 8 : List continents where the average city population is greater than 200,000.
select c.continent, round(avg(ci.population),0) as Avg_city_pop
from country c
left join city ci on ci.CountryCode = c.Code
group by c.Continent
HAVING AVG(ci.Population) > 200000
order by Avg_city_pop desc;

##Question 9 : Find the total population and average life expectancy for each continent, ordered ordered by average life expectancy descending.
select continent, sum(country_pop) as Total_population,
round(avg(lifeExpectancy),0) as Avg_lifeexpectancy
from country
WHERE LifeExpectancy IS NOT NULL
group by continent
order by Avg_lifeexpectancy desc;

##Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where the total population is over 200 million.
select continent, sum(country_pop) as Total_population,
round(avg(lifeExpectancy),0) as Avg_lifeexpectancy
from country
group by continent
HAVING Total_population > 200000000
order by Avg_lifeexpectancy desc
limit 3;




