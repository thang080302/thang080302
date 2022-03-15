--1;
create proc insert_Khoa(@makhoa nvarchar(20),
						@tenkhoa nvarchar(30),
						@dienthoai nchar(20))
as
begin
 if(exists (select * from Khoa where Tenkhoa = @tenkhoa))
	print('Exist !')
else insert into Khoa values(@makhoa,@tenkhoa,@dienthoai)
end
execute insert_Khoa('123','465',012)
--2;
create proc insert_Class(
						 @malop nchar(20),
						 @tenlop nvarchar(30),
						 @Khoa nchar(20),
						 @Hedt nchar(20),
						 @Namnhaphoc int,
						 @makhoa nvarchar(20)
						 )
as
begin
	if(not exists (select * from Lop where Tenlop = @tenlop))
		print('not exists Tenlop !')
	else if(not exists (select * from Lop where MaKhoa = @makhoa))
			print('not exists MaKhoa !')
		else 
			insert into Lop values (@malop,@tenlop@Khoa,@Hedt,@Namnhaphoc,@makhoa)
end
