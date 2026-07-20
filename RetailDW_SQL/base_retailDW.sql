CREATE DATABASE RetailDW;
GO
USE RetailDW;
GO

CREATE TABLE DimDate
(
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    DayNumber INT,
    MonthNumber INT,
    MonthName VARCHAR(20),
    QuarterNumber INT,
    YearNumber INT
);

CREATE TABLE DimProduct
(
    ProductKey INT IDENTITY PRIMARY KEY,
    ProductID VARCHAR(50),
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    SubCategory VARCHAR(100)
);

CREATE TABLE DimCustomer
(
    CustomerKey INT IDENTITY PRIMARY KEY,
    CustomerID VARCHAR(50),
    CustomerName VARCHAR(150),
    Segment VARCHAR(50)
);

CREATE TABLE DimRegion
(
    RegionKey INT IDENTITY PRIMARY KEY,
    Country VARCHAR(50),
    Region VARCHAR(50),
    State VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE DimShipMode
(
    ShipModeKey INT IDENTITY PRIMARY KEY,
    ShipMode VARCHAR(50)
);

CREATE TABLE FactSales
(
    SalesKey INT IDENTITY PRIMARY KEY,
    DateKey INT,
    ProductKey INT,
    CustomerKey INT,
    RegionKey INT,
    ShipModeKey INT,
    Sales DECIMAL(18,2),
    Quantity INT,
    Discount FLOAT,
    Profit DECIMAL(18,2),
    FOREIGN KEY(DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey),
    FOREIGN KEY(CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY(RegionKey) REFERENCES DimRegion(RegionKey),
    FOREIGN KEY(ShipModeKey) REFERENCES DimShipMode(ShipModeKey)
);