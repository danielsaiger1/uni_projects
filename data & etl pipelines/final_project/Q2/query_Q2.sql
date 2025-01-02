-- Create Example Table and insert duplicate values
CREATE TABLE duplicates (
	ID INT,
	Item varchar(255),
	Value varchar(255)
)

INSERT INTO duplicates (ID, Item, Value)
VALUES
	    (1, 'Item1', 'Value1'),
        (2, 'Item2', 'Value2'),
        (3, 'Item3', 'Value3'),
		(4, 'Item3', 'Value3'),
		(5, 'Item1', 'Value1');

SELECT * From duplicates

-- Get Duplicates with window function and delete them in the next step
WITH get_duplicates AS (
    SELECT 
        ID, 
        Item, 
        Value,
        ROW_NUMBER() OVER (PARTITION BY Item, Value ORDER BY ID) AS row_num
    FROM 
        duplicates
)
DELETE FROM duplicates
WHERE ID IN (
    SELECT ID
    FROM DuplicateCTE
    WHERE row_num > 1
);

SELECT * From duplicates