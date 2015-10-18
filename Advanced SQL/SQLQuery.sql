USE TelerikAcademy

/******	1. Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
		Use a nested SELECT statement. ******/

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary  =
	(SELECT MIN(SALARY) FROM Employees)

/******	2. Write a SQL query to find the names and salaries of the employees 
			that have a salary that is up to 10% higher than the minimal salary for the company. ******/

DECLARE @MinSalary int = (SELECT MIN(SALARY) FROM Employees)
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary BETWEEN @MinSalary AND 1.1 * @MinSalary
ORDER BY Salary

/******	3. Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
			Use a nested SELECT statement.	******/

SELECT e.FirstName + ' ' + e.LastName AS 'Full Name', 
	   e.Salary AS 'Salary',
	   d.Name AS 'Departments name'
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = e.DepartmentID
	WHERE Salary =
		(SELECT MIN(SALARY) FROM Employees employees
		WHERE employees.DepartmentID = d.DepartmentID)
		ORDER BY SALARY

/******	4. Write a SQL query to find the average salary in the department #1. ******/

SELECT AVG(Salary) AS 'Average salary'
FROM Employees e
    WHERE DepartmentID = 1

/****** 5. Write a SQL query to find the average salary in the "Sales" department. ******/

SELECT AVG(Salary) AS 'Average salary'
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'

/****** 6. Write a SQL query to find the number of employees in the "Sales" department. ******/

SELECT COUNT(*) AS [Number of employees]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'
	
/****** 7. Write a SQL query to find the number of all employees that have manager. ******/

SELECT COUNT(*) AS [Number of employees with manager]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE e.ManagerID IS NOT NULL
	
/****** 8. Write a SQL query to find the number of all employees that have no manager. ******/

SELECT COUNT(*) AS [Number of employees without manager]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE e.ManagerID IS NULL

/****** 9. Write a SQL query to find all departments and the average salary for each of them. ******/

SELECT d.Name AS [Department],
	   AVG(Salary) AS [Average salary]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	GROUP BY d.Name
	ORDER BY [Average salary]
	
/****** 10. Write a SQL query to find the count of all employees in each department and for each town. ******/

SELECT COUNT(e.EmployeeID) AS [Employees],
	   d.Name AS [Departments],
	   t.Name AS [Towns]   			
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	JOIN Addresses a
		ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
	GROUP BY d.Name, t.Name
	ORDER BY [Employees]

/****** 11. Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name. ******/

