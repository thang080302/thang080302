use QLBanHang

--a;
select NhanVien.MaNV,TenNV,SUM(SoLuongN*DonGiaN) N'Tổng tiền nhập'
from Nhap inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
		  inner join NhanVien on NhanVien.MaNV = PNhap.MaNV
where month(NgayNhap) = 8 and year(NgayNhap) = 2018
group by NhanVien.MaNV, TenNV
having SUM(SoLuongN*DonGiaN) > 100000

--b;
select SanPham.MaSP,TenSP
From SanPham Inner join nhap on SanPham.MaSP = nhap.MaSP
Where SanPham.MaSP Not In (Select MaSP From Xuat)

--c;
select SanPham.MaSp,TenSP
from SanPham inner join Nhap on Nhap.MaSP = SanPham.MaSP
			 inner join Xuat on Xuat.MaSP = SanPham.MaSP
			 inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
			 inner join PXuat on PXuat.SoHDX = Xuat.SOHDX
where YEAR(NgayNhap) = 2020 and YEAR(NgayXuat) = 2020

--d;
select MaNV, TenNV
from NhanVien
where MaNV in (select MaNV from PNhap) and MaNV in (select MaNV from PXuat)

--e;
select MaNV, TenNV
from NhanVien
where MaNV not in (select MaNV from PNhap) and MaNV not in (select MaNV from PXuat)