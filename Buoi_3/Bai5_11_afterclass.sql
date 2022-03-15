create database QLKHO
use QLKHO

create table Ton
(
	MaVT varchar(20),
	TenVT nvarchar(20),
	SoLuongT int,
	primary key (MaVT)
)

create table Nhap
(
	SoHDN int,
	MaVT varchar(20),
	SoLuongN int,
	DonGiaN float(20),
	NgayN date,
	primary key (SoHDN),
	foreign key (MaVT) references Ton(MaVT)
)

create table Xuat
(
	SoHDX int,
	MaVT varchar(20),
	SoLuongX int,
	DonGiaX float(20),
	NgayX date,
	primary key (SoHDX),
	foreign key (MaVT) references Ton(MaVT)
)
select * from Nhap
select * from Xuat
select * from Ton

--2;

create view TienBan
as
select Xuat.MaVT,TenVT, sum(SoLuongX*DonGiaX) as 'TienBan'
from Xuat inner join Ton on Xuat.MaVT = Ton.MaVT
group by Xuat.MaVT,TenVT

select * from TienBan

--3;

CREATE VIEW SLX
AS 
select Ton.TenVT, sum(SoLuongX) as 'tong sl'
from  Xuat inner join Ton on Xuat.MaVT = Ton.MaVT
group by ton.tenvt
select * from SLX

--4;

CREATE VIEW SLN
AS 
select Ton.TenVT, sum(SoLuongN) as 'SoLuongNhap'
from  Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
group by ton.tenvt
select * from SLN

--5;
create view SoLuongTon
as
select Ton.TenVT , SLN.SoLuongNhap - SLX.[tong sl] + sum(SoLuongT) as 'TongTon'
from SLX inner join SLN on SLX.TenVT = SLX.TenVT
		 inner join Ton on SLX.TenVT = Ton.TenVT
group by Ton.TenVT,Ton.MaVT,SLN.SoLuongNhap,SLX.[tong sl]

select * from SoLuongTon