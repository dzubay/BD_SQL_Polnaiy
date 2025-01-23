
create view AllEmployees
as
select
e.ID_Employee                             as 'ID_����������'
,d.Name_Department 						  as '������������_������������'
,g.Name_Group							  as '������������_������'
,tg.Name_The_Subgroup					  as '������������_���������'
,p.Number_Series						  as '�����_�����_��������'
,p.Date_Of_Issue						  as '����_������'
,p.Department_Code						  as '���_������������'
,p.Issued_By_Whom						  as '���_�����'
,p.Registration							  as '�����������'
,p.Military_Duty						  as '�����������_�������_������'
,b.City									  as '�����_�������'
,b.Address								  as '�����_�������'
,b.Name_Branch							  as '������������_�������'
,ps.Name_Post							  as '������������_���������'
,c.Password								  as '������_��'
,c.Login								  as '�����_��'
,c.Date_�reated							  as '����_���������_��'
,e.ID_Chief								  as '������������'
,e.Name									  as '���'
,e.SurName								  as '�������'
,e.LastName								  as '��������'
,e.Date_Of_Hiring						  as '����_��������_�����_���������'
,e.Date_�ard_�reated_Employee			  as '����_������_��_������'
,e.Residential_Address					  as '�����_����������'
,e.Home_Phone							  as '��������_�������'
,e.Cell_Phone							  as '�������_�������'
,e.Image_Employees						  as '����������_����������'
,e.Work_Phone							  as '�������_�������'
,e.Mail									  as '�����������_�����_����������'
,e.Pol									  as '���'
,e.Date_Of_Dismissal					  as '����_����������'
,e.Date_Of_Birth 						  as '����_��������'
,s.Name_Status_Employee                   as '������_��������_����������'
from Employees as e
inner join Department as d              on d.ID_Department          = e.ID_Department
inner join [Group] as g                 on g.ID_Group               = e.ID_Group
inner join All_Endpoints_Grops as tg    on tg.ID_The_Subgroup       = e.ID_The_Subgroup
inner join Passport as p                on p.ID_Passport            = e.ID_Passport
inner join Branch as b                  on b.ID_Branch              = e.ID_Branch
inner join Post as ps                   on ps.ID_Post               = e.ID_Post
inner join Connection_String as c       on c.ID_Connection_String   = e.ID_Connection_String
inner join Status_Employee   as s       on s.ID_Status_Employee     = e.ID_Status_Employee
go

