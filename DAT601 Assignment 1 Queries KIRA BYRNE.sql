--1
SELECT ProductName
From Product
ORDER by ProductName asc;

--2
SELECT ProductID, ProductPrice, ProductName
From Product
ORDER BY ProductPrice, ProductName asc;

--3
SELECT ProductID, ProductPrice, ProductName
From Product
ORDER BY ProductPrice desc, ProductName asc;

--4
SELECT ProductName, ProductPrice
From Product
WHERE ProductPrice = '3.49';

--5
SELECT ProductName, ProductPrice
From Product
WHERE ProductPrice <'10.00';

--6
SELECT ProductID, ProductName
From Product
WHERE VendorID <> 'DLL01';

--7
SELECT ProductName, ProductPrice
From Product
WHERE ProductPrice BETWEEN '5.00' and '10.00';

--8
SELECT ProductName, ProductPrice
From Product
WHERE ProductPrice >= '10.00' AND (VendorID = 'DLL01' OR VendorID = 'BRS01');

--9
SELECT AVG (ProductPrice)
FROM Product;

--10
SELECT (COUNT(*)) AS TotalCustomers
From Customer;

--11
SELECT (COUNT(*)) AS TotalCustomerEmails
FROM Customer
WHERE CustEmail IS NOT NULL;
--OR
SELECT (COUNT(CustEmail)) AS TotalCustomerEmails
FROM Customer;

--12
SELECT (COUNT(ProductDesc)) AS ProductTypes, (MIN(ProductPrice)) AS MinPrice, (MAX(ProductPrice)) AS MaxPrice, (AVG(ProductPrice)) AS AvgPrice
FROM Product;

--13
SELECT VendorName v, ProductName p, ProductPrice p
FROM Product
LEFT JOIN Vendor ON Product.VendorID = Vendor.VendorID;

--14 (talked to Todd as answers as conflicting with expectation but statement is still correct)
SELECT ProductName p, VendorName v, ProductPrice p, Quantity o, OrderID o
FROM Product
INNER JOIN Vendor ON Product.VendorID = Vendor.VendorID
RIGHT JOIN OrderItem ON Product.ProductID = OrderItem.ProductID
WHERE OrderID = '20007';


--15 Pre-nested queries
SELECT OrderID
FROM OrderItem
WHERE ProductID = 'RGAN01';

SELECT CustID 
FROM OrderEntry
WHERE OrderID = '20007' or OrderID = '20008';

SELECT CustName, CustContact
From Customer
WHERE CustID = '1000000004' or CustID = '1000000005';

--15 Nested (Was able to get answer through this but could not figureout where to place the OrderItem query)
SELECT CustName, CustContact
From Customer
WHERE CustID IN 
	(SELECT CustID FROM OrderEntry WHERE OrderID ='20007' or OrderID = '20008' and CustID = '1000000004' or CustID = '1000000005');

--16 (UNFINISHED)
SELECT CustName, CustCity, (SELECT COUNT(OrderID) FROM OrderEntry) AS 'Number of Orders'
FROM Customer


--17
SELECT CustName, CustContact, CustEmail
FROM Customer
WHERE CustCity = 'Nelson' or CustCity = 'Wellington'
UNION
SELECT CustName, CustContact, CustEmail
FROM Customer 
WHERE CustCity = 'Auckland' and CustName = 'Fun4All'
ORDER BY CustName, CustContact asc;

--18 (Could only make it work with orderID and productID columns as 'where' clause in query wouldn't take invalid columns
DROP VIEW [ProductCustomer];

CREATE VIEW [ProductCustomer] AS
SELECT CustName, CustContact, OrderItem.OrderID,ProductID
FROM Customer
LEFT JOIN
OrderEntry on OrderEntry.CustID = Customer.CustID
RIGHT JOIN
OrderItem on OrderItem.OrderID = OrderEntry.OrderID

SELECT * FROM [ProductCustomer]
WHERE ProductID = 'RGAN01'

--19
-- Create customer
INSERT INTO Customer (CustID, CustName, CustPhone)
VALUES ('1000000006', 'The Toy Emporium', '09-546-8552');

--Query
SELECT CustName, CustAddress, CustCity, CustPhone
FROM Customer

--View
CREATE VIEW [CustomerMailingLabel] AS
SELECT CustName, CustAddress, CustCity, CustPhone
FROM Customer

-- Refined View
SELECT * FROM [CustomerMailingLabel]
WHERE CustAddress is not NULL and CustCity is not NULL;