USE RetailDW;
GO
'''peuple les 5 dimensions à partir de la table staging'''
INSERT INTO DimShipMode (ShipMode)
SELECT DISTINCT Ship_Mode
FROM Superstore
WHERE Ship_Mode IS NOT NULL;

INSERT INTO DimCustomer (CustomerID, CustomerName, Segment)
SELECT DISTINCT Customer_ID, Customer_Name, Segment
FROM Superstore
WHERE Customer_ID IS NOT NULL;

INSERT INTO DimRegion (Country, Region, State, City)
SELECT DISTINCT Country, Region, State, City
FROM Superstore
WHERE Country IS NOT NULL;

INSERT INTO DimProduct (ProductID, ProductName, Category, SubCategory)
SELECT DISTINCT Product_ID, Product_Name, Category, Sub_Category
FROM Superstore
WHERE Product_ID IS NOT NULL;
GO