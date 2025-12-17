--funciones definidas por el usuario(udf_)
--funciones escalares solo devuelven un valor
--tipo tabla devuelven un conjunto de datos
--tipos de datos:
--pueden retornar los numerico, decimal, los float, texto, fecha, booleanos, bit, etc

--calcula el precio total con impuesto aplicado a un producto
use bdsisventas
create function calculprecioXimpues(
@precio decimal (10,2), @Impuesto decimal (5,2))

returns decimal (10,2)
as begin 
--calcular el precio con los impuestos
	return @precio +(@precio *@Impuesto / 100);
end;
--usar la funcion
select dbo.calculprecioXimpues (100,16) as precioconimpuesto

--determina si un cliente es considerado VIP segun el total de su compra
create function  ESclienteVIP(
@totaldecompra decimal (10,2))
returns bit
as 
begin
	declare @esVIP bit;
	--si las compras son mayores a 10.000 es un cliente bit
	if @totaldecompra >= 10000 
	set @esVIP= 1; --true
	else 
	set @esVIP= 0; --false
	return @esVIP
end

select dbo.ESclienteVIP(12000) AS VIP