create database bdventana
use bdventana

create table producto(
idproducto int identity (1,1) primary key,
categoria nvarchar (50) not null,
fecha_venta date,
cantidad int,
precio decimal (10,2));

insert into producto (categoria, fecha_venta, cantidad, precio)
values
('Electrónica', '2025-01-05', 3, 450.00),
('Electrónica', '2025-01-10', 1, 1200.00),
('Hogar','2025-01-12', 5, 35.50),
('Hogar','2025-01-15', 2, 89.99),
('Oficina','2025-01-18', 10, 15.00);

select *from producto
--ejemplo 1: total acumulado por categoria
select categoria,
cantidad,
fecha_venta,
precio, cantidad*precio as Ingreso, 
sum(cantidad*precio) over (partition by categoria order by fecha_venta) 
as TotalAcumulado
from producto
--ejemplo 2: calcular el promedio de ingreso por categoria
select
categoria,
cantidad
fecha_venta,
precio,
cantidad*precio as ingreso,
avg(cantidad*precio) over  (partition by categoria) as promedioXcategoria
from producto
--ejemplo 3: hallar el minimo y el maximo por categoria
select
cantidad,
categoria,
precio,
fecha_venta,
min(precio) over (partition by categoria) as preciomin,
max(precio) over (partition by categoria) as preciomax
from producto
--ejemplo 4: conteo acumulativo de productos por categoria
select
categoria,
fecha_venta,
cantidad,
count(*) over(partition by categoria order by fecha_venta) as conteo
 from producto