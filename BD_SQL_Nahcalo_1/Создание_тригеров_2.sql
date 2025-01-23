use Magaz_DB_2
go

begin tran
create table dbo.[Employees_Audit]
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Employee                bigint         null,
ID_Department              bigint         null,
ID_Group                   bigint         null,
ID_The_Subgroup            bigint         null,
ID_Passport                bigint         null,
ID_Branch                  bigint         null,
ID_Post                    bigint         null,
ID_Status_Employee         bigint         null,
ID_Connection_String       bigint         null,
ID_Chief                   bigint         null,
Name                       nvarchar(100)  null,
SurName                    nvarchar(100)  null,
LastName                   nvarchar(100)  null,
Date_Of_Hiring             datetime       null, 
Date_Ñard_Ñreated_Employee datetime       null,
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null, 
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        null,
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       null,
[Description]              nvarchar(1000) null, 
Image_Employees            varbinary(max) null,   
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go


	CREATE TRIGGER TR_Employees_Audit ON dbo.Employees
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
                    INSERT  INTO dbo.Employees_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
							   ,ID_Department             
							   ,ID_Group                  
							   ,ID_The_Subgroup           
							   ,ID_Passport               
							   ,ID_Branch                 
							   ,ID_Post                   
							   ,ID_Status_Employee        
							   ,ID_Connection_String      
							   ,ID_Chief                  
							   ,Name                      
							   ,SurName                   
							   ,LastName                  
							   ,Date_Of_Hiring            
							   ,Date_Ñard_Ñreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U'            
									,D.ID_Employee               
									,D.ID_Department             
									,D.ID_Group                  
									,D.ID_The_Subgroup           
									,D.ID_Passport               
									,D.ID_Branch                 
									,D.ID_Post                   
									,D.ID_Status_Employee        
									,D.ID_Connection_String      
									,D.ID_Chief                  
									,D.Name                      
									,D.SurName                   
									,D.LastName                  
									,D.Date_Of_Hiring            
									,D.Date_Ñard_Ñreated_Employee
									,D.Residential_Address       
									,D.Home_Phone                
									,D.Cell_Phone                
									,D.Work_Phone                
									,D.Mail                      
									,D.Pol                       
									,D.Date_Of_Dismissal         
									,D.Date_Of_Birth             
									,D.[Description]             
									,D.Image_Employees                                                                                                                 
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Employees_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
							   ,ID_Department             
							   ,ID_Group                  
							   ,ID_The_Subgroup           
							   ,ID_Passport               
							   ,ID_Branch                 
							   ,ID_Post                   
							   ,ID_Status_Employee        
							   ,ID_Connection_String      
							   ,ID_Chief                  
							   ,Name                      
							   ,SurName                   
							   ,LastName                  
							   ,Date_Of_Hiring            
							   ,Date_Ñard_Ñreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
									,D.ID_Employee               
									,D.ID_Department             
									,D.ID_Group                  
									,D.ID_The_Subgroup           
									,D.ID_Passport               
									,D.ID_Branch                 
									,D.ID_Post                   
									,D.ID_Status_Employee        
									,D.ID_Connection_String      
									,D.ID_Chief                  
									,D.Name                      
									,D.SurName                   
									,D.LastName                  
									,D.Date_Of_Hiring            
									,D.Date_Ñard_Ñreated_Employee
									,D.Residential_Address       
									,D.Home_Phone                
									,D.Cell_Phone                
									,D.Work_Phone                
									,D.Mail                      
									,D.Pol                       
									,D.Date_Of_Dismissal         
									,D.Date_Of_Birth             
									,D.[Description]             
									,D.Image_Employees           
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Employees_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
							   ,ID_Department             
							   ,ID_Group                  
							   ,ID_The_Subgroup           
							   ,ID_Passport               
							   ,ID_Branch                 
							   ,ID_Post                   
							   ,ID_Status_Employee        
							   ,ID_Connection_String      
							   ,ID_Chief                  
							   ,Name                      
							   ,SurName                   
							   ,LastName                  
							   ,Date_Of_Hiring            
							   ,Date_Ñard_Ñreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
									,I.ID_Employee               
									,I.ID_Department             
									,I.ID_Group                  
									,I.ID_The_Subgroup           
									,I.ID_Passport               
									,I.ID_Branch                 
									,I.ID_Post                   
									,I.ID_Status_Employee        
									,I.ID_Connection_String      
									,I.ID_Chief                  
									,I.Name                      
									,I.SurName                   
									,I.LastName                  
									,I.Date_Of_Hiring            
									,I.Date_Ñard_Ñreated_Employee
									,I.Residential_Address       
									,I.Home_Phone                
									,I.Cell_Phone                
									,I.Work_Phone                
									,I.Mail                      
									,I.Pol                       
									,I.Date_Of_Dismissal         
									,I.Date_Of_Birth             
									,I.[Description]             
									,I.Image_Employees           
                    FROM    Inserted I
        END
