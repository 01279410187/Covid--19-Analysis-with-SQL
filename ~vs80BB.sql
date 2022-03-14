select *
from Portifolio..CovidDeth



select *
from Portifolio..CovidVaccination
order by 3,4


--selct data 

select location, date, total_cases, new_cases, total_deaths, population 
from Portifolio..CovidDeth
Where continent is not null 
order by 1,2


-- Total cases in Eggypt and deth rate presntage

select location, date, total_cases, new_cases, total_deaths, (total_cases/total_deaths)*100 as deathRate
from Portifolio..CovidDeth
where location like '%Egypt%'
And continent is not null 
order by 1,2



-- Total cases vs population in Eggypt and deth rate presntage
select location, date, total_cases, new_cases, population, (total_cases/population)*100 as poplulationinfectd
from Portifolio..CovidDeth
where location like '%Egypt%'
And continent is not null 
order by 1,2




--Countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portifolio..CovidDeth
Group by location, population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int )) as DeathCount
From Portifolio..CovidDeth
where continent is not null 
Group by Location
order by DeathCount desc

--united stats is hightest death rate


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Portifolio..CovidDeth
where continent is not null 
order by 1,2

--total population vs total vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations_smoothed_per_million
, SUM(CONVERT(int,vac.new_vaccinations_smoothed_per_million)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Portifolio..CovidDeth dea
Join Portifolio..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3







