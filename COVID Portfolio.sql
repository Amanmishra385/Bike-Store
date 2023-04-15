Select *
From dbo.CovidDeaths
Where Continent is not null
Order by 3,4

Select *
From dbo.CovidVaccinations
Order by 3,4

--Selecting the data we are going to use

select Continent,location,date,total_cases,new_cases,total_deaths,population
From dbo.CovidDeaths
Where Continent is not null
order by 2,3

--Looking at Total cases vs Total Deaths
--Shows the likelihood of dying if contracted covid in India

select continent, location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From dbo.CovidDeaths
where location = 'India' 
AND continent is not null
order by 2,3

--Looking at Total Case vs Population
--shows what percentage of person contracted covid

select location,date,population,total_cases, (total_cases/Population)*100 as Infected_Rate
From dbo.CovidDeaths
where location = 'India' 
AND continent is not null
order by 1,2,


--Looking at countries with highest infection rate compared to Population

select Continent,location,population,MAX(total_cases) As HighestInfectionCount, Max((total_cases/Population))*100 as Infected_Rate
From dbo.CovidDeaths
Where Continent is not null
Group by Continent,location,population
order by Infected_Rate DESC

--shows total death count of a country

select location, Max(cast(Total_Deaths as int)) As TotalDeathCount
From dbo.CovidDeaths
Where Continent is not null
Group by location
order by TotalDeathCount DESC


-- Breaking Things Down By cotinent
--Showing continents with the highest death count

select continent, location, Max(cast(Total_Deaths as int)) As TotalDeathCount
From dbo.CovidDeaths 
Where Continent is null
Group by continent,location,
order by TotalDeathCount DESC




-- Global numbers 

--Death Percentage 

select  Sum(new_cases) as total_cases, Sum(cast(New_deaths as int))as total_deaths, 
Sum(cast(new_deaths as int))/Sum(New_cases)*100 as DeathPercentage
From dbo.CovidDeaths
Where continent is not null
--Group by date
order by 1,2

-- Death percentage per day
select date,  Sum(new_cases) as total_cases, Sum(cast(New_deaths as int))as total_deaths, 
Sum(cast(new_deaths as int))/Sum(New_cases)*100 as DeathPercentage
From dbo.CovidDeaths
Where continent is not null
Group by date
order by 1,2


--Looking at total poplation vs vaccinations


Select Dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location,dea.date)
as IncrementalVaccination
From dbo.CovidDeaths Dea
Join dbo.CovidVaccinations Vac
   on Dea.location=Vac.location
   and Dea.date = vac.date
Where dea.continent is not null
order by 2,3

--USING CTE


with PopvsVac(continent, location, date,population, New_Vaccinations, IterativeVaxed_Population)
as
(
Select Dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location,dea.date)
as IterativeVaxed_Population
From dbo.CovidDeaths Dea
Join dbo.CovidVaccinations Vac
   on Dea.location=Vac.location
   and Dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
select *,(IterativeVaxed_Population/population)*100 As Percenatge_population_vaccinated
from PopvsVac
--where location = 'India' 
order by 2,3

--Creating view to store date for later visualizations

Create View Percenatge_population_vaccinated as
Select Dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location,dea.date)
as IterativeVaxed_Population
From dbo.CovidDeaths Dea
Join dbo.CovidVaccinations Vac
   on Dea.location=Vac.location
   and Dea.date = vac.date
Where dea.continent is not null



Select *
From Percenatge_population_vaccinated



