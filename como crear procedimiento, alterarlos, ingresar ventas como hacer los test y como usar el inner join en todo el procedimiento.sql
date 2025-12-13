create database sistema_ordeness
use sistema_ordeness

create table cliente(
clienteid int identity(1,1) primary key,
nombre_cliente nvarchar(100) not null,
telefono nvarchar(10) null,
correo nvarchar (max) null,
direccion nvarchar(max)
);
create table productos(
productoid int identity (1,1) primary key,
nombre_producto nvarchar(100) not null,
descripcion nvarchar(max) not null,
precio_unitario decimal (10,2)not null,
stock int
);
create table ventas(
ventaid varchar (10) primary key,
clienteid int not null,
fechar_venta date default getdate(),
total decimal (10,2) default 0,
foreign key (clienteid) references cliente(clienteid) on delete cascade); --el delete cascade indica que si borro un cliente se borra todos los pedidos que ese cliente tiene

create table detallesventa(
 detalleid int identity (1,1) primary key,
 ventaid varchar(10) not null,
 productoid int not null,
 cantidad int not null,
 precio_unitario decimal (10,2),
 subtotal as (cantidad*precio_unitario) persisted,
 foreign key (ventaid) references ventas (ventaid) on delete cascade,
 foreign key (productoid) references productos (productoid) on delete cascade);--codigos del producto
 
 create type detalleordentype as table(
  productoid int ,
 cantidad int,
 precio_unitario decimal (10,2));

insert into cliente(nombre_cliente, telefono,correo,direccion)
values ('Carlos Pérez', '0987654321', 'carlos.perez@gmail.com', 'Av. Siempre Viva 123'),
('María López', '0991122334', 'maria.lopez@hotmail.com', 'Cdla. El Paraíso, Mz 12'),
('Diego Mesías', '0983344556', 'diego.mesias@gmail.com', 'Barrio Central, Calle 20'),
('Ana Torres', '0975566778', 'ana.torres@live.com', 'Urbanización Las Lomas, Villa 9'),
('Fernando Ruiz', '0964433221', 'fernando.ruiz@empresa.com', 'Calle Los Álamos 456');
select *from cliente

insert into productos (nombre_producto,descripcion ,precio_unitario ,stock )
values ('Laptop HP 15', 'Laptop HP con procesador Intel i5, 8GB RAM y SSD 256GB',500.00, 20),
('Mouse Logitech M280', 'Mouse inalámbrico ergonómico',25.00, 50),
('Teclado Mecánico Redragon', 'Teclado mecánico RGB switches blue',35.00, 35),
('Monitor Samsung 24', 'Monitor LED Full HD 1920x1080',452.99, 15),
('Auriculares Sony WH-CH520', 'Auriculares inalámbricos Bluetooth con micrófono',19.99, 25);
select *from productos

go 
alter procedure insertar_venta
@ventaid varchar(10),
@clienteid int,
@detallesventa detalleordentype readonly
 as 
	begin transaction
		begin try
			 --insertar en ventas
			 insert into ventas (ventaid,clienteid)
			 values (@ventaid,@clienteid);
			 --insertar en detallesventas con los precios actuales del producto
			 insert into detallesventa (ventaid, productoid,cantidad,precio_unitario)
			 select @ventaid, d.productoid,d.cantidad,p.precio_unitario
			 from @detallesventa d inner join productos p on d.productoid=p.productoid;
			 --calcular el total (declarar un total)
			 declare @total decimal (10,2)
			 select @total = sum (subtotal)
			 from detallesventa where ventaid=@ventaid
			 --actualizar el total
			 update ventas
			 set total = @total
			 where ventaid = @ventaid;

			commit transaction;--grabar los cambios en la bd si no existiera errores en la transaction
		end try
		begin catch
			rollback transaction;--deshacer los cambios
			throw;
		end catch;
--realizar el test
declare @detalles detalleordentype
insert into @detalles (productoid,cantidad) 
values (1,2),(2,1)

execute insertar_venta
@ventaid ='orde0004',
@clienteid =1,
@detallesventa = @detalles;

--select*from ventas
--select*from detallesventa
--mostrar los datos que se requiera con los inner join y crear un procedure (para cambiar el procedure creado se tiene que usar alter)
go
alter procedure consultarordenes
as
begin 
select v.ventaid,c.nombre_cliente,v.fechar_venta,d.detalleid,p.nombre_producto,d.cantidad,d.precio_unitario,d.subtotal,v.total
from ventas v inner join cliente c on v.clienteid=c.clienteid
inner join detallesventa d on v.ventaid=d.ventaid
inner join productos p on p.productoid=d.productoid
order by v.fechar_venta desc
end;
execute consultarordenes
 go
 --eliminar venta
 create procedure eliminarorder
 @ventaid varchar (10)
 as begin
 delete from ventas
 where ventaid=@ventaid
 end;
 exec eliminarorder 'orde0003'

