create database QLSV
use QLSV

create table LOP
(
	MaLop int primary key,
	TenLop varchar(5),
	Phong int
)

create table SV
(
	MaSV int primary key,
	TenSV varchar(5),
	MaLop int,
	foreign key (MaLop) references Lop(MaLop)
)



insert into LOP values
(1,'CD',1),
(2,'DH',2),
(3,'LT',2),
(4,'CH',4)

insert into SV values
(1,'A',1),
(2,'B',2),
(3,'C',1),
(4,'D',3)

select * from SV
select * from LOP

--1;
create function F_check(@malop int)
returns int
as 
begin
	declare @dem int
	select @dem = count(SV.MaSV)
	from SV inner join LOP
	on SV.MaLop = LOP.MaLop
	where LOP.MaLop = @malop
	group by LOP.TenLop
	return @dem
end
select DBO.F_check(1) as N'Tổng số dinh viên trong lớp'

--2;
create function ListSV(@tenlop varchar(5))
returns @List table (
						MaSV int,
						TenSV varchar(5)
					)
as
begin 
	insert into @List
	select MaSV,TenSV from SV inner join LOP
						on SV.MaLop = LOP.MaLop
	where TenLop = @tenlop
	return
end
select * from DBO.ListSV('CH')

--3;
create function Thongke(@tenlop varchar(5))
returns @List table (
					MaLop int,
					TenLop varchar(5),
					Soluong int
					)
as
begin
if(not exists(select MaLop from Lop where TenLop = @tenlop))
	insert into @List
		select LOP.MaLop, LOP.TenLop,count(SV.MaSV) as 'Số lượng'
		from LOP inner join SV on LOP.MaLop = SV.MaLop
		group by LOP.MaLop, LOP.TenLop
else
	insert into @List
		select LOP.MaLop, LOP.TenLop,count(SV.MaSV) as 'Số lượng'
		from LOP inner join SV on LOP.MaLop = SV.MaLop
		where LOP.TenLop = @tenlop
		group by LOP.MaLop, LOP.TenLop
	return
end


select * from Thongke('CF')
--4;

create function Find_class(@tensv varchar(5))
returns @List table (TenSv varchar(5),
					 TenPhong int)
as
begin 
	insert into @List
	select TenSV, Phong from LOP inner join SV on SV.MaLop = LOP.MaLop
	where SV.TenSV = @tensv 
	return 
end
--5;
create function Find_room(@tenphong int)
returns @List table (
						MaSV int,
						TenSV varchar(5),
						TenLop varchar(5)
					)
as
begin
	if(not exists (select Phong from LOP where Phong = @tenphong))
		insert into @List
			select SV.MaSV, SV.TenSV, LOP.Phong 
			from SV inner join LOP on SV.MaLop = LOP.MaLop
	else 
		insert into @List
			select SV.MaSV, SV.TenSV, LOP.Phong 
			from SV inner join LOP on SV.MaLop = LOP.MaLop
			where LOP.Phong = @tenphong
	return
end
select * from Find_room(2)

--6;
create function Count_class(@tenphong int)
returns int
as
begin
	declare @a int
	if(not exists (select Phong from LOP where Phong = @tenphong))
		 set @a = 0
			
	else 
		select @a = count(LOP.MaLop)
		from LOP
		where Lop.Phong = @tenphong
		group by LOP.Phong
	return @a
end

select dbo.Count_class(2) as N'Số lớp trong phòng'
