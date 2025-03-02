
begin tran
create table Status_Employee_Audit  
(
AuditID              INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy           nVARCHAR(128)  null,
ModifiedDate         DATETIME       null,
Operation            CHAR(1)        null,
ID_Status_Employee   bigint         null,
Name_Status_Employee nvarchar(100)  null,
[Description]        nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Status_Employee_Audit ON dbo.Status_Employee
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
                    INSERT  INTO dbo.Status_Employee_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Status_Employee  
                               ,Name_Status_Employee
                               ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Status_Employee  
                                    ,D.Name_Status_Employee
                                    ,D.[Description]                
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Status_Employee_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Status_Employee  
                               ,Name_Status_Employee
                               ,[Description]                       
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Status_Employee  
                                    ,D.Name_Status_Employee
                                    ,D.[Description]                         
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Status_Employee_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Status_Employee  
                               ,Name_Status_Employee
                               ,[Description]                          
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Status_Employee  
                                    ,I.Name_Status_Employee
                                    ,I.[Description]                 
                    FROM    Inserted I
        END
GO
commit
--rollback