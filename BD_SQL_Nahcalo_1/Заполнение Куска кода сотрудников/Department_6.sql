--select * from Department

---- Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
/*
begin tran
if exists 
	  (	  
	  	SELECT last_value 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.Department') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Department', RESEED, 0)
	  end
--rollback
commit
go
*/


--delete from Department where id_Department is not null
--select * from Department


--579
use  Magaz_DB
go
set nocount,xact_abort on
go
begin tran
	  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Финансовый депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
         else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамен HR',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамент продаж',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Маркетинговый депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Операционный депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамен IT (информационных технологий)',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Юридический Депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
	  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамент службы безопастности',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
commit
--rollback





