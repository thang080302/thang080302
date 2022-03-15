use QLBanHang
--a;
select * from SanPham
select * from HangSX
select * from NhanVien
select * from Nhap
select * from PNhap
select * from Xuat
select * from PXuat

--b;
select MaSP,TenSP,TenHang,SoLuong,MauSac,GiaBan,DonViTinh,MoTa
from SanPham inner join HangSX on SanPham.MaHangSx = HangSX.MaHangSx
order by GiaBan desc

--c;
select MaSP, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
From SanPham Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
Where TenHang = 'SamSung'

--d;
select * from NhanVien
where GioiTinh = N'Nữ'
--e;
select Nhap.SoHDN, SanPham.MaSP, TenSP, TenHang, SoLuongN, 
	   DonGiaN, SoLuongN*DonGiaN N'Tiền Nhập',
	   MauSac, DonViTinh, NgayNhap, TenNV, 
	   TenPhong
from SanPham Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
			 inner join Nhap on SanPham.MaSP = Nhap.MaSP
			 Inner join PNhap on Nhap.SoHDN=PNhap.SoHDN
			 Inner join NhanVien on PNhap.MaNV = NhanVien.MaNV
order by SoHDN Asc

--f;
select Xuat.SoHDX, SanPham.MaSP, TenSP, TenHang, SoLuongX, 
	   GiaBan, SoLuongX*GiaBan N'Tiền Xuất', 
	   MauSac, DonViTinh, NgayXuat, TenNV, 
	   TenPhong
from Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
		  Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX 
		  Inner join NhanVien on PXuat.MaNV = NhanVien.MaNV
		  Inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
where MONTH(NgayXuat) = 6 and YEAR(NgayXuat) = 2020
order by SoHDX