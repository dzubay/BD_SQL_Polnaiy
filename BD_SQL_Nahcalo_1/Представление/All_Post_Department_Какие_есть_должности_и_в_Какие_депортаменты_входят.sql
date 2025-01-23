

create view All_Post_Department
as
select 
 p.ID_Post                                as 'ID_Должности'
,p.Name_Post                              as 'Наименование_должности'
,p.ID_Department                          as 'ID_депортамента'
,d.Name_Department 						  as 'Наименование_депортамента'
,p.ID_Group                               as 'ID_Группы'
,g.Name_Group							  as 'Наименование_группы'
,p.ID_The_Subgroup                        as 'ID_ПодГруппы'   
,eg.Name_The_Subgroup					  as 'Наименование_подгруппы'
from Post p 
inner join All_Endpoints_Grops as eg on  eg.ID_The_Subgroup       = p.ID_The_Subgroup
inner join Department as d           on  d.ID_Department          = p.ID_Department
inner join [Group] as g              on  g.ID_Group               = p.ID_Group
go