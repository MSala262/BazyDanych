
--Cwiczenie 8--

USE AdventureWorks2019;


--zad1--

--Pierwszy sposob--
CREATE TABLE #TempEmployeeInfo (IDPracownika INT, Imie VARCHAR(50), Nazwisko VARCHAR(50), Stawka DECIMAL(10,2)); -- #->tabela lokalna tymczasowa; ##->tabela globalna tymczasowa

WITH DanePracownika_CTE (BusinessEntityID, FirstName, LastName)
AS
(
	SELECT BusinessEntityID, FirstName, LastName
	FROM Person.Person
	WHERE BusinessEntityID IS NOT NULL
)
,
StawkaPracownika_CTE (ID, Rates)
AS
(
	SELECT BusinessEntityID, SUM(Rate) AS Rates
	FROM HumanResources.EmployeePayHistory
	WHERE BusinessEntityID IS NOT NULL
	GROUP BY BusinessEntityID	
)
INSERT INTO #TempEmployeeInfo
SELECT BusinessEntityID, FirstName, LastName, Rates
FROM DanePracownika_CTE 
JOIN StawkaPracownika_CTE ON DanePracownika_CTE.BusinessEntityID = StawkaPracownika_CTE.ID;

SELECT * FROM #TempEmployeeInfo ORDER BY IDPracownika;

-- DROP TABLE #TempEmployeeInfo;


--Drugi sposob--
WITH DanePracownika_CTE (BusinessEntityID, FirstName, LastName)
AS
(
	SELECT BusinessEntityID, FirstName, LastName
	FROM Person.Person
	WHERE BusinessEntityID IS NOT NULL
)
,
StawkaPracownika_CTE (ID, Rates)
AS
(
	SELECT BusinessEntityID, SUM(Rate) AS Rates
	FROM HumanResources.EmployeePayHistory
	WHERE BusinessEntityID IS NOT NULL
	GROUP BY BusinessEntityID	
)
SELECT BusinessEntityID, FirstName, LastName, Rates INTO dbo.TempEmployeeInfo
FROM DanePracownika_CTE 
JOIN StawkaPracownika_CTE ON DanePracownika_CTE.BusinessEntityID = StawkaPracownika_CTE.ID;

SELECT * FROM dbo.TempEmployeeInfo ORDER BY BusinessEntityID;

-- DROP TABLE dbo.TempEmployeeInfo


------------------------------------------------------------------------
USE AdventureWorksLT2019;


--zad2--

WITH CompanyContact_CTE (IDC, CompanyContact)
AS
( 
	SELECT CustomerID, CompanyName+' ('+FirstName+' '+LastName+')'
	FROM SalesLT.Customer
)
,
Revenue_CTE (IDC, Revenue)
AS
(
	SELECT CustomerID, TotalDue 
	FROM SalesLT.SalesOrderHeader
)
SELECT CompanyContact, Revenue
FROM CompanyContact_CTE
JOIN Revenue_CTE ON CompanyContact_CTE.IDC = Revenue_CTE.IDC
ORDER BY CompanyContact;


------------------------------------------------


--zad3--

WITH Category_CTE (IDPC, Category)
AS
(
	SELECT ProductCategoryID, Name
	FROM SalesLT.ProductCategory
	WHERE ParentProductCategoryID = 4
)
,
Lacznik_CTE (IDP, IDPC)
AS
(
	SELECT ProductID, ProductCategoryID
	FROM SalesLT.Product
)
,
SalesValue_CTE (IDP, PSalesValue)
AS
(
	SELECT ProductID, LineTotal
	FROM SalesLT.SalesOrderDetail
)
SELECT Category, CONVERT(DECIMAL(10,2),ROUND(SUM(PSalesValue),2)) AS SalesValue
FROM Category_CTE
JOIN Lacznik_CTE ON Category_CTE.IDPC = Lacznik_CTE.IDPC
JOIN SalesValue_CTE ON Lacznik_CTE.IDP = SalesValue_CTE.IDP
--WHERE Category IN ('Bike Racks', 'Bottles and Cages', 'Cleaners', 'Helmets', 'Hydration Packs', 'Tires and Tubes')
GROUP BY Category
ORDER BY Category;




---------------------------------------------------------------------------------------------------------------------------------------------------
--Przyklady z zajec--

--Przyklad1--
--Definicja wyrazenia CTE i listy kolumn
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
--Definicja zapytania CTE
(
	SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
)
--Definicja zapytania zewnetrzego, ktore bazuje na CTE
SELECT SalesPersonID, YEAR(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE -- FROM bazuje na nazwie CTE zdefiniowanej wy¿ej
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;

--Przyklad2--Srednia sprzedaz handlowcow
WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS
(
	SELECT SalesPersonID, COUNT(*)
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID
)
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM Sales_CTE;

--Przyklad3--
WITH Sales_CTE (SalesPersonID, TotalSales, SalesYear)
AS
--Pierwsze wyrazenie CTE
(
	SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID, YEAR(OrderDate)
)
, --uzyj przecinka, aby oddzieliæ kilka definicji CTE

--Definicja drugiego CTE
Sales_Quota_CTE (BusinessEntityID, SalesQuota, SalesQuotaYear)
AS
(
	SELECT BusinessEntityID, SUM(SalesQuota) AS SalesQuota, YEAR(QuotaDate) AS SalesQuotaYear
	FROM Sales.SalesPersonQuotaHistory
	GROUP BY BusinessEntityID, YEAR(QuotaDate)
)

--Definicja zapytania zewnetrznego, ktore wykorzystuje oba CTE
SELECT SalesPersonID
	, SalesYear
	, FORMAT(TotalSales,'C','en-us') AS TotalSales
	, SalesQuotaYear
	, FORMAT(SalesQuota,'C','en-us') AS SalesQuota
	, FORMAT(TotalSales -SalesQuota,'C','en-us') AS Amt_Above_or_Below_Quota
FROM Sales_CTE
JOIN Sales_Quota_CTE ON Sales_Quota_CTE.BusinessEntityID = Sales_CTE.SalesPersonID
					AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear 
ORDER BY SalesPersonID, SalesYear;