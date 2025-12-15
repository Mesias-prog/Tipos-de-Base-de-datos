use tiendacte
select *from productos

--niveles de aislamiento
--read uncommitted (lectura sucia)
set transaction isolation level read uncommitted;
 begin tran
 update productos set stock =5 where idcategoria=1
--rollback
--commit

--read committed(evitar lecturas sucias)
set tran isolation level read committed
begin tran
update productos set stock =100 where idcategoria = 1
--rollback
--commit

--repeatable red (evita lecturas no repetibles)
 set tran isolation level repeatable read
 begin tran
 select *from productos where idcategoria = 1;
 --commit
 --rollback

 --prueba serializable (evita lecturas fantasmas)
 set tran isolation level serializable
 begin tran 
 select *from productos
 --commit
 --rollback