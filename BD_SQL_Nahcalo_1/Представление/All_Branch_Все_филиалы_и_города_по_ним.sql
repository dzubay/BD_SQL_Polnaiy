

create view All_Branch
as
select 
b.ID_Branch	           as 'ID_Филиала'
,b.Id_Country		   as 'ID_Страны'
,c.Name_Country		   as 'Наименование_страны'
,c.Name_English		   as 'Наименование_на_английском'
,c.Cod_Country_Phone   as 'Телефонный_код_страны'
,b.City				   as 'Наименование_города_где_находится_филиал'
,b.Address			   as 'Адрес_где_находится_филиал'
,b.Name_Branch		   as 'Наименование_филиала'
,b.Mail				   as 'Электроная_почта_филиала'
,b.Phone			   as 'Телефон_филиала'
,b.Postal_Code		   as 'Почтовый_индекс'
,b.INN				   as 'ИНН'
,b.Description         as 'Комментарии_к_филиалу'
from Branch as b
inner join Country as c on c.ID_Country = b.ID_Country



