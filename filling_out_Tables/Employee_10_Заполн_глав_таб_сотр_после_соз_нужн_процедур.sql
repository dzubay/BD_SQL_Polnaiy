use  Magaz_DB_Poln;
go
set nocount,xact_abort on;
go

/*
begin tran  --Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
if exists 
	  (	  
	  	SELECT name,last_value 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.Employees') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Employees', RESEED, 0)
	  end
--rollback
SELECT name,last_value 
FROM sys.identity_columns 
WHERE object_id = OBJECT_ID('dbo.Employees')
commit
go
*/

-- select * from Employees
-- delete from  Employees where id_Employee is not null



--В конце запроса будет ошибка, которая ссылается на ограничения. Ничего страшного, всё заполнится в предедах 100 пользователей

begin tran
 --Для вставки изображения
 --declare @3_Image_Employees varbinary(max) = (SELECT * FROM OPENROWSET(BULK N'D:\Программы\БД\Моя база данных\Картинки для БД\q13.jpg', SINGLE_BLOB) AS image)

declare @Employees_i int = 0
while @Employees_i <  5000
    begin 
	   declare  @Employees_gender  int
		  set @Employees_gender   = FLOOR(2*RAND()+1)
	   declare
	      @Employees_Name                nvarchar(50)  
         ,@Employees_SurName             nvarchar(50)
         ,@Employees_LastName            nvarchar(50)
		  exec Proc_Random_F   @Employees_gender,@Employees_Name        output;
          exec Proc_Random_I   @Employees_gender,@Employees_SurName     output;
          exec Proc_Random_O   @Employees_gender,@Employees_LastName    output;
	   declare
		  @Date_Of_Birth        datetime     
		  exec RandomDateNew  '19750101','20070101', @Date_Of_Birth   output;
	   declare 
	      @Employees_RandomLogin         nvarchar(100)
		 ,@Employees_RandomMile          nvarchar(150)     
		  exec RandomLogin 10,20,      @Employees_RandomLogin           output;

	   declare
		  @ID_Department        bigint        
		 ,@ID_Group             bigint
		 ,@ID_The_Subgroup      bigint
		 ,@ID_Passport          bigint
		 ,@ID_Branch            bigint
		 ,@ID_Post              bigint
		 ,@ID_Status_Employee   bigint
		 ,@ID_Connection_String bigint
		 ,@Pol                  Char(1)
		 ,@Cell_Phone           nvarchar(20)
		 ,@Work_Phone           nvarchar(20)
		 ,@Home_Phone           nvarchar(20)
		 ,@Date_Of_Hiring       datetime
		 ,@Date_Of_Dismissal    datetime
		 ,@Residential_Address  nvarchar(300)
		 set @ID_Department    = (select top 1 ID_Department from Department order by NEWID())
		 set @ID_Group         = (select top 1 ID_Group from [Group]where ID_Department = @ID_Department  order by NEWID())
		 set @ID_The_Subgroup  = (select
                                      case when @ID_Department = 1 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())    
	                                       when @ID_Department = 2 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())
	                                       when @ID_Department = 3 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())
	                                       when @ID_Department = 4 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())
	                                       when @ID_Department = 5 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())
	                                       when @ID_Department = 7 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())
	                                       when @ID_Department = 8 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is null and g.ID_Department != 6 and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID())
                                           when @ID_Department = 6 then (select top 1 s.ID_The_Subgroup  from The_Subgroup s  left join [Group]  as g on g.ID_Group = s.ID_Group  where s.ID_Parent_The_Subgroup is not null and g.ID_Department = @ID_Department and s.ID_Group = @ID_Group order by NEWID()) 
                                  end)
		 set @ID_Passport          = (select top 1 f.ID_Passport from Passport as f where not exists  (select top 1 ID_Passport from Employees where f.ID_Passport = ID_Passport ) order by newid())
		 set @ID_Branch            = (select top 1 ID_Branch from The_Subgroup where ID_The_Subgroup = @ID_The_Subgroup order by newid())
		 set @Id_Post              = (select top 1 Id_Post from Post where ID_The_Subgroup = @ID_The_Subgroup order by newid())		 
		 set @ID_Connection_String = (select top 1 f.ID_Connection_String from Connection_String as f where not exists  (select top 1 ID_Connection_String from Employees where f.ID_Connection_String = ID_Connection_String ) order by newid())
		 set @Pol                  = (select case when @Employees_gender = 1 then 'М' when @Employees_gender = 2 then 'Ж' end)
		 set @Cell_Phone           = (case when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(912)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(962)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(495)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(928)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(988)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(953)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(374)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(798)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				                           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(912)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
			                          else '' end)
		 set @Work_Phone           = (case when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(912)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(962)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(495)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(928)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(988)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(953)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(374)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(798)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									       when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(912)'  + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
									  else '' end)
		 set @Home_Phone           = (case when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
		                                   when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								           when cast(round(rand()*4,0) as nvarchar(3)) = 4  then  REPLACE(STR(cast(round(rand()*999,0) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
								     else '' end)
       set  @Employees_RandomMile =	 (case when round(rand()*100,0)  = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yandex.ru'
                                           when round(rand()*1,0)    = 1  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.ru'
	                                       when round(rand()*2,0)    = 2  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.com'
	                                       when round(rand()*3,0)    = 3  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@gmail.com'
	                                       when round(rand()*4,0)    = 4  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yahoo.com'
	                                       when round(rand()*5,0)    = 5  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@hotmail.com'
	                                       when round(rand()*6,0)    = 6  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.com'
	                                       when round(rand()*7,0)    = 7  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@icloud.com'
	                                       when round(rand()*8,0)    = 8  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@moore@mail.com'
	                                       when round(rand()*9,0)    = 9  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@tutanota.com'
	                                       when round(rand()*10,0)  = 10  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mydomain.com'
	                                       when round(rand()*11,0)  = 11  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@dr.com'
	                                       when round(rand()*12,0)  = 12  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.co.uk'
	                                       when round(rand()*13,0)  = 13  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@sharklasers.com'
	                                       when round(rand()*14,0)  = 14  then REPLACE(SUBSTRING(CONVERT(varchar(36), @Employees_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@uol.com.br'
                                     ELSE N'Email не указан' END)

       set @Date_Of_Hiring      =  DATEADD(DAY, -ROUND(RAND() * 950, 0), cast(('20201231') as datetime))
	   set @Date_Of_Dismissal   = (select case when floor(2*rand()+1) = 1 then DATEADD(DAY, -ROUND(RAND() * 950, 0), GETDATE()) end)
       set @ID_Status_Employee  = (case  when  @Date_Of_Dismissal is null       then  (select top 1 ID_Status_Employee from Status_Employee where ID_Status_Employee in (1,3,4,6)  order by newid())   
	                                     when  @Date_Of_Dismissal is not null   then  (select top 1 ID_Status_Employee from Status_Employee where ID_Status_Employee in (2,5) and @Date_Of_Dismissal > @Date_Of_Hiring order by newid()) 
										  end)
	   set @Residential_Address = (select CASE    WHEN ROUND(RAND() * 12, 0) = 0  THEN N'ул. Пушкина, д. 1, г. Москва'
		                                          WHEN ROUND(RAND() * 12, 0) = 1  THEN N'ул. Ленина, д. 2, г. Санкт-Петербург'
		                                          WHEN ROUND(RAND() * 12, 0) = 2  THEN N'ул. Свердлова, д. 3, г. Новосибирск'
			                                      WHEN ROUND(RAND() * 12, 0) = 3  THEN N'ул. Кутузова, д. 3,к 2, г. Лысвегас'
			                                      WHEN ROUND(RAND() * 12, 0) = 4  THEN N'ул. Подольских курсантов, д. 43,стр 2, г. Пятигорск'
			                                      WHEN ROUND(RAND() * 12, 0) = 5  THEN N'ул. Проспект Богратиона, д. 10,к 3, г. Салекамск'
			                                      WHEN ROUND(RAND() * 12, 0) = 6  THEN N'ул. Ленина, д. 145, г. Сывтывкар'
			                                      WHEN ROUND(RAND() * 12, 0) = 7  THEN N'ул. Павла Морозова, д. 43,к 6, г. Москва'
			                                      WHEN ROUND(RAND() * 12, 0) = 8  THEN N'ул. Лесная, д. 46,к 5, г. Новосибирск'
			                                      WHEN ROUND(RAND() * 12, 0) = 9  THEN N'ул. Проспект Ермолова, д. 78,стр 2, к 6, г. Москва'
			                                      WHEN ROUND(RAND() * 12, 0) = 10 THEN N'ул. Бульвар северный, д. 79, г. Владикавказ'
			                                      WHEN ROUND(RAND() * 12, 0) = 11 THEN N'ул. Чкалова, д.56,к 34, г. Ставрополь'
		                                      ELSE N'ул. Куйбышева, д. 4, г. Екатеринбург' END)
	   exec InsertEmployee
		 @ID_Department					     = @ID_Department		
		,@ID_Group						   	 = @ID_Group
		,@ID_The_Subgroup				   	 = @ID_The_Subgroup
		,@ID_Passport					   	 = @ID_Passport
		,@ID_Branch						   	 = @ID_Branch
		,@ID_Post						   	 = @ID_Post
		,@ID_Status_Employee			   	 = @ID_Status_Employee
		,@ID_Connection_String			   	 = @ID_Connection_String
		,@ID_Chief						   	 = null              --нельзя указывать на несуществующего пользователя, и на самого себя
		,@Name							   	 = @Employees_Name
		,@SurName						   	 = @Employees_SurName
		,@LastName						   	 = @Employees_LastName
		,@Date_Of_Hiring				   	 = @Date_Of_Hiring   --Дата приёма на работу
		,@Residential_Address			   	 = @Residential_Address
		,@Home_Phone					   	 = @Home_Phone
		,@Cell_Phone					   	 = @Cell_Phone
		,@Image_Employees				   	 = null
		,@Work_Phone					   	 = @Work_Phone
		,@Mail							   	 = @Employees_RandomMile
		,@Pol							   	 = @Pol
		,@Date_Of_Dismissal				   	 = @Date_Of_Dismissal   --Дата увольнения
		,@Date_Of_Birth					   	 = @Date_Of_Birth   --Дата рождения
		,@Description					   	 = null
		set @Employees_i = @Employees_i +1
        print ' Добавлено число ' +  ' -  строк --> ' + convert(nvarchar(10),@Employees_i) + '  В таблицу dbo.Employees';
	end
	--select * from  dbo.Employees
--rollback
commit

