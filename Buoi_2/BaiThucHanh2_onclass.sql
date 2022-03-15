use QLBanHang
select * from SanPham
select * from HangSX
select * from NhanVien
select * from Nhap
select * from PNhap
select * from Xuat
select * from PXuat
--bài 1 :
--a;
select Nhap.SoHDN, SanPham.MaSP, SanPham.TenSP, SoLuongN, DonGiaN, NgayNhap, TenNV, TenPhong
from SanPham inner join Nhap on SanPham.MaSP = Nhap.MaSP
			 inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
			 inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
			 inner join NhanVien on NhanVien.MaNV = PNhap.MaNV
where TenHang = 'Samsung' and YEAR(NgayNhap) = 2020

--b;
select top 10 * from PXuat inner join Xuat on PXuat.SoHDX = Xuat.SoHDX
order by SoLuongX desc

--c;
Select top 10 MaSP, TenSP,GiaBan
From SanPham
Order by GiaBan DESC

--d;
select * from SanPham inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
where GiaBan between 100000 and 500000 and TenHang = 'Samsung'

--e;
select SUM(SoLuongN*DonGiaN) 'Tổng tiền nhập'
from Nhap inner join SanPham on SanPham.MaSP = Nhap.MaSP
		  inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
		  inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where YEAR(NgayNhap) = 2020 and TenHang = 'Samsung'

--f;
select sum(SoLuongX*GiaBan) N'Tổng tiền xuất'
from Xuat inner join SanPham on Xuat.MaSP = SanPham.MaSP
		  inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
where day(NgayXuat) = 14 and month(NgayXuat) = 6 and YEAR(NgayXuat) = 2020

--g;
select PNhap.SoHDN,NgayNhap
from PNhap inner join Nhap on Nhap.SoHDN = PNhap.SoHDN 
where YEAR(NgayNhap) = 2020 and SoLuongN*DonGiaN = (select max(SoLuongN*DonGiaN)
													from PNhap inner join Nhap on Nhap.SoHDN = PNhap.SoHDN 
													where YEAR(NgayNhap) = 2020)

--Bài 2:
--a;
select TenHang,SUM(SoLuongN)
from HangSX inner join SanPham on SanPham.MaHangSx = HangSX.MaHangSx
			inner join Nhap on Nhap.MaSP = SanPham.MaSP
group by TenHang

--b;
select TenHang,SUM(SoLuongN*DonGiaN)
from HangSX inner join SanPham on SanPham.MaHangSx = HangSX.MaHangSx
			inner join Nhap on Nhap.MaSP = SanPham.MaSP
			inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where year(NgayNhap) = 2020
group by TenHang

--c;
select  SanPham.MaSP,TenSP,sum(SoLuongX) As N'Tổng xuất'
from SanPham inner join Xuat on Xuat.MaSP = SanPham.MaSP
			 inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
			 inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
where TenHang = 'Samsung' and year(NgayXuat) = 2020
group by SanPham.MaSP,TenSP
having SUM(SoLuongX) > 10000

--d;
select TenPhong,count(MaNV) as N'Số lượng nhân viên'
from NhanVien
where GioiTinh = 'Nam'
group by TenPhong

--e : Thống kê Tổng số lượng nhâp của mỗi hãng sx năm 2018;
select TenHang,SUM(SoLuongN)
from Nhap inner join SanPham on Nhap.MaSP = SanPham.MaSP
		  inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
		  inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where YEAR(NgayNhap) = 2018

--f: Hãy thống kê xem tổng lượng tiền xuất của mỗi nhân viên trong năm 2018 là bao nhiêu;

select TenNV,SUM(SoLuongX*GiaBan) N'lượng tiền xuất'
from Xuat inner join SanPham on SanPham.MaSP = Xuat.MaSp
		  inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
		  inner join NhanVien on PXuat.MaNV = NhanVien.MaNV
where YEAR(NgayXuat) = 2018
group by TenNV