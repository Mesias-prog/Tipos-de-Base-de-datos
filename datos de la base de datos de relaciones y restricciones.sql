--insertar autores
insert into autores(autorID, nombre, fechadenacimiento)
values(1,'gabriel garcia','1989-09-07'),
(2,'j.k rowling','1970-07-09'),
(3,'Garcia Moreno','1990-10-04');

--insertar categorias
insert into categorias(categoriaID,nombrecategoria)
values (1,'ficcion'),
(2,'fantasia'),
(3,'ciencia');

select*from categorias
select* from libros
--delete *from categorias where categoriaID=3
select *from autores
--insertar libros
insert into libros(librosID,nombrelibro,autorID,preciolibros)
values (1,'harry potter 1',2,15.90)}
insert into libros(librosID,nombrelibro,autorID,preciolibros)
values (2,'la vida y la muerte',1,20.90)
insert into libros(librosID,nombrelibro,autorID,preciolibros)
values (3,'mil años de soledad',3,19.30)
insert into libros(librosID,nombrelibro,autorID,preciolibros)
values (4,'contigo hasta el fin',3,20.30)
select *from libros

--insertar relaciones entre libros y categorias
insert into libros_categorias (librosID,categoriaID)
values(1,1),(2,1),(3,2)
select *from libros_categorias

select *from libros
select*from categorias