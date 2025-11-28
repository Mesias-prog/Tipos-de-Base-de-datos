create table personal
(ID int primary key,
Nombre varchar(50),
Edad int,
Salario money,
Fechcontra datetime,
Depart varchar(50),
activo bit)
--ingresar datos
insert into personal (ID, Nombre,Edad,Salario,Fechcontra,Depart,activo)
values
(2,'Ana',19,700.70,2025-4-15,'pasante de sistemas',1),
(3,'Rafael',44,2500.70,2025-2-30,'contador',1),
(4,'Maria',35,2500.70,2025-7-25,'abogado',1),
(5,'Jose',27,2500.70,2025-3-12,'RRHH',1),
(6,'Delgado',30,2500.70,2025-4-06,'tecnico',1)
--personal con salarios mayor a 2000 y activos
Select 
*from personal
where salario >2000 and activo=1
--personal que estén en abogado o tecnico y tenga menos de 40 años
Select
*from personal
where (Depart='abogado' or Depart='tecnico')
and edad <40 order by Depart desc --el order by es para ordenar y "desc" y "acen" es descendente y ascendente
--seleccionr el departamento con el salario entre 2000 y 5000
select 
*from personal 
where Salario between 2000 and 5000
--seleccionar al personal cuyo nombre empieze con D
select
* from personal
where Nombre like 'd%' --like '%' es para buscar por letras en especifico
--seleccionar personal cuya edad no sea 30 y que trabaje en abogado
select
*from personal
where edad <> 30 and Depart = 'abogado' -- el <> es diferente
--pesonal no activo salario mayor a 2100
select
*from personal
where not activo=1 and Salario>2100 
--resumen
--=(igual) compara si dos valores son iguales
--<>(diferente) compara si dos valores son diferentes
-->(mayor que) compara si un valor es mayor que otro
--<(menor que) compara si un valor es menor que otro
--between se usa para seleccionar un rango de valores 
--like es usado para comparar partes especificas de una cadena con el uso de 
-- formato y condiciones