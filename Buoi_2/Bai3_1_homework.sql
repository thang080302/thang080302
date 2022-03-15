use DeptEmp
--1;
select * from department

--2;
select * from Employee

--3;
select EmpNo,Fname,Lname 
from Employee
where Fname = 'Kate'

--4;
select Fname + ' ' + Lname 'Fullname',
	   Salary,
	   Salary * 0.1 N'10% Lương'
from Employee

--5;
select Fname,Lname,HireDate 
from Employee
where year(HireDate) = 1981
order by Lname

--6;
select avg(Salary) N'Trung Bình',
	   max(Salary) N'Max',
	   min(Salary) N'Min'
from Employee

--7;
select departmentNo, count(EmpNo) N'Số người trong từng phòng ban'
from Employee
group by departmentNo

--8;
select Department.DepartmentNo,
	   DepartmentName,
	   Fname + Lname 'Fullname',
	   Job, Salary
from Department inner join Employee 
				on Department.DepartmentNo = Employee.DepartmentNo

--9;
select Department.DepartmentNo,
	   Department.DepartmentName,
	   Department.Locations ,
	   count(EmpNo)
from Employee inner join Department
			  on Department.DepartmentNo = Employee.DepartmentNo
group by Department.DepartmentNo,
		 departmentName,
		 Locations

--10;
select Department.DepartmentNo,
	   Department.DepartmentName,
	   Department.Locations ,
	   count(EmpNo) N'Số người có trong từng phòng ban'
from Employee full outer join Department
			  on Department.DepartmentNo = Employee.DepartmentNo
group by Department.DepartmentNo,
		 departmentName,
		 Locations