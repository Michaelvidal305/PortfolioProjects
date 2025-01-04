
SELECT * 
FROM PortfolioProject.dbo.NashvilleHousing


-- Select Data that we are going to be using 

SELECT [UniqueID ], PropertySplitAddress, PropertySplitCity, TotalValue, SalePrice
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
ORDER BY 3


-- LOOKING AT SalePrice vs TotalValue
-- Shows difference in Sale Price and Total Value of property 

SELECT [UniqueID ], PropertySplitAddress, PropertySplitCity, SalePrice, TotalValue, (SalePrice - TotalValue) AS TotalValue_and_SalePrice_difference
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
ORDER BY 3


-- Looking at LandValue vs BuildingValue
-- Shows difference in Building Value and Land Value 

SELECT [UniqueID ], PropertySplitAddress, PropertySplitCity, BuildingValue, LandValue, (BuildingValue - LandValue) AS BuildingValue_and_LandValue_difference
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
ORDER BY 3


-- Cities with the Highest Property SalePrice

SELECT PropertySplitCity, SaleDateConverted AS Date, MAX(SalePrice) AS Highest_Saleprice
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity, SaleDateConverted
ORDER BY Highest_Saleprice DESC


-- Average Saleprice by City

SELECT PropertySplitCity, ROUND(AVG(SalePrice), 2) AS Avg_SalePrice
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity
ORDER BY Avg_SalePrice DESC


-- Average BuildingValue by City

SELECT PropertySplitCity, ROUND(AVG(BuildingValue), 2) AS Avg_BuildingValue
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity
ORDER BY Avg_BuildingValue DESC


-- Average LandValue by City

SELECT PropertySplitCity, ROUND(AVG(LandValue), 2) AS Avg_LandValue
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity
ORDER BY Avg_LandValue DESC


-- Average Acreage by city


SELECT PropertySplitCity, ROUND(AVG(Acreage), 2) AS Avg_Acreage
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity
ORDER BY Avg_Acreage DESC


-- LAND USE 

SELECT DISTINCT(LandUse), COUNT(LandUse) AS LandUse_Count
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY LandUse
ORDER BY LandUse_Count DESC


-- LAND USE BY CITY 

SELECT DISTINCT(LandUse), PropertySplitCity, COUNT(LandUse) AS LandUse_Count
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY LandUse, PropertySplitCity
ORDER BY PropertySplitCity, LandUse_Count DESC



-- Total Property Count by City 

SELECT PropertySplitCity, COUNT([UniqueID ]) AS Property_count
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity
ORDER BY Property_count DESC



-- Comparing Property sales between years 2016 & 2015

SELECT SaleDateConverted, PropertySplitCity, PropertySplitAddress, Acreage, LandUse, SalePrice
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SaleDateConverted BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY SaleDateConverted 

SELECT SaleDateConverted, PropertySplitCity, PropertySplitAddress, Acreage, LandUse, SalePrice
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SaleDateConverted BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY SaleDateConverted 
