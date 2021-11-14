/**
Retrieve the names of all employees in department 5 who work more 
than 10 hours per week on the ProductX project
**/

SELECT DISTINCT Fname,Lname,Dno, Hours, Pname FROM(Employee Join Works_on ON Ssn = Essn) Left Join Project on Pnumber = Pno WHERE Dno = 5 AND Hours > 10.0 AND Pname = 'ProductX';


/**
List the names of all employees who have a dependent with the same first 
name as themselves.
**/

SELECT Fname, Lname, Dependent_name FROM (Employee Join Dependent on Ssn = Essn) WHERE Dependent_name = Fname;

/**
Find the names of all employees who are directly supervised by ‘Franklin 
Wong’.
**/

SELECT E.Fname, E.Lname FROM Employee as E, Employee as S WHERE E.Super_ssn = S.Ssn AND S.Fname = 'Franklin' AND S.Lname = 'Wong';

/**
For each department whose average employee salary is more than 
$30,000, retrieve the department name and the number of employees 
working for that department.
**/

SELECT Dname, COUNT(*) FROM (Department  join Employee on Dno = Dnumber) Where Salary > 30000 Group By Dname ; 

/**
Suppose that we want the number of male employees in each department 
making more than $30,000, rather than all employees (as in Exercise 7.5a). Can we specify this query in SQL? Why or why not?
**/
SELECT Dname, COUNT(*) FROM (Department  join Employee on Dno = Dnumber) Where Salary > 30000 AND Sex = 'M' Group By Dname; 

/**
Retrieve the names of all employees who work in the department that has 
the employee with the highest salary among all employees.
**/

SELECT Dname, Fname, Lname , salary FROM (Department join Employee on Dno = Dnumber) GROUP BY Dname having salary = Max(salary);

SELECT Dname, Fname, Lname , salary FROM (Department join Employee on Dno = Dnumber) GROUP BY Dname;
/**
Retrieve the names of all employees whose supervisor’s supervisor has 
‘888665555’ for Ssn.
Select * FROM Employee AS S WHERE S.super_ssn = '888665555';
Select * FROM Employee;

**/
SELECT Dname, Fname, Lname, Salary FROM Employee e, Department d WHERE (e.ssn, e.salary) IN (SELECT Ssn, (MAX(salary)) as Salary FROM Employee GROUP BY Dno) AND e.Dno = d.Dnumber;

SELECT * From Department, Employee where Dname = 'research';
SELECT Fname,Lname FROM EMPLOYEE AS E WHERE E.Super_ssn in (Select ssn FROM Employee AS S WHERE S.super_ssn = '888665555');

/**
Find the names and addresses of all employees who work on at least one project located in Houston but whose department has no location in Huston 
**/

SELECT *
FROM Employee, DEPT_LOCATIONS, Project, WORKS_ON 
WHERE Employee.ssn = WORKS_ON.Essn -- Join
AND WORKS_ON.pno = Project.pnumber -- Join
AND PROJECT.Dnum = DEPT_LOCATIONS.Dnumber -- Join
AND Project.Plocation = 'Houston' 
AND DEPT_LOCATIONS.Dnumber = Employee.Dno -- Join
AND DEPT_LOCATIONS.Dlocation != 'Houston'; 

