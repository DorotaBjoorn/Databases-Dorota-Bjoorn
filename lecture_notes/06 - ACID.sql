begin transaction -- begin tran

delete from users2 where FirstName like 'a%';
delete from users2 where FirstName like 'b%';

rollback

commit

select * from users2