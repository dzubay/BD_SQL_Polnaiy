set nocount,xact_abort on;
go

begin tran 
    go
    create procedure Proc_Random_FIO
    @gender int,
	@Random_FIO nvarchar(200) output
      as
        DECLARE @firstname   NVARCHAR(70);
        DECLARE @lastname  	 NVARCHAR(70);
        DECLARE @middlename	 NVARCHAR(70);
        SET @firstname  = (select top 1 firstname  from  names_f  where gender  = @gender order by newid())
        SET @lastname   = (select top 1 lastname   from  names_l  where gender  = @gender order by newid())
        SET @middlename = (select top 1 middlename from  names_m  where gender  = @gender order by newid())
    
    set @Random_FIO = @firstname + ' ' +  @lastname + ' ' +  @middlename  
    go



    create procedure Proc_Random_F
    @gender int,
	@Random_F  nvarchar(70) output
      as
        DECLARE @firstname   NVARCHAR(70);
        SET @firstname  = (select top 1 firstname  from  names_f  where gender  = @gender order by newid())  
    set @Random_F =  @firstname 
	go


	create procedure Proc_Random_I
    @gender int,
	@Random_I  nvarchar(70) output  
      as
        DECLARE @lastname   NVARCHAR(70);
        SET @lastname  = (select top 1 lastname   from  names_l  where gender  = @gender order by newid())  
     set @Random_I =  @lastname
	go


    create procedure Proc_Random_O
    @gender int,
	@Random_O  nvarchar(70) output  
      as
        DECLARE @middlename   NVARCHAR(70);
        SET @middlename  = (select top 1 middlename   from  names_m  where gender  = @gender order by newid())  
      set @Random_O =  @middlename
	go

commit
--rollback

/*
exec Proc_Random_F 	2   ,@Random_F output
exec Proc_Random_I  2   ,@Random_I output
exec Proc_Random_O  2   ,@Random_O output 
exec Proc_Random_FIO 2   ,@Random_FIO output
*/