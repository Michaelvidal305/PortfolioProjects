SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is null
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to be using 

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent is null
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths 
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage_by_Population
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
and continent is null
ORDER BY 1,2


-- Looking at the Total Cases vs Population 
-- Shows what percentage of population get Covid 

SELECT location, date, population, total_cases, (total_cases/population)*100 AS Case_Percentage_by_Population
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is null
ORDER BY 1,2


-- Looking at countries with Highest Infection rate compared to Population 

SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_of_Population_Infected
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
WHERE continent is null
GROUP BY location, population
ORDER BY Percent_of_Population_Infected DESC


-- Showing the Countries with the Highest Death Count per Population

SELECT location, MAX(cast(total_deaths as int)) AS Total_Death_Count
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
WHERE continent is null
GROUP BY location
ORDER BY Total_Death_Count DESC


-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing continents with the Highest Death Count per Population 


SELECT continent, MAX(cast(total_deaths as int)) AS Total_Death_Count
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
WHERE continent is not null
GROUP BY continent
ORDER BY Total_Death_Count DESC


-- Global Numbers
-- W/ Date

SELECT date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by date
ORDER BY 1,2

-- W/O Date

SELECT SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
--Group by date
ORDER BY 1,2



-- Looking at Total Population vs Vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, 
	dea.date) as Rolling_Ppl_Vaccinated
--,	(Rolling_Ppl_Vaccinated/dea.population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date 
WHERE dea.continent is not null
ORDER BY 2,3



-- USE CTE

With Pop_Vs_Vac (Continent, Location, Date, Population, New_Vaccinations, Rolling_Ppl_Vaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, 
	dea.date) as Rolling_Ppl_Vaccinated
--,	(Rolling_Ppl_Vaccinated/dea.population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date 
WHERE dea.continent is not null
--ORDER BY 2,3
)
SELECT *, (Rolling_Ppl_Vaccinated/Population)*100
FROM Pop_Vs_Vac


-- Temp table 

DROP Table if exists #Percent_Population_Vaccinated
CREATE TABLE #Percent_Population_Vaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric, 
Rolling_Ppl_Vaccinated numeric
)

Insert into #Percent_Population_Vaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, 
	dea.date) as Rolling_Ppl_Vaccinated
--,	(Rolling_Ppl_Vaccinated/dea.population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date 
--WHERE dea.continent is not null
--ORDER BY 2,3

SELECT *, (Rolling_Ppl_Vaccinated/Population)*100
FROM #Percent_Population_Vaccinated


-- Creating View to store data for later visualizations

CREATE View Percent_Population_Vaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, 
	dea.date) as Rolling_Ppl_Vaccinated
--,	(Rolling_Ppl_Vaccinated/dea.population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date 
WHERE dea.continent is not null
--ORDER BY 2,3

-- View Query

SELECT *
FROM Percent_Population_Vaccinated