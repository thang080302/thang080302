create database DeptEmp
use DeptEmp
create table Department
(
	DepartmentNo Integer PRIMARY KEY ,
	DepartmentName Char(25) NOT NULL,
	Locations Char(25) NOT NULL
)
create table Employee
(
	EmpNo Integer PRIMARY KEY,
	Fname varchar(15) NOT NULL,
	Lname Varchar(15) NOT NULL,
	Job Varchar(25) NOT NULL,
	HireDate Datetime NOT NULL,
	Salary Numeric NOT NULL,
	Commision Numeric ,
	DepartmentNo Integer ,
	constraint fk FOREIGN KEY (DepartmentNo)
		references Department(DepartmentNo)
)
insert into Department values
	(10, 'Accounting' ,'Melbourne'),
	(20, 'Research' ,'Adealide'),
	(30 ,'Sales' ,'Sydney'),
	(40 ,'Operations', 'Perth')

insert into Employee values 
	(1, 'John',' Smith',' Clerk', '17-Dec-1980', 800, null, 20),
	(2, 'Peter',' Allen', 'Salesman','20-Feb-1981', 1600, 300, 30),
	(3, 'Kate', 'Ward', 'Salesman', '22-Feb-1981' ,1250, 500, 30),
	(4, 'Jack',' Jones',' Manager',' 02-Apr-1981', 2975, null, 20),
	(5 ,'Joe',' Martin',' Salesman',' 28-Sep-1981', 1250, 1400, 30)