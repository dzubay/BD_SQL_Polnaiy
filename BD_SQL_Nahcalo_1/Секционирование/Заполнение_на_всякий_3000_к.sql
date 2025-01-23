use  Magaz_DB
go

/*
begin tran  --���� � ������ ������ �������� �� � ID ������ = 1, �� ����� �������� ������� � ������� �����, � ��������� �������.
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



--� ����� ������� ����� ������, ������� ��������� �� �����������. ������ ���������, �� ���������� � �������� 100 �������������

begin tran
 --��� ������� �����������
 --declare @3_Image_Employees varbinary(max) = (SELECT * FROM OPENROWSET(BULK N'D:\���������\��\��� ���� ������\�������� ��� ��\q13.jpg', SINGLE_BLOB) AS image)

declare @i int = 0
while @i <= 2000
    begin 
	   declare 
	     @gender               int
		  set @gender           = FLOOR(2*RAND()+1)
	   declare
	      @i_1                  nvarchar(30) =  dbo.RandomFIO_Name(@gender)
		 ,@i_2                  nvarchar(30) =  dbo.RandomFIO_Lastname(@gender)
		 ,@i_3                  nvarchar(30) =  dbo.RandomFIO_Middlename(@gender)
		 ,@Date_Of_Birth        datetime     =  dbo.RandomDate_View_function()
		 ,@ID_Department        bigint        
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
		 set @ID_Passport          = (select STR(cast(round(rand()*99,0) as nvarchar(100)),2,0)) --(select top 1 f.ID_Passport from Passport as f where not exists  (select top 1 ID_Passport from Employees where f.ID_Passport = ID_Passport ) order by newid())
		 set @ID_Branch            = (select top 1 ID_Branch from The_Subgroup where ID_The_Subgroup = @ID_The_Subgroup order by newid())
		 set @Id_Post              = (select top 1 Id_Post from Post where ID_The_Subgroup = @ID_The_Subgroup order by newid())		 
		 set @ID_Connection_String = (select top 1 f.ID_Connection_String from Connection_String as f where not exists  (select top 1 ID_Connection_String from Employees where f.ID_Connection_String = ID_Connection_String ) order by newid())
		 set @Pol                  = (select case when @gender = 1 then '�' when @gender = 2 then '�' end)
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

       set @Date_Of_Hiring      =  DATEADD(DAY, -ROUND(RAND() * 950, 0), cast(('20201231') as datetime))
	   set @Date_Of_Dismissal   = (select case when floor(2*rand()+1) = 1 then DATEADD(DAY, -ROUND(RAND() * 950, 0), GETDATE()) end)
       set @ID_Status_Employee  = (case  when  @Date_Of_Dismissal is null       then  (select top 1 ID_Status_Employee from Status_Employee where ID_Status_Employee in (1,3,4,6)  order by newid())   
	                                     when  @Date_Of_Dismissal is not null   then  (select top 1 ID_Status_Employee from Status_Employee where ID_Status_Employee in (2,5) and @Date_Of_Dismissal > @Date_Of_Hiring order by newid()) 
										  end)
	   set @Residential_Address = (select CASE    WHEN ROUND(RAND() * 12, 0) = 0  THEN N'��. �������, �. 1, �. ������'
		                                          WHEN ROUND(RAND() * 12, 0) = 1  THEN N'��. ������, �. 2, �. �����-���������'
		                                          WHEN ROUND(RAND() * 12, 0) = 2  THEN N'��. ���������, �. 3, �. �����������'
			                                      WHEN ROUND(RAND() * 12, 0) = 3  THEN N'��. ��������, �. 3,� 2, �. ��������'
			                                      WHEN ROUND(RAND() * 12, 0) = 4  THEN N'��. ���������� ���������, �. 43,��� 2, �. ���������'
			                                      WHEN ROUND(RAND() * 12, 0) = 5  THEN N'��. �������� ����������, �. 10,� 3, �. ���������'
			                                      WHEN ROUND(RAND() * 12, 0) = 6  THEN N'��. ������, �. 145, �. ���������'
			                                      WHEN ROUND(RAND() * 12, 0) = 7  THEN N'��. ����� ��������, �. 43,� 6, �. ������'
			                                      WHEN ROUND(RAND() * 12, 0) = 8  THEN N'��. ������, �. 46,� 5, �. �����������'
			                                      WHEN ROUND(RAND() * 12, 0) = 9  THEN N'��. �������� ��������, �. 78,��� 2, � 6, �. ������'
			                                      WHEN ROUND(RAND() * 12, 0) = 10 THEN N'��. ������� ��������, �. 79, �. �����������'
			                                      WHEN ROUND(RAND() * 12, 0) = 11 THEN N'��. �������, �.56,� 34, �. ����������'
		                                      ELSE N'��. ���������, �. 4, �. ������������' END)
	   exec InsertEmployee
		 @ID_Department					     = @ID_Department		
		,@ID_Group						   	 = @ID_Group
		,@ID_The_Subgroup				   	 = @ID_The_Subgroup
		,@ID_Passport					   	 = @ID_Passport
		,@ID_Branch						   	 = @ID_Branch
		,@ID_Post						   	 = @ID_Post
		,@ID_Status_Employee			   	 = @ID_Status_Employee
		,@ID_Connection_String			   	 = @ID_Connection_String
		,@ID_Chief						   	 = null              --������ ��������� �� ��������������� ������������, � �� ������ ����
		,@Name							   	 = @i_1
		,@SurName						   	 = @i_2
		,@LastName						   	 = @i_3
		,@Date_Of_Hiring				   	 = @Date_Of_Hiring   --���� ����� �� ������
		,@Residential_Address			   	 = @Residential_Address
		,@Home_Phone					   	 = @Home_Phone
		,@Cell_Phone					   	 = @Cell_Phone
		,@Image_Employees				   	 = null
		,@Work_Phone					   	 = @Work_Phone
		,@Mail							   	 = 'Na_mylo_uge_zabil))_podnadoelo.@yandex.ru'
		,@Pol							   	 = @Pol
		,@Date_Of_Dismissal				   	 = @Date_Of_Dismissal   --���� ����������
		,@Date_Of_Birth					   	 = @Date_Of_Birth   --���� ��������
		,@Description					   	 = null
	    set @i = @i + 1
	end
	--select * from  dbo.Employees
--rollback
commit
