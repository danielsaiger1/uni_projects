-- Dimension table to store SCD Type 2 data
CREATE TABLE DimensionTable (
        DimID INT IDENTITY(1,1),
        ID INT,
        Name NVARCHAR(50),
        Value NVARCHAR(50),
        StartDate DATETIME,
        EndDate DATETIME,
        IsCurrent INT
    );

-- Insert Test Data into Dimension Table
INSERT INTO DimensionTable (ID, Name, Value, StartDate, EndDate, IsCurrent)
VALUES  (1, 'Item1', 'Value1', '01-01-2024', NULL, 1),
        (2, 'Item2', 'Value2', '05-01-2024', NULL, 1),
        (3, 'Item3', 'Value3', '05-01-2024', NULL, 1);

-- Check Dimension Table before executing Stored Procedure
SELECT * FROM DimensionTable


CREATE PROCEDURE UpdateDimensionTable
AS
BEGIN
    -- Variable to get current date
    DECLARE @CurrentDateTime DATETIME = GETDATE();

    -- Temporary Table for new source data
    CREATE TABLE #SourceData (
        ID INT,
        Name NVARCHAR(50),
        Value NVARCHAR(50)
    );

    -- Simulate change in the value of Item3 in the source table
    INSERT INTO #SourceData (ID, Name, Value)
    VALUES
        (1, 'Item1', 'Value1'),
        (2, 'Item2', 'Value2'),
        (3, 'Item3', 'Value4');

    -- Mark existing rows as not current in the dimension table if there are changes in the source table 
    UPDATE DimensionTable
    SET EndDate = @CurrentDateTime,
        IsCurrent = 0
    FROM DimensionTable D
    INNER JOIN #SourceData S
        ON D.ID = S.ID
    WHERE D.IsCurrent = 1 AND (D.Name <> S.Name OR D.Value <> S.Value);

    -- Add new row in dimension table for new values
    INSERT INTO DimensionTable (ID, Name, Value, StartDate, EndDate, IsCurrent)
    SELECT S.ID, S.Name, S.Value, @CurrentDateTime, NULL, 1
    FROM #SourceData S
    LEFT JOIN DimensionTable D
        ON S.ID = D.ID AND D.IsCurrent = 1
    WHERE D.ID IS NULL OR (D.Name <> S.Name OR D.Value <> S.Value);

    -- Delete temporary table
    DROP TABLE #SourceData;

    -- Show updated dimension table
    SELECT * FROM DimensionTable;
END;

-- Execute stored procedure
EXEC UpdateDimensionTable;