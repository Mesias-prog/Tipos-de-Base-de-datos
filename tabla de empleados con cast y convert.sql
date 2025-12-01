create table empleados(
empleados int primary key,
nombre varchar(100),
fechanaci date,
salario decimal(10,2),
activo bit)

insert into empleados(empleados,nombre,fechanaci,salario,activo)
values (1, 'juan perez', '2002/05/12',500.50, 1),
(2, 'varlos gomez', '2004/10/05',800.50, 0),
(3, 'ana lopez',  '2001/08/25',5000.50, 1)

select *from empleados

select nombre, cast(salario as varchar(20)) as salariotext
from empleados;

select nombre, convert(varchar(10), fechanaci, 102)as fechanacimientotext
from empleados;

select  CONCAT(nombre,' - ', 'salario: ',cast (salario as varchar(20)), '-',
'fecha de nacimiento: ', convert(varchar(10),fechanaci,102))
as detallesempleados
from empleados

select nombre, TRY_CAST (salario as varchar(20)) as salariotexto
from empleados