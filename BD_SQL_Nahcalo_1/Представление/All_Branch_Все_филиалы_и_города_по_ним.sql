

create view All_Branch
as
select 
b.ID_Branch	           as 'ID_�������'
,b.Id_Country		   as 'ID_������'
,c.Name_Country		   as '������������_������'
,c.Name_English		   as '������������_��_����������'
,c.Cod_Country_Phone   as '����������_���_������'
,b.City				   as '������������_������_���_���������_������'
,b.Address			   as '�����_���_���������_������'
,b.Name_Branch		   as '������������_�������'
,b.Mail				   as '����������_�����_�������'
,b.Phone			   as '�������_�������'
,b.Postal_Code		   as '��������_������'
,b.INN				   as '���'
,b.Description         as '�����������_�_�������'
from Branch as b
inner join Country as c on c.ID_Country = b.ID_Country