GO


create table dbo.[Department_Audit]
(
AuditID                     INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                  nVARCHAR(128)  null,
ModifiedDate                DATETIME       null,
Operation                   CHAR(1)        null,
ID_Department               bigint         null,
ID_Head_Department          bigint         null,
ID_Vice_Head_Department     bigint         null,
Name_Department             nvarchar(300)  null,
ID_Branch                   bigint         null,
Department_Ñode             int            null,
[Description]               nvarchar(1000) null, 
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go
	CREATE TRIGGER TR_Department_Audit ON dbo.Department
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
                    INSERT  INTO dbo.Department_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]            
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
									,D.ID_Department            
									,D.ID_Head_Department       
									,D.ID_Vice_Head_Department  
									,D.Name_Department          
									,D.ID_Branch                
									,D.Department_Ñode          
									,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Department_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]                    
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Department            
									,D.ID_Head_Department       
									,D.ID_Vice_Head_Department  
									,D.Name_Department          
									,D.ID_Branch                
									,D.Department_Ñode          
									,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Department_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]                     
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Department           
									,I.ID_Head_Department      
									,I.ID_Vice_Head_Department 
									,I.Name_Department         
									,I.ID_Branch               
									,I.Department_Ñode         
									,I.[Description]           
                    FROM    Inserted I
        END
GO

create table dbo.Group_Audit
(
AuditID                 INTEGER        NOT NULL IDENTITY(1, 1),
ModifiedBy              nVARCHAR(128)  null,
ModifiedDate            DATETIME       null,
Operation               CHAR(1)        null,
ID_Group                bigint         null,
ID_Head_Group           bigint         null,
ID_Vice_Head_Group      bigint         null,
ID_Department           bigint         null,
Name_Group              nvarchar(300)  null,
ID_Branch               bigint         null,
Department_Ñode         int            null,
[Description]           nvarchar(1000) null, 
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go
go
	CREATE TRIGGER TR_Group_Audit ON dbo.[Group]
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
                    INSERT  INTO dbo.Group_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Group           
							   ,ID_Head_Group      
							   ,ID_Vice_Head_Group 
							   ,ID_Department      
							   ,Name_Group         
							   ,ID_Branch          
							   ,Department_Ñode    
							   ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
									,D.ID_Group           
									,D.ID_Head_Group      
									,D.ID_Vice_Head_Group 
									,D.ID_Department      
									,D.Name_Group         
									,D.ID_Branch          
									,D.Department_Ñode    
									,D.[Description]      
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Group_Audit
                            ( 
                                ModifiedBy         
							   ,ModifiedDate       
							   ,Operation          
                               ,ID_Group           
							   ,ID_Head_Group      
							   ,ID_Vice_Head_Group 
							   ,ID_Department      
							   ,Name_Group         
							   ,ID_Branch          
							   ,Department_Ñode    
							   ,[Description]      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Group           
									,D.ID_Head_Group      
									,D.ID_Vice_Head_Group 
									,D.ID_Department      
									,D.Name_Group         
									,D.ID_Branch          
									,D.Department_Ñode    
									,D.[Description]                          
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Group_Audit
                    ( 
                         ModifiedBy         
						,ModifiedDate       
						,Operation          
						,ID_Group           
						,ID_Head_Group      
						,ID_Vice_Head_Group 
						,ID_Department      
						,Name_Group         
						,ID_Branch          
						,Department_Ñode    
						,[Description]                         
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Group           
									,I.ID_Head_Group      
									,I.ID_Vice_Head_Group 
									,I.ID_Department      
									,I.Name_Group         
									,I.ID_Branch          
									,I.Department_Ñode    
									,I.[Description]      
                    FROM    Inserted I
        END
GO


create table dbo.[The_Subgroup_Audit] 
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_The_Subgroup            bigint         null,
ID_Head_The_Subgroup       bigint         null,
ID_Vice_Head_The_Subgroup  bigint         null,
ID_Group                   bigint         null,
Name_The_Subgroup          nvarchar(300)  null,
ID_Branch                  bigint         null,
Department_Ñode            int            null,
[Description]              nvarchar(1000) null,
ID_Parent_The_Subgroup     bigint         null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go

	CREATE TRIGGER TR_The_Subgroupt_Audit ON dbo.The_Subgroup
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
                    INSERT  INTO dbo.The_Subgroup_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_The_Subgroup          
							   ,ID_Head_The_Subgroup     
							   ,ID_Vice_Head_The_Subgroup
							   ,ID_Group                 
							   ,Name_The_Subgroup        
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]            
							   ,ID_Parent_The_Subgroup            
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_The_Subgroup          
                                    ,D.ID_Head_The_Subgroup     
                                    ,D.ID_Vice_Head_The_Subgroup
                                    ,D.ID_Group                 
                                    ,D.Name_The_Subgroup        
                                    ,D.ID_Branch                
                                    ,D.Department_Ñode          
                                    ,D.[Description]            
                                    ,D.ID_Parent_The_Subgroup                   
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.The_Subgroup_Audit
                            ( 
                                ModifiedBy                
                               ,ModifiedDate              
                               ,Operation                 
                               ,ID_The_Subgroup          
                               ,ID_Head_The_Subgroup     
                               ,ID_Vice_Head_The_Subgroup
                               ,ID_Group                 
                               ,Name_The_Subgroup        
                               ,ID_Branch                
                               ,Department_Ñode          
                               ,[Description]            
                               ,ID_Parent_The_Subgroup                          
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_The_Subgroup          
                                    ,D.ID_Head_The_Subgroup     
                                    ,D.ID_Vice_Head_The_Subgroup
                                    ,D.ID_Group                 
                                    ,D.Name_The_Subgroup        
                                    ,D.ID_Branch                
                                    ,D.Department_Ñode          
                                    ,D.[Description]            
                                    ,D.ID_Parent_The_Subgroup                       
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.The_Subgroup_Audit
                    ( 
                                 ModifiedBy                
                                ,ModifiedDate              
                                ,Operation                 
                                ,ID_The_Subgroup          
                                ,ID_Head_The_Subgroup     
                                ,ID_Vice_Head_The_Subgroup
                                ,ID_Group                 
                                ,Name_The_Subgroup        
                                ,ID_Branch                
                                ,Department_Ñode          
                                ,[Description]            
                                ,ID_Parent_The_Subgroup                         
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_The_Subgroup          
                                    ,I.ID_Head_The_Subgroup     
                                    ,I.ID_Vice_Head_The_Subgroup
                                    ,I.ID_Group                 
                                    ,I.Name_The_Subgroup        
                                    ,I.ID_Branch                
                                    ,I.Department_Ñode          
                                    ,I.[Description]            
                                    ,I.ID_Parent_The_Subgroup               
                    FROM    Inserted I
        END
GO

create table dbo.Passport_Audit
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Passport                bigint         null,
Number_Series              nvarchar(100)  null,
Date_Of_Issue              Datetime       null,
Department_Code            nvarchar(20)   null,
Issued_By_Whom             nvarchar(400)  null,
Registration               nvarchar(200)  null,
Military_Duty              nvarchar(200)  null,
[Description]              nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go
	CREATE TRIGGER TR_Passport_Audit ON dbo.Passport
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
                    INSERT  INTO dbo.Passport_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport      
                               ,Number_Series    
                               ,Date_Of_Issue    
                               ,Department_Code  
                               ,Issued_By_Whom   
                               ,Registration     
                               ,Military_Duty    
                               ,[Description]             
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Passport      
                                    ,D.Number_Series    
                                    ,D.Date_Of_Issue    
                                    ,D.Department_Code  
                                    ,D.Issued_By_Whom   
                                    ,D.Registration     
                                    ,D.Military_Duty    
                                    ,D.[Description]              
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Passport_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport     
                               ,Number_Series   
                               ,Date_Of_Issue   
                               ,Department_Code 
                               ,Issued_By_Whom  
                               ,Registration    
                               ,Military_Duty   
                               ,[Description]                      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Passport     
                                    ,D.Number_Series   
                                    ,D.Date_Of_Issue   
                                    ,D.Department_Code 
                                    ,D.Issued_By_Whom  
                                    ,D.Registration    
                                    ,D.Military_Duty   
                                    ,D.[Description]                      
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Passport_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport     
                               ,Number_Series   
                               ,Date_Of_Issue   
                               ,Department_Code 
                               ,Issued_By_Whom  
                               ,Registration    
                               ,Military_Duty   
                               ,[Description]                      
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Passport     
                                    ,I.Number_Series   
                                    ,I.Date_Of_Issue   
                                    ,I.Department_Code 
                                    ,I.Issued_By_Whom  
                                    ,I.Registration    
                                    ,I.Military_Duty   
                                    ,I.[Description]              
                    FROM    Inserted I
        END
GO

create table Post_Audit  
(
AuditID               INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy            nVARCHAR(128)  null,
ModifiedDate          DATETIME       null,
Operation             CHAR(1)        null,
ID_Post               bigint         null,
Name_Post             nvarchar(200)  null,
ID_Department         bigint         null,
ID_Group              bigint         null,
ID_The_Subgroup       bigint         null,
[Description]         nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go
	CREATE TRIGGER TR_Post_Audit ON dbo.Post
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
                    INSERT  INTO dbo.Post_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]             
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Post         
                                    ,D.Name_Post       
                                    ,D.ID_Department   
                                    ,D.ID_Group        
                                    ,D.ID_The_Subgroup 
                                    ,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Post_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]                      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Post         
                                    ,D.Name_Post       
                                    ,D.ID_Department   
                                    ,D.ID_Group        
                                    ,D.ID_The_Subgroup 
                                    ,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Post_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]                       
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Post         
                                    ,I.Name_Post       
                                    ,I.ID_Department   
                                    ,I.ID_Group        
                                    ,I.ID_The_Subgroup 
                                    ,I.[Description]             
                    FROM    Inserted I
        END
GO

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
) on Employee_Group_2
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

create table Connection_String_Audit 
(
AuditID                INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy             nVARCHAR(128)  null,
ModifiedDate           DATETIME       null,
Operation              CHAR(1)        null,
ID_Connection_String   bigint         null,
Password               nvarchar(50)   null,
Login                  nvarchar(100)  null,
Date_Ñreated           datetime       null,
[Description]          nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
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
                               ,Date_Ñreated         
                               ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Connection_String 
                                    ,D.Password             
                                    ,D.Login                
                                    ,D.Date_Ñreated         
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
                               ,Date_Ñreated         
                               ,[Description]                           
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Connection_String 
                                    ,D.Password             
                                    ,D.Login                
                                    ,D.Date_Ñreated         
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
                               ,Date_Ñreated         
                               ,[Description]                            
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Connection_String 
                                    ,I.Password             
                                    ,I.Login                
                                    ,I.Date_Ñreated         
                                    ,I.[Description]                  
                    FROM    Inserted I
        END
GO
create table Branch_Audit 
(
AuditID       INTEGER         NOT NULL IDENTITY(1, 1) ,
ModifiedBy    nVARCHAR(128)   null,
ModifiedDate  DATETIME        null,
Operation     CHAR(1)         null,
ID_Branch     bigint          null,
Id_Country    bigint          null,
City          nvarchar(100)   null,
[Address]     nvarchar(300)   null,
Name_Branch   nvarchar(300)   null,
Mail          nvarchar(300)   null,
Phone         nvarchar(15)    null,
Postal_Code   int             null,
INN           int             null,
[Description] nvarchar(1000)  null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go
	CREATE TRIGGER TR_Branch_Audit ON dbo.Branch
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
                    INSERT  INTO dbo.Branch_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]        
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Branch    
                                    ,D.Id_Country   
                                    ,D.City         
                                    ,D.[Address]    
                                    ,D.Name_Branch  
                                    ,D.Mail         
                                    ,D.Phone        
                                    ,D.Postal_Code  
                                    ,D.INN          
                                    ,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Branch_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]                  
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Branch    
                                    ,D.Id_Country   
                                    ,D.City         
                                    ,D.[Address]    
                                    ,D.Name_Branch  
                                    ,D.Mail         
                                    ,D.Phone        
                                    ,D.Postal_Code  
                                    ,D.INN          
                                    ,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Branch_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]                   
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Branch    
                                    ,I.Id_Country   
                                    ,I.City         
                                    ,I.[Address]    
                                    ,I.Name_Branch  
                                    ,I.Mail         
                                    ,I.Phone        
                                    ,I.Postal_Code  
                                    ,I.INN          
                                    ,I.[Description]          
                    FROM    Inserted I
        END
GO

create table Country_Audit 
(
AuditID            INTEGER          NOT NULL IDENTITY(1, 1) ,
ModifiedBy         nVARCHAR(128)    null,
ModifiedDate       DATETIME         null,
Operation          CHAR(1)          null,
Id_Country         bigint           null,
Name_Country       nvarchar(150)    null,
Name_English       nvarchar(150)    null,
Cod_Country_Phone  nvarchar(10)     null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group_2
go
	CREATE TRIGGER TR_Country_Audit  ON dbo.Country
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
                    INSERT  INTO dbo.Country_Audit 
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone           
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.Id_Country        
                                    ,D.Name_Country      
                                    ,D.Name_English      
                                    ,D.Cod_Country_Phone           
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Country_Audit 
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone                   
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.Id_Country        
                                    ,D.Name_Country      
                                    ,D.Name_English      
                                    ,D.Cod_Country_Phone                   
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Country_Audit 
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone                   
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.Id_Country        
                                    ,I.Name_Country      
                                    ,I.Name_English      
                                    ,I.Cod_Country_Phone           
                    FROM    Inserted I
        END
GO
commit
--rollback