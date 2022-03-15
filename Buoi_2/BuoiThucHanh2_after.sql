use QLBanHang

--a;
select top 10 TenSP,SoLuongN
from SanPham inner join Nhap on SanPham.MaSP = Nhap.MaSP
			 inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where YEAR(NgayNhap) = 2019
order by SoLuongN desc

--b;
select SanPham.MaSP, TenSP 
from SanPham inner join HangSX on HangSx.MaHangSX = SanPham.MaHangSX
			 inner join Nhap on Nhap.MaSP = SanPham.MaSP
			 inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where TenHang = N'Samsung' and MaNV = 'NV01'

--c;
select Nhap.SoHDN,SanPham.MaSP,SoLuongN,NgayNhap
from SanPham inner join Nhap on Nhap.MaSP = SanPham.MaSP
			 inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where SanPham.MaSP = 'SP02' and MaNV = 'NV02'

--d;
select PXuat.MaNV,TenNV 
from Xuat inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
		  inner join SanPham on SanPham.MaSP = Xuat.MaSP
		  inner join NhanVien on NhanVien.MaNV = PXuat.MaNV
where SanPham.MaSP = 'SP02' and day(NgayXuat) = 03 and month(NgayXuat) = 02 and year(NgayXuat) = 2020;