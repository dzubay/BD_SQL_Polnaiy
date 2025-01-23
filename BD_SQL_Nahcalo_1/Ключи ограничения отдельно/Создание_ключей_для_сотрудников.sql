use Magaz_DB
go
ALTER TABLE dbo.[Employees]
Add 
CONSTRAINT FK_Employees_ID_Department Foreign key  (ID_Department) references dbo.[Department](ID_Department)  on delete set null on Update cascade ,
CONSTRAINT FK_Employees_ID_Group Foreign key  (ID_Group) references dbo.[Group](ID_Group)  on delete set null on Update cascade ,
CONSTRAINT FK_Employees_ID_The_Subgroup Foreign key  (ID_The_Subgroup) references dbo.[The_Subgroup](ID_The_Subgroup)  on delete set null on Update cascade ,
CONSTRAINT FK_Employees_ID_Passport Foreign key  (ID_Passport) references dbo.[Passport](ID_Passport)  on delete cascade on Update cascade ,
CONSTRAINT FK_Employees_ID_Branch Foreign key  (ID_Branch) references dbo.[Branch](ID_Branch)  on delete set null on Update cascade,
CONSTRAINT FK_Employees_ID_Post Foreign key  (ID_Post) references dbo.[Post](ID_Post)  on delete set null on Update cascade,
CONSTRAINT FK_Employees_ID_Status_Employee Foreign key  (ID_Status_Employee) references dbo.[Status_Employee](ID_Status_Employee)  on delete set null on Update cascade,
CONSTRAINT FK_Employees_ID_Connection_String Foreign key  (ID_Connection_String) references dbo.[Connection_String](ID_Connection_String) on delete set null on Update cascade 
go
ALTER TABLE dbo.[Department]
Add 
CONSTRAINT FK_Department_ID_Head_Department Foreign key  (ID_Head_Department) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_Department_ID_Vice_Head_Department Foreign key  (ID_Vice_Head_Department) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_Department_ID_Branch Foreign key  (ID_Vice_Head_Department) references dbo.[Branch](ID_Branch)  
go
ALTER TABLE dbo.[Group]
Add 
CONSTRAINT FK_Group_ID_Head_Group Foreign key  (ID_Head_Group) references dbo.[Employees](ID_Employee) ,
CONSTRAINT FK_Group_ID_Vice_Head_Group Foreign key  (ID_Vice_Head_Group) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_Group_ID_Department Foreign key  (ID_Department) references dbo.[Department](ID_Department),
CONSTRAINT FK_Group_ID_Branch Foreign key  (ID_Branch) references dbo.[Branch](ID_Branch)
go
ALTER TABLE dbo.[The_Subgroup]
Add 
CONSTRAINT FK_The_Subgroup_ID_Head_The_Subgroup Foreign key  (ID_Head_The_Subgroup) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_The_Subgroup_ID_Vice_Head_The_Subgroup Foreign key  (ID_Vice_Head_The_Subgroup) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_The_Subgroup_ID_Group Foreign key  (ID_Group) references dbo.[Group](ID_Group),
CONSTRAINT FK_The_Subgroup_ID_Branch Foreign key  (ID_Branch) references dbo.[Branch](ID_Branch)
go
ALTER TABLE dbo.[Post]
Add
CONSTRAINT FK_Post_ID_Department Foreign key  (ID_Department) references dbo.[Department](ID_Department),
CONSTRAINT FK_Post_ID_Group Foreign key  (ID_Group) references dbo.[Group](ID_Group),
CONSTRAINT FK_Post_ID_The_Subgroup Foreign key  (ID_The_Subgroup) references dbo.[The_Subgroup](ID_The_Subgroup)
go
ALTER TABLE dbo.[Branch]
Add
CONSTRAINT FK_Branch_Id_Country Foreign key  (Id_Country) references dbo.[Country](Id_Country)  on delete set null on Update cascade
go


/*

select
  'ALTER TABLE [' + sch.name + '].[' + part.name + '] DROP CONSTRAINT [' + fkn.name + ']' as [Drop Command]
  --t.name as TableName, object_name(s.constraint_object_id) as ForeignKeyName
from sys.foreign_key_columns fk
inner join sys.tables reft on reft.object_id = fk.referenced_object_id
inner join sys.tables part on part.object_id = fk.parent_object_id
inner join sys.schemas sch on sch.schema_id = part.schema_id
inner join sys.objects fkn on fkn.object_id = fk.constraint_object_id
--where part.name in ('Attributes') and sch.schema_id = 'dbo'
  -- sch.name + '.' + part.name in ('dbo.Attributes')
cross join
(
  values
  ('dbo','Branch'),
  ('dbo','Connection_String'),
  ('dbo','Country'),
  ('dbo','Department'),
  ('dbo','Employees'),
  ('dbo','Group'),
  ('dbo','Passport'),
  ('dbo','Post'),
  ('dbo','Status_Employee'),
  ('dbo','The_Subgroup')
) cj ([schema_name], [table_name])
where cj.table_name = part.name and cj.schema_name = sch.name and fkn.name  like '%Branch%'


*/








