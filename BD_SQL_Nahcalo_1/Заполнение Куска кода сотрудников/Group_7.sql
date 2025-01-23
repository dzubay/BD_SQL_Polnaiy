
/*  

--(1,'Финансовый депортамент'197)
     (1,'Отдел бухгалтерского учёта'              ,197),
     (1,'Отдел финансового планирования и анализа',197),
     (1,'Казначейство'                            ,197),
     (1,'Отдел налогов'                           ,197),
--(2,'Депортамен HR'292)														   	
     (2,'Отдел подбора персонала'                 ,292),
     (2,'Отдел обучения и развития'               ,292),
     (2,'Отдел компенсаций и льгот'               ,292),
--(3,'Депортамент продаж'487)													  		,
     (3,'Отдел управления продажами'              ,487),
     (3,'Отдел корпоративных продаж'              ,487),
     (3,'Отдел розничных продаж'                  ,487),
     (3,'Отдел продаж в интернете'                ,487),
--(4,'Маркетинговый депортамент'506)													   	
     (4,'Отдел исследований и аналитики'          ,506),
     (4,'Отдел стратегического маркетинга'        ,506),
     (4,'Отдел цифрового маркетинга'              ,506),
     (4,'Отдел рекламы и PR'                      ,506),
--(5,'Операционный депортамент'129)													   	
     (5,'Отдел планирования операций'             ,129),
     (5,'Отдел управления проектами'              ,129),
     (5,'Отдел контроля качества'                 ,129),
     (5,'Отдел информационных технологий'         ,129),
     (5,'Отдел логистики и снабжения'             ,129),
--(6,'Депортамен IT (информационных технологий)'556)											   	
     (6,'Разработка программного обеспечения'     ,556),
     (6,'Системное администрирование'             ,556),
     (6,'Информационные технологии (IT)'          ,556),
     (6,'Аналитика и бизнес-разведка'             ,556),
     (6,'Управление проектами'                    ,556),
     (6,'Маркетинг и Продажи'                     ,556),
     (6,'Кибербезопасность'                       ,556),
     (6,'Дизайн и пользовательский опыт (UX/UI)'  ,556),
--7,'Юридический Депортамент'395)													   	
     (7,'Отдел корпоративного права'              ,395),
     (7,'Отдел гражданского права'                ,395),
     (7,'Отдел уголовного права'                  ,395),
     (7,'Отдел административного права'           ,395),
--8,'Депортамент службы безопастности'127)											   		
     (8,'Отдел аналитики и прогнозирования'       ,127),
     (8,'Отдел оперативной поддержки'             ,127),
     (8,'Отдел физической безопасности'           ,127),
     (8,'Отдел аналитики и прогнозирования'       ,127)
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
	          print  convert(nvarchar(10),@e_1) + ' @e_1 Заполнение переменной'
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
		      print  convert(nvarchar(10),@e_2) + ' @e_2 Заполнение переменной'
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
		       print  convert(nvarchar(10),@e_3) + ' @e_3 Заполнение переменной'
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
	         print  convert(nvarchar(10),@e_4) + ' @e_4 Заполнение переменной'
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
		      print  convert(nvarchar(10),@e_5) + ' @e_5 Заполнение переменной'
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
		       print  convert(nvarchar(10),@e_6) + ' @e_6 Заполнение переменной'
		   end
	 end
	 else
			break;
	if (@e_7 = 0)
	 begin
	    set  @e_7 = (select ID_Branch from Department where ID_Department = @e)
		if @e_7 is not null
		    begin
			    print  convert(nvarchar(10),@e_7) + ' @e_7 Заполнение переменной'
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
		      print  convert(nvarchar(10),@e_8) + ' @e_8 Заполнение переменной'
		   end
	 end
	 else
			break;
 end;




insert into dbo.[Group] (ID_Department,Name_Group,ID_Branch)
 values
--1,'Финансовый депортамент'197
     (1,'Отдел бухгалтерского учёта'              ,@e_1),
     (1,'Отдел финансового планирования и анализа',@e_1),
     (1,'Казначейство'                            ,@e_1),
     (1,'Отдел налогов'                           ,@e_1),
--2,'Депортамен HR'292														   		
     (2,'Отдел подбора персонала'                 ,@e_2),
     (2,'Отдел обучения и развития'               ,@e_2),
     (2,'Отдел компенсаций и льгот'               ,@e_2),
--3,'Депортамент продаж'487													  		,
     (3,'Отдел управления продажами'              ,@e_3),
     (3,'Отдел корпоративных продаж'              ,@e_3),
     (3,'Отдел розничных продаж'                  ,@e_3),
     (3,'Отдел продаж в интернете'                ,@e_3),
--4,'Маркетинговый депортамент'506													   		
     (4,'Отдел исследований и аналитики'          ,@e_4),
     (4,'Отдел стратегического маркетинга'        ,@e_4),
     (4,'Отдел цифрового маркетинга'              ,@e_4),
     (4,'Отдел рекламы и PR'                      ,@e_4),
--5,'Операционный депортамент'129													   		
     (5,'Отдел планирования операций'             ,@e_5),
     (5,'Отдел управления проектами'              ,@e_5),
     (5,'Отдел контроля качества'                 ,@e_5),
     (5,'Отдел информационных технологий'         ,@e_5),
     (5,'Отдел логистики и снабжения'             ,@e_5),
--6,'Депортамен IT (информационных технологий)'556													   		
     (6,'Разработка программного обеспечения'     ,@e_6),
     (6,'Системное администрирование'             ,@e_6),
     (6,'Информационные технологии (IT)'          ,@e_6),
     (6,'Аналитика и бизнес-разведка'             ,@e_6),
     (6,'Управление проектами'                    ,@e_6),
     (6,'Маркетинг и Продажи'                     ,@e_6),
     (6,'Кибербезопасность'                       ,@e_6),
     (6,'Дизайн и пользовательский опыт (UX/UI)'  ,@e_6),
--7,'Юридический Депортамент'395													   	
     (7,'Отдел корпоративного права'              ,@e_7),
     (7,'Отдел гражданского права'                ,@e_7),
     (7,'Отдел уголовного права'                  ,@e_7),
     (7,'Отдел административного права'           ,@e_7),
--8,'Депортамент службы безопастности'127														   		
     (8,'Отдел аналитики и прогнозирования'       ,@e_8),
     (8,'Отдел оперативной поддержки'             ,@e_8),
     (8,'Отдел физической безопасности'           ,@e_8),
     (8,'Отдел аналитики и прогнозирования'       ,@e_8)
 --rollback
commit
go


begin tran
drop table if exists #t_3
Select ID_Group,null as Department_Сode, 0 flag into #t_3 from dbo.[Group]
go
declare @i_3 int = 0;
declare @s_1 int;
declare @ROWCOUNT_1 int;

declare
 @ID_Group            bigint  
,@Department_Сode     int
,@flag                int
declare mycur_1 cursor local fast_forward read_only for

Select * from #t_3

open  mycur_1
fetch next from  mycur_1 into @ID_Group,@Department_Сode,@flag
 while @@FETCH_STATUS  = 0
    begin
        begin try

              set  @s_1= (case when (round(rand()*4,0)) =1 then round(rand()*9999999,0)
						       when (round(rand()*4,0)) =2 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =3 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =4 then round(rand()*9999999,0)
                           else  round(rand()*9999999,0)  end);
			  print ' Сформировали случайное число -->' + convert(nvarchar(10),@s_1)

			  if ( select top 1 1 
			       from dbo.#t_3  as Gr 
				   where 1 = 1 
				   and Gr.flag = 0 
				   and Gr.ID_Group = @ID_Group 
				   and Gr.Department_Сode is  null)  = 1
			     begin
	                update  Gr
	                set Department_Сode = @s_1 
	                from  dbo.#t_3  as Gr 
			        where  Gr.flag = 0 and  Gr.ID_Group = @ID_Group and Gr.Department_Сode is  null					
					set @ROWCOUNT_1 = @@ROWCOUNT

			        print ' Случайное число внесено в Department_Сode в таблицу dbo.#t_3 --> ' + convert(nvarchar(10),@ID_Group)
                 end
			  
			  if  @ROWCOUNT_1 > 0   
			     begin
			         update m 
			         set flag = 1 
			         from #t_3  as m where   ID_Group = @ID_Group and flag = 0 
					 print ' ID_Group ' +  convert(nvarchar(10),@ID_Group) + ' flag с "0" изменён на "1" в таблице #t_3' 
			     end  
        end try
	    begin catch
	       if xact_state() in (1, -1) -- Функция XACT_STATE сообщает о состоянии пользовательской транзакции текущего выполняемого запроса.
		              /*
		              1 : запрос внутри блока транзакции активен и действителен (не выдал ошибку).
                      0 : запрос не выдаст ошибку (например, запрос select внутри транзакции без запросов update / insert).
                      -1: Запрос внутри транзакции выдал ошибку (при вводе блока catch) и выполнит полный откат
					  (если у нас есть 4 успешных запроса и 1 выдает ошибку ,все 5 запросов будут откатаны ).
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
     fetch next from  mycur_1 into @ID_Group,@Department_Сode,@flag
   end
close mycur_1
deallocate mycur_1
commit

begin tran
declare
 @ID_Group_2            bigint  
,@Department_Сode_2     int
,@flag_2                int;

 if exists (select flag from #t_3 where  not exists ( select flag from #t_3 where flag = 0))
	   begin
			   declare  mycur_2 cursor local fast_forward read_only for 
			   select ID_Group,Department_Сode,flag from  #t_3 
			   open  mycur_2
			     fetch next from  mycur_2 into @ID_Group_2,@Department_Сode_2,@flag_2
			       while @@FETCH_STATUS =  0 
				       begin
					       begin try
						         update Gr_2
								 set Department_Сode = @Department_Сode_2
								 from dbo.[Group] as Gr_2
								 where @ID_Group_2 = ID_Group and @flag_2 = 1
								 print ' По -->  ID_Group ' +  convert(nvarchar(10),@ID_Group_2) + ' Внесены изменения в таблице Group из таблицы #t_3' 
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
                       fetch next from  mycur_2 into @ID_Group_2,@Department_Сode_2,@flag_2
					   end
               close mycur_2
              deallocate mycur_2
            end
commit
--rollback


--select * from #t_3   2749159
--select * from [Group]  764492


