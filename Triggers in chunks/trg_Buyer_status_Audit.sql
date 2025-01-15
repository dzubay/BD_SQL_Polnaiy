﻿
begin tran 

CREATE TABLE Buyer_status_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_Status              bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_Buyer_status_Audit ON Buyer_status
AFTER INSERT, UPDATE, DELETE

AS
    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(4000);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Buyer_status_Audit
                            ( 
                               Id_Status            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.Id_Status
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                                          	                      

						   DECLARE @OldId_Status                bigint          ;
						   DECLARE @OldName                  	nvarchar(300)  	;
						   DECLARE @OldSysTypeBuyerStatusName	nvarchar(300) 	;
						   DECLARE @OldDescription      	    nvarchar(4000)	;


						   DECLARE @NewId_Status                bigint          ;
						   DECLARE @NewName                  	nvarchar(300)  	;
						   DECLARE @NewSysTypeBuyerStatusName	nvarchar(300) 	;
						   DECLARE @NewDescription      	    nvarchar(4000)	;
                       

							SELECT 
                                  @NewId_Status                 = Id_Status                  ,
								  @NewName                  	= Name                  	 ,
								  @NewSysTypeBuyerStatusName	= SysTypeBuyerStatusName	 ,
								  @NewDescription      	        = [Description]      	
							FROM inserted;									 

							SELECT 
                                  @OldId_Status                 = Id_Status                  ,
								  @OldName                  	= Name                  	 ,
								  @OldSysTypeBuyerStatusName	= SysTypeBuyerStatusName	 ,  	
								  @OldDescription      	        = [Description]      	
							FROM Deleted;																		 

                            IF @NewName <> @OldName 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name = Old ->"' +  ISNULL(@OldName,'') + ' " NEW -> " ' + isnull(@NewName,'') + '", ';
							   end
                            
							IF @NewSysTypeBuyerStatusName <> @OldSysTypeBuyerStatusName 
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SysTypeBuyerStatusName = Old ->"' +  ISNULL(@OldSysTypeBuyerStatusName,'') + ' " NEW -> " ' + isnull(@NewSysTypeBuyerStatusName,'') + '", ';
							   end
                                                                                    
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' Id_Status = (' +  isnull(cast(@OldId_Status as nvarchar(20)),'')+ ') ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Buyer_status_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Buyer_status_Audit
                            ( 
                               Id_Status       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.Id_Status
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                            DECLARE @OldId_Status_2                 bigint          ;
							DECLARE @OldName_2                  	nvarchar(300)  	;
							DECLARE @OldSysTypeBuyerStatusName_2	nvarchar(300) 	;
							DECLARE @OldDescription_2      	        nvarchar(4000)	;

							SELECT 
                                  @OldId_Status_2               = Id_Status               ,
								  @OldName_2                    = Name                    ,
								  @OldSysTypeBuyerStatusName_2  = SysTypeBuyerStatusName  ,
								  @OldDescription_2             = [Description]      		  
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'Id_Status'               +'="'+  ISNULL(CAST(@OldId_Status_2  AS NVARCHAR(50)),'')+ '", '
							+ 'Name'                    +'="'+  ISNULL(@OldName_2,'')+ '", '
							+ 'SysTypeBuyerStatusName'  +'="'+  ISNULL(@OldSysTypeBuyerStatusName_2,'')+ '", '
							+ '[Description]'           +'="'+  ISNULL(@OldDescription_2  ,'')+ '", '


                          update u
						  set ChangeDescription = @ChangeDescription
						  from Buyer_status_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Buyer_status_Audit
                    ( 
                          Id_Status  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.Id_Status
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @Id_Status_3 BIGINT;
                    SELECT @Id_Status_3 = Id_Status FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_Status="' + CAST(@Id_Status_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Buyer_status_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback

commit


