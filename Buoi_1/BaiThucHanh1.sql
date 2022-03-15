create database QLBanHang
 use QLBanHang
create table SanPham 
(
	MaSP nchar(10) primary key not null ,
	MaHangSx nchar(10),
	TenSP nvarchar(20),
	SoLuong int,
	MauSac nvarchar(10),
	GiaBan money,
	DonViTinh nchar(20),
	Mota nvarchar(40)
	constraint fk_sp_hsx foreign key(MaHangSx)
	references HangSX(MaHangSx)
)

create table HangSX 
(
	MaHangSx nchar(10) primary key,
	TenHang nvarchar(20),
	DiaChi nchar(30),
	SoDT Nvarchar(20),
	Email Nvarchar(30)
)

create table NhanVien(
   MaNV Nchar(10) primary key,
   TenNV nvarchar(20),
   GioiTinh Nchar(10),
   DiaChi Nvarchar(30),
   SoDT Nvarchar(20),
   Email Nvarchar(30),
   TenPhong Nvarchar(30)
)
create table PNhap(
   SoHDN nchar(10) primary key,
   NgayNhap date,
   MaNV nchar(10)
   constraint PNhap_MaNV foreign key (manv)
   references NhanVien(MaNV)
)

create table Nhap(
   SoHDN nchar(10) primary key,
   MaSP nchar(10),
   SoLuongN int, 
   DonGia money,
   constraint Nhap_sohdn foreign key (sohdn)
   references PNhap(SoHDN),
   constraint Nhap_masp foreign key (MaSP)
   references SanPham(MaSP)
)

create table PXuat(
   SoHDX nchar(10) primary key,
   NgayXuat date,
   MaNV nchar(10)
   constraint PXuat_manv foreign key (manv)
   references NhanVien(manv)
)
create table Xuat(
   SoHDX nchar(10) primary key,
   MaSP nchar(10),
   SoLuongX int,
   constraint Fk_xuat_sohdx foreign key (sohdx)
   references PXuat(SoHDX),
   constraint FK_xuat_masp foreign key (masp)
   references SanPham(masp)
)

insert into HangSX values
	('H01','Samsung','Korea',011-08271717,'ss@gmail.com.kr'),
	('H02','OPPO','China',081-08626262 ,'oppo@gmail.com.cn'),
	('H03','Vinfone',N'Việt Nam',084-098262626,'vf@gmail.com.vn')

insert into NhanVien values
	('NV01',N'Nguyễn Thị Thu',N'Nữ',N'Hà Nội',0982626521,'thu@gmail.com',N'Kế toán'),
	('NV02',N'Lê Văn Nam',N'Nam',N'Bắc Ninh' ,0972525252,'nam@gmail.com',N'Vật tư'),
	('NV03',N'Trần Hòa Bình',N'Nam',N'Hà Nội',0328388388,'hb@gmail.com',N'Kế toán')

insert into SanPham values
	('SP01','H02','F1 Plus',100,N'Xám',7000000,N'Chiếc',N'Hàng cận cao cấp'),
	('SP02','H01','Galaxy Note 11',50,N'Đỏ',19000000,N'Chiếc','Hàng cao cấp'),
	('SP03','H02','F3 lite',200,N'Nâu',3000000 ,N'Chiếc',N'Hàng phổ thông'),
	('SP04','H03','Vjoy3',200,N'Xám',1500000,N'Chiếc',N'Hàng phổ thông'),
	('SP05','H01','Galaxy V21',500,N'Nâu',8000000,N'Chiếc',N'Hàng cận cao cấp')

insert into PNhap values
	('N01','02-05-2019','NV01'),
	('N02','04-07-2020','NV02'),
	('N03','05-17-2020','NV02'),
	('N04','03-22-2020','NV03'),
	('N05','07-07-2020','NV01')

insert into Nhap values
	('N01','SP02',10,17000000),
	('N02','SP01',30,6000000),
	('N03','SP04',20,1200000),
	('N04','SP01',10,6200000),
	('N05','SP05',20,7000000)

insert into PXuat values
	('X01','06-14-2020','NV02'),
	('X02','03-05-2019','NV03'),
	('X03','12-12-2020','NV01'),
	('X04','06-02-2020','NV02'),
	('X05','05-18-2020','NV01')

insert into Xuat values
	('X01','SP03',5),
	('X02','SP01',3),
	('X03','SP02',1),
	('X04','SP03',2),
	('X05','SP05',1)

select * from SanPham
select * from HangSX
select * from NhanVien
select * from Nhap
select * from PNhap
select * from Xuat
select * from PXuat
