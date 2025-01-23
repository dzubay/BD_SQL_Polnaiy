
--Сначала требуется ввести данные о пути к папкам, и после чего запускать.
declare                                          --------------------------------------------
 @Magaz_DB_2_Root      nvarchar(400) =  'D:\Программы\БД\Для теста\Magaz_DB_2_Root\'   +  'Magaz_DB_2_Root.mdf'
,@Customers_Data_2_1   nvarchar(400) =  'D:\Программы\БД\Для теста\Costomers_Group_2\' +  'Customers_Data_2_1.ndf'
,@Customers_Data_2_2   nvarchar(400) =  'D:\Программы\БД\Для теста\Costomers_Group_2\' +  'Customers_Data_2_2.ndf'
,@Product_Data_2_1	   nvarchar(400) =  'D:\Программы\БД\Для теста\Products_Group_2\'  +  'Product_Data_2_1.ndf'
,@Product_Data_2_2	   nvarchar(400) =  'D:\Программы\БД\Для теста\Products_Group_2\'  +  'Product_Data_2_2.ndf'
,@Orders_Data_2_1	   nvarchar(400) =  'D:\Программы\БД\Для теста\Orders_Group_2\'    +  'Orders_Data_2_1.ndf'
,@Orders_Data_2_2	   nvarchar(400) =  'D:\Программы\БД\Для теста\Orders_Group_2\'    +  'Orders_Data_2_2.ndf'
,@Employee_Data_2_1	   nvarchar(400) =  'D:\Программы\БД\Для теста\Employee_Group_2\'  +  'Employee_Data_2_1.ndf'
,@Employee_Data_2_2	   nvarchar(400) =  'D:\Программы\БД\Для теста\Employee_Group_2\'  +  'Employee_Data_2_2.ndf'
,@Log_Data_2           nvarchar(400) =  'D:\Программы\БД\Для теста\Log_Data_2\'        +  'Log_Data_2.ldf'
                                         --------------------------------------------    
declare @SQL_Cod nvarchar(max) -- В коде не должно быть комментариев, а то будут ошибка, или просто не сработает
set @SQL_Cod = N'
create database Magaz_DB_2
on primary 																	
(																			
name =  Magaz_DB_2_Root,													
filename = '''+@Magaz_DB_2_Root+''',										
size = 50 mb ,																
maxsize = 5000 mb,															
filegrowth = 50 mb															
),																			
filegroup  Costomers_Group_2												
(																			
name =  Customers_Data_2_1,													
filename = '''+@Customers_Data_2_1+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),																			
(																			
name =  Customers_Data_2_2,													
filename = '''+@Customers_Data_2_2+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),																			
filegroup  Products_Group_2													
(																			
name =  Product_Data_2_1,													
filename = '''+@Product_Data_2_1+''',										
size = 50 mb,																
maxsize = 1000 mb,															
filegrowth = 50 mb															
),																			
(																			
name =  Product_Data_2_2,													
filename = '''+@Product_Data_2_2+''',										
size = 50 mb,																
maxsize = 1000 mb,															
filegrowth = 50 mb															
),																			
filegroup  Orders_Group_2													
(																			
name =  Orders_Data_2_1,													
filename = '''+@Orders_Data_2_1+''',										
size = 75 mb,																
maxsize = 750 mb,															
filegrowth = 75 mb															
),																			
(																			
name =  Orders_Data_2_2,													
filename = '''+@Orders_Data_2_2+''',										
size = 75 mb,																
maxsize = 750 mb,															
filegrowth = 75 mb															
),																			
filegroup  Employee_Group_2													
(																			
name =  Employee_Data_2_1,													
filename = '''+@Employee_Data_2_1+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),																			
(																			
name =  Employee_Data_2_2,													
filename = '''+@Employee_Data_2_2+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
)																			
log on																		
(																			
name = Log_Data_2,															
filename = '''+@Log_Data_2+''',												
size = 20mb,																
maxsize =1200mb,															
filegrowth = 40mb															
)																			
collate Cyrillic_General_CI_AS                                              
'

EXEC sp_executesql @SQL_Cod
go
