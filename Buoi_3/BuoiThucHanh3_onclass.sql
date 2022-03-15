use QLBanHang
select * from SanPham

--a;
create view SamSung
as
select Nhap.SoHDN, Nhap.MaSP, TenSP, SoLuongN, DonGiaN, NgayNhap, TenNV, TenPhong
from Nhap inner join SanPham on SanPham.MaSP = Nhap.MaSP
				   inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
				   inner join NhanVien on NhanVien.MaNV = PNhap.MaNV
where year(NgayNhap) = 2020

--b;
create view Limited_product
as 
select MaSP,MaHangSX, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
from SanPham
where GiaBan >= 100000 and GiaBan <=500000

--c;
create view cau_c
as
select Nhap.MaSP,sum(SoLuongN * DonGiaN) as N'Tổng tiền nhập' from Nhap inner join SanPham on Nhap.MaSP = SanPham.MaSP
																   inner join HangSX on SanPham.MaHangSx = HangSX.MaHangSx
where TenHang = 'Samsung'
group by Nhap.MaSP

--d;
Create view cau_d
as
Select Sum(SoLuongX*GiaBan) As N'Tổng tiền xuất'
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
 Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX
Where NgayXuat = '06/14/2020'

--e;
Create view cau_e
as
select PNhap.SoHDN,NgayNhap 
	from PNhap inner join Nhap 
		on Nhap.SoHDN = PNhap.SoHDN
	where year(NgayNhap) = 2020 
	and SoLuongN*DonGiaN = 
	(
			select max(SoLuongN*DonGiaN) 
				from PNhap inner join Nhap on Nhap.SoHDN = PNhap.SoHDN 
				where year(NgayNhap) = 2020
	)
--f;
create view cau_f
as
select TenHang,count(MaSP) as N'Số SP'
	from HangSX inner join SanPham
		on HangSX.MaHangSx = SanPham.MaHangSx
	group by TenHang

--g;
create view cau_g
as
select Nhap.MaSP,sum(SoLuongN * DonGiaN) as 'Tong'
	from Nhap inner join PNhap
		on PNhap.SoHDN = Nhap.SoHDN
	where year(NgayNhap) = 2020
	group by Nhap.MaSP

--h;
create view cau_h
as
select SanPham.MaSP,TenSP,count(SoLuongX) as N'Số lượng Xuất'
	from Xuat inner join PXuat
				on PXuat.SoHDX = Xuat.SoHDX
			  inner join SanPham
				on SanPham.MaSP = Xuat.MaSP
			  inner join HangSX 
				on HangSX.MaHangSx = SanPham.MaHangSx
	where YEAR(NgayXuat) = 2020 and TenHang = 'Samsung'
	group by SanPham.MaSP,TenSP 
	having count(SoLuongX) > 10000
	
--i;
create view cau_i
as
select TenPhong,count(MaNV) as 'SoLuong'
	from NhanVien
	where GioiTinh = 'Nam'
	group by TenPhong

--j;
create view cau_j
as select TenHang,sum(SoLuongN) as 'SoLuongN'
	from HangSX inner join SanPham on HangSX.MaHangSx = SanPham.MaHangSx
				inner join Nhap on SanPham.MaSP = Nhap.MaSP
				inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
	where year(NgayNhap) = 2018
	group by TenHang

--k;
create view cau_k
as 
Select MaNV,Sum(SoLuongX*GiaBan) As N'Tổng tiền xuất'
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
 Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX
Where year(NgayXuat) = 2018
group by MaNV