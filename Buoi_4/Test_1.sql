create database QLSV1
use QLSV1
create table SinhVien
(
 MaSV nchar(10) primary key not null,
 HoTenSV nvarchar(30),
 SoDT nvarchar(10),
 Diachi nvarchar(30),
 SoCMT nchar(20)
)
create table MonHoc
(
 MaMH nchar(10) primary key not null,
 TenMH nvarchar(30),
 SoTinChi int
)
create table KetQua
(
 MaSV nchar(10),
 MaMH nchar(10),
 DiemTX1 float,
 DiemTX2 float,
 DiemThi float,
 primary key(MaSV,MaMH),
 foreign key(MaSV) references SinhVien(MaSV),
 
 foreign key(MaMH) references MonHoc(MaMH),
)

insert SinhVien values
('SV01','Ten1',1234,'HaNoi',12334),
('SV02','Ten2',1235,'HaNoi',12335),
('SV03','Ten3',1236,'HaNoi',12336)
insert MonHoc values
('Mon1','Co So Du Lieu',3),
('Mon2','Toan',4),
('Mon3','Ly',5)

insert KetQua values
('SV01','Mon1',8,9,9),
('SV01','Mon2',7,9,1),
('SV02','Mon1',6,9,2),
('SV02','Mon3',5,9,3),
('SV03','Mon1',4,9,4)

select * from SinhVien
select * from MonHoc
select * from KetQua

--2;
create view cau_a
as 
select MaMH,TenMH,SoTinChi from MonHoc
where SoTinChi < (select SoTinChi from MonHoc where TenMH = 'Co So Du Lieu')

select * from cau_a
--3;
alter function cau_3_a(@tenmh nvarchar(30))
returns int
as
begin 
declare @a int
	set @a = (select count(MaSV) from KetQua inner join MonHoc on KetQua.MaMH = MonHoc.MaMH where DiemThi < 5 and TenMH = @tenmh
	group by KetQua.MaMH)
	
	return @a
end
--b
select dbo.cau_3_a('Toan')
select dbo.cau_3_a('Hoa')

--c;
create function cau_c(@tenmh nvarchar(30))
returns @List table 
(
 MaSV nchar(10),
 HoTenSV nvarchar(30),
 KetQua float
)
as begin
insert into @List 
	select KetQua.MaSV,HoTenSV,DiemTX1*0.2 + DiemTX2*0.2 + DiemThi*0.6 
	from KetQua inner join SinhVien on SinhVien.MaSV = KetQua.MaSV
				inner join MonHoc on MonHoc.MaMH = KetQua.MaMH
	where TenMH = @tenmh
	return
end

--d;
select * from cau_c('Toan')
select * from cau_c('Co So Du Lieu')
select * from cau_c('Ly')