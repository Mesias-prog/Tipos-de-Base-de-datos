--tipo de datos
--numeros
--enteros (int, integer):
  --edad, cantidad, identificados de una tabla.

create database ejemplodedatos
use ejemplodedatos
create table empleados(
idempl int,
edad int);

insert into empleados (idempl,edad) 
values (1,20),(2,32);

select *from empleados
--decimales(2 tipos: decimal y float):
--precio, descuento, talla, peso
create table productos(
precio decimal(10,2),
descuento float)
insert into productos (precio, descuento)
values (15.99, 0.49)
select *from productos

--texto:
  --varchar, text:
  --nombre, apellido,ruc, dni
  --text:
  --descripcion, comentario
create table cliente(
nombre varchar (50),
dni varchar(10),
descripcion text)
insert into cliente (nombre, dni, descripcion)
values ('diego mesias', '0908403048','cliente habitual con compras de comida')
select*from cliente

--fechas y horas
  --date, time, datatime 
create table horatrans(
fechnaci date,
fechcontra date,
horainici time,
horafin time,
videocompleto datetime)
insert into horatrans (fechnaci, fechcontra, horafin, horainici, videocompleto)
values('2002-02-05','2024-04-25','16:04','10:00', '2025-09-08 20:00')
select *from horatrans
--datos boolean ("bit" en sqlserver)
  --valores de verdad o falso, si algo o algioen está activo o inactivo, flag 
create table usuarrios(
id int,
activo bit)
insert into usuarrios (id,activo) --(activo 1, inactivo 0)
values (1,1),(2,0),(3,0),(4,1)
select *from usuarrios