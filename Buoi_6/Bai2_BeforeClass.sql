use trigger_1
--a;
create trigger TG_2
on HoaDon
for delete
as
begin
	declare @soluongban int
	set @soluongban = (select deleted.SoLuongBan from deleted inner join HoaDon on HoaDon.MaHang = deleted.MaHang)
	update Hang set SoLuong = SoLuong + @soluongban
end

--b;

create trigger TG_3
on HoaDon
for update 
as
begin
 declare @delete int
 declare @insert int
	set @delete = (select deleted.SoLuongBan from deleted inner join HoaDon on HoaDon.SoLuongBan = deleted.SoLuongBan)
	set @insert = (select inserted.SoLuongBan from inserted inner join HoaDon on HoaDon.SoLuongBan = inserted.SoLuongBan )
	update Hang set SoLuong = SoLuong - (@insert-@delete)
end