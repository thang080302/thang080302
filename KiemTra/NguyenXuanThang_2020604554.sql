create database QLSinhVien1
use QLSinhVien1
create table GVCN
(MaGV nchar(10) primary key,
TenGV nvarchar(30))

create table Lop
(MaLop nchar(10) primary key,
TenLop nvarchar(30),
SiSo int,
MaGV nchar(10),
foreign key(MaGV) references GVCN(MaGV))

create table SinhVien
(MaSV nchar(10) primary key,
HoTen nvarchar(30),
NgaySinh date,
GioiTinh bit,
DiaChi nvarchar(30),
MaLop nchar(10),
foreign key(MaLop) references Lop(MaLop))

insert GVCN values
('GV1','TenGV1'),
('GV2','TenGV2'),
('GV3','TenGV3')

insert Lop values
('Lop1','TL1',20,'GV1'),
('Lop2','TL2',21,'GV2'),
('Lop3','TL3',22,'GV3')

insert SinhVien values
('SV1','TSV1','2002/2/2',1,'HaNoi','Lop1'),
('SV2','TSV2','2002/2/3',0,'HaNoi','Lop1'),
('SV3','TSV3','2002/2/4',1,'HaNoi','Lop2'),
('SV4','TSV4','2002/2/5',0,'HaNoi','Lop2'),
('SV5','TSV5','2002/2/6',1,'HaNoi','Lop3')

select * from GVCN
select * from Lop
select * from SinhVien

--2;
alter trigger TG1
on SinhVien
for insert
as
begin	
	declare @malop nchar(10)
	set @malop = (select MaLop from inserted)
	declare @masv nchar(10)
	set @masv = (select MaSV from inserted)
	if(exists(select MaSV from SinhVien where MaSV = @masv))
		begin
			raiserror(N'Đã tồn tại mã sinh viên',16,1)
			rollback tran
		end
	else if(not exists (select MaLop from Lop where MaLop = @malop))
		begin
			raiserror(N'Chưa tồn tại mã lớp',16,1)
			rollback tran
		end
	else if((select SiSo from Lop where MaLop = @malop) >= 80)
		begin
			raiserror(N'Lớp quá đông',16,1)
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

alter table SinhVien
nocheck constraint all

insert SinhVien values
('SV1','TSV6','2002/2/6',1,'HaNoi','Lop4')
insert SinhVien values
('SV4','TSV6','2002/2/6',1,'HaNoi','Lop4')

--3;
create proc sp_TimKiem(@TuTuoi int, @DenTuoi int)
as
begin
		if(not exists (select*from SinhVien where YEAR(getdate())-YEAR(NgaySinh) between @TuTuoi and @DenTuoi ))
		print(N'Không Tìm Thấy Sinh Viên Nào')
		else
		select MaSV ,HoTen, YEAR(getdate())-YEAR(NgaySinh) as'Tuoi',DiaChi,TenLop,TenGV
		from SinhVien inner join Lop on SinhVien.MaLop=Lop.MaLop
						inner join GVCN on Lop.MaGV= GVCN.MaGV
		where YEAR(getdate())-YEAR(NgaySinh) between @TuTuoi and @DenTuoi
end

exec sp_TimKiem'5','10'
exec sp_TimKiem'10','100'
