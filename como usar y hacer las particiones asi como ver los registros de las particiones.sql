--optimizacion de consultas y performance tuning

create database bdmedicinal
use bdmedicinal

 create table plantas(
 idplantas int identity (1,1) primary key,
 nombre nvarchar(100) not null, 
 categoria nvarchar(100)not null,
 fechadescutbimiento date default getdate(),
 regionid int foreign key references regiones(regionid))

 create table regiones(
 regionid int identity (1,1) primary key,
 nombre_region nvarchar(100) not null);

 create table observaciones(
 idobservaciones int identity(1,1) primary key,
 idplantas int foreign key references plantas(idplantas),
 regionid int foreign key references regiones(regionid),
 descripcion nvarchar(max),
 fecha_observacion date default getdate());

insert into regiones (nombre_region) values
('amazonas'),('himalaya'),('andes');

insert into plantas (nombre, categoria, regionid) values
('Aloe Vera', 'Medicinal', 1),
('Ginseng', 'Energizante', 2),
('Valeriana', 'Relajante', 3),
('Manzanilla', 'Digestiva', 1),
('Arnica', 'Antiinflamatoria', 3);

insert into observaciones (idplantas, regionid, descripcion) values
(1, 1, 'Se observó crecimiento acelerado en clima húmedo.'),
(2, 2, 'Raíz muy utilizada para mejorar energía y vitalidad.'),
(3, 3, 'Planta encontrada en zonas frías, útil para dormir.'),
(4, 1, 'Utilizada como infusión digestiva.'),
(5, 3, 'Aplicación tópica reduce inflamaciones.');

select *from regiones
select *from plantas
select *from observaciones
--optimizar consultas
select * from plantas
where nombre like '%Ginseng%';
--para mejorarlo creamos un indice para optimizar la busqueda
create index idx_plantas_nombre on plantas(nombre);
select * from plantas
where nombre like ('Ginseng%');
--optimizacionesycon estadisticas y plan de ejecucion
set statistics io on; --cuantas paginas de datos y de indics se leen desde el disco/memoria
set statistics time on; --cuanto tarda la consulta en completarse
select * from plantas where nombre='ginseng';
set statistics io off;
set statistics time off;

update statistics plantas;

-- 1. Crear función de partición (usando date)
create partition function pfobservacionnuevo (date)
as range right for values ('2025-11-24');

-- 2. Crear esquema de partición
create partition scheme psobservacion
as partition pfobservacionnuevo
all to ([PRIMARY]);

-- 3. Crear tabla particionada
create table observacionesparts(
    observacionid int,
    plantaid int,
    descripcion nvarchar(255),
    fechaobservacion date) 
on psobservacion(fechaobservacion);

insert into observacionesparts (observacionid,descripcion,fechaobservacion)
values (1,'Se observó crecimiento acelerado en clima húmedo.','2023-01-01'),
(2, 'Raíz muy utilizada para mejorar energía y vitalidad.','2025-11-24'),
(3, 'Planta encontrada en zonas frías, útil para dormir.','2025-11-24');

--consultar las particiones de la tabla
select partition_id,rows
from sys.partitions
where object_id=object_id('observacionesparts')

select *
from observacionesparts 
where fechaobservacion >='2023-01-01' and fechaobservacion <'2024-01-01'