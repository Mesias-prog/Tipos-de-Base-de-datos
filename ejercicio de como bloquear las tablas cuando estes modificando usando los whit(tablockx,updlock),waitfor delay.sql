create database tienda
use tienda

create table productos ( idproducto int identity primary key, nombreprod varchar(50), precio decimal (10,2),
stock int)
create table venta ( idventa int identity (1,1) primary key, idproducto int, cantidad int,
fecha_venta date default getdate(), foreign key (idproducto) references productos (idproducto))

insert into productos(nombreprod, precio, stock)
values ('laptop',500.00,40),
('mouse',25.00,80),
('teclado',35.00,70);

insert into venta (idproducto, cantidad)
values  (1, 2),
(2, 10),
(3, 16);
select *from venta

 --concurrecia: ocurre cuando varios ususarios intentan acceder y modificar la base de datos al mismo tiempo 
--bloqueo con begin transaccion y lock 
--evitar que otro usuario modifique un producto mientras actualizamos el stock (ususario vendedor 1)
begin transaction 
update productos
set stock = stock - 2
where idproducto = 1
--simulamos que dejamos la transacciones abierta 
waitfor delay '00:00:10'; --esperamos 10 segundos
commit;
select *from productos

--bloqueo explicito con tablockx
begin transaction
update productos
set stock = stock -10
where idproducto = 2
select *from productos with (tablockx) --ahora nadie mas puede modificar la tabla de productos hasta que termine la transaction
waitfor delay '00:00:10';
commit;

--ejemplo de control de versiones con un campo rowversion
 alter table productos add rowversion ROWVERSION

--lock, unlock no existe en sqlserver pero se puede usar el lock with(updlock), tablockx, rowlock
--implementar los comandos equivales al lock y unlock
--bloquear un producto mientras actualizamos el stock
begin transaction
select *from productos with (updlock) where idproducto=1;
waitfor delay '00:00:05';
update productos
set stock = stock -16
where idproducto= 3;
commit;