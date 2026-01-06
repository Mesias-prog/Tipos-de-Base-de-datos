use master
create database dbinventario
use dbinventario
create table ProductoActual(
idproducto int primary key,
nombreprod nvarchar(100) not null,
precio decimal (10,2) not null,
stock int);
insert into ProductoActual 
values (1,'teclado',30.55,50),
(2,'mouse',15.00,80),
(3,'pantalla',150.00,10);
create table ProductoNuevo(
idproducto int primary key,
nombreprod nvarchar (100) not null,
precio decimal (10,2) not null,
stock int);
insert into ProductoNuevo 
values (1,'teclado mecanico',35.55,50),
(3,'monitor',30.00,50),
(4,'autricular',10.00,300);--este producto tiene que integrarse

select *from ProductoNuevo
select *from ProductoActual;

-----------------------------------------------------
--crear una tabla temporal
create table #resultadomerge(
accion nvarchar(100),
idproducto int,
nombreprod nvarchar (100) not null,
precio decimal (10,2) not null,
stock int);
select*from #resultadomerge
----------------------------------------------------

merge into ProductoActual as destino
using ProductoNuevo as fuente
on destino.idproducto=fuente.idproducto
when matched then
update set
destino.nombreprod=fuente.nombreprod,
destino.stock=fuente.stock,
destino.precio=fuente.precio
when not matched by target then--aqui se inserta los nuevos registors
insert (idproducto,nombreprod,stock,precio)
values(fuente.idproducto,fuente.nombreprod,fuente.stock,fuente.precio)
when not matched by source then--aqui se elimina los registros que ya no esten en la fila
delete
--para ver los cambios se tiene que crear una tabla temporal antes del merge solo si quieres

output
$action as action,
inserted.idproducto as productoid,
inserted.nombreprod as nombre,
inserted.stock as stock,
inserted.precio as precio
into #resultadomerge;