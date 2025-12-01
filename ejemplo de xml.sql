--xml
create table productoxml(
id int,
nombre varchar (10),
detalles xml)

insert into productoxml(id, nombre, detalles)
values (1,'laptop','<producto><marca>hp</marca><modelo>hp1234</modelo><precio>1200</precio></producto>'),
(2,'smartphone','<producto><marca>apple</marca><modelo>a360</modelo><precio>8000</precio></producto>')

select * from productoxml

--json
create table clientes2(
id int, nombre varchar (100), infodatos nvarchar(max))

insert into clientes2(id,nombre,infodatos)
values(1,'juan','["edad: 30, "ciudad": "madrid"]')

select *from clientes2

create table ventas(id int, productonom varchar(100), precio money, descuento smallmoney)
 insert into ventas (id, productonom, precio, descuento)
 values (1,'laptop', 1500.00,23.80),
 (2,'smatphone',800,30)

 select *from ventas

 --binary(100) y varbinary(max) es para almacenar fotos o documentos, en general cualquier dato binario
 create table archivos (id int, nombarch varchar(100), archivo varbinary (max))
 insert into archivos (id, nombarch,archivo)
 select 1,'cacao',* from openrowset(bulk 'D:\sql2022\Cacao.jpg', single_blob) as imagen;

  select *from archivos