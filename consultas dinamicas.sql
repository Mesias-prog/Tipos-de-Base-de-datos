/*
consultas dinamincas con uso de variables
*/
create database ejemplodinamica
use ejemplodinamica

declare @nombretabla nvarchar (100);
declare @sql nvarchar(max);
set @nombretabla='cliente';
set @sql ='create table '+@nombretabla+'(
id int primary key, 
nombre nvarchar (100),
edad int)';
exec sp_executesql @sql;
select*from cliente
--ejemplo de seleccionar una columna
declare @columnaseleccion nvarchar(100);
declare @sql2 nvarchar(max);
set @columnaseleccion ='nombre'
set @sql2 ='select '+@columnaseleccion+' from cliente ';--aqui se debe dejar un espacio al principio y al final porque da error al ejecutar
exec sp_executesql @sql2 
--ejemplo 2
insert into cliente
values (2,'Diego',33),
(3,'Maria',18),(4,'Gonzales',21);
--ejemplo 3 filtrar la edad cuando esta sea igual o mayor a 30
declare @filtroedad int;
declare @sql3 nvarchar(max);
set @filtroedad =30;
set @sql3='select*from cliente where edad>=@edad';
exec sp_executesql @sql3, N'@edad int', @edad=@filtroedad --el N se utiliza para saber que la cadena es unicode y es buena practica usarlo pero no es necesario cuando se quiere filtrar los nvarchar,
--el @edad es igual a la variable que se indicó en el @filtroedad


