select*from PortfolioProject.dbo.SalesData
order by Order_Date


-- Sales by year

Select Year(Order_Date) as SalesYear,SUM(Units_Sold * Unit_Price) as Total_Sales
From PortfolioProject..SalesData
GROUP BY YEAR(Order_Date)
order by SalesYear

-- Sales By Month

Select Year(Order_Date) as SalesYear,Month(Order_Date) as SalesMonth,SUM(Units_Sold * Unit_Price) as Total_Sales
From PortfolioProject..SalesData
GROUP BY  YEAR(Order_Date),Month(Order_Date)
order by SalesMonth,SalesYear

--Sales by week

Select  YEAR(Order_Date) as salesyear, DATEPART(WEEK,Order_Date) as SalesWeek , SUM(Units_Sold*Unit_Price) as TotalSales
FROM PortfolioProject.dbo.SalesData
GROUP BY YEAR(Order_Date), DATEPART(WEEK, Order_Date)
ORDER BY SalesYear, SalesWeek

--- Sales By Quater
SELECT YEAR(Order_Date) AS SalesYear,DATEPART(QUARTER, Order_Date) AS SalesQuarter,SUM(Units_Sold * Unit_Price) AS TotalSales
FROM PortfolioProject.dbo.SalesData
GROUP BY YEAR(Order_Date), DATEPART(QUARTER, Order_Date)
ORDER BY SalesYear, SalesQuarter

--Year to Year Growth

WITH YearlySales AS (
    SELECT YEAR(Order_Date) AS SalesYear,SUM(Units_Sold * Unit_Price) AS TotalSales
    FROM PortfolioProject.dbo.SalesData
    GROUP BY YEAR(Order_Date)
),


YOYGROWTH as (
    select Y1.SalesYear,Y1.TotalSales,Y2.TotalSales as Lastyearsales,
    ROUND( ( ( Y1.TotalSales - Y2.TotalSales) * 100.0) / NULLIF(Y2.TotalSales, 0 ), 2) as YoYGrowthPersent
        
    From YearlySales Y1
    Left Join YearlySales Y2 ON Y1.SalesYear=Y2.SalesYear + 1

       )
    SELECT * FROM YoYGROWTH
    Order by SalesYear

-- Month by Month

WITH MonthlySales AS (
    SELECT 
        YEAR(Order_Date) AS SalesYear,
        MONTH(Order_Date) AS SalesMonth,
        CONCAT(YEAR(Order_Date), '-', RIGHT('00' + CAST(MONTH(Order_Date) AS VARCHAR), 2)) AS Period,
        SUM(Units_Sold * Unit_Price) AS TotalSales
    FROM PortfolioProject.dbo.SalesData
    GROUP BY YEAR(Order_Date), MONTH(Order_Date)
),
MoMGrowth AS (
    SELECT 
        M1.Period,
        M1.TotalSales,
        M2.TotalSales AS LastMonthSales,
        ROUND(((M1.TotalSales - M2.TotalSales) * 100.0) / NULLIF(M2.TotalSales, 0), 2) AS MoM_Growth_Percent
    FROM MonthlySales M1
    LEFT JOIN MonthlySales M2 
        ON M1.SalesYear = M2.SalesYear AND M1.SalesMonth = M2.SalesMonth + 1
           OR (M1.SalesYear = M2.SalesYear + 1 AND M1.SalesMonth = 1 AND M2.SalesMonth = 12)
)
SELECT * FROM MoMGrowth
ORDER BY Period;



-- Monthly Treanding items Units Sold based

WITH MonthlyItemSales AS (
    SELECT 
        YEAR(Order_Date) AS SalesYear,
        MONTH(Order_Date) AS SalesMonth,
        Item_Type,
        SUM(Units_Sold) AS TotalUnitsSold
    FROM PortfolioProject.dbo.SalesData
    GROUP BY YEAR(Order_Date), MONTH(Order_Date), Item_Type
),
RankedItems AS (
    SELECT *,
           RANK() OVER (PARTITION BY SalesYear, SalesMonth ORDER BY TotalUnitsSold DESC) AS RankInMonth
    FROM MonthlyItemSales
)
SELECT *
FROM RankedItems
WHERE RankInMonth = 1
ORDER BY SalesYear, SalesMonth;


-- Monthly Sales Rank based by Item_types

SELECT 
    YEAR(Order_Date) AS SalesYear,
    MONTH(Order_Date) AS SalesMonth,
    FORMAT(Order_Date, 'MMM') AS MonthName,
    SUM(Units_Sold) AS TotalUnitsSold,
    SUM(Units_Sold * Unit_Price) AS TotalRevenue
FROM PortfolioProject.dbo.SalesData
WHERE Item_Type = 'Snacks'
GROUP BY YEAR(Order_Date), MONTH(Order_Date), FORMAT(Order_Date, 'MMM')
ORDER BY SalesYear, SalesMonth;







 



        

    

