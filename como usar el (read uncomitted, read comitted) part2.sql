dbcc opentran
dbcc inputbuffer (67)
rollback tran;
kill 67;

begin tran
update acoount set balance = 1 where accountid=1
commit

begin tran
update acoount set balance = balance + 220 where accountid= 2
 rollback;

 begin tran
update acoount set balance=balance - 16 where accountid = 1
commit

begin tran
update acoount set balance = 1700 where accountid=1
commit