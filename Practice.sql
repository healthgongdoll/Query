-- SELECT <Attribute list> FROM <TABLE list> WHERE <Condition>
-- If you want to put all the rows 
SELECT Fname,Minit,Lname,Dname FROM EMPLOYEE,Department;
SELECT Fname,Minit,Lname,Dname FROM EMPLOYEE,Department WHERE Dname = 'Research';

-- Query 0 Retrieve the birth date and address of the employee whose name is 'John Smith'
SELECT Bdate, Address From Employee where Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

-- Query 1 Retrieve the name and address of all employees who work for the 'Research Department'
 SELECT Fname,Minit,Lname,address From Employee,Department Where Dname = 'Research' and Dnumber = Dno;
-- Important Point, If there are some columns, If we have to retrive even though we dont use that as the output, we have to bring the tables in From clause
-- Why we need second condition Dnumber = Dno -> One default feature, when you specify multiple tables
-- in the From Clause SQL automatically performs the cross product of the rows from all those table 
-- Joint Condition is used to basically specify 
-- Basically Foreign Key Column is mostly join Columns , So can filter unnecessary data 
-- Dnumber = Dno (To Join) 

-- Query 2 For every project located in 'Stafford', list the project number, the controlling department number and the department manager's last name 
Select Pnumber, Dnum, Lname, address, Bdate From Employee, Project, Department Where Plocation = 'Stafford' AND Dnum = Dnumber AND Mgr_ssn = Ssn;

-- Aliases 
-- Query 8 For each employee, retrieve the employee's first and last name and the first and last name of his or her immediate supervisor.
Select E.Fname, E.Lname, S.Fname, S.Lname From Employee As E, Employee As S Where E.Super_Ssn = S.Ssn;

-- Tables as Set in SQL 
-- SET Operations 
-- UNION, EXCEPT (Difference), INTERSECT 
-- Corresponding multiset operations: UNION ALL, EXCEPT ALL, INTERSECT ALL
-- Query 4 Make a list of all project numbers for project that involve an emplouee whose last name is 
-- ' Smith' either as a worker or as a manager of the department that controls the project 

-- Will bring the distinct Pnum, Lname employee whose last name is smith in manager department
(Select Distinct Pnumber FROM EMPLOYEE, PROJECT,DEPARTMENT WHERE Lname = 'Smith' AND  Dnum = Dnumber AND Mgr_ssn = Ssn);

(Select Distinct Pnumber FROM Employee, Project, WORKS_ON WHERE Lname = 'Smith' AND Pnumber = Pno AND Essn = Ssn);
-- Will bring the distinct Pnum, Lname employee whose last name is smith in employee will come up 
-- Union All -> Displays Twice // Union -> Appear once 

-- Query 13. Show the resulting salaries if every employee working on the "ProductX" Project is given a 10 percent raise 
Select * From Employee;
Select E.Fname, E.Lname, 1.1 * E.Salary As Increased_sal From Employee as E, WORKS_ON AS W, PROJECT as P Where E.Ssn = W.ESsn AND W.Pno = P.Pnumber AND P.Pname = 'ProductX';

-- Query Insert Command (Insert multiple tuples where a new table is loaded values from the result of a query 
-- YOU MUST DEFINE THE WORKS_ON_INFO TABLE 
CREATE TABLE WORKS_ON_INFO(
Emp_name CHAR(20),
Proj_name CHAR(20),
Hours_per_week CHAR(20)
);
INSERT INTO WORKS_ON_INFO (Emp_name,Proj_name,Hours_per_Week)
		Select E.Lname, P.Pname, W.Hours
        From Project P, WORKS_ON W, EMPLOYEE E 
        WHERE P.PNumber = W.Pno AND W.Essn = E.Ssn;
Select * from WORKS_ON_INFO;
-- Another variation of INSERT is used for bulk loading of several tuples into tables 
-- A new table NEW can be created with the same attributes as T and using LIKE and DATA in the syntax, it can be loaded with entire data. 
CREATE TABLE DEPT_LOC_MGR(
	Dlocation VARCHAR(15) NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    PRIMARY KEY(Dlocation, Mgr_ssn)
);

INSERT INTO DEPT_LOC_MGR
SELECT Dlocation, Mgr_ssn -- If we switch the order it will occur an error 
FROM DEPARTMENT, DEPT_LOCATIONS
WHERE DEPARTMENT.Dnumber = DEPT_LOCATIONS.Dnumber ;

SELECT * FROM DEPT_LOC_MGR;


-- TABLE PROJECT RUNNING CERTAIN LOCATION
-- ONLY PROJECT LOCATION IS AT HOUSTON
CREATE TABLE PROJECTS_AT_HOUSTON
SELECT  *
FROM PROJECT
WHERE Plocation = 'Houston';

Select * from PROJECTS_AT_HOUSTON;

/**
SQL uses Three value logic:
FALSE & UNKNOWN = FALSE 
TRUE & UNKNOWN => Unknown
**/

-- Test for NULL 
-- IS or IS NOT NULL 
-- Query 18 Retrieve the names of all employees who do not have supervisiors 
Select Fname, Lname from EMPLOYEE Where Super_ssn is NULL;

-- IN Comparison 
-- Query 

SELECT DISTINCT Pnumber
FROM PROJECT 
WHERE Pnumber IN 
(SELECT Pnumber FROM PROJECT, DEPARTMENT, EMPLOYEE Where Dnum = Dnumber AND Mgr_ssn=Ssn AND Lname = 'Smith')
or 
Pnumber IN
(Select Pno From WORKS_ON,EMPLOYEE Where Essn=Ssn And Lname = 'Smith');

-- Use Tuples of values in Comparisons 
 SELECT DISTINCT Essn FROM WORKS_ON WHERE (Pno,Hours) IN (SELECT Pno,Hours FROM WORKS_ON WHERE Essn ='123456789');
 -- Can be Explicit as well
 SELECT DISTINCT Essn FROM WORKS_ON WHERE Pno IN (1,2,3);
 
 -- ANY & ALL Operator 
 -- ANY -  "=" Returns true if the value v equal to some value in the set V and in hence equivalent to insert
 -- ALL : value must exceed all values from nested query 
 
 SELECT Lname, Fname
 From EMPLOYEE 
 WHERE Salary = ANY ( SELECT Salary From EMPLOYEE WHERE Dno =5);
 
 
 -- USE OF EXISTS 
 -- Query 7
 -- From employee, we take all the rows one by one and for the inner query check if the inner query produces some output or not, if it produces yes
 -- if it is not produces output no 
 -- EXISTS -> Check whether the result of a correlated nested query is empty or not. TRUE or FALSE 
 -- UNIQUE -> Return TRUE if there are no duplicate tuples in the result of nested query 
 INSERT INTO DEPENDENT VALUE('888665555','SON','M','1937-11-10','FATHER');
 SELECT Fname, Lname FROM Employee WHERE EXISTS
 (SELECT * FROM DEPENDENT WHERE Ssn = Essn) and Exists (Select * From department Where ssn = Mgr_ssn) ;
 
 SELECT Dnumber, Dname FROM DEPARTMENT WHERE EXISTS( SELECT * FROM PROJECT WHERE Dnumber = Dnum);

-- Cross Product when have <> -> Not work as a join which means  
 SELECT  Dnum, Dname FROM DEPARTMENT, PROJECT WHERE Dnumber <> Dnum;
 
 -- Query 1 Retrieve the name and address of all employees who work for the 'Research' Department 
 
 SELECT Fname,Lname,Address FROM (EMPLOYEE JOIN DEPARTMENT ON Dno=Dnumber) WHERE Dname = 'Research';
 
 -- SAME AS BELOW
 SELECT Fname, Lname, Address
 FROM EMPLOYEE, DEPARTMENT 
 WHERE Dname = 'Research' AND Dnumber = Dno;