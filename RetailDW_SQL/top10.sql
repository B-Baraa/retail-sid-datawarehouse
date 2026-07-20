USE RetailDW;
GO

-- Top 10 produits
SELECT TOP 10
    p.ProductName,
    SUM(f.Sales) AS TotalSales
FROM FactSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;

-- Ventes par région
SELECT
    r.Region,
    SUM(f.Sales) AS TotalSales
FROM FactSales f
JOIN DimRegion r ON f.RegionKey = r.RegionKey
GROUP BY r.Region;

-- Profit par catégorie
SELECT
    p.Category,
    SUM(f.Profit) AS TotalProfit
FROM FactSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.Category;

-- Ventes par année
SELECT
    d.YearNumber,
    SUM(f.Sales) AS TotalSales
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.YearNumber;

-- ROLLUP : Région x Catégorie
SELECT
    r.Region,
    p.Category,
    SUM(f.Sales) AS TotalSales
FROM FactSales f
JOIN DimRegion r ON f.RegionKey = r.RegionKey
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY ROLLUP(r.Region, p.Category);

-- CUBE : Région x Catégorie
SELECT
    r.Region,
    p.Category,
    SUM(f.Sales) AS TotalSales
FROM FactSales f
JOIN DimRegion r ON f.RegionKey = r.RegionKey
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY CUBE(r.Region, p.Category);