SELECT e.FirstName + ' ' + e.LastName AS [Full name]
FROM Employees e
	JOIN Employees employees
		ON employees.ManagerID = e.ManagerID
	GROUP BY e.EmployeeID, E.FirstName, E.LastName
	HAVING COUNT(E.EmployeeID) = 5

 /****** 12. Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)". ******/
 
 SELECT e.FirstName + ' ' + e.LastName AS [Employees full name],
		COALESCE(employees.FirstName + ' ' + employees.LastName, 'no manager') AS [Manager full name]
 FROM Employees e
	  JOIN Employees employees
		ON e.ManagerID = employees.ManagerID

  /****** 13. Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in LEN(str) function. ******/
  
  SELECT e.FirstName + ' ' + e.LastName AS [Employees full name]
  FROM Employees e
	   WHERE LEN(e.LastName) = 5
	   
	/****** 14. Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds".
				Search in Google to find how to format dates in SQL Server.  ******/
	
	SELECT CONVERT(VARCHAR(30),GETDATE(), 113) AS [Current date and time]
	
	/****** 15. Write a SQL statement to create a table Users. Users should have username, password, full name and last login time.
				Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
				Define the primary key column as identity to facilitate inserting records.
				Define unique constraint to avoid repeating usernames.
				Define a check constraint to ensure the password is at least 5 characters long.	******/
				
	CREATE TABLE Users (
		UserID int IDENTITY PRIMARY KEY,
		Username nvarchar(100) NOT NULL UNIQUE,
		Pass nvarchar(200) NOT NULL CHECK(LEN(Pass) > 5),
		FullName nvarchar(150) NOT NULL ,
		LastLogin DateTime NOT NULL,
	)
	GO
	
	/****** 16. Write a SQL statement to create a view that displays the users from the Users table that have been in the system today.
			Test if the view works correctly.  -> NOT COMPILED ******/
			
	CREATE VIEW [Users in system] AS
		SELECT Username
		FROM Users
		WHERE DATEDIFF(DAY, LastLogin, GETDATE()) = 0 
		
	/****** 17. Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint).
				Define primary key and identity column.	******/
				
	CREATE TABLE Groups (
		GroupId int IDENTITY PRIMARY KEY,
		Name nvarchar(150) NOT NULL UNIQUE
	)
	GO
	
	/****** 18. Write a SQL statement to add a column GroupID to the table Users.
				Fill some data in this new column and as well in the `Groups table.
				Write a SQL statement to add a foreign key constraint between tables Users and Groups tables. ******/

	ALTER TABLE Users
		ADD GroupId int NOT NULL
	GO

	ALTER TABLE Users 
		ADD CONSTRAINT FK_Users_Groups
		FOREIGN KEY (GroupId)
		REFERENCES Groups(GroupId)
	GO

	/****** 19. Write SQL statements to insert several records in the Users and Groups tables. ******/

	INSERT INTO Users
		VALUES ('user1', 'User1', 'UserFull1', '18-10-2015-18-53-49-451', 1),
			   ('user2', 'User2', 'UserFull2', '18-10-2015-18-53-19-451', 2),
			   ('user3', 'User3', 'UserFull3', '18-10-2015-08-53-19-451', 3),
			   ('user4', 'User4', 'UserFull4', '15-10-2015-18-53-19-451', 4),
			   ('user5', 'User5', 'UserFull5', '19-10-2015-18-53-19-451', 5),
			   ('user6', 'User6', 'UserFull6', '04-10-2015-18-53-19-451', 6)
			   
	INSERT INTO Groups
		VALUES ('Software'),
			   ('Kendo'),
			   ('Edge'),
			   ('AngularJS'),
			   ('SoftUniverse'),
			   ('TelerikAlgoAcademy')
			   
	/****** 20. Write SQL statements to update some of the records in the Users and Groups tables. ******/
	
	UPDATE Groups
	SET Name = REPLACE(Name, 'name', 'NAME')
	WHERE GroupId % 2 = 0
	
	/****** 21. Write SQL statements to delete some of the records from the Users and Groups tables. ******/
	
	DELETE Groups
	FROM Groups
	WHERE GroupId IN (11, 37)
	
	/****** 22. Write SQL statements to insert in the Users table the names of all employees from the Employees table.
				Combine the first and last names as a full name.
				For username use the first letter of the first name + the last name (in lowercase).
				Use the same for the password, and NULL for last login time. ******/
				
	INSERT INTO Users (Username, FullName, Pass)
			(SELECT CONCAT(FirstName, ' ', LastName),
					LOWER(CONCAT(FirstName, '.', LastName)),
					LOWER(CONCAT(FirstName, '.', LastName))
			FROM Employees)
		GO

	/****** 23. Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010. ******/

	UPDATE Users
	SET Pass = NULL
	WHERE DATEDIFF(day, LastLogin, '2010-3-10 00:00:00') > 0

	/****** 24. Write a SQL statement that deletes all users without passwords (NULL password). ******/

	DELETE Users
	WHERE Pass IS NULL

	/****** 25. Write a SQL query to display the average employee salary by department and job title. ******/


	SELECT AVG(e.Salary) AS [Average employees salary],
			e.JobTitle AS [Job title],
			d.Name AS [Department name]
	FROM Employees e
		JOIN Departments d
			ON e.DepartmentID = d.DepartmentID
		GROUP BY d.Name, e.JobTitle
											   			     
	/****** 26. Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it. ******/
	
	SELECT MIN(e.Salary) AS [Minimal employees salary],
		   MIN(CONCAT(e.FirstName, ' ', e.LastName)),	
		   e.JobTitle AS [Job title],
		   d.Name AS [Department name] 
	FROM Employees e
		JOIN Departments d
			ON e.DepartmentID = d.DepartmentID
		GROUP BY d.Name, e.JobTitle
		
	/****** 27. Write a SQL query to display the town where maximal number of employees work. ******/
	
	SELECT TOP 10(t.Name) AS [Town name], COUNT(e.EmployeeID) AS [Number employees in town]
	FROM Employees e
		JOIN Addresses a
			ON e.AddressID = a.AddressID
		JOIN Towns t
			ON t.TownID = a.TownID
		GROUP BY t.Name
		ORDER BY t.Name ASC

	/****** 28. Write a SQL query to display the number of managers from each town. ******/
	
	SELECT t.Name AS [Town],	
		   COUNT(e.EmployeeID) AS [Manager count]		   	
	FROM Employees e
		JOIN Addresses a
			ON e.AddressID = a.AddressID
		JOIN Towns t
			ON t.TownID = a.AddressID
		GROUP BY t.Name
		
	/****** 29. Write a SQL to create table WorkHours to store work reports for each employee (employee id, date, task, hours, comments).
					Don't forget to define identity, primary key and appropriate foreign key.
					Issue few SQL statements to insert, update and delete of some data in the table.
					Define a table WorkHoursLogs to track all changes n the WorkHours table with triggers.
					For each change keep the old record data, the new record data and the command (insert / update / delete). ******/

	CREATE TABLE WorkHours(
		WorkHoursID int NOT NULL IDENTITY,
		EmployeeID int NOT NULL,
		[Date] datetime,
		task nvarchar(250),
		[Hours] int,
		Comments nvarchar(300),
		CONSTRAINT PK_WorkHours PRIMARY KEY(WorkHoursID),
	 	CONSTRAINT FK_WorkHourss_Employees FOREIGN KEY(EmployeeID)
		REFERENCES Employees(EmployeeID)
		)
	GO

	INSERT INTO WorkHours(EmployeeID, [Date], task, [Hours], Comments)
	VALUES
		(2, '1999-10-05', 'Learn SQL', 10, 'SQL homework'),
		(3, '1999-10-02', 'Learn JS', 11, 'JS homework'),
		(6, '1999-10-07', 'Learn DSA', 9, 'DSA homework'),
		(6, '1999-10-04', 'Learn XML', 5, 'XML homework')

	UPDATE WorkHours
	SET task = 'Telerik'
	WHERE EmployeeID % 2 = 0

	DELETE WorkHours
	WHERE task = 'Telerik'

	CREATE TABLE WorkHourLogs(
		WorksHourLogsID int NOT NULL IDENTITY,
		WorkHourID int NOT NULL,
		EmployeeID int NOT NULL,
		[Date] datetime,
		task nvarchar(250),
		[Hours] int,
		Comments nvarchar(300),
		Command nvarchar(150),
		CONSTRAINT PK_WorksHourLogs PRIMARY KEY(WorksHourLogsID),
		CONSTRAINT FK_WorksHourLogs_Employees FOREIGN KEY(EmployeeID)
		REFERENCES Employees(EmployeeID)
		)
	GO

	CREATE TRIGGER TR_WorkHourInsert ON WorkHours FOR INSERT
	AS
	INSERT INTO WorkHourLogs(WorkHourID, EmployeeID, [Date], task, [Hours], Comments, Command)
	SELECT WorkHoursID, EmployeeID, [Date], task, [Hours], Comments, 'INSERT'
	FROM inserted
	GO

	CREATE TRIGGER TR_WorkHourUpdate ON WorkHours FOR UPDATE
	AS
	INSERT INTO WorkHourLogs(WorkHourID, EmployeeID, [Date], task, [Hours], Comments, Command)
	SELECT WorkHoursID, EmployeeID, [Date], task, [Hours], Comments, 'UPDATE'
	FROM inserted
	GO

	CREATE TRIGGER TR_WorkHourDelete ON WorkHours FOR DELETE
	AS
	INSERT INTO WorkHourLogs(WorkHourID, EmployeeID, [Date], task, [Hours], Comments, Command)
	SELECT WorkHoursID, EmployeeID, [Date], task, [Hours], Comments, 'DELETE'
	FROM inserted
	GO

	DELETE FROM WorkHourLogs

	INSERT INTO WorkHours(EmployeeID, [Date], task, [Hours], Comments)
	VALUES
	(2, GETDATE(), 'test', 3, 'test1'),
	(4, GETDATE(), 'TEST2', 9, 'TEST2')

	UPDATE WorkHours
	SET task = 'TeSt'
	WHERE EmployeeID = 2

	DELETE WorkHours
	WHERE task = 'TeSt'

					
	/****** 30. Start a database transaction, delete all employees from the 'Sales' department along with all dependent records from the pother tables.
					At the end rollback the transaction. ******/
					
	BEGIN TRAN	

	DELETE *
	FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
		WHERE d.Name = 'Sales'
		
	ROLLBACK TRAN
	
	/****** 31. Start a database transaction and drop the table EmployeesProjects.
					Now how you could restore back the lost table data?	******/
					
	BEGIN TRAN
	 
		DROP TABLE EmployeesProjects

	ROLLBACK TRANSACTION
	
	/****** 32. Find how to use temporary tables in SQL Server.
					Using temporary tables backup all records from EmployeesProjects and restore them back after dropping 
					and re-creating the table. ******/
	BEGIN TRAN
					
	SELECT *
		INTO #TemporaryEmployeesProjects
		FROM EmployeesProjects
		
	DROP TABLE EmployeesProjects
	
	SELECT *
		INTO EmployeesProjects
		FROM #TemporaryEmployeesProjects
		
	DROP TABLE #TemporaryEmployeesProjects
	
	ROLLBACK TRANSACTION							 					 												
								 						 	