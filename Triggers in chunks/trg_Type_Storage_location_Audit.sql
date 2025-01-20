
begin tran 

CREATE TABLE Type_Storage_location_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Type_Storage_location  bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Type_Storage_location_Audit ON Type_Storage_location
AFTER INSERT, UPDATE, DELETE

AS
    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(max);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Type_Storage_location_Audit
                            ( 
                               ID_Type_Storage_location            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Type_Storage_location
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
						   DECLARE @OldID_Type_Storage_location    bigint           ;
						   DECLARE @OldName_Type_Storage_location  nvarchar(300)	;
						   DECLARE @OldSysNameTypeStoragelocation  nvarchar(300)	;
	                       DECLARE @OldDescription                 nvarchar(4000)	;

                           DECLARE @NewID_Type_Storage_location    bigint           ;
						   DECLARE @NewName_Type_Storage_location  nvarchar(300)	;
						   DECLARE @NewSysNameTypeStoragelocation  nvarchar(300)	;
						   DECLARE @NewDescription                 nvarchar(4000)	;
                     
                         
							SELECT 
							    @NewID_Type_Storage_location    = ID_Type_Storage_location  ,
								@NewName_Type_Storage_location	= Name_Type_Storage_location,
								@NewSysNameTypeStoragelocation  = SysNameTypeStoragelocation,            
								@NewDescription                 = [Description]        	
							FROM inserted;									 

							SELECT 
							    @OldID_Type_Storage_location    = ID_Type_Storage_location  ,
								@OldName_Type_Storage_location  = Name_Type_Storage_location,
								@OldSysNameTypeStoragelocation	= SysNameTypeStoragelocation,
								@OldDescription                 = [Description]        							
							FROM Deleted;																		 

                            
							IF @NewName_Type_Storage_location <> @OldName_Type_Storage_location
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_Type_Storage_location = Old ->"' +  ISNULL(@OldName_Type_Storage_location,'') + ' " NEW -> "' + isnull(@NewName_Type_Storage_location,'') + '", ';
							   end

							IF @NewSysNameTypeStoragelocation <> @OldSysNameTypeStoragelocation 
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SysNameTypeStoragelocation = Old ->"' +  ISNULL(@OldSysNameTypeStoragelocation,'') + ' " NEW -> "' + isnull(@NewSysNameTypeStoragelocation,'') + '", ';
							   end                  
							
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> "' + ISNULL(@NewDescription,'') + '",';
                               end

                            SET @ChangeDescription = 'Updated: ' + ' ID_Type_Storage_location = "' +  isnull(cast(@OldID_Type_Storage_location as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Type_Storage_location_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Type_Storage_location_Audit
                            ( 
                               ID_Type_Storage_location       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Type_Storage_location
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                           DECLARE @OldID_Type_Storage_location_2    bigint         ;
						   DECLARE @OldName_Type_Storage_location_2  nvarchar(300)	;
						   DECLARE @OldSysNameTypeStoragelocation_2  nvarchar(300)	;
	                       DECLARE @OldDescription_2                 nvarchar(4000)	;

                            SELECT 
							    @OldID_Type_Storage_location_2    = ID_Type_Storage_location   ,
								@OldName_Type_Storage_location_2  = Name_Type_Storage_location ,
								@OldSysNameTypeStoragelocation_2  = SysNameTypeStoragelocation ,
								@OldDescription_2                 = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Type_Storage_location'   +' = "'+  ISNULL(CAST(@OldID_Type_Storage_location_2  AS NVARCHAR(50)),'')+ '", '
							+ 'Name_Type_Storage_location' +' = "'+  ISNULL(@OldName_Type_Storage_location_2,'')+ '", '
							+ 'SysNameTypeStoragelocation' +' = "'+  ISNULL(@OldSysNameTypeStoragelocation_2,'')+ '", '
							+ 'Description'                +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '
                          
						   IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Type_Storage_location_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Type_Storage_location_Audit
                    ( 
                          ID_Type_Storage_location  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Type_Storage_location
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Type_Storage_location_3 BIGINT;
                    SELECT @ID_Type_Storage_location_3 = ID_Type_Storage_location FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Type_Storage_location = "' + CAST(@ID_Type_Storage_location_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Type_Storage_location_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit
