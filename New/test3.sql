create database QLHANG
go

use QLHANG
go

-- create table
create table Hang(
	MaHang nvarchar(10) not null primary key,
	TenHang nvarchar(30) not null,
	DVTinh nvarchar(20),
	SLTon int default 0
)

create table HDBan(
	MaHD nvarchar(10) not null primary key,
	NgayBan date default '01-01-1970',
	HoTenKhach nvarchar(30),
)

create table HangBan(
	MaHD nvarchar(10) not null,
	MaHang nvarchar(10) not null,
	DonGia money default 0,
	SoLuong int default 0,
	constraint PRI_KEY_HangBan primary key(MaHD, MaHang),
	constraint HangBan_Hang foreign key(MaHang) references Hang(MaHang),
	constraint HangBan_HDBan foreign key(MaHD) references HDBan(MaHD)
)

go

-- insert

insert into Hang values('H001', N'Nước rửa tay sát khuẩn', N'Lọ', 22230),
						('H002', N'Khẩu trang y tế', N'Cái', 521230)
insert into HDBan values('HD001', '05-14-2020', N'Công Nghệ Thông Tin 5'),
						('HD002', '05-15-2020', N'Khoa Học Máy Tính')
insert into HangBan values('HD001', 'H001', 35000, 80),
							('HD001', 'H002', 5000, 80),
							('HD002', 'H001', 35000, 79),
							('HD002', 'H002', 5500, 79)
go

select * from Hang
select * from HDBan
select * from HangBan
go

--2;
create view vie1
as
select HDBan.MaHD,NgayBan,sum(SoLuong*DonGia) as N'Tổng Tiền'from HangBan inner join HDBan on HDBan.MaHD=HangBan.MaHD
group by HDBan.MaHD,NgayBan

select * from vie1

--3;
create proc SP1(@thang int,@nam int)
as
begin
	select Hang.MaHang,TenHang,NgayBan,SoLuong,
					case DATEPART(dw,NgayBan)
						when 2 then N'Thứ Hai'
						when 3 then N'Thứ Ba'
						when 4 then N'Thứ Tư'
						when 5 then N'Thứ Năm'
						when 6 then N'Thứ Sáu'
						when 7 then N'Thứ Bảy'
						when 1 then N'Chủ Nhật'
					end
				    as 'NgayThu'
	from Hang inner join HangBan on Hang.MaHang = HangBan.MaHang
			  inner join HDBan on HDBan.MaHD=HangBan.MaHD
	where MONTH(NgayBan) = @thang and year(NgayBan) = @nam
end

--4;
create trigger TG1
on HangBan
for insert 
as
begin
	declare @soluongton int,@mahang nvarchar(10)
	set @mahang = (select MaHang from inserted )
	set @soluongton = (select SLTon from Hang where MaHang = @mahang)
	if((select SoLuong from inserted) <= @soluongton)
		begin
			update Hang set SLTon = SLTon - (select SoLuong from inserted)
			from Hang where MaHang = @mahang
		end
	else
		begin
			raiserror(N'Số lượng tồn không đủ',16,1)
			rollback tran
		end
end