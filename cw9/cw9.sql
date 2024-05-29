USE AdventureWorks2019;

SELECT * FROM Production.Product

--zad1--

BEGIN TRANSACTION;
BEGIN TRY
	--Aktualizacja ceny produktu o nr ID 680 o 10%
	UPDATE Production.Product
	SET ListPrice = ListPrice*1.10
	WHERE ProductID = 680;
END TRY
BEGIN CATCH
	--Jezeli wystapi blad, wycofaj transakcje i wyswietl komunikat o bledzie
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * FROM Production.Product WHERE ProductID = 680;

-------------------------------------------------------------------------------------------

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"; -- wylacza wszystkie ograniczenia 

--zad2--
BEGIN TRY
	BEGIN TRANSACTION;
	DELETE FROM Production.Product
	WHERE ProductID = 707;
	PRINT 'Usunieto produkt'
	ROLLBACK;
	PRINT 'Transakcja wycofana.'
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

	EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all"; -- wlacza wszystkie ograniczenia

-------------------------------------------------------------------------------------------

SET IDENTITY_INSERT Production.Product ON;
SELECT ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, 
	ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate, rowguid, ModifiedDate 
	FROM Production.Product;

--zad3--

BEGIN TRY
	BEGIN TRANSACTION;
	INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, 
	SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate) 
	VALUES (5, 'Ball', 'BA-0000', 0, 0, 5, 500, 0.00, 0.00,0,'2000-02-25 00:00:00.000');
	COMMIT;
	PRINT 'Transakcja zatwierdzona. Dodano nowy produkt.'
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SET IDENTITY_INSERT Production.Product OFF

SELECT ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, 
	SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate, rowguid, ModifiedDate 
	FROM Production.Product;

-------------------------------------------------------------------------------------------

--zad4--

BEGIN TRANSACTION;
BEGIN TRY
	--Aktualizacja StandardCost o 10%
	UPDATE Production.Product
	SET StandardCost = StandardCost*1.10;

	--Sprawdzenie czy suma StandardCost po aktualizacji nie przekracza 50000
	DECLARE @TotalStandardCost MONEY;
	SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;

	IF @TotalStandardCost <= 50000
	BEGIN
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST(@TotalStandardCost AS VARCHAR(50));
	END
	ELSE
	BEGIN
		ROLLBACK;
		PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50000. Aktualna suma wynosi: ' + CAST(@TotalStandardCost AS VARCHAR(50));
	END
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-------------------------------------------------------------------------------------------

SET IDENTITY_INSERT Production.Product ON;

--zad5--

BEGIN TRANSACTION;
BEGIN TRY
	DECLARE @ProductNumber INT
	SET @ProductNumber = (SELECT COUNT(*) FROM Production.Product Where ProductNumber = 'BA-0001');

	IF @ProductNumber = 0
		BEGIN
		INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, 
		SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
		VALUES (6, 'Ball2', 'BA-0001', 0, 0, 5, 500, 0.00, 0.00,0,'2000-02-25 00:00:00.000');
		PRINT 'Transakcja zatwierdzona. Dodano nowy produkt.'
		COMMIT;
	END;
	ELSE
		BEGIN
		PRINT 'Transakcja wycofana. Juz istnieje produkt o takim numerze.'
		ROLLBACK;
	END;
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SET IDENTITY_INSERT Production.Product OFF

-------------------------------------------------------------------------------------------

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";
SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty=0;

--zad6--

BEGIN TRANSACTION;
BEGIN TRY
	IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		PRINT 'Transakcja wycofana. Wartosc OrderQty rowna 0'
		ROLLBACK;
	END;
	ELSE
	BEGIN
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty - 1
		PRINT 'Transakcja zaakceptowana. Zaktualizowano wartosc OrderQty'
		COMMIT;
	END;
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all";

-------------------------------------------------------------------------------------------

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";
SELECT * FROM Production.Product;

--zad7--

BEGIN TRANSACTION;
BEGIN TRY
	DECLARE @avqCostAllP INT
	SET @avqCostAllP = (SELECT AVG(StandardCost) FROM Production.Product)

	DECLARE @amRD INT
	SET @amRD = (SELECT COUNT(*) FROM Production.Product WHERE StandardCost > @avqCostAllP)

	IF @amRD > 10
	BEGIN
		ROLLBACK;
		PRINT 'Transakcja wycofana. Ilosc produktow przekroczyla 10.'
	END;
	ELSE
	BEGIN
		DELETE FROM Production.Product
		WHERE StandardCost > @avqCostAllP;
		PRINT 'Transakcja zaakceptowana. Usunieto produkt(y)'
		COMMIT;
	END;
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;




EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all";