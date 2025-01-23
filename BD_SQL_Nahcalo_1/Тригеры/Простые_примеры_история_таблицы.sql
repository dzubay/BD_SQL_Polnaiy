CREATE TABLE PERSONS
(
PERSON_ID INT NOT NULL IDENTITY PRIMARY KEY,
SURNAME VARCHAR(150) NOT NULL,
NAME VARCHAR(150) NOT NULL,
OTCHESTVO VARCHAR(150) NOT NULL
)
 
CREATE TABLE CHANGES_PERSONS
(
CHANGE_ID_PERS int not null identity,
CHANGE_DATE datetime not null default getdate(),
CHANGE_TYPE varchar(10) not null,
PERSON_ID INT NOT NULL,
SURNAME VARCHAR(150) NOT NULL,
NAME VARCHAR(150) NOT NULL,
OTCHESTVO VARCHAR(150) NOT NULL
)


--view sourceprint?
--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ
create trigger dbo.changes_persons_trigger
on  PERSONS FOR INSERT, UPDATE, DELETE NOT FOR REPLICATION
as
-- SET NOCOUNT ON добавлен чтобы не было лишних результатов выполнения операции
set NOCOUNT ON;
 
-- определеяем тип произошедших изменений INSERT,UPDATE, or DELETE
declare @change_type as varchar(10)
declare @count as int
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into CHANGES_PERSONS(CHANGE_TYPE, PERSON_ID, SURNAME, NAME, OTCHESTVO) select 'deleted', PERSON_ID, SURNAME, NAME, OTCHESTVO from deleted
end
else
begin
-- триггер не различает вставку и удаление, так что добавим ручную обработку
-- обработка вставки
    if @change_type = 'inserted'
    begin
        insert into CHANGES_PERSONS(CHANGE_TYPE, PERSON_ID, SURNAME, NAME, OTCHESTVO) 
		select 'inserted', PERSON_ID, SURNAME, NAME, OTCHESTVO from inserted
    end
-- обработка обновления
    else
    begin
        insert into CHANGES_PERSONS(CHANGE_TYPE, PERSON_ID, SURNAME, NAME, OTCHESTVO) 
		select 'updates', PERSON_ID, SURNAME, NAME, OTCHESTVO from inserted
    end
end -- завершение if
-- завершение dbo.changes_persons

----------------------------Проверка с добавлением и изменением---------------------------------------------
insert into PERSONS (SURNAME,NAME,OTCHESTVO) values
 ('Антон','Антонов','Антонович')
,('Сергей','Сергеев','Сергеевич')
,('Алексей','Алексеев','Алексеевич')
,('Александр','Александров','Александрович')
,('Василий','Васильев','Васильевич')


update s
set  SURNAME = 'Оболтус'
from  PERSONS s
where  PERSON_ID =11

--drop trigger dbo.changes_persons_trigger

--select * from  PERSONS
--select * from  CHANGES_PERSONS


-------------------------------------Пример с указанием пользователя, который внёс изменение-----------------------------------------------------------------------
CREATE TABLE Employees_2
    (
      EmployeeID integer NOT NULL IDENTITY(1, 1) ,
      EmployeeName VARCHAR(50) ,
      EmployeeAddress VARCHAR(50) ,
      MonthSalary NUMERIC(10, 2)
      PRIMARY KEY CLUSTERED (EmployeeID)
    )
GO
-----------------------------------------------------------------------------------------------------------
CREATE TABLE EmployeesAudit
    (
      AuditID INTEGER NOT NULL IDENTITY(1, 1) ,
      EmployeeID INTEGER ,
      EmployeeName VARCHAR(50) ,
      EmployeeAddress VARCHAR(50) ,
      MonthSalary NUMERIC(10, 2) ,
      ModifiedBy VARCHAR(128) ,
      ModifiedDate DATETIME ,
      Operation CHAR(1) 
      PRIMARY KEY CLUSTERED ( AuditID )
    )
GO



	CREATE TRIGGER TR_Audit_Employees ON dbo.Employees_2
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.EmployeesAudit
                            ( EmployeeID ,
                              EmployeeName ,
                              EmployeeAddress ,
                              MonthSalary ,
                              ModifiedBy ,
                              ModifiedDate ,
                              Operation
                            )
                            SELECT  D.EmployeeID ,
                                    D.EmployeeName ,
                                    D.EmployeeAddress ,
                                    D.MonthSalary ,
                                    @login_name ,
                                    GETDATE() ,
                                    'U'
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.EmployeesAudit
                            ( EmployeeID ,
                              EmployeeName ,
                              EmployeeAddress ,
                              MonthSalary ,
                              ModifiedBy ,
                              ModifiedDate ,
                              Operation
                            )
                            SELECT  D.EmployeeID ,
                                    D.EmployeeName ,
                                    D.EmployeeAddress ,
                                    D.MonthSalary ,
                                    @login_name ,
                                    GETDATE() ,
                                    'D'
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.EmployeesAudit
                    ( EmployeeID ,
                      EmployeeName ,
                      EmployeeAddress ,
                      MonthSalary ,
                      ModifiedBy ,
                      ModifiedDate ,
                      Operation
                    )
                    SELECT  I.EmployeeID ,
                            I.EmployeeName ,
                            I.EmployeeAddress ,
                            I.MonthSalary ,
                            @login_name ,
                            GETDATE() ,
                            'I'
                    FROM    Inserted I
        END
GO


--select * from  Employees_2
--select * from  EmployeesAudit
INSERT INTO dbo.Employees_2
        ( EmployeeName ,
          EmployeeAddress ,
          MonthSalary
        )
SELECT 'Mark Smith', 'Ocean Dr 1234', 10000
UNION ALL
SELECT 'Joe Wright', 'Evergreen 1234', 10000
UNION ALL
SELECT 'John Doe', 'International Dr 1234', 10000
UNION ALL
SELECT 'Peter Rodriguez', '74 Street 1234', 10000
GO
---------------------------------------------------------------------------------------------------