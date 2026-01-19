create database bddinamica;
go;
use bddinamica;
go;
create table cliente(
idcliente int primary key,
nombre nvarchar (100) not null,
edad int not null,
ciudad nvarchar(100) not null);

create table predidos(
idpedido int primary key,
idcliente int,
fecha date,
monto decimal (12,0) not null,
foreign key (idcliente) references cliente(idcliente));

insert into cliente (idcliente, nombre, edad, ciudad)
values
(1, 'Carlos Pérez', 30, 'Guayaquil'),
(2, 'María López', 25, 'Quito'),
(3, 'Diego Mesías', 28, 'Milagro'),
(4, 'Ana Torres', 35, 'Cuenca');

insert into predidos (idpedido, idcliente, fecha, monto)
values
(101, 1, '2025-01-10', 150),
(102, 2, '2025-01-12', 230),
(103, 1, '2025-01-15', 320),
(104, 3, '2025-01-18', 90);

/*incluye el total de pedidos por cliente
que permita filtrar por ciudad y rango de edad
tambien que pueda ordenar los resultados por cualquier columna
*/

declare @filtrociudad nvarchar(100);
declare @filtroedadmin int;
declare @filtroedadmax int;
declare @orden nvarchar (100);
declare @sql nvarchar(max);
--configuracion dinamica
set @filtrociudad ='Guayaquil';
set @filtroedadmin =20;
set @filtroedadmax = 30;
set @orden ='totalpedidos desc';
--construccion de consultas
set @sql =' select c.idcliente,
	c.nombre,
	c.ciudad, 
	count(p.idpedido) as totalpedidos,
	sum(p.monto) as totalmonto
	from cliente c left join predidos p on p.idcliente=c.idcliente
	where c.ciudad=@ciudad
	and c.edad between @edadmin and @edadmax
	group by c.idcliente,c.nombre,c.ciudad
	order by ' +@orden
--aqui lo ejecutamos
exec sp_executesql @sql, N'@ciudad nvarchar(100), @edadmin int, @edadmax int',
@ciudad=@filtrociudad,
@edadmin=@filtroedadmin,
@edadmax=@filtroedadmax;