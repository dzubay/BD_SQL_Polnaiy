

create view All_Post_Department
as
select 
 p.ID_Post                                as 'ID_���������'
,p.Name_Post                              as '������������_���������'
,p.ID_Department                          as 'ID_������������'
,d.Name_Department 						  as '������������_������������'
,p.ID_Group                               as 'ID_������'
,g.Name_Group							  as '������������_������'
,p.ID_The_Subgroup                        as 'ID_���������'   
,eg.Name_The_Subgroup					  as '������������_���������'
from Post p 
inner join All_Endpoints_Grops as eg on  eg.ID_The_Subgroup       = p.ID_The_Subgroup
inner join Department as d           on  d.ID_Department          = p.ID_Department
inner join [Group] as g              on  g.ID_Group               = p.ID_Group
go