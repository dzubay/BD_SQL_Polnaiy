
/*  

--(1,'���������� �����������'197)
     (1,'����� �������������� �����'              ,197),
     (1,'����� ����������� ������������ � �������',197),
     (1,'������������'                            ,197),
     (1,'����� �������'                           ,197),
--(2,'���������� HR'292)														   	
     (2,'����� ������� ���������'                 ,292),
     (2,'����� �������� � ��������'               ,292),
     (2,'����� ����������� � �����'               ,292),
--(3,'����������� ������'487)													  		,
     (3,'����� ���������� ���������'              ,487),
     (3,'����� ������������� ������'              ,487),
     (3,'����� ��������� ������'                  ,487),
     (3,'����� ������ � ���������'                ,487),
--(4,'������������� �����������'506)													   	
     (4,'����� ������������ � ���������'          ,506),
     (4,'����� ��������������� ����������'        ,506),
     (4,'����� ��������� ����������'              ,506),
     (4,'����� ������� � PR'                      ,506),
--(5,'������������ �����������'129)													   	
     (5,'����� ������������ ��������'             ,129),
     (5,'����� ���������� ���������'              ,129),
     (5,'����� �������� ��������'                 ,129),
     (5,'����� �������������� ����������'         ,129),
     (5,'����� ��������� � ���������'             ,129),
--(6,'���������� IT (�������������� ����������)'556)											   	
     (6,'���������� ������������ �����������'     ,556),
     (6,'��������� �����������������'             ,556),
     (6,'�������������� ���������� (IT)'          ,556),
     (6,'��������� � ������-��������'             ,556),
     (6,'���������� ���������'                    ,556),
     (6,'��������� � �������'                     ,556),
     (6,'�����������������'                       ,556),
     (6,'������ � ���������������� ���� (UX/UI)'  ,556),
--7,'����������� �����������'395)													   	
     (7,'����� �������������� �����'              ,395),
     (7,'����� ������������ �����'                ,395),
     (7,'����� ���������� �����'                  ,395),
     (7,'����� ����������������� �����'           ,395),
--8,'����������� ������ �������������'127)											   		
     (8,'����� ��������� � ���������������'       ,127),
     (8,'����� ����������� ���������'             ,127),
     (8,'����� ���������� ������������'           ,127),
     (8,'����� ��������� � ���������������'       ,127)
*/



use Magaz_DB
go
set nocount,xact_abort on
go
begin tran

declare @e bigint = 1
declare 
    @e_1 bigint = 0
   ,@e_2 bigint	= 0
   ,@e_3 bigint	= 0
   ,@e_4 bigint	= 0
   ,@e_5 bigint	= 0
   ,@e_6 bigint	= 0
   ,@e_7 bigint	= 0
   ,@e_8 bigint	= 0
while  @e <= 9
   begin
     if (@e_1 = 0)
	  begin
       set  @e_1 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_1 is not null
	       begin
	          set  @e =  @e + 1
	          print  convert(nvarchar(10),@e_1) + ' @e_1 ���������� ����������'
		   end
	  end
	  else
			break;
	 if (@e_2 = 0)
	  begin
	    set  @e_2 = (select ID_Branch from Department where ID_Department = @e)
		if @e_2 is not null
		    begin
		      set  @e =  @e + 1
		      print  convert(nvarchar(10),@e_2) + ' @e_2 ���������� ����������'
			end
	  end
	  else
			break;
	 if (@e_3 = 0)
	  begin
	    set  @e_3 = (select ID_Branch from Department where ID_Department = @e)
		if @e_3 is not null
		    begin
		       set  @e =  @e + 1
		       print  convert(nvarchar(10),@e_3) + ' @e_3 ���������� ����������'
		    end
	  end
	  else
			break;
	if (@e_4 = 0)
	 begin
	  set  @e_4 = (select ID_Branch from Department where ID_Department = @e)
	  if @e_4 is not null
	      begin
	         set  @e =  @e + 1
	         print  convert(nvarchar(10),@e_4) + ' @e_4 ���������� ����������'
		  end
	 end
	 else
			break;
	if (@e_5 = 0)
	 begin
	   set  @e_5 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_5 is not null
	       begin
		      set  @e =  @e + 1
		      print  convert(nvarchar(10),@e_5) + ' @e_5 ���������� ����������'
		   end
	 end
	 else
			break;
	if (@e_6 = 0)
	 begin
	   set  @e_6 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_6 is not null
	       begin
		       set  @e =  @e + 1
		       print  convert(nvarchar(10),@e_6) + ' @e_6 ���������� ����������'
		   end
	 end
	 else
			break;
	if (@e_7 = 0)
	 begin
	    set  @e_7 = (select ID_Branch from Department where ID_Department = @e)
		if @e_7 is not null
		    begin
			    print  convert(nvarchar(10),@e_7) + ' @e_7 ���������� ����������'
		        set  @e =  @e + 1
			end
	 end
	 else
			break;
	if (@e_8 = 0)
	 begin
	   set  @e_8 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_8 is not null
	       begin
		      set  @e =  @e + 1
		      print  convert(nvarchar(10),@e_8) + ' @e_8 ���������� ����������'
		   end
	 end
	 else
			break;
 end;




