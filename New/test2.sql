use QLSinhVien

--2;
select top 5 MaSV,HoTen,DATEDIFF(YEAR,GETDATE(),NgaySinh) as N'Tuổi' 
from SinhVien inner join Lop on Lop.MaLop=SinhVien.MaLop
order by MaKhoa

--3;
create proc Sp1(@tutuoi int,@dentuoi int)
as
begin
	select MASV,Hoten,NgaySinh,TenLop,TenKhoa,DATEDIFF(YEAR,GETDATE(),NgaySinh) as N'Tuổi'
	from SinhVien inner join Lop on Lop.MaLop=SinhVien.MaLop
				  inner join Khoa on Lop.MaKhoa=Khoa.MaKhoa
	where DATEDIFF(YEAR,GETDATE(),NgaySinh) in (@tutuoi,@dentuoi)
end

--4;
alter trigger TG2
on SinhVien
for insert
as
	begin
		declare @malop nchar(10),@siso int,@dong int
		set @malop = (select MaLop from inserted)
		set @siso = (select SiSo from Lop where MaLop = @malop)
		if(@siso>80)
			begin
				raiserror('Lop da co tren 80 Sv',16,1)
				rollback tran
			end
		else
			begin
				update Lop set SiSo = SiSo + 1
				from Lop where MaLop = @malop
			end
	end
select * from Lop
select * from SinhVien
insert SinhVien values
('SV13','Ten10','2002/1/1',1,'ML02'),
('SV11','Ten11','2002/1/2',0,'ML02')