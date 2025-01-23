
create view All_Endpoints_Grops
as
with s as(
select distinct 
ID_Parent_The_Subgroup
from The_Subgroup 
where  ID_Parent_The_Subgroup is not null
), 
s_2 as
(
select
d.ID_The_Subgroup,
f.ID_Parent_The_Subgroup
from s as f 
full outer join The_Subgroup as d on d.ID_The_Subgroup  = f.ID_Parent_The_Subgroup
where  f.ID_Parent_The_Subgroup is null
)
select 
d.ID_The_Subgroup
,d.ID_Parent_The_Subgroup
,d.Name_The_Subgroup
from The_Subgroup as d inner join  s_2 as s on  s.ID_The_Subgroup =  d.ID_The_Subgroup  