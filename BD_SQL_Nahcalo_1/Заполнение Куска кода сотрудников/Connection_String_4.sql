use Magaz_DB
go
set nocount,xact_abort on;
go
-- ���� � ������ ������ �������� �� � ID ������ = 1, �� ����� �������� ������� � ������� �����, � ��������� �������.
--begin tran
--if exists 
--	  (	  
--	  	SELECT * 
--	  	FROM sys.identity_columns 
--	  	WHERE object_id = OBJECT_ID('dbo.Product') 
--	  		AND last_value IS not NULL 	  
--	  )
--	  begin
--	  DBCC CHECKIDENT ('dbo.Connection_String', RESEED, 0)
--	  end
----rollback
--commit
--go
begin tran
declare @i int  =1;
 while @i < = 1014
  begin 
      insert into  Connection_String (Password,Login,Date_�reated,[Description])
	  values 
	  (
	   (REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, 15), '-', '')),
	   (REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '')),
	   DATEADD(DAY, -ROUND(RAND() * 950, 0), GETDATE()),
       CASE   
               WHEN ROUND(RAND() * 51, 0) = 1  THEN '���������� �������� ���������� � ��������.'
               WHEN ROUND(RAND() * 51, 0) = 2  THEN '������ �������� � ������� �������.'
               WHEN ROUND(RAND() * 51, 0) = 3  THEN '�������������� ������ � �������� � ����.'
               WHEN ROUND(RAND() * 51, 0) = 4  THEN '�������� � �������� � ������� ������.'
               WHEN ROUND(RAND() * 51, 0) = 5  THEN '��������� ������������� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 6  THEN '���� �������� ��������� �����.'
               WHEN ROUND(RAND() * 51, 0) = 7  THEN '���������� ����������� ����������.'
               WHEN ROUND(RAND() * 51, 0) = 8  THEN '�������� ������ �������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 9  THEN '�������� ����������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 10 THEN '��������� ������� � ���� ��� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 11 THEN '���������� �� ������������� ����������.'
               WHEN ROUND(RAND() * 51, 0) = 12 THEN '�������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 13 THEN '������������ ���� ��� ���������� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 14 THEN '��������� � �������� � ������� ������.'
               WHEN ROUND(RAND() * 51, 0) = 15 THEN '���������� ������� �������������� ����������.'
               WHEN ROUND(RAND() * 51, 0) = 16 THEN '����� ��������� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 17 THEN '��������� �������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 18 THEN '���������� �������� �������� ������.'
               WHEN ROUND(RAND() * 51, 0) = 19 THEN '����������� ������ � ��������.'
               WHEN ROUND(RAND() * 51, 0) = 20 THEN '������������ ������� ��� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 21 THEN '��������� ������ ������������� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 22 THEN '�� ������� ��������� ����������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 23 THEN '�������� � ������������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 24 THEN '������ � ������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 25 THEN '��������� ���������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 26 THEN '������ ���������� �� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 27 THEN '���������� ������������� �� ������������.'
               WHEN ROUND(RAND() * 51, 0) = 28 THEN '��������� �������������� �������.'
               WHEN ROUND(RAND() * 51, 0) = 29 THEN '������������ ����� ��������������� ����������.'
               WHEN ROUND(RAND() * 51, 0) = 30 THEN '����������� ������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 31 THEN '������������ ������ � ������.'
               WHEN ROUND(RAND() * 51, 0) = 32 THEN '��������� ������������� �����������.'
               WHEN ROUND(RAND() * 51, 0) = 33 THEN '�������� ��� ��� ����.'
               WHEN ROUND(RAND() * 51, 0) = 34 THEN '���������� �� ������������� �����������.'
               WHEN ROUND(RAND() * 51, 0) = 35 THEN '����� � ��������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 36 THEN '��������� ���������� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 37 THEN '�� ������� ���������� ��� ����������.'
               WHEN ROUND(RAND() * 51, 0) = 38 THEN '��������� ������� ������ ��������������.'
               WHEN ROUND(RAND() * 51, 0) = 39 THEN '��������� �� ������ ��������.'
               WHEN ROUND(RAND() * 51, 0) = 40 THEN '������ �������� �� �������������� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 41 THEN '���������� ��������� ������ � ������.'
               WHEN ROUND(RAND() * 51, 0) = 42 THEN '������ � ������ ����������.'
               WHEN ROUND(RAND() * 51, 0) = 43 THEN '��������� ������� ���������� ����� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 44 THEN '����� ��������� ������������.'
               WHEN ROUND(RAND() * 51, 0) = 45 THEN '���������� �������������� ������� �� �����.'
               WHEN ROUND(RAND() * 51, 0) = 46 THEN '���������� ���������� ��������������� ����.'
               WHEN ROUND(RAND() * 51, 0) = 47 THEN '������ �������� �� ����������� ��������.'
               WHEN ROUND(RAND() * 51, 0) = 48 THEN '���������� ������������ ��������� �� �������.'
               WHEN ROUND(RAND() * 51, 0) = 49 THEN '������������ ��� ���������.'
               WHEN ROUND(RAND() * 51, 0) = 50 THEN '��������� ������, ���������� �����.'
          ELSE N'' END
	  );
  set @i = @i +1
  print ' ��������� �����' +  ' - �����   ' + convert(nvarchar(10),@i);
  end;
  --rollback
  commit
go

--select * from  Connection_String

--delete from Connection_String  where ID_Connection_String is not null

/* -- ������������ �����
case when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yandex.ru'
     when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.ru'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@gmail.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yahoo.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@hotmail.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@icloud.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@moore@mail.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@tutanota.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mydomain.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@dr.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.co.uk'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@sharklasers.com'
	 when cast(round(rand()*100,0) as nvarchar(10)) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@uol.com.br'
ELSE N'Email �� ������' END
*/