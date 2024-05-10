USE [AdventureWorks2019];

-- ZAD 1 -------------------------------------------------------------

-- funkcja
GO
CREATE OR ALTER FUNCTION cFibonacci(@n INTEGER)
	RETURNS INTEGER
AS
BEGIN
	DECLARE @f0 INTEGER = 0;
	DECLARE @f1 INTEGER = 1;
	DECLARE @fi INTEGER;
	DECLARE @i INTEGER = 2;
	IF @n = 0 
		RETURN @f0;
	IF @n = 1 
		RETURN @f1;
	IF @n > 1 
	BEGIN
		WHILE @i <= @n
		BEGIN
			SET @fi = @f0+@f1;
			SET @f0 = @f1;
			SET @f1 = @fi;
			SET @i = @i + 1;
		END
		RETURN @fi;
	END
	RETURN 0;
END;
GO

-- procedura
GO
CREATE OR ALTER PROCEDURE showFibonacci(@n INTEGER)
AS
BEGIN
	PRINT 'Ciag Fibonacciego dla ' + CAST(@n AS VARCHAR(5)) + ' elementow:';
	DECLARE @i INT = 0;
	WHILE @i < @n
	BEGIN
		PRINT CAST(dbo.cFibonacci(@i) AS VARCHAR(5)) + ' ';
		SET @i = @i + 1;
	END
END
GO


EXEC ShowFibonacci 8; -- wykonanie procedury

SELECT * FROM Person.Person;

-- ZAD 2 -------------------------------------------------------------

GO 
CREATE OR ALTER TRIGGER uppercaseLastName ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person
	SET LastName = UPPER(LastName) FROM Person.Person;
END;
GO

INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, MiddleName, LastName)
VALUES (292, 'VC', 'John', 'Tim', 'Smith');

SELECT * FROM Person.Person;


-- ZAD 3 -------------------------------------------------------------

SELECT * FROM Sales.SalesTaxRate

GO
CREATE OR ALTER TRIGGER taxRateMonitoring ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted
        JOIN deleted ON inserted.TaxRate > deleted.TaxRate * 1.3
    )
    BEGIN
        PRINT 'Error - The change in TaxRate exceeds 30% limit.'
    END;

END;
GO


UPDATE Sales.SalesTaxRate 
SET TaxRate = TaxRate*1.5
WHERE TaxRate = 8.00;
