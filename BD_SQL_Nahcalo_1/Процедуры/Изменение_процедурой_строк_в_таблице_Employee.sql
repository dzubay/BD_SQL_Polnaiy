
begin tran 
declare
@3_Image_Employees varbinary(max) = (SELECT * FROM OPENROWSET(BULK N'D:\���������\��\��� ���� ������\�������� ��� ��\q10.jpg', SINGLE_BLOB) AS image)
exec UpdateEmployee
 @ID_Employee                        = 13
,@ID_Department					     = 3		
,@ID_Group						   	 = 2
,@ID_The_Subgroup				   	 = 2
,@ID_Passport					   	 = 3
,@ID_Branch						   	 = 3
,@ID_Post						   	 = 3
,@ID_Status_Employee			   	 = 3
,@ID_Connection_String			   	 = 3
,@ID_Chief						   	 = 13     --������ ��������� �� ��������������� ������������, � �� ������ ����
,@Name							   	 = 'hjghfghf'
,@SurName						   	 = 'ughvhgchg'
,@LastName						   	 = 'hfhgfhg'
,@Date_Of_Hiring				   	 = '20240912'   --���� ����� �� ������
,@Residential_Address			   	 = 'dfvdfvxfv'
,@Home_Phone					   	 = 56756
,@Cell_Phone					   	 = 567835
,@Image_Employees				   	 = @3_Image_Employees
,@Work_Phone					   	 = 35354
,@Mail							   	 = 'werwer@yandex.ru'
,@Pol							   	 = '�'
,@Date_Of_Dismissal				   	 = '20240910'   --���� ����������
,@Date_Of_Birth					   	 = '20240910'   --���� ��������
,@Description					   	 = 'utytr lkhugu ljlknjh hvdtkl'
--rollback
commit


--select * from Employees

--select * from Employees_Audit