use QLKHO
--a;
select TenVT,SoLuongT
from Ton
where SoLuongT = (select max(SoLuongT) from Ton)

--b;
select TenVT,Ton.MaVT,SoLuongT
from Ton inner join Xuat on Xuat.MaVT = Ton.MaVT
group by Ton.MaVT,TenVT,SoLuongT
having sum(SoLuongX) > 100

--c;
create view cau_4
as
select month(NgayX) as N'Tháng xuất',year(NgayX) as N'Năm xuất',count(SoLuongX) N'Tổng số lượng xuất'
from Xuat
group by month(NgayX),year(NgayX)

--d;
create view cau_5
as 
select Nhap.MaVT,TenVT,SoLuongN,SoLuongX,DonGiaN,DonGiaX,NgayN,NgayX
from Nhap inner join Ton on Ton.MaVT = Nhap.MaVT
		  inner join Xuat on Nhap.MaVT = Xuat.MaVT

--e;
create view cau_6
as
select Ton.MaVT,TenVT,sum(SoLuongT) + sum(SoLuongN) - sum(SoLuongX) as N'Tổng số lượng còn lại trong kho'
from Nhap inner join Ton on Ton.MaVT = Nhap.MaVT
		  inner join Xuat on Nhap.MaVT = Xuat.MaVT
where year(NgayX) = 2015
group by Ton.MaVT,TenVT