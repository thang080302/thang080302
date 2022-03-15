create database QLKHO
use QLKHO
create table PXuat
(
	SoPX nvarchar(20) primary key not null,
	NgayNhap date,
	GhiChu nvarchar(20)
)
create table VatTu
(
	MaVT nvarchar(20) primary key not null,
	TenVT nvarchar(20),
	SoLuongT int
)
create table CTPXuat
(
	SoPX nvarchar(20),
	MaVT nvarchar(20),
	SoLuongX int,
	DonGiaX float(20),
	primary key(SoPX,MaVT),
	foreign key(SoPX) references PXuat(SoPX),
	foreign key(MaVT) references VatTu(MaVT)
)

insert into PXuat values
('P01','2022/2/2','on'),
('P02','2022/2/3','on'),
('P03','2022/2/4','on')

insert into VatTu values
('Ma01','Ten01',20),
('Ma02','Ten02',20),
('Ma03','Ten03',20)

insert into CTPXuat values
('P01','Ma01',20,10),
('P01','Ma02',20,10),
('P01','Ma03',20,10),
('P02','Ma01',20,10),
('P03','Ma01',20,10)

select * from PXuat
select * from VatTu
select * from CTPXuat

--2;
create proc SP1(@mavt nvarchar(20),@tenVT nvarchar(20),@soluongt int)
as
begin
declare @a int
set @a = (select SoLuongT from VatTu)
	if(exists (select MaVT from VatTu))
		raiserror('Da ton tai ma vat tu !',16,1)
	else if ( @a < 0) 
			raiserror('So luong ton khong thoa man !',16,1)
	else 
		insert into VatTu values
		(@mavt,@tenVT,@soluongt)
end
exec SP1 'Ma01','Ten01',10
--3;
alter trigger TG1
on CTPXuat
for insert 
as
	begin
	declare @slx int
	declare @slt int
	set @slx = (select SoLuongX from inserted)
	set @slt = (select SoLuongT from VatTu where MaVT = (select MaVT from inserted))
		if(not exists (select MaVT from VatTu where MaVT = (select MaVT from inserted)))
		begin
			raiserror('Khong ton tai ma vat tu',16,1)
			rollback tran
		end
		else if(not exists (select PXuat.SoPX from PXuat inner join inserted on inserted.SoPX = PXuat.SoPX))
		begin
			raiserror('Khong ton tai so phieu xuat',16,1)
			rollback tran
		end
		else if(@slt<@slx)
		begin
			raiserror('So Luong Xuat qua lon',16,1)
			rollback tran
		end
		else 
			update VatTu set SoLuongT = SoLuongT - @slx
	end

alter table CTPXuat
nocheck constraint all
select * from CTPXuat
insert CTPXuat values
('P04','Ma02',10,20)
