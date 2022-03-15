create database MManagement
use MManagement 
create table Students(
	StudentID Nvarchar(12) PRIMARY KEY,
	StudentName Nvarchar(25) NOT NULL,
	DateofBirth Datetime NOT NULL,
	Email Nvarchar(40),
	Phone Nvarchar(12),
	Class Nvarchar(10)
)
create table Subjects
(
	SubjectID Nvarchar(10) PRIMARY KEY,
	SubjectName Nvarchar(25) NOT NULL
)
create table Mark
(
	StudentID Nvarchar(12),
	SubjectID Nvarchar(10),	Dates Datetime,	Theory Tinyint,	Practical Tinyint,	constraint pk primary key (SubjectID,StudentID),
	constraint fk_Stu_Mark foreign key(StudentID)
	references Students(StudentID),
	constraint fk_Sub_Mark foreign key(SubjectID)
	references Subjects(SubjectID)
)
select * from Mark
insert into Students
values ('AV0807005', 'Mail Trung Hiếu' ,11/10/1989, 'trunghieu@yahoo.com' ,'0904115116' ,'AV1'),
	   ('AV0807006', 'Nguyễn Quý Hùng' ,2/12/1988 ,'quyhung@yahoo.com', '0955667787' ,'AV2'),	   ('AV0807007', 'Đỗ Đắc Huỳnh' ,2/1/1990 ,'dachuynh@yahoo.com', '0988574747', 'AV2'),	   ('AV0807009', 'An Đăng Khuê' ,6/3/1986, 'dangkhue@yahoo.com' ,'0986757463' ,'AV1'),
	   ('AV0807010', 'Nguyễn T. Tuyết Lan', 12/7/1989 ,'tuyetlan@gmail.com', '0983310342', 'AV2'),
	   ('AV0807011', 'Đinh Phụng Long', 2/12/1990, 'phunglong@yahoo.com',NULL, 'AV1'),
	   ('AV0807012', 'Nguyễn Tuấn Nam', 2/3/1990, 'tuannam@yahoo.com',NULL, 'AV1')

insert into Subjects
values ('S001' ,'SQL'),
	   ('S002' ,'Java Simplefield'),
	   ('S003', 'Active Server Page')

insert into Mark
values ('AV0807005', 'S001', 6/5/2008 ,8 ,25),
	   ('AV0807006', 'S002', 6/5/2008 ,16 ,30 ),
	   ('AV0807007', 'S001', 6/5/2008 ,10 ,25  ),
	   ('AV0807009', 'S003', 6/5/2008 ,7 ,13 ),
	   ('AV0807010', 'S003', 6/5/2008 ,9 ,16 ),
	   ('AV0807011', 'S002', 6/5/2008 ,8 ,30 ),
	   ('AV0807012', 'S001', 6/5/2008 ,7 ,31 ),
	   ('AV0807005', 'S002', 6/6/2008 ,12 ,11  ),
	   ('AV0807012', 'S003', 6/6/2008 ,11 ,20 ),
	   ('AV0807010', 'S001', 6/6/2008 ,7 ,6 )
--1;
select * from Students
select * from Subjects

--2;
select * from Students
where Class = 'AV1'
 
--3;
update Students
set Class = 'AV2'
where StudentID = 'AV0807012'

--4;
select Class,count(StudentID) N'Số sinh viên'
from Students
group by Class

--5;
select * 
from Students
where Class = 'AV2'
order by StudentName 

--6;
select StudentID  from Mark
where Theory < 10 and Dates = '6/5/2008'

--7;
select count(StudentID)'Số sinh viên không đạt'
from Mark
where SubjectID = 'S001' and Theory < 10

--8;
select * 
from Students
where Class = 'AV1' and DateofBirth < '1/1/1980'

--9;
delete from Mark 
where StudentID = 'AV0807011'
delete from Students
where StudentID = 'AV0807011'

--10;
select Mark.StudentID,
	   StudentName, 
	   Subjects.SubjectName, 
	   Theory, 
	   Practical, 
	   Dates
from Students inner join Mark on Students.StudentID = Mark.StudentID
			  inner join Subjects on Mark.SubjectID = Subjects.SubjectID
where Mark.SubjectID = 'S001' and Dates = '6/5/2008'

select * from Mark
select * from Students
select * from Subjects