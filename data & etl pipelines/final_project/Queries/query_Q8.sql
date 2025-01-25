SELECT c.MaritalStatus, st.SalesTerritoryCountry, CAST(SUM(f.SalesAmount) AS INT) total_sales_amount, COUNT(f.salesordernumber) total_orders
FROM FactInternetSales f
JOIN 
	DimSalesTerritory st
ON
	f.SalesTerritoryKey = st.SalesTerritoryKey
JOIN
	DimCustomer c
ON
	f.CustomerKey = c.CustomerKey
GROUP BY c.MaritalStatus, st.SalesTerritoryCountry