select*from PortfolioProject.dbo.SalesData
	order by Order_Date

--- Sales By region  ---

Select Region , SUM(Units_Sold * Unit_Price) as Total_Sales
From PortfolioProject..SalesData
Group by Region
Order by Total_Sales DESC


--- Sales By Country  ---

Select Country , SUM(Units_Sold * Unit_Price) as Total_Sales
From PortfolioProject..SalesData
Group by Country
Order by Total_Sales desc

--- now fimding sales is same as upper two we just need to change first place like country,region,item type etc.

Select Sales_Channel , SUM(Units_Sold * Unit_Price) as Total_Sales
From PortfolioProject..SalesData
Group by Sales_Channel
Order by Total_Sales desc

-- ^- this query is for total sales accordingly Online or Ofline sales


--total sales based on Order_Priority --

Select Order_Priority , SUM(Units_Sold * Unit_Price) as Total_Sales
From PortfolioProject..SalesData
Group by Order_Priority
Order by Total_Sales desc

