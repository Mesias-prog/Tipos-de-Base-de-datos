--SINTAXIS BASICA
--Merge intp tabla_destino as target
--using: tabla origen as source
--on considicion_de_coincidencia
--where matched then
--ACCIONES PARA FILA QUE COINCIDEN
--update set columna1= source.columna1,columna2=source.columna2
--when not matched then
--ACCIONES PARA FILAS EN SOURCE QUE NO ESTAN EN TARGET
--insert (columna1, columna2)
--values(source.columna1, source.columna2)
--when not matched by source then
--opcional:ACCIONES PARA FILAS EN TARGET QUE NO ESTAN EN SOURCE
--delete
create database dbInvetario
use dbInvetario
create table producto_destino(
idproducto int primary key,
nombreprod nvarchar(100) not null,
precio decimal (10,2) not null);
create table producto_origen(
idproducto int  primary key,
nombreprod nvarchar (100) not null,
precio decimal (10,2) not null);

insert into producto_destino 
values (1,'producto a', 50.00),
(2,'producto b', 300.00),
(3,'producto d', 400.00);

insert into producto_origen
values (1,'producto a', 100.00),
(2,'producto b', 200.00),
(3,'producto c', 300.00);

select *from producto_origen
select *from producto_destino;

--uso del comando de merge
merge into producto_destino as target
using producto_origen as source
on target.idproducto= source.idproducto
when matched then
	update set target.nombreprod= source.nombreprod,
					target.precio=source.precio
when not matched then 
	insert(idproducto, nombreprod, precio)
	values(source.idproducto, source.nombreprod, source.precio)
when not matched by source then
delete;
--que está pasando aqui?: el comando merge hizo que todos los productos de la tabla destino
--sean igual al de la tabla origen, en palabras mas cortas, se actualizó la tabla del destino en base a la de origen