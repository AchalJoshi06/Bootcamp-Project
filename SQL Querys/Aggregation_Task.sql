select*from PortfolioProject.dbo.SalesData
order by Order_Date

--Data we are going to use for project -- 

Select Region,Country,Item_Type,Sales_Channel,Order_ID,Unit_Price,
Unit_Cost,(Unit_Cost/Unit_Price)*100 as Profit_Margin
from PortfolioProject.dbo.SalesData
where Country like '%As%'
GROUP BY Region
order by Region 


ALTER TABLE PortfolioProject.dbo.SalesData
ALTER COLUMN Unit_Price DECIMAL(10, 3);

ALTER TABLE PortfolioProject.dbo.SalesData
ALTER COLUMN Unit_Cost DECIMAL(10, 3);


--Total sold Units --
SELECT Country, SUM(Units_Sold) AS TotalUnitsSold
FROM PortfolioProject.dbo.SalesData
GROUP BY Country
order by TotalUnitsSold desc

-- total unit Sold data Grouped by item type 
SELECT Item_Type, SUM(Units_Sold) AS TotalUnitsSold
FROM PortfolioProject.dbo.SalesData
GROUP BY Item_Type
order by TotalUnitsSold desc

-- Total sales day on that day --

SELECT Order_Date, SUM(Units_Sold * Unit_Price) AS TotalSales
FROM PortfolioProject.dbo.SalesData
WHERE Order_Date = '2010-11-05'
GROUP BY Order_Date


-- total sales countrywise --

SELECT Country, SUM(Units_Sold*Unit_Price) AS TotalSales
FROM PortfolioProject.dbo.SalesData
--Where Country like '%New%'
GROUP BY Country

--Average Order Value --

Select Order_Date,SUM(Units_Sold*Unit_Price) as TotalSales,COUNT(DISTINCT Order_ID )as TotalOrders,
SUM(Units_Sold * Unit_Price) * 1.0 / COUNT(DISTINCT Order_ID) AS AverageOrderValue
FROM PortfolioProject.dbo.SalesData
WHERE Order_Date = '2010-12-05'
GROUP BY Order_Date

-- Minimum / Maximum Unit Price --

SELECT Order_Date,MAX(Unit_Price) AS MaxUnitPrice,MIN(Unit_Price) AS MinUnitPrice
FROM PortfolioProject.dbo.SalesData
WHERE Order_Date = '2015-11-05'
GROUP BY Order_Date

--  Total Revanue --

SELECT Country,SUM(Units_Sold * Unit_Price) AS TotalRevenue
FROM PortfolioProject.dbo.SalesData
GROUP BY Country
ORDER BY TotalRevenue DESC 

-- Total Profit --

SELECT Country,SUM(Units_Sold * (Unit_Price-Unit_Cost)) AS TotalProfit
FROM PortfolioProject.dbo.SalesData
GROUP BY Country
ORDER BY TotalProfit DESC

