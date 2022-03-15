create database QLSinhVien
use QLSinhVien

create table Khoa
(MaKhoa nchar(10) primary key,
TenKhoa nvarchar(30))

create table Lop
(MaLop nchar(10) primary key,
TenLop nvarchar(30),
SiSo int,
MaKhoa nchar(10),
foreign key(MaKhoa) references Khoa(MaKhoa))

create table SinhVien
(MaSV nchar(10),
HoTen nvarchar(30),
NgaySinh date,
GioiTinh bit,
MaLop nchar(10),
foreign key(MaLop) references Lop(MaLop))

insert Khoa values 
('MK01','TK01'), 
('MK02','TK02')

insert Lop values
('ML01','TL01',80,'MK01'),
('ML02','TL02',75,'MK02')

insert SinhVien values
('SV1','Ten1','2022/2/2',1,'ML01'),
('SV2','Ten2','2022/2/2',1,'ML01'),
('SV3','Ten3','2022/2/2',1,'ML01'),
('SV4','Ten4','2022/2/2',1,'ML02'),
('SV5','Ten5','2022/2/2',1,'ML02'),
('SV6','Ten6','2022/2/2',1,'ML02'),
('SV7','Ten7','2022/2/2',1,'ML02')

--cau2 : 
create view view1
as
select TenKhoa,count(MaLop) as N'Số Lớp' from Khoa inner join Lop on Lop.MaKhoa=Khoa.MaKhoa
group by TenKhoa

select * from view1

--caau3:
alter function F1(@makhoa nchar(10))
returns @List table
(MaSinhVien nchar(10),
HoTen nvarchar(30),
NgaySinh date,
GioiTinhh nvarchar(5),
TenLop nvarchar(30),
TenKhoa nvarchar(30))
as
begin
	insert into @List 
		select MaSV,HoTen,NgaySinh,GioiTinhh = 'Nam',TenLop,TenKhoa 
		from SinhVien inner join Lop on Lop.MaLop=SinhVien.MaLop
					  inner join Khoa on Khoa.MaKhoa = Lop.MaKhoa
		where Khoa.MaKhoa=@makhoa and GioiTinh = 1
	insert into @List 
		select MaSV,HoTen,NgaySinh,GioiTinhh = N'Nữ',TenLop,TenKhoa 
		from SinhVien inner join Lop on Lop.MaLop=SinhVien.MaLop
					  inner join Khoa on Khoa.MaKhoa = Lop.MaKhoa
		where Khoa.MaKhoa=@makhoa and GioiTinh = 0
	return 
end
select * from F1('MK01')

create trigger TG1
on SinhVien
for insert
as
	begin
		declare @malop nchar(10),@siso int
		set @malop = (select MaLop from inserted)
		set @siso = (select SiSo from Lop where MaLop = @malop)
		if(@siso > 80)
			begin
				raiserror('Lop nhieu hon 80sv',16,1)
				rollback tran
			end
		else 
			update Lop set SiSo = @siso + 1
			from Lop where MaLop = @malop
	end

select * from Lop
select * from SinhVien
insert SinhVien values
('SV9','Ten9','2022/2/2',0,'ML02'),
('SV10','Ten10','2022/2/2',0,'ML02')