insert into dbo.[Group] (ID_Department,Name_Group,ID_Branch)
 values
--1,'���������� �����������'197
     (1,'����� �������������� �����'              ,@e_1),
     (1,'����� ����������� ������������ � �������',@e_1),
     (1,'������������'                            ,@e_1),
     (1,'����� �������'                           ,@e_1),
--2,'���������� HR'292														   		
     (2,'����� ������� ���������'                 ,@e_2),
     (2,'����� �������� � ��������'               ,@e_2),
     (2,'����� ����������� � �����'               ,@e_2),
--3,'����������� ������'487													  		,
     (3,'����� ���������� ���������'              ,@e_3),
     (3,'����� ������������� ������'              ,@e_3),
     (3,'����� ��������� ������'                  ,@e_3),
     (3,'����� ������ � ���������'                ,@e_3),
--4,'������������� �����������'506													   		
     (4,'����� ������������ � ���������'          ,@e_4),
     (4,'����� ��������������� ����������'        ,@e_4),
     (4,'����� ��������� ����������'              ,@e_4),
     (4,'����� ������� � PR'                      ,@e_4),
--5,'������������ �����������'129													   		
     (5,'����� ������������ ��������'             ,@e_5),
     (5,'����� ���������� ���������'              ,@e_5),
     (5,'����� �������� ��������'                 ,@e_5),
     (5,'����� �������������� ����������'         ,@e_5),
     (5,'����� ��������� � ���������'             ,@e_5),
--6,'���������� IT (�������������� ����������)'556													   		
     (6,'���������� ������������ �����������'     ,@e_6),
     (6,'��������� �����������������'             ,@e_6),
     (6,'�������������� ���������� (IT)'          ,@e_6),
     (6,'��������� � ������-��������'             ,@e_6),
     (6,'���������� ���������'                    ,@e_6),
     (6,'��������� � �������'                     ,@e_6),
     (6,'�����������������'                       ,@e_6),
     (6,'������ � ���������������� ���� (UX/UI)'  ,@e_6),
--7,'����������� �����������'395													   	
     (7,'����� �������������� �����'              ,@e_7),
     (7,'����� ������������ �����'                ,@e_7),
     (7,'����� ���������� �����'                  ,@e_7),
     (7,'����� ����������������� �����'           ,@e_7),
--8,'����������� ������ �������������'127														   		
     (8,'����� ��������� � ���������������'       ,@e_8),
     (8,'����� ����������� ���������'             ,@e_8),
     (8,'����� ���������� ������������'           ,@e_8),
     (8,'����� ��������� � ���������������'       ,@e_8)
 --rollback
commit
go


begin tran
drop table if exists #t_3
Select ID_Group,null as Department_�ode, 0 flag into #t_3 from dbo.[Group]
go
declare @i_3 int = 0;
declare @s_1 int;
declare @ROWCOUNT_1 int;

declare
 @ID_Group            bigint  
,@Department_�ode     int
,@flag                int
declare mycur_1 cursor local fast_forward read_only for

Select * from #t_3

open  mycur_1
fetch next from  mycur_1 into @ID_Group,@Department_�ode,@flag
 while @@FETCH_STATUS  = 0
    begin
        begin try

              set  @s_1= (case when (round(rand()*4,0)) =1 then round(rand()*9999999,0)
						       when (round(rand()*4,0)) =2 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =3 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =4 then round(rand()*9999999,0)
                           else  round(rand()*9999999,0)  end);
			  print ' ������������ ��������� ����� -->' + convert(nvarchar(10),@s_1)

			  if ( select top 1 1 
			       from dbo.#t_3  as Gr 
				   where 1 = 1 
				   and Gr.flag = 0 
				   and Gr.ID_Group = @ID_Group 
				   and Gr.Department_�ode is  null)  = 1
			     begin
	                update  Gr
	                set Department_�ode = @s_1 
	                from  dbo.#t_3  as Gr 
			        where  Gr.flag = 0 and  Gr.ID_Group = @ID_Group and Gr.Department_�ode is  null					
					set @ROWCOUNT_1 = @@ROWCOUNT

			        print ' ��������� ����� ������� � Department_�ode � ������� dbo.#t_3 --> ' + convert(nvarchar(10),@ID_Group)
                 end
			  
			  if  @ROWCOUNT_1 > 0   
			     begin
			         update m 
			         set flag = 1 
			         from #t_3  as m where   ID_Group = @ID_Group and flag = 0 
					 print ' ID_Group ' +  convert(nvarchar(10),@ID_Group) + ' flag � "0" ������ �� "1" � ������� #t_3' 
			     end  
        end try
	    begin catch
	       if xact_state() in (1, -1) -- ������� XACT_STATE �������� � ��������� ���������������� ���������� �������� ������������ �������.
		              /*
		              1 : ������ ������ ����� ���������� ������� � ������������ (�� ����� ������).
                      0 : ������ �� ������ ������ (��������, ������ select ������ ���������� ��� �������� update / insert).
                      -1: ������ ������ ���������� ����� ������ (��� ����� ����� catch) � �������� ������ �����
					  (���� � ��� ���� 4 �������� ������� � 1 ������ ������ ,��� 5 �������� ����� �������� ).
		              */
              ROLLBACK TRAN
           SELECT 
             ERROR_NUMBER() AS ErrorNumber,
             ERROR_SEVERITY() AS ErrorSeverity,
             ERROR_STATE() as ErrorState,
             ERROR_PROCEDURE() as ErrorProcedure,
             ERROR_LINE() as ErrorLine,
             ERROR_MESSAGE() as ErrorMessage;
	    end catch
     fetch next from  mycur_1 into @ID_Group,@Department_�ode,@flag
   end
close mycur_1
deallocate mycur_1
commit

begin tran
declare
 @ID_Group_2            bigint  
,@Department_�ode_2     int
,@flag_2                int;

 if exists (select flag from #t_3 where  not exists ( select flag from #t_3 where flag = 0))
	   begin
			   declare  mycur_2 cursor local fast_forward read_only for 
			   select ID_Group,Department_�ode,flag from  #t_3 
			   open  mycur_2
			     fetch next from  mycur_2 into @ID_Group_2,@Department_�ode_2,@flag_2
			       while @@FETCH_STATUS =  0 
				       begin
					       begin try
						         update Gr_2
								 set Department_�ode = @Department_�ode_2
								 from dbo.[Group] as Gr_2
								 where @ID_Group_2 = ID_Group and @flag_2 = 1
								 print ' �� -->  ID_Group ' +  convert(nvarchar(10),@ID_Group_2) + ' ������� ��������� � ������� Group �� ������� #t_3' 
						   end try
						   begin catch
						          if xact_state() in (1, -1)   
								      ROLLBACK TRAN
                                  SELECT 
								    ERROR_NUMBER() AS ErrorNumber,
								    ERROR_SEVERITY() AS ErrorSeverity,
								    ERROR_STATE() as ErrorState,
								    ERROR_PROCEDURE() as ErrorProcedure,
								    ERROR_LINE() as ErrorLine,
								    ERROR_MESSAGE() as ErrorMessage;
						   end catch
                       fetch next from  mycur_2 into @ID_Group_2,@Department_�ode_2,@flag_2
					   end
               close mycur_2
              deallocate mycur_2
            end
commit
--rollback


--select * from #t_3   2749159
--select * from [Group]  764492


