--sintaxis case= forma simple: case expresion
--when valor1 then resultado1
--when valor2 then resultado2
--------------------
--else resultado_por_defecto
--end
--NO SE OLVIDEN DE LAS COMAS, PUNTO Y COMA, QUE YA VAN VARIAS VECES QUE ME MARCA ERROR  Y SOLO ME FALTABAN LAS COMAS
--utilizar case en su froma simple para la clasificacion de un costo
select costo,
case costo 
when 10 then 'economico'
when 30 then 'moderado'
when 40 then 'costoso'
else 'indefinido'
end as clasificacion 
from consultas
--busqueda de clasificacion por rango ( si la edad de una mascota es tal se muestra un mensaje especifico)
select nombre_mascota, edad,
case 
when edad <=1 then 'cachorro'
when edad between 2 and 5 then 'joven'
else 'adulto'
end as categoria
from mascotas

--ejemplo 1con case: obtener informacion de las consultas con estado basado en el costo
go
create procedure usp_obtenerconsultasconestado
as 
begin
	select c.costo, c.idconsulta,cl.nombre_cliente,m.nombre_mascota,
	c.fecha,c.descripcion,
	--aqui se usa el case para determinar el estado del costo
	case 
		when c.costo > 30 then 'alto'
		when c.costo between 20 and 10 then 'medio'
		else 'bajo'
	end as estado_costo
	from consultas c inner join mascotas m on c.idmascotas=m.idmascotas
	inner join cliente cl on cl.idcliente=c.idcliente
end;
exec usp_obtenerconsultasconestado
go

--ejemplo2 : agrupar los clientes y clasificarlos por gasto total
alter procedure usp_agruparloporgasto
as begin
select c.idcliente, c.nombre_cliente,
c.telefono, c.direccion,
count(co.idconsulta) as totalconsultas,
sum(co.costo) as gastototal,
--aqui se clasifica segun los gastos y colocarlos en un nivel (vip,frecuence,ocacional)
case 
when sum(co.costo)>40 then 'vip'
when sum(co.costo) between 30 and 20 then 'frecuente'
else 'ocacional'
end as clasificacion
from cliente c inner join mascotas m on m.idcliente=c.idcliente
inner join consultas co on m.idmascotas=co.idmascotas
group by c.idcliente,c.nombre_cliente,c.telefono, c.direccion
end;

exec usp_agruparloporgasto
select*from cliente
select *from mascotas
select*from consultas

go 
alter procedure usp_agruparnombres
as begin 
select c.idcliente, c.nombre_cliente, m.nombre_mascota, co.fecha,co.costo,
--aquí se pregunta cauntas consultas en total tiene cada cliente
count(co.idconsulta) as total_consultas,
case 
when co.fecha = '2025-11-28' then 'llegó'
when co.fecha between '2025-11-29' and '2025-11-30' then 'tarde'
else 'no llegó'
end as saber_si_llegó
from cliente c inner join mascotas m on m.idcliente=c.idcliente
inner join consultas co on co.idmascotas=co.idmascotas
group by c.idcliente, c.nombre_cliente, m.nombre_mascota, co.fecha,co.costo
end;
exec usp_agruparnombres
select*from consultas