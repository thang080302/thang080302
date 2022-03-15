use QLBanHang
--a;
create trigger TG2
on Xuat
for update
as
	begin
		declare @slxafter int
		set @slxafter = (select SoLuongX from inserted)
		declare @slco int
		set @slco = (select SoLuong from SanPham where MaSP = (select MaSP from deleted)) + (select SoLuongX from deleted)
		if(@@ROWCOUNT > 1)
			Begin
			Raiserror(N'Không được cập nhật nhiều hơn 1 bản ghi cùng lúc',16,1)
			Rollback Transaction
			End		
		else if (@slxafter > @slco)
			Begin
			Raiserror(N'Không được xuất với số lượng nhiều hơn số lượng có',16,1)
			Rollback Transaction
			End
		else 
			begin
			update SanPham set SoLuong = @slco - @slxafter
			where MaSP = (select MaSP from deleted)
			end
end
--b;
create trigger caub
on Nhap
for insert 
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from inserted)

	if(not exists (select MaSP from SanPham where MaSP = @masp))
	begin
		print('Khong ton tai ma san pham!')
		rollback tran
	end

	else if ((select SoLuongN from inserted) <= 0)
	begin
		print(N'Số lượng nhập phải dương!')
		rollback tran
	end
	else if ((select DonGiaN from inserted) <= 0)
	begin
		print(N'Đơn Giá nhập phải dương!')
		rollback tran
	end
	else update SanPham set SoLuong = SoLuong + (select SoLuongN from inserted)
		 where MaSP = @masp
end

--c;
create trigger cauc
on Xuat
for insert
as
begin
	declare @masp nchar(10), @slco int, @slx int
	set @masp = (select MaSP from inserted)
	set @slco = (select SoLuong from SanPham where MaSP = @masp)
	set @masp = (select MaSP from inserted)
	if(not exists (select MaSP from SanPham where MaSP = @masp))
	begin
		print('Khong ton tai ma san pham!')
		rollback tran
	end
	else if (@slx > @slco)
	begin
		print('SoLuong xuat lon qua!')
		rollback tran
	end
	else 
		update SanPham set SoLuong = @slco - @slx
		where MaSP = @masp
end

--d;
create trigger caud
on Xuat
for delete
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from deleted)
	if(not exists (select MaSP from SanPham where MaSP = @masp))
		begin 
			Raiserror(N'Không tồn tại sản phẩm trong danh mục sản phẩm',16,1)
			Rollback Transaction
		end
	else
		begin
		update SanPham set SoLuong = SoLuong + (select SoLuongX from deleted)
		where SanPham.MaSP = @masp
		end
end

--e;
create trigger caue
on Nhap
for update
as
begin 
	declare @truoc int,@sau int,@masp nchar(10)
	set @truoc = (select SoLuongN from deleted)
	set @sau = (select SoLuongN from inserted) 
	set @masp = (select MaSP from inserted) 
	if(@@ROWCOUNT > 1)
		begin 
			Raiserror(N'Không cập nhật số bản ghi lớn hơn 1',16,1)
			Rollback Transaction
		end
	else if (not exists (select MaSP from SanPham where MaSP = @masp))
		begin 
			Raiserror(N'Không tồn tại mã sản phẩm trong bảng sản phẩm',16,1)
			Rollback Transaction
		end
	else 
		begin
			update SanPham 
			set SoLuong = SoLuong - @truoc + @sau
			where SanPham.MaSP = @masp
		end
end

--f;
create trigger cauf
on Nhap
for delete
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from deleted)
	if(not exists (select MaSP from SanPham where MaSP = @masp))
		begin 
			Raiserror(N'Không tồn tại sản phẩm trong danh mục sản phẩm',16,1)
			Rollback Transaction
		end
	else
		begin
			update SanPham 
			set SoLuong = SoLuong - (select SoLuongN from deleted)
			where SanPham.MaSP = @masp
		end
end

print('So :' + str(1))