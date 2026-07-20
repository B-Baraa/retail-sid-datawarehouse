USE RetailDW;
GO

DECLARE @StartDate DATE = '2014-01-01';
DECLARE @EndDate DATE = '2017-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (DateKey, FullDate, DayNumber, MonthNumber, MonthName, QuarterNumber, YearNumber)
    VALUES (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        YEAR(@StartDate)
    );
    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END
GO