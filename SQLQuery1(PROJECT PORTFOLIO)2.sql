SELECT * 
FROM [SQL DATA EXPLORATION]..['Covid Death$']
WHERE continent is NOT NULL
ORDER BY 3,4;

SELECT * 
FROM [SQL DATA EXPLORATION]..['Covid Vacinations$']
ORDER BY 3,4;

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM [SQL DATA EXPLORATION]..['Covid Death$']
ORDER BY 1,2;

--LOOKING AT TOTAL CASES VS TOTTAL DEATH
-- shows the likehood of dying if you contact covid in your country

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS "DeathPercentage"
FROM [SQL DATA EXPLORATION]..['Covid Death$']
WHERE location like '%states%'
ORDER BY 1,2;

--LOOKING AT TOTAL CASES VS POPOPULATION
-- This wouldd show us what percentage of people have gotten Covid

SELECT location,date,total_cases,population,(total_cases/population)*100 AS "DeathPercentage"
FROM [SQL DATA EXPLORATION]..['Covid Death$']
WHERE location like '%states%'
ORDER BY 1,2;

--- What country had the highest infection rate compared to population
SELECT location, population,MAX(total_cases)AS"HighestInfectionCount",MAX(total_cases/population)*100 AS "PercentPopulationInfected"
FROM [SQL DATA EXPLORATION]..['Covid Death$']
--WHERE location like '%states%'
GROUP BY location,population
ORDER BY PercentPopulationInfected DESC;

---LET BREAK THINGS DOWN BY CONTINENT

--Showing Countries with Highest Death Count per population
SELECT location,MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [SQL DATA EXPLORATION]..['Covid Death$']
--WHERE location like '%states%'
WHERE continent is null
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS int)) AS total_deaths, SUM(cast
(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
FROM [SQL DATA EXPLORATION]..['Covid Death$']
--WHERE location like '%states%'
WHERE continent is not null
Group by date
ORDER BY 1,2;


--LOOKING AT TOTAL POPULATION VS VACCICNATION

--TEMP TABLE
Create Table #PercentPoulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Dates datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPoulationVaccinated
SELECT dea.continent,dea.location,dea.date,dea.population
FROM [SQL DATA EXPLORATION]..['Covid Death$']AS dea
JOIN [SQL DATA EXPLORATION]..['Covid Vacinations$']AS vac
ON dea.location = vac.location
AND dea.date = vac.date
where dea.continent is not null
order by 1,2,3


--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION

Create View PPV as
SELECT dea.continent,dea.location,dea.date,dea.population
FROM [SQL DATA EXPLORATION]..['Covid Death$']AS dea
JOIN [SQL DATA EXPLORATION]..['Covid Vacinations$']AS vac
ON dea.location = vac.location
AND dea.date = vac.date
where dea.continent is not null
--order by 1,2,3




