use QLBanHang
go
alter trigger TG1
on Nhap
for insert 
as
begin 
	declare @masp nchar(10)
	set @masp = (select MaSP from inserted) 
	declare @sln int
	set @sln = (select SoLuongN from inserted)
	declare @dgn money
	set @dgn = (select DonGiaN from inserted)
	if(not exists (select MaSP from SanPham where MaSP = @masp))
		begin
			raiserror('Ma san pham chua ton tai !',16,1)
			rollback tran
		end
	else if (@sln <= 0 or @dgn <= 0)
		begin
			raiserror('So Luong va Don Gia nhan gia tri duong !',16,1)
			rollback tran
		end
	else 
		update SanPham set SoLuong = SoLuong + @sln from inserted
end
--check : 
alter table Nhap
nocheck constraint all
select * from Nhap
select * from SanPham
insert Nhap values 
('N06','SP06',10,1000000)
insert Nhap values 
('N06','SP01',-10,1000000)
insert Nhap values 
('N07','SP01',10,-1000000)
insert Nhap values 
('N08','SP01',12,100000)