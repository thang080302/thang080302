create database QLbanhang1
use QLbanhang1
go
create table ChiNhanh
(MaChiNhanh nchar(10) primary key not null,
TenCHiNhanh nvarchar(30),
DiaChi nvarchar(30))

create table SanPham
(MaSanPham nchar(10) primary key not null,
TenSanPham nvarchar(30),
MauSac nvarchar(30),
SoLuongCo int,
GiaBan float(20)
)

create table CungUng
(
 MaChiNhanh nchar(10),
 MaSanPham nchar(10),
 SoLuongCungUng int,
 NgayCungUng date,
 primary key (MaChiNhanh,MaSanPham),
 foreign key (MaChiNhanh) references ChiNhanh(MaChiNhanh),
 foreign key (MaSanPham) references SanPham(MaSanPham)
)

insert into ChiNhanh values 
('CN1','Ten1','HaNoi'),
('CN2','Ten2','HaNoi'),
('CN3','Ten3','HaNoi')

insert into SanPham values
('SP1','TSP1','Do',20,10000),
('SP2','TSP2','Do',21,20000),
('SP3','TSP3','Do',22,30000)

insert into CungUng values
('CN1','SP1',10,'2022/2/2'),
('CN1','SP2',11,'2022/2/2'),
('CN1','SP3',12,'2022/2/2'),
('CN2','SP2',13,'2022/2/2'),
('CN3','SP3',14,'2022/2/2')
select * from ChiNhanh
select * from SanPham
select * from CungUng
--2;

create proc SP1(@MaChiNhanh nchar(10),@TenCHiNhanh nvarchar(30),@DiaChi nvarchar(30),@check int output)
as
begin 
	if(exists (select TenCHiNhanh from ChiNhanh))
		set @check = 1
	else 
		set @check = 0
	return @check
end
--call proc
declare @a int
exec dbo.SP1 'CN04','Ten1','HaNoi',@a output
print @a

--3;
alter trigger TG1
on CungUng
for update
as
begin
	declare @masp nchar(10)
	declare @slcu_new int, @slcu_old int, @slco int
	set @masp = (select MaSanPham from inserted)
	set @slco = (select SoLuongCo from SanPham where MaSanPham = @masp)
	set @slcu_new = (select SoLuongCungUng from inserted)
	set @slcu_old = (select SoLuongCungUng from deleted)
	if(@slco + @slcu_old < @slcu_new)
		begin 
			raiserror ('So luong cung ung khong thoa man',16,1)
			rollback tran
		end
	else 
		begin 
			update SanPham set SoLuongCo = SoLuongCo + @slcu_old - @slcu_new
			from SanPham where MaSanPham = @masp
		end
end
select * from SanPham
select * from CungUng
alter table CungUng
nocheck constraint all
update CungUng set SoLuongCungUng = 1000 where MaSanPham = 'SP1'
update CungUng set SoLuongCungUng = 10 where MaSanPham = 'SP1'

--đề 12
create database Class
use Class
create table Khoa
(MaKhoa nchar(10) primary key not null,
TenKhoa nvarchar(30),
DiaDiem nvarchar(30))

create table Lop 
(MaLop nchar(10) primary key not null,
TenLop nvarchar(30),
SiSo int,
MaKhoa nchar(10),
foreign key(MaKhoa) references Khoa(MaKhoa))

create table SinhVien
(MaSV nchar(10) primary key not null,
TenLop nvarchar(30),
NgaySinh date,
GioiTinh bit,
MaLop nchar(10)
foreign key(MaLop) references Lop(MaLop))

insert Khoa values
('K1','TK1','Tang1'),
('K2','TK2','Tang2'),
('K3','TK3','Tang3')

insert Lop values 
('Lop1','TL1',10,'K1'),
('Lop2','TL2',10,'K2'),
('Lop3','TL3',10,'K3')

insert SinhVien values
('SV1','Ten1','2022/2/2',1,'Lop1'),
('SV2','Ten2','2022/2/2',0,'Lop2'),
('SV3','Ten3','2022/2/2',1,'Lop3')

insert SinhVien values
('SV4','Ten2','2022/2/2',0,'Lop2'),
('SV5','Ten3','2022/2/2',1,'Lop3')

select * from Khoa
select * from Lop
select * from SinhVien

--2;
create proc SP01(@ngaysinh date,@check int output)
as
begin
	if(@ngaysinh > getdate())
	begin
		set @check = 1
		raiserror('Loi ngay sinh',16,1)
	end
	else
		set @check = 0
	return @check
end

declare @check int
exec SP01 '2023/2/2',@check output
print(@check)

--3;
alter trigger TG_abc
on SinhVien
for update
as
begin
	declare @masv nchar(10)
	set @masv = (select MaSV from inserted)
	if((select MaSV from deleted) != @masv)
		begin 
			raiserror('Khong cho cap nhap ma sinh vien',16,1)
			rollback tran
		end
	else
		begin
			update Lop set SiSo = SiSo + 1 from Lop where MaLop = (select MaLop from inserted)
			update Lop set SiSo = SiSo - 1 from Lop where MaLop = (select MaLop from deleted)
		end
end

select * from Lop
select * from SinhVien
update SinhVien set MaSV = 1 where MaLop = 'Lop1' -- lỗi

update SinhVien set MaLop = 'Lop2' where MaSV = 'SV1'


