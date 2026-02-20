/*como crear vistas optimizadas*/
use bdmedicinal
select * from plantas
select * from regiones
select * from observaciones
select * from observacionesparts
--lista de plantas junto a la region que pertenece
go;
create view vistaplantasconregion as
select p.idplantas,p.nombre,p.fechadescutbimiento, r.nombre_region
from plantas p join regiones r on p.regionid=r.regionid

select * from vistaplantasconregion

--crear una vista de las plantas con su descripcion
go;
create view vistadeplantascondescripcion as
select p.nombre,p.fechadescutbimiento,p.categoria, o.descripcion
from plantas p join observaciones o on p.idplantas=o.idplantas

select *from vistadeplantascondescripcion

--vista de plantas por categoria y descripcion

select
p.nombre,p.categoria,o.descripcion, count(p.idplantas) as cantidaddeplantas
from plantas p join observaciones o on o.idplantas=p.idplantas
group by p.nombre,p.categoria,o.descripcion
/*
mostrar todas las vistas en la base de datos actual*/
select*from INFORMATION_SCHEMA.views;
/* ver el contenido de la vista*/
exec sp_helptext 'vistadeplantascondescripcion'
-