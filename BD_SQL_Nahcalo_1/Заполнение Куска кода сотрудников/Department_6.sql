--select * from Department

---- ���� � ������ ������ �������� �� � ID ������ = 1, �� ����� �������� ������� � ������� �����, � ��������� �������.
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
	  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '���������� �����������',
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
			  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '���������� HR',
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
			  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '����������� ������',
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
			  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '������������� �����������',
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
			  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '������������ �����������',
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
			  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '���������� IT (�������������� ����������)',
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
			  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '����������� �����������',
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
	  insert into  Department (Name_Department,ID_Branch,Department_�ode) 
      values
        (
        '����������� ������ �������������',
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





