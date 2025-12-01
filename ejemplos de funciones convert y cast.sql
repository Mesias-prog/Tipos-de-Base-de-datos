--funcion convert
select convert(datetime,'2021-12-25 10:00:00') as fechaconvertida;
select convert (datetime ,'15/12/2002',103) as fechaformatoeuropeo;
--funcion cast 
select cast ('2023-03-16' as date) as fechaconvertida;
--formato yyyy-mm-dd
select convert (datetime, '15-03-2025',103)as fechaestandar;
--conversion de cadenas
select cast('123'as int)as numero; --convertir de cadena a entero
select cast (getdate ()as varchar (20)) as fechacadena; --getdate coje la fecha actual
select convert (int,'456') as cadenanumero;
select convert(varchar,getdate(),103)as dia_mes_año;
--estilo 103 es un formato de fecha britanico dia,mes,año
--estilo 120 es un formato ISO año,mes,dia, hora,minutos,segundos
select TRY_CAST('123' as int); --as=convertir
select TRY_CONVERT(int, 'abc')
select TRY_CONVERT (varchar, getdate(),1)