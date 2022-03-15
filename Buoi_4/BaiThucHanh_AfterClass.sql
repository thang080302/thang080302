  use QLBanHang
--a;
create function SUM_xuat(@tenhang nvarchar(20),@nam int)
returns float
as begin
declare @a float
	set @a = (select sum(SoLuongX*GiaBan) from SanPham inner join Xuat on Xuat.MaSP = SanPham.MaSP
													   inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
													   inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
			 where TenHang = @tenhang and year(NgayXuat) = @nam
			 )
	return @a
end
--b;
create function 