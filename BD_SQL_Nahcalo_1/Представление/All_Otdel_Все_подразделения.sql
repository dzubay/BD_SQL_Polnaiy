create view All_Otdel
as
select 
d.ID_Department		   as 'ID_Департамента'
,d.Name_Department	   as 'Наименование_Департамента'
,g.ID_Group			   as 'ID_Группы_или_отдела'
,g.Name_Group		   as 'Наименование отдела'
,t.ID_The_Subgroup	   as 'ID_Группы'
,t.Name_The_Subgroup   as 'Наименование_группы'
,t2.ID_The_Subgroup	   as 'ID_подгруппы'
,t2.Name_The_Subgroup  as 'Наименование_подгруппы'
from Department d 
left join  [Group] as g on g.ID_Department = d.ID_Department
left join  The_Subgroup as t on t.[ID_Group] = g.[ID_Group] and t.[ID_Parent_The_Subgroup] is null
left join  The_Subgroup as t2 on t2.[ID_Parent_The_Subgroup] = t.[ID_The_Subgroup] 

