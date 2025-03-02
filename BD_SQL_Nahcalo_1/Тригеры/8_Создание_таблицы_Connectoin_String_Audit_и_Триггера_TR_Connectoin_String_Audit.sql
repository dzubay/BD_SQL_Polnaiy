begin tran 
create table Connection_String_Audit 
(
AuditID                INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy             nVARCHAR(128)  null,
ModifiedDate           DATETIME       null,
Operation              CHAR(1)        null,
ID_Connection_String   bigint         null,
Password               nvarchar(50)   null,
Login                  nvarchar(100)  null,
Date_Created           datetime       null,
[Description]          nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Connection_String_Audit ON dbo.Connection_String
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
                    INSERT  INTO dbo.Connection_String_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Connection_String 
                               ,Password             
                               ,Login                
                               ,Date_Created         
                               ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Connection_String 
                                    ,D.Password             
                                    ,D.Login                
                                    ,D.Date_Created         
                                    ,D.[Description]                   
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Connection_String_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Connection_String 
                               ,Password             
                               ,Login                
                               ,Date_Created         
                               ,[Description]                           
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Connection_String 
                                    ,D.Password             
                                    ,D.Login                
                                    ,D.Date_Created         
                                    ,D.[Description]                           
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Connection_String_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Connection_String 
                               ,Password             
                               ,Login                
                               ,Date_Created         
                               ,[Description]                            
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Connection_String 
                                    ,I.Password             
                                    ,I.Login                
                                    ,I.Date_Created         
                                    ,I.[Description]                  
                    FROM    Inserted I
        END
GO
commit
--rollback