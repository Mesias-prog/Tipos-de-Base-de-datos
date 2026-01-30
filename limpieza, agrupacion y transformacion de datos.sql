create database dbpreparacion
use dbpreparacion

create table ventas(
idventas int primary key identity,
fechaventa datetime,
producto nvarchar(100) not null,
cantidadventa int,
precio decimal(10,2),
clienteid int)
-- Insertar datos en tabla VENTAS
INSERT INTO ventas (fechaventa, producto, cantidadventa, precio, clienteid) VALUES
('2024-01-05 10:30:00', 'Laptop Dell XPS 13', 2, 1250.00, 1),
('2024-01-08 14:15:00', 'Mouse Logitech MX', 5, 89.99, 2),
('2024-01-10 09:45:00', 'Teclado Mecánico RGB', 3, 145.50, 3),
('2024-01-12 16:20:00', 'Monitor Samsung 27"', 1, 320.00, 1),
('2024-01-15 11:00:00', 'Auriculares Sony WH-1000XM4', 4, 299.99, 4),
('2024-01-18 13:30:00', 'Webcam Logitech C920', 2, 79.99, 5),
('2024-01-20 10:10:00', 'Disco Duro Externo 2TB', 6, 89.00, 2),
('2024-01-22 15:45:00', 'Tablet iPad Air', 1, 599.00, 6),
('2024-01-25 12:00:00', 'Impresora HP LaserJet', 2, 280.00, 7),
('2024-01-28 09:30:00', 'Router TP-Link AC1750', 3, 65.00, 3),
('2024-02-01 14:50:00', 'Laptop Dell XPS 13', 1, 1250.00, 8),
('2024-02-03 11:20:00', 'Mouse Logitech MX', 10, 89.99, 1),
('2024-02-05 16:00:00', 'Teclado Mecánico RGB', 2, 145.50, 9),
('2024-02-08 10:40:00', 'Monitor Samsung 27"', 3, 320.00, 4),
('2024-02-10 13:15:00', 'Auriculares Sony WH-1000XM4', 1, 299.99, 10),
('2024-02-12 09:00:00', 'Webcam Logitech C920', 5, 79.99, 2),
('2024-02-15 15:30:00', 'Disco Duro Externo 2TB', 4, 89.00, 5),
('2024-02-18 12:45:00', 'Tablet iPad Air', 2, 599.00, 7),
('2024-02-20 10:20:00', 'Impresora HP LaserJet', 1, 280.00, 3),
('2024-02-22 14:10:00', 'Router TP-Link AC1750', 8, 65.00, 6),
('2024-03-01 11:30:00', 'Laptop Dell XPS 13', 3, 1250.00, 1),
('2024-03-03 16:15:00', 'Mouse Logitech MX', 7, 89.99, 9),
('2024-03-05 09:50:00', 'Teclado Mecánico RGB', 1, 145.50, 2),
('2024-03-08 13:40:00', 'Monitor Samsung 27"', 2, 320.00, 8),
('2024-03-10 10:05:00', 'Auriculares Sony WH-1000XM4', 6, 299.99, 4),
('2024-03-12 15:20:00', 'Webcam Logitech C920', 3, 79.99, 10),
('2024-03-15 12:30:00', 'Disco Duro Externo 2TB', 10, 89.00, 5),
('2024-03-18 09:15:00', 'Tablet iPad Air', 1, 599.00, 3),
('2024-03-20 14:50:00', 'Impresora HP LaserJet', 4, 280.00, 7),
('2024-03-22 11:10:00', 'Router TP-Link AC1750', 5, 65.00, 6),
('2024-03-25 16:30:00', 'Laptop Dell XPS 13', 2, 1250.00, 9),
('2024-03-28 10:45:00', 'Mouse Logitech MX', 12, 89.99, 1),
('2024-03-30 13:00:00', 'Teclado Mecánico RGB', 3, 145.50, 8),
('2024-04-02 09:25:00', 'Monitor Samsung 27"', 1, 320.00, 2),
('2024-04-05 15:40:00', 'Auriculares Sony WH-1000XM4', 2, 299.99, 10);
select *from ventas

/*
limpieza de datos
*/
delete from ventas
where fechaventa is null or producto =  'Laptop Dell XPS 13' 
/*
transformacion de datos
*/
select 
convert (date, fechaventa,120) as fechadeventa,
producto,
cantidadventa,
precio,
(cantidadventa*precio) as totalventa
from ventas
/*
agregacion de datos
*/
select
clienteid,
producto,
sum(cantidadventa) as totalunidadesventas,
sum(cantidadventa*precio) as totaldeventas
from ventas
group by producto,clienteid
