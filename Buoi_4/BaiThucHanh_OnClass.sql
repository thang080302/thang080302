use QLBanHang
--1;
--a;

create function Find_brand(@id_product nchar(10))
returns nvarchar(20)
as begin
	declare @a nvarchar(20)
	set @a = (select TenHang from HangSX inner join SanPham on SanPham.MaHangSx = HangSX.MaHangSx
			  where MaSP = @id_product)
	return @a
end
--b;
create function tong_giatri(@Giatri_duoi int, @Giatri_tren int)
returns float
as
begin 
	declare @a int
	set @a = (select count(SoLuongN * DonGiaN) 
			  from Nhap inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
			  where year(NgayNhap) >= @Giatri_duoi and year(NgayNhap) <= @Giatri_tren
			  group by Nhap.MaSP
			  )
	return @a
end
--c;
create function Thong_ke(@tensp nvarchar(20),@nam int)
returns int
as
begin 
	declare @a int
	set @a = (select sum(SoLuongN - SoLuongX) 
			  from Nhap inner join Xuat on Nhap.MaSP = Xuat.MaSP
						inner join SanPham on Nhap.MaSP = SanPham.MaSP
						inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
						inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
			  where TenSP = @tensp and year(NgayNhap) = @nam and year(NgayXuat) = @nam
			  group by SanPham.MaSP)
	return @a
end

--d;
create function tonggiatrinhap(@Giatri_duoi int, @Giatri_tren int)
returns int
as
begin
	declare @a int
	set @a = (select sum(SoLuongN * DonGiaN) from Nhap inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
			  where day(NgayNhap) in (@Giatri_duoi,@Giatri_tren))
	return @a
end

--2;
--a;
create function ThongTinSP(@tenhang nvarchar(20))
returns @List table (
					 MaSP nchar(10),
					 TenSP nvarchar(20),
					 MaHangSX nchar(10),
					 SoLuong int,
					 MauSac nvarchar(20),
					 GiaBan money,
					 DonViTinh nchar(10),
					 MoTa nvarchar(40)
					)
as
begin 
	insert into @List 
		select SanPham.MaSP, SanPham.MaHangSx, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
		from SanPham inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
		where TenHang = @tenhang
	return
end
--b;
create function List_product(@Giatri_duoi date, @Giatri_tren date)
returns @List table (
					 MaSP nchar(10),
					 TenSP nvarchar(20),
					 TenHang nvarchar(20)
					)
as 
begin
	insert into @List
		select SanPham.MaSP, TenSP,SanPham.MaHangSx from SanPham inner join Nhap on Nhap.MaSP = SanPham.MaSP
																 inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
													where NgayNhap in (@Giatri_duoi,@Giatri_tren)
		return
end
--c;
use QLBanHang
create function DanhSach(@tenhang nvarchar(20),@luachon int)
returns @List table ( 
					 MaSP nchar(10),
					 TenSP nvarchar(20),
					 TenHang nvarchar(20)
					)
as begin
	
	if @luachon = 0
		insert into @List
		select MaSP,TenSP ,TenHang
		from SanPham inner join HangSX 
			on HangSX.MaHangSx = SanPham.MaHangSx
		where SoLuong = 0 and TenHang = @tenhang
	if  @luachon = 1
		insert into @List
		select MaSP,TenSP,TenHang 
		from SanPham inner join HangSX 
			on HangSX.MaHangSx = SanPham.MaHangSx
		where SoLuong < 0 and TenHang = @tenhang
	return
end

--d;
create function List_NV(@tenphong nvarchar(30))
returns @List table (
					 MaNV nchar(10),
					 TenNV nvarchar(20),
					 GioiTinh nchar(10),
					 DiaChi nvarchar(30),
					 SoDT nvarchar(20),
					 Email nvarchar(30)
					 )
as
begin
	insert into @List
		select MaNV,TenNV,GioiTinh,DiaChi,SoDT,Email from NhanVien
		where TenPhong = @tenphong
	return
end

select * from List_NV('NV')   

