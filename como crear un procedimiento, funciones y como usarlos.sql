--funciones : bloques de codigo que aceptan parametros de entrada
--son reusables: reutilizar la funcion en multiples consultas evitando la repeticion de codigo
--transparencia: devuelven resultados einmediatos (en una sola fila o un valor escalar)
--no pueden modificar los datos

--ejemplo: crear la funcion escalar para calcular el descuento sobre una venta
use bdsisventas
create function calculardescuento(@totalventa decimal (10,2))
returns decimal (10,2)
as
begin 
	return @totalventa *0.10
end;

select
idventas, totalventa, dbo.calculardescuento(totalventa) as descuento
from ventas;

--Procedimiento almacenado:
--capacidades mas avanzadas,
--control de errores 
--mejora el rendimiento
--seguridad
--si pueden modificar los datos

select*from cliente
select *from productos
select*from ventas
select *from detalleventa

alter procedure usp_Buscarproductosxcod
@idproducto int --esto es un parametro de entrada
as 
begin
	select idproducto,nombreproducto, precio
	from productos
	where idproducto = @idproducto
end
exec usp_Buscarproductosxcod 3 --exec=ejecuta un procedimiento

exec sp_helptext usp_Buscarproductosxcod --procedimiento del sistema es decir que ya está creado

--obtener todas las ventas realizadas por un cleinte en especifico
--incluyendo el detalle de la venta y datos del cliente

create procedure usp_obtenerventasXcliente
@idcliente int
as
begin 
	select v.idcliente,v.idventas,c.idcliente,c.idcliente,c.email
	from ventas v inner join cliente c on v.idcliente=c.idcliente
	where v.idcliente =@idcliente
	end;

exec usp_obtenerventasXcliente @idcliente=2

--crear una funcion de buscar clientes x id
create function buscarclienteXid (@idcliente int)
returns table
as 
	return( select idcliente,nombrecliente,email from cliente
	where idcliente=@idcliente)

--usar la funcion de tabla en una consulta
select *from dbo.buscarclienteXid (3)



