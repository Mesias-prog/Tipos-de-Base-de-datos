create database ejemplodb;
go
use ejemplodb
go
create table productos(
idproducto int identity (1,1) primary key,
nombre nvarchar(100) not null,
precio decimal (10,2) not null,
categoria nvarchar(100) not null);
insert into productos
values('Laptop Lenovo', 850.99, 'Tecnología'),
('Mouse Logitech', 25.99, 'Accesorios'),
('Teclado Mecánico', 70.55, 'Accesorios'),
('Monitor Samsung 24"', 220.30, 'Tecnología'),
('Impresora HP', 180.55, 'Oficina');

select *from productos

 declare @sql nvarchar(max);
 declare @categoria nvarchar(50)='Tecnología';
 declare @precmin decimal (10,2)=100.00;
 declare @precmax decimal (10,2)=900.00
 --ahora se debe incializar la consulta 
 set @sql='select idproducto,nombre,precio,categoria from productos where 1=1'
 --agregamos las condiciones dinamicas
 if @categoria is not null
	set @sql = @sql + ' and categoria = ''' +@categoria+''''
if @precmin is not null
	set @sql = @sql +' and precio >= ' +cast (@precmin as nvarchar)
if @precmax is not null
	set @sql =@sql +' and precio <= '+cast(@precmax as nvarchar)
--imprimimos la consulta generada para depuracion 
--print @sql
--ejecutamos la consulta dinamica 
exec sp_executesql @sql 



/*
select idproducto,nombre,precio,categoria from productos where 1=1 
and categoria ='Tecnología'

 select p.idproducto,p.categoria,p.precio
 from productos p
 where p.idproducto =1
 and p.categoria = 'Tecnología'
 and p.precio >=100.00
 and p.precio <=900.00
 */