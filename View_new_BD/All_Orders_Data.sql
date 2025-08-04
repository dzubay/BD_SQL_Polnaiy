create view All_Orders_Data
as
select 
do.ID_Orders                        as 'ID_заказа'
,do.Id_Data_Orders                  as 'ID_данных_заказа'
,do.ID_Employee                     as 'ID_Сотрудника'
,do.Id_buyer						as 'ID_Покупателя'
,o.ID_status                        as 'ID_Статуса_заказа'
,os.Name                            as 'Наименование_статуса_заказа' 
,o.ID_TypeOrders			        
,t.TypeOrdersName                   as 'Наименование_типа_заказа'
,oc.ID_OrderCategory		        
,oc.Abbreviation                    as 'Аббревиатура_сокращённое_наименование_Категории_заказа'
,oc.OrderCategoryName               as 'Наименование_категории_заказа'
,o.ID_OrderAssignment		        
,oa.OrderAssignmentName             as 'Наименование_Принадлежности_заказа_к_системе'
,o.Date                             as 'Дата_создания_заказа'
,o.Payment_Date                     as 'Дата_Оплаты_заказа'
,o.Amount                           as 'Сумма_заказа'
,o.AmountCurr                       as 'Сумма_заказа_c_начислением_коммисии' 
,o.AmountNDS                        as 'Сумма_заказа_c_начисленным_НДС'
,o.AmountCurrNDS                    as 'Сумма_заказа_c_начислением_коммисии_и_НДС'
,c.ID_Currency                      
,c.Abbreviation_eng                 as 'Короткое_наименование_на_английском'
,c.Full_name_rus                    as 'Полное_наименование_валюты_на_русском'
,o.Num                              as 'Номер_заказа'
,e.ID_Exemplar
,e.Old_Price_no_NDS                 as 'Цена_без_НДС_экземпляра'
,e.Old_Price_NDS					as 'Цена_экземпляра_с_НДС'
,e.New_Price_NDS					as 'Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис'
,e.New_Price_no_NDS					as 'Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис'
,e.Date_Refund                      as 'Дата_возврата'
,e.Date_Created                     as 'Дата_заведения_экземпляра_в_систему'
,e.ID_Condition_of_the_item
,e_2.Name_Condition_of_the_item     as 'Наименование_статуса_экземпляра'
,e.Id_Item             
,e_3.Name_Item                      as 'Наименование_карточки_товара'
,e_3.Manufacturer                   as 'Наименование_производителя'
,e_3.Country                        as 'Страна_производителя'
,e_3.City							as 'Город_производителя'
,e_3.Adress							as 'Адрес_производителя'
,e_3.Quantity                       as 'Количество_товара'
,e_3.Date_Created                   as 'Дата_создания_карточки_товара'
,e_3.ID_product_measurement    
,t_4.Product_measurement_Name       as 'Тип_измерения_товара'
,e_3.ID_TypeItem
,t_2.TypeItemName                   as 'Тип_товара'
,e_3.ID_Species_Item
,t_3.SpeciesItemName                as 'Вид_товара'
,e_3.Id_Item_Status
,i.ItemStatus                       as 'Наименование_статуса_товара'
,e.ID_Storage_location          
,s.Name                             as 'Наименование_места_хранения'
,s.ID_Type_Storage_location
,s_2.Name_Type_Storage_location     as 'Наименование_типа_места_хранения'
,s.Id_Status
,s_3.TypeStoragelocationName        as 'Статус_места_хранения'
,s.Id_Country
,co.Name_Country                    as 'Наименование_страны_места_хранения'
,s.City                             as 'Город_места_хранения'
,s.Adress                           as 'Адрес_места_хранения'
from Data_Orders as do
inner join  Orders as o                           on  o.ID_Orders                 = do.ID_Orders
left join   Orders_status as os                   on os.Id_Status                 = o.ID_status
left join   TypeOrders as t                       on t.ID_TypeOrders              = o.ID_TypeOrders
left join   Order_category as oc                  on oc.ID_OrderCategory          = o.ID_OrderCategory
left join   Order_Assignment as oa                on oa.ID_OrderAssignment        = o.ID_OrderAssignment
left join   Currency as c                         on c.ID_Currency                = o.ID_Currency
inner join  Exemplar as e                         on e.ID_Exemplar                = do.ID_Exemplar
left join   Condition_of_the_item as e_2          on e_2.ID_Condition_of_the_item = e.ID_Condition_of_the_item 
left join   item as e_3                           on e_3.ID_item                  = e.ID_item 
left join   Type_of_product_measurement as t_4    on t_4.ID_product_measurement   = e_3.ID_product_measurement
left join   TypeItem as t_2                       on t_2.Id_TypeItem              = e_3.ID_TypeItem
left join   Species_Item as t_3                   on t_3.ID_Species_Item          = e_3.ID_Species_Item 
left join   Item_status as i                      on i.Id_Item_Status             = e_3.Id_Item_Status
left join   Storage_location as s                 on s.ID_Storage_location        = e.ID_Storage_location
left join   Type_Storage_location as s_2          on s_2.ID_Type_Storage_location = s.ID_Type_Storage_location
left join   Storage_location_status as s_3        on s_3.Id_Status                = s.Id_Status
left join   Country as co                         on co.Id_Country                = s.Id_Country
go