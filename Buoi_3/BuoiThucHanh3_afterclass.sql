use QLKHO


insert ton values
('vt05','vattu5',500),
('vt01','vattu1',10),
('vt02','vattu2',90),
('vt03','vattu3',75),
('vt04','vattu4',99)
insert nhap values
	(3,'vt02',1,100,'2021-02-11'),
	(1,'vt01',1,100,'2022-02-11'),
	(2,'vt01',1,200,'2022-01-07')
insert xuat values
(2,'vt01',1,90,'2022-01-10'),
(1,'vt02',1,80,'2019-01-09')


select * from Nhap
select * from Xuat
select * from Ton

--d;
delete from Xuat 
from Xuat inner join Nhap on Xuat.MaVT = Nhap.MaVT
where DonGiaX < Nhap.DonGiaN

--e;
update Xuat
set NgayX = NgayN
from Xuat inner join Nhap on Xuat.MaVT = Nhap.MaVT
where NgayX < NgayN
