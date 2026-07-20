USE RetailDW;
GO

INSERT INTO FactSales (DateKey, ProductKey, CustomerKey, RegionKey, ShipModeKey, Sales, Quantity, Discount, Profit)
SELECT
    d.DateKey,
    p.ProductKey,
    c.CustomerKey,
    r.RegionKey,
    s.ShipModeKey,
    t.Sales,
    t.Quantity,
    t.Discount,
    t.Profit
FROM Superstore t
JOIN DimDate d ON d.FullDate = t.Order_Date
JOIN DimProduct p ON p.ProductID = t.Product_ID AND p.ProductName = t.Product_Name
JOIN DimCustomer c ON c.CustomerID = t.Customer_ID
JOIN DimRegion r ON r.Country = t.Country AND r.Region = t.Region AND r.State = t.State AND r.City = t.City
JOIN DimShipMode s ON s.ShipMode = t.Ship_Mode;
GO

-- Vérification finale
SELECT 'DimShipMode' AS TableName, COUNT(*) AS Total FROM DimShipMode
UNION ALL SELECT 'DimCustomer', COUNT(*) FROM DimCustomer
UNION ALL SELECT 'DimRegion', COUNT(*) FROM DimRegion
UNION ALL SELECT 'DimProduct', COUNT(*) FROM DimProduct
UNION ALL SELECT 'FactSales', COUNT(*) FROM FactSales;