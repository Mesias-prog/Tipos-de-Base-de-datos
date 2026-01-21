create database dbautomatizacion
use dbautomatizacion

create table productos(
idproducto int identity(1,1) primary key,
nombre nvarchar (max) not null)
insert into productos
values('laptop'),
('impresora')
select *from productos


