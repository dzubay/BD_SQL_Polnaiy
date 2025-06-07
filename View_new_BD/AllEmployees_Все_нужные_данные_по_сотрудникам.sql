
create view AllEmployees
as
select
e.ID_Employee                             as 'ID_Сотрудника'
,d.Name_Department 						  as 'Наименование_депортамента'
,g.Name_Group							  as 'Наименование_группы'
,tg.Name_The_Subgroup					  as 'Наименование_подгруппы'
,p.Number_Series						  as 'Номер_серия_паспорта'
,p.Date_Of_Issue						  as 'Дата_выдачи'
,p.Department_Code						  as 'Код_депортамента'
,p.Issued_By_Whom						  as 'Кем_выдан'
,p.Registration							  as 'Регистрация'
,p.Military_Duty						  as 'Прохождение_военной_службы'
,b.City									  as 'Город_филиала'
,b.Address								  as 'Адрес_филиала'
,b.Name_Branch							  as 'Наименование_филиала'
,ps.Name_Post							  as 'Наименование_должности'
,c.Password								  as 'Пароль_УЗ'
,c.Login								  as 'Логин_УЗ'
,c.Date_Created							  as 'Дата_заведения_УЗ'
,e.ID_Chief								  as 'Руководитель'
,e.Name									  as 'Имя'
,e.SurName								  as 'Фамилия'
,e.LastName								  as 'Отчество'
,e.Date_Of_Hiring						  as 'Дата_создания_карты_работника'
,e.Date_Card_Created_Employee			  as 'Дата_приема_на_работу'
,e.Residential_Address					  as 'Адрес_проживания'
,e.Home_Phone							  as 'Домашний_телефон'
,e.Cell_Phone							  as 'Сотовый_телефон'
,e.Image_Employees						  as 'Фотография_сотрудника'
,e.Work_Phone							  as 'Рабочий_телефон'
,e.Mail									  as 'Электронная_почта_сотрудника'
,e.Pol									  as 'Пол'
,e.Date_Of_Dismissal					  as 'Дата_увольнения'
,e.Date_Of_Birth 						  as 'Дата_Рождения'
,s.Name_Status_Employee                   as 'Статус_карточки_сотрудника'
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

