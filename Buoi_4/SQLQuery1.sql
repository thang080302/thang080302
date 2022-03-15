use QLBanHang
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
create function Count_product(@gh_duoi money,@gh_tren money,@tenhang nvarchar(20))
returns int
as
begin 
	declare @a int
	set @a = (select count(MaSP) from SanPham inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
			  where GiaBan >= @gh_duoi and GiaBan <= @gh_tren and TenHang = @tenhang)
	return @a
end

--c;
create function find_info(@gh_duoi money,@gh_tren money)
returns @List table (
					Masp nchar(10),
					Tensp nvarchar(20),
					Tenhang nvarchar(20)
					)
as 
begin
  insert into @List
		select MaSP,TenSP,TenHang from SanPham inner join HangSX on HangSX.MaHangSx = SanPham.MaHangSx
		where GiaBan >= @gh_duoi and GiaBan <= @gh_tren
		return
end
