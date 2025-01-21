set nocount,xact_abort on;
go

begin tran 
    go
    create procedure Proc_Random_FIO
    @gender int  
      as
        DECLARE @firstname   NVARCHAR(70);
        DECLARE @lastname  	 NVARCHAR(70);
        DECLARE @middlename	 NVARCHAR(70);
        SET @firstname  = (select top 1 firstname  from  names_f  where gender  = @gender order by newid())
        SET @lastname   = (select top 1 lastname   from  names_l  where gender  = @gender order by newid())
        SET @middlename = (select top 1 middlename from  names_m  where gender  = @gender order by newid())
    
    SELECT @firstname + ' ' +  @lastname + ' ' +  @middlename  as FIO
    go



    create procedure Proc_Random_F
    @gender int  
      as
        DECLARE @firstname   NVARCHAR(70);
        SET @firstname  = (select top 1 firstname  from  names_f  where gender  = @gender order by newid())  
    SELECT @firstname as F
	go


	create procedure Proc_Random_I
    @gender int  
      as
        DECLARE @lastname   NVARCHAR(70);
        SET @lastname  = (select top 1 lastname   from  names_l  where gender  = @gender order by newid())  
      SELECT @lastname as I
	go


    create procedure Proc_Random_O
    @gender int  
      as
        DECLARE @middlename   NVARCHAR(70);
        SET @middlename  = (select top 1 middlename   from  names_m  where gender  = @gender order by newid())  
      SELECT @middlename as O
	go

commit
--rollback

/*
exec Proc_Random_F 	2
exec Proc_Random_I  2
exec Proc_Random_O  2
exec Proc_Random_FIO 2
*/