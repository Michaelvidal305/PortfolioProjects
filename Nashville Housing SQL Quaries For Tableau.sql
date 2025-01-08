/*

Quaries for Tableau

*/

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing



-- 1.
-- Highest Sale price by city 

SELECT OwnerSplitCity, MAX(SalePrice) as Highest_Saleprice_by_City
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerSplitCity IS NOT NULL
GROUP BY OwnerSplitCity
Order by Highest_Sale_by_City DESC



-- 2.
-- LAND USE 

SELECT DISTINCT(LandUse), COUNT(LandUse) AS LandUse_Count
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY LandUse
ORDER BY LandUse_Count DESC



-- 3

-- DIFFERENCE IN AVERAGE SALEPRICE VS AVERAGE TOTALVALUE

SELECT PropertySplitCity, AVG(SalePrice) AS AVG_SalePrice, AVG(TotalValue) AS AVG_TotalValue, (AVG(SalePrice) - AVG(TotalValue)) AS TotalValue_and_SalePrice_difference
FROM PortfolioProject.dbo.NashvilleHousing
WHERE OwnerName is not null
GROUP BY PropertySplitCity
ORDER BY TotalValue_and_SalePrice_difference DESC

-- 4 

-- PROPERY SALES BY YEAR

SELECT YEAR(SaleDateConverted), SUM(SalePrice) AS Total_Sales
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SaleDateConverted BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY SaleDateConverted 
ORDER BY Total_Sales 