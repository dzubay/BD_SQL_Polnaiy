create view All_Otdel
as
select 
d.ID_Department		   as 'ID_������������'
,d.Name_Department	   as '������������_������������'
,g.ID_Group			   as 'ID_������_���_������'
,g.Name_Group		   as '������������ ������'
,t.ID_The_Subgroup	   as 'ID_������'
,t.Name_The_Subgroup   as '������������_������'
,t2.ID_The_Subgroup	   as 'ID_���������'
,t2.Name_The_Subgroup  as '������������_���������'
from Department d 
left join  [Group] as g on g.ID_Department = d.ID_Department
left join  The_Subgroup as t on t.[ID_Group] = g.[ID_Group] and t.[ID_Parent_The_Subgroup] is null
left join  The_Subgroup as t2 on t2.[ID_Parent_The_Subgroup] = t.[ID_The_Subgroup] 

