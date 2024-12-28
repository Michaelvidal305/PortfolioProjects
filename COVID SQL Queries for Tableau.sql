/*

Quaries for Tableau

*/

-- 1.

SELECT SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
--Group by date
ORDER BY 1,2

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International" Location

--SELECT SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 
--as Death_Percentage
--FROM PortfolioProject..CovidDeaths
----WHERE location like '%states%'
--WHERE location = 'World'
----Group by date
--ORDER BY 1,2

-- 2. 

-- We take these out as they are not included in the above queries and want to stay consistent
-- European Union is part of Europe 

SELECT location, MAX(cast(total_deaths as int)) AS Total_Death_Count
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
WHERE continent is null
and location not in ('World', 'European Union', 'International')
GROUP BY location
ORDER BY Total_Death_Count DESC


-- 3. 

SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_of_Population_Infected
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
GROUP BY location, population
ORDER BY Percent_of_Population_Infected DESC


-- 4.


SELECT location, population, date, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_of_Population_Infected
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
GROUP BY location, population, date
ORDER BY Percent_of_Population_Infected DESC
