use QLBanHang
go
create trigger tgnhap
on Nhap
for insert 
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from inserted)
	declare @sln int, @dgn float
	select @sln = SoLuongN,@dgn = DonGiaN from inserted
	if(not exists (select MaSP from SanPham where MaSP = @masp))
		begin 
			raiserror ('Loi khong tim thay ma san pham !',16,1)
			rollback tran
		end
	else if (@sln <= 0 or @dgn <= 0)
		begin 
			raiserror (N'Số lượng nhập và đơn giá nhập phải là số dương !',16,1)
			rollback tran
		end
	else 
		begin
			update SanPham set SoLuong = SoLuong + @sln
			where MaSP = @masp
		end
end

--bài 2
create trigger TG
on Xuat
for insert 
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from inserted)
	declare @soluong int,@slx int
	set @soluong = (Select SoLuong from SanPham where MaSP = @masp)
	set @slx = (Select SoLuongX from inserted)
	if(not exists (select MaSP from SanPham where MaSP = @masp))
		begin
			raiserror(N'khong tim duoc a san pham trong bang san pham',16,1)
			rollback tran
		end
	else if(@slx > @soluong)
		begin
			raiserror(N'so luong qua lon',16,1)
			rollback tran
		end
	else 
		begin
			update SanPham set SoLuong = SoLuong - @slx
			from SanPham where MaSP = @masp
		end
end

--aljbva
create trigger TGfb
on Xuat 
for update
as
	begin 
		
		declare @slx int,@slco int,@masp nchar(10)
		set @masp = (select MaSP from inserted)
		set @slx = (select SoLuongX from inserted)
		set @slco = (select SoLuong from SanPham where MaSP = @masp) + (select SoLuongX from deleted)
		if(@@ROWCOUNT > 1)
			begin
				raiserror('Khong update qua 1 ban ghi',16,1)
				rollback tran
			end
		else if(not exists (select MaSP from SanPham where MaSP = @masp))
			begin
				raiserror('Khong tim thay ma san pham',16,1)
				rollback tran
			end
		else if(@slx > @slco)
			begin
				raiserror('Khong de sl xuat lon hon sl co',16,1)
				rollback tran
			end
		else
			begin
				update SanPham set SoLuong = SoLuong - @slx 
				from SanPham where MaSP = @masp
			end
end