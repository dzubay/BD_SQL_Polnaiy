use Magaz_DB 
go
set nocount,xact_abort on
go

begin tran
--��� ���� ������������� ����� �������� ������ ����������� �� � ����, �� ����� ������� �� � �������� ������ � ����.
--������ ���� ��� ��������������� ����  DBCC CHECKIDENT �������� � ��.
--IF EXISTS  
--		(
--			SELECT * 
--			FROM sys.identity_columns 
--			WHERE object_id = OBJECT_ID('dbo.Status_Employee') 
--				AND last_value IS not NULL 
--		)
--	begin
		--DBCC CHECKIDENT ('dbo.Status_Employee', RESEED, 0);

		  insert into  Status_Employee (Name_Status_Employee,[Description])
		  values
			  ('�����������',''),
			  ('� ������','��� ������ ��� ������������ ����� �������, � �� ������ ������ ������'),
			  ('������� ������','�� 1 �� 3 �������'),
			  ('�� ��������','����������� � ��'),
			  ('������������ ������� ������',''),
			  ('�����������','')
--    end
commit
go
--select * from Status_Employee 
--delete from Status_Employee where ID_Status_Employee is not null
