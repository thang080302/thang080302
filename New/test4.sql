use QLKHOX

select * from Nhap
select * from Xuat
select * from Ton

create view v1
as
select Xuat.MaVTu,TenVTu,sum(SoLuongX*DonGiaX) as 'TienBan'
from Ton inner join Xuat on Ton.MaVTu=Xuat.MaVTu
group by Xuat.MaVTu,TenVTu

select * from v1

create function F2(@mavattu nchar(10))
returns @List table (
					MaVT nchar(10),
					TenVT nvarchar(30),
					TienBan float(20)
					)
as
begin
	insert into @List
		select Xuat.MaVTu,TenVTu,sum(SoLuongX*DonGiaX)
		from Ton inner join Xuat on Ton.MaVTu=Xuat.MaVTu
		where Xuat.MaVTu = @mavattu
		group by Xuat.MaVTu,TenVTu
	return
end

select * from F2('VT001')

alter proc Sp01(@mavt nchar(10))
as
begin
	declare @dongian float(20)
	set @dongian = (select max(DonGiaN) from Nhap where MaVTu = @mavt)
	select Ton.MaVTu,TenVTu,SoLuongT,sum(SoLuongT*@dongian) as N'TienDong'
	from Ton inner join Nhap on Nhap.MaVTu=Ton.MaVTu
	where Ton.MaVTu = @mavt
	group by Ton.MaVTu,TenVTu,SoLuongT
end

exec dbo.Sp01'VT001'
