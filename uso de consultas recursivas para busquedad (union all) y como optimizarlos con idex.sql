create database ctebd
use ctebd
create table empleados(
idempleado int identity primary key,
nombre nvarchar (100) not null,
edad int not null,
supervisorid int null,
constraint fksupervisor foreign key (supervisorid) references empleados(idempleado));

--Insertamos a los altos mandos (Supervisorid es null)
insert into empleados (nombre, edad, supervisorid) values 
('Carlos Mendoza', 52, null),-- id 1 (Gran Jefe)
('Ana Rodríguez', 45, null);-- id 2 (Directora Regional)
--Insertamos supervisores de área (Reportan a los ids 1 y 2)
insert into empleados (nombre, edad, supervisorid) values 
('Luis García', 38, 1),-- Reporta a Carlos
('Sofía Martínez', 33, 1),-- Reporta a Carlos
('Roberto Gómez', 40, 2);-- Reporta a Ana
--Insertamos analistas y operativos (Reportan a los supervisores)
insert into empleados (nombre, edad, supervisorid) values 
('Elena Pazo', 28, 3),-- Reporta a Luis
('Diego Torres', 25, 3),-- Reporta a Luis
('Javier López', 30, 4),-- Reporta a Sofía
('Lucía Rivas', 27, 5),-- Reporta a Roberto
('Marco Ruiz', 29, 4);-- Reporta a Sofía
select *from empleados
--ahora se va hacer una consulta recursiva
with jerarquiaempleados as(
	select nombre, edad, idempleado,supervisorid
	from empleados
	where supervisorid is null
	union all --aqui es la parte recursiva donde se va a seleccionar a los empleados
	--que reportan a los que ya estan en la jerarquia
	select e.nombre,e.edad,e.idempleado,e.supervisorid
	from empleados e inner join jerarquiaempleados j on e.supervisorid=j.idempleado)
	select * from jerarquiaempleados

with jerarquiaXniveles as(
	select idempleado,nombre,edad,supervisorid, 0 as nivel
	from empleados
	where supervisorid is null
	union all
	select e.idempleado,e.nombre,e.edad,e.supervisorid,je.nivel+1
	from empleados e inner join jerarquiaXniveles je on e.supervisorid=je.idempleado)
	select*from jerarquiaXniveles order by nivel;

create table categoria(
idcategoria int identity primary key,
nombrecategoria nvarchar(100) not null,
categoriapadreid int null);
--Categorías Principales (Raíz - Categoriapadreid es null)
insert into categoria (nombrecategoria, categoriapadreid) values 
('Electrónica', null),    -- id 1
('Hogar y Muebles', null), -- id 2
('Ropa y Calzado', null);  -- id 3
--Subcategorías de Nivel 2 (Dependen de las principales)
insert into categoria (nombrecategoria, categoriapadreid) values 
('Computación', 1),-- id 4 (Hija de Electrónica)
('Telefonía', 1),-- id 5 (Hija de Electrónica)
('Dormitorio', 2),-- id 6 (Hija de Hogar)
('Cocina', 2),-- id 7 (Hija de Hogar)
('Caballeros', 3);-- id 8 (Hija de Ropa)
--Subcategorías de Nivel 3 (Detalle específico)
insert into categoria (nombrecategoria, categoriapadreid) values 
('Laptops', 4),-- id 9 (Hija de Computación)
('Monitores', 4),-- id 10 (Hija de Computación)
('Smartphones', 5),-- id 11 (Hija de Telefonía)
('Colchones', 6),-- id 12 (Hija de Dormitorio)
('Microondas', 7);-- id 13 (Hija de Cocina)

with jerarquiaXcategoria as(
	select idcategoria,nombrecategoria,categoriapadreid
	from categoria
	where categoriapadreid is null --nivel superior
	union all
	select ca.idcategoria,ca.nombrecategoria,ca.categoriapadreid
	from categoria ca inner join jerarquiaXcategoria jer on ca.categoriapadreid= jer.idcategoria)
	select *from jerarquiaXcategoria order by idcategoria;

----------------------------------------------optimizacion--------------------------
create table directorio(
iddirectorio int identity primary key,
nombredirectorio nvarchar(100) not null,
directoriopadreid int null); --aqui se hace referencia a la carpeta principal

--Unidades o Carpetas Raíz (Nivel 0)
insert into directorio (nombredirectorio, directoriopadreid) values 
('C:', null),-- id 1
('D: (Backup)', null);-- id 2
--Carpetas de Sistema y Usuario en C: (Nivel 1)
insert into directorio (nombredirectorio, directoriopadreid) values 
('Archivos de Programa', 1), -- id 3
('Usuarios', 1),-- id 4
('Windows', 1);-- id 5
-- Subcarpetas de Usuario (Nivel 2)
insert into directorio (nombredirectorio, directoriopadreid) values 
('Admin', 4),-- id 6 (Dentro de Usuarios)
('Invitado', 4);-- id 7 (Dentro de Usuarios)
-- Carpetas de Documentos del Admin (Nivel 3)
insert into  directorio (nombredirectorio, directoriopadreid) values 
('Mis Documentos', 6),-- id 8
('Imágenes', 6),-- id 9
('Proyectos_SQL', 8);-- id 10 (Dentro de Mis Documentos)

create index idx_directorioXpadreid on directorio(directoriopadreid);
create index idx_directorioid on directorio(iddirectorio);

with jerarquiaXdirectorio as(
	select iddirectorio, nombredirectorio, directoriopadreid
	from directorio
	where directoriopadreid is null
	union all
	select d.iddirectorio, d.nombredirectorio, d.directoriopadreid
	from directorio d inner join jerarquiaXdirectorio je on d.directoriopadreid= je.iddirectorio)
	select *from jerarquiaXdirectorio
	option (maxrecursion 100); --aqui se limita la recursividad a 100 interacciones