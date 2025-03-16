use Magaz_DB_Poln 
go
set nocount,xact_abort on
go

begin tran
--Это если идентификатор после удаления начала добавляться не с нуля, то можно удалить всё и добавить заново с нуля.
--Только один раз воспользоваться этой  DBCC CHECKIDENT функцией и всё.
--IF EXISTS  
--		(
--			SELECT * 
--			FROM sys.identity_columns 
--			WHERE object_id = OBJECT_ID('dbo.Status_Employee') 
--				AND last_value IS not NULL 
--		)
--	begin
		--DBCC CHECKIDENT ('dbo.Status_Employee', RESEED, 0);

		  insert into  Status_Employee (Name_Status_Employee,[Description])
		  values
			  ('Действующий',''),
			  ('В Архиве','Это значит что пользователь когда работал, и на данный момент уволен'),
			  ('Пробный период','От 1 до 3 месяцев'),
			  ('На проверке','Проверяется в СБ'),
			  ('Дублированая Учётная запись',''),
			  ('Неисправная','');

         declare @Status_Employee int;
         set @Status_Employee = (select count(ID_Status_Employee) as ID_Status_Employee from Status_Employee)
         print 'Заполнена таблица dbo.Status_Employee. Общее количество заполненных строк --> ' +  cast(@Status_Employee as nvarchar(5))
--    end
commit
go
--select * from Status_Employee 
--delete from Status_Employee where ID_Status_Employee is not null
