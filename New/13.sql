create database QLmuonsach
use QLmuonsach
create table Sach
(MaSach nchar(10) primary key not null,
TenSach nvarchar(20),
SoTrang int,
SLTon int
)
create table PM
(
MaPM nchar(10) primary key not null,
NgayM date,
HoTenDG nvarchar(20)
)
create table SachMuon
(MaPM nchar(10),
MaSach nchar(10),
songaymuon int
primary key(MaPM,MaSach),
foreign key(MaPM) references PM(MaPM) ,
foreign key(MaSach) references Sach(MaSach) ,
)

insert Sach values
('ma01','TS1',20,10),
('ma02','TS2',20,10)

insert PM values
('P01','2022/2/2','Ten1'),
('P02','2022/2/3','Ten2')

insert SachMuon values
('P01','ma01',20),
('P02','ma01',20),
('P01','ma02',20),
('P02','ma02',20)

select * from Sach
select * from PM
select * from SachMuon

--2;
create proc SP1(@ngaymuon date,@check int output)
as
begin
	if(@ngaymuon > getdate())
		set @check = 1
	else
		set @check = 0
	return @check
end

declare @check int
exec SP1 '2023/2/2',@check output
print(@check)
declare @check int
exec SP1 '2021/2/2',@check output
print(@check)

--3;
alter trigger TG1
on SachMuon
for delete
as
begin 
	if((select songaymuon from deleted) < 5)
		begin
			raiserror('Muon qua it',16,1)
			rollback tran
		end
	else if((select songaymuon from deleted) >= 5)
		begin
			update Sach set SLTon = SLTon - 1
			from Sach where MaSach = (select MaSach from deleted)
		end
end
select * from Sach
select * from SachMuon
delete from SachMuon where MaPM = 'P01' and MaSach = 'ma02'