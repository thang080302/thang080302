create database trigger_1
go
use trigger_1
create table Hang
(
MaHang nchar(20) primary key not null,
TenHang nvarchar(20),
SoLuong int,
GiaBan float(20)
)
create table HoaDon
(
MaHoaD nchar(20),
MaHang nchar(20),
SoLuongBan int,
NgayBan date,
primary key(MaHoaD),
foreign key(MaHang) references Hang(MaHang)
)

create trigger TG_1
on Hang
for insert
as 
begin 
	if(not exists (select inserted.MaHang from inserted inner join Hang on Hang.MaHang = inserted.MaHang))
		begin
			print(N'Không có mã hàng trong bảng hàng')
		rollback transaction
		end
	else 
		begin 
			declare @soluongban int
			set @soluongban = (select SoLuongBan from HoaDon inner join inserted on inserted.MaHang = HoaDon.MaHang)
			declare @soluong int
			set @soluong = (select inserted.SoLuong from Hang inner join inserted on inserted.MaHang = Hang.MaHang)
			if(@soluongban <= @soluong)
				print('khong thoa man')
			else
				update Hang set Hang.SoLuong = Hang.SoLuong - @soluongban from inserted inner join Hang on Hang.MaHang = inserted.MaHang
		end
end