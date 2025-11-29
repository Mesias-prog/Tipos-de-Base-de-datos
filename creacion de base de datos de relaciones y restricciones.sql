create database dblibrerias
go --el comando go lo detiene para crear uno por uno 
--seleccionar la base de datos
use dblibrerias;
go

--crear la tabla de autores
 create table autores ( autorID int primary key, --clave primaria
 nombre varchar (50) not null,  --el nombre del autor no puede ser nulo
 fechadenacimiento date not null,
 constraint UQ_autorNom unique (nombre)); -- unique es una restriccion unique: no puede haber dos autores iguales
 go
  
  --tabla categorias
create table categorias (categoriaID int primary key,
nombrecategoria varchar (50) not null,
constraint UQ_categoriaNom unique (nombrecategoria));
go

--tabla libros
create table libros(librosID int primary key,
nombrelibro varchar (110) not null,
autorID int,--calve foranea de la tabla autores
preciolibros decimal(10,2) default 0.00,
constraint FK_libros_autor foreign key (autorID) references autores(autorID), --references: relacion con la tabla autores
constraint chk_precio check (preciolibros >=0)); --restriccion check: precio debe ser mayor o igual a 0
go

--tabla intermedia para la relacion de muchos a muchos entre libros y categorias
create table libros_categorias (libcategID int primary key identity(1,1),
librosID int, --clave foranea de la tabla libros 
categoriaID int, --clave foranea de la tabla categorias
constraint fk_libros foreign key(librosID) references libros(librosID),
constraint fk_categorias foreign key (categoriaID) references categorias(categoriaID))
