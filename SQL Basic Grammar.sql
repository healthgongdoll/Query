/**
SQL MASTERPIECE 

SQL SELECT STATEMENT 
	- Used to Select Data from a database 
    Select column1, column2, ... FROM table_name 
    
    SELECT * FROM TABLE;
    SELECT CustomerName, CustomerID FROM Customers;
    
SQL SELECT DISTINCT Statement 
	- if you dont want the duplicate use DISTINCT 
    
	SELECT DISTINCT Country FROM Customer 
    
    - If you want to Count the Number of Customers as a table 
    
    SELECT COUNT(DISTINCT Country) FROM Customers;
    OR
    SELECT COUNT(*) AS DistinctCountries FROM (SELECT DISTINCT Country FROM Customers 
    
SQL WHERE Clause 
	- extract only that fulfill a specified condition.
    
		SELECT Column1, Column2,... FROM Table_name WHERE condition; 
        
	- However, Becareful about when you do multiple tables, Since SQL automatically produces the 'CROSS PRODUCT' JOIN Condition must needed
    
		EX) SELECT Fname, Lname, Address FROM Employee, Department WHERE Dname = 'Research' AND Dno = Dnumber
        
        Dno = Dnumber -> must needed to avoid having a wrong value 'Usually Foreign Key' 
	- Operator in the Where Clause 
		= Equal , > Greater, < Less >= Greater equal, <= Lesser Equal, <> Not equal, BETWEEN range, LIKE Search for a pattern, IN to specify multiple possible values for a column
        
        SELECT * FROM Customers WHERE City IN ('Paris', 'London'); 

SQL AND,OR, NOT Clauses
	SELECT * FROM Customers WHERE Country='Germany' AND (City='Berlin' OR City='München');
    SELECT * FROM Customers WHERE NOT Country='Germany' AND NOT Country='USA';

SQL ORDER BY KeyWord 
	
    The ORDER BY Keyword is used to sort the result - set in ascending or descending order 
    The ORDER BY Keyword sorts the records in ascending order by default. To sor the record in descending order, use the DESC keyword
    
    SELECT column1, column2, ... FROM talbe_name ORDER BY colum1, colum2, ASC|DESC;
    
    SELECT * FROM Customers ORDER BY Country
    
    Multiple Columns Example: SQL statement selects all customers from the "Customers" table, sorted by the "COUNTRY" and the "CustomerName" column.
    Means that it order by Country, but if some row have the same Country, it orders by CustomerName
    
    SELECT * FROM Customers ORDER BY Country, CustomerName;
    SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;
    
SQL INSERT INTO Statement 
	
    The INSERT INTO statement is used to insert new records in a table. 
    
    1. Specify both the column names and the values to be inserted: 
		INSERT INTO tableName (column1, colum2, colum3, ...) VALUES (value1, value2, value3, ...) 
	2. If you are adding values for all the columns
		INSERT INTO tableName VALUES (value1,value2,value3,...) 
        
SQL IS NULL and IS NOT NULL 
	
	It is impossible to test for NULL values with comparison operators, such as =,<,or <>. 
    
    IS NULL Syntax 
		SELECT column_names FROM table_name WHERE column_name IS NULL; 
	
    IS NOT NULL Syntax 
		SELECT column_names FROM table_name WHERE column_name IS NOT NULL; 
	
SQL UPDATE statement 
	NOTE ** The WHERE clause specifies which record(s) that should be updated. If you omit the WHERE clause, all records in the table will be updated! 
	UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition
    
SQL DELETE statement 
	NOTE ** DELETE satement is used to delete exisiting records in a table. 
    DELETE FROM table_name WHERE condition; 
    
    Notice WHERE clause in the DELETE statement. The WHERE Clause specifies which record(s) should be deleted. If you omit WHERE clause all records in the table will be deleted

SQL MIN() and MAX() Functions 
	
    The MIN() function returns the smallest value of the selected column. 
    The MAX() function returns the largest value of the selected column. 
    
    MIN() Syntax 
		SELECT MIN(column_name) FROM table_name WHERE condition; 
	MAX() Syntax 
		SELECT MAX(column_name) FROM table_name WHERE condition; 
        
	SELECT MAX(Price) As LargestPrice FROM Products;
    SELECT MIN(Price) As SmallestPrice FROM Products;

SQL COUNT(), AVG(), and SUM() Functions 
	
    COUNT()
	The COUNT() function returns the number of rows that matches a specified criterion 
    SELECT COUNT(column_name) FROM table_name WHERE condition 
    
    AVG()
    The AVG() function returns the average value of a numeric column.
    SELECT AVG(column_name) FROM table_name WHERE condition
    
    SUM()
    The SUM() function returns the total sum of a numeric column.
    SELECT SUM(column_name) FROM table_name WHERE condition 

SQL LIKE Operator
	
    LIKE Operator is used in a WHERE clause to search for a specified pattern in a column. 
		- Two Wildcards 
			% - Represents Zero, One, or Multiple Characters 
            _ - Represents one, single character 
		
        Ex)
			WHERE CustomerName LIKE 'a%' Finds any values that start with "a"
            WHERE CustomerName LIKE '%a' Finds any values that end with "a"
            WHERE CustomerName LIKE '%or%' Finds any values that have "or" in any position 
            WHERE CustomerName LIKE '_r%' Finds any values that have "r" in the second position 
            WHERE CustomerName LIKE 'a_%' Finds any values that start with "a" and are at least 2 characters in length 
            WHERE CustomerName LIKE 'a__%' Finds any values that start with "a" and are at least 3 characters in length 
            WHERE Contactname LIKE 'a%o' Finds any values that start with "a" and ends with "o" 

SQL IN Operator 

	The IN operator allows you to specify multiple values in a WHERE clause 
    The IN operator is shorthand for multiple OR conditions. 
    
    IN Syntax 
    
    SELECT column_name FROM table_name WHERE column_name IN (value1, value2, value3...) 
    
    or 
    
    SELECT column_name FROM table_name WHERE column_name IN (SELECT STATEMENT) 
    SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);

SQL BETWEEN Operator 

	The BETWEEN operator selects values within a given range. 
    
    SELECT column_name FROM table_name WHERE column_name BETWEEN value1 AND value2; 
    SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;
    
SQL JOIN 

	A JOIN clause is used to combine rows from two or more tables, based on a related columns between them 
    
    SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;
    
    Different Types of SQL JOINS 
    - (INNER) JOIN: Returns records that have matching values in both tables 
    - LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table 
    - Right (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table 
    - FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table 

	INNER JOIN Syntax 
		SELECT column_name(s) FROM table1 INNER JOIN table2 ON table1.column_name = table2.column_name;
	
    TRIPLE INNER JOIN Syntax 
		SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName FROM ((Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID) INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);
	
SQL GROUP BY 
	
    The GROUP BY Statement Groups rows that have the same values into summary rows, like "find the number of customers in each country"
    
    The GROUP BY statement is often used with aggregate functions (COUNT(),MAX(),MIN(),SUM(),AVG()) to group the result - set by one or more columns. 
    
    SELECT column_name(s)
    FROM table_name 
    WHERE condition
    GROUP BY column_name 
    ORDER BY column_name 
    
    SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country; 
    SELECT Shippers.ShipperName,COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID GROUP BY ShipperName;
    
SQL HAVING Syntax 
	
    The HAVING clause was added to SQL because the WHERE keyword can not be used with aggregate functions. 

	SELECT column_name(s) 
	FROM table_name
    WHERE condition
    GROUP BUY column_name(s)
    HAVING condition
    ORDER BY column_name(s);
    
    SELECT COUNT(CustomerName),Country FROM Customers GROUP BY Country HAVING COUNT(CustomerName) > 5

SQL EXISTS Operator 

	The EXISTS operator is used to test for the existence of any record in a subquery.
    The EXISTS operator returns TRUE if the subquery returns one or more records 
    
    SELECT column(s) FROM table_name WHERE EXISTS (SELECT column_name FROM table_name WHERE condition); 
    
    SELECT SupplierName FROM Suppliers WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

**/