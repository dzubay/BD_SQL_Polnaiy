
begin tran 

CREATE TABLE TypeItem_Audit
(
    AuditID              bigint IDENTITY(1,1)  not null,
    Id_TypeItem          bigint                null,
 	ModifiedBy           nVARCHAR(128)         null,
    ModifiedDate         DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation            CHAR(1)               null,
    ChangeDescription    nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
);


go

CREATE TRIGGER trg_TypeItem_Audit ON TypeItem
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
                    INSERT  INTO dbo.TypeItem_Audit
                            ( 
                               Id_TypeItem            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.Id_TypeItem
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                            
                            DECLARE @OldId_TypeItem BIGINT;
                            DECLARE @OldTypeItemName NVARCHAR(300);
                            DECLARE @OldSysTypeItemName NVARCHAR(300);
                            DECLARE @OldDescription NVARCHAR(4000);	                    
	                       
							DECLARE @NewId_TypeItem BIGINT;
                            DECLARE @NewTypeItemName NVARCHAR(300);
                            DECLARE @NewSysTypeItemName NVARCHAR(300);
                            DECLARE @NewDescription NVARCHAR(4000);

							SELECT @NewId_TypeItem = Id_TypeItem,
							       @NewTypeItemName = TypeItemName, 
							       @NewSysTypeItemName = SysTypeItemName,
							       @NewDescription = [Description]
							FROM inserted;

							SELECT @OldId_TypeItem = Id_TypeItem, 
                                   @OldTypeItemName = TypeItemName, 
                                   @OldSysTypeItemName = SysTypeItemName,
                                   @OldDescription = [Description]
                            FROM deleted;

                         
                            IF @NewTypeItemName <> @OldTypeItemName 
							   begin
                                SET @ChangeDescription = ''+ 'TypeItem = (' +  isnull(@OldId_TypeItem,'')+ ')' + isnull(@ChangeDescription,'') + '  TypeItemName = Old ->"' +  ISNULL(@OldTypeItemName,'') + ' " NEW -> " ' + isnull(@NewTypeItemName,'') + '", ';
							   end
                            IF @NewSysTypeItemName <> @OldSysTypeItemName
							   begin
                                SET @ChangeDescription = ''+ 'TypeItem = (' +  isnull(@OldId_TypeItem,'')+ ')' + isnull(@ChangeDescription,'') + '  SysTypeItemName = Old ->"' + ISNULL(@OldSysTypeItemName,'') + ' " NEW -> "' + ISNULL(@NewSysTypeItemName,'') + '", ';
							   end
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = 'Updated: ' + ' TypeItem = (' +  isnull(@OldId_TypeItem,'')+ ')'+ isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from TypeItem_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.TypeItem_Audit
                            ( 
                               Id_TypeItem       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.Id_TypeItem
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

							DECLARE @OldId_TypeItem_2 BIGINT;
                            DECLARE @OldTypeItemName_2 NVARCHAR(300);
                            DECLARE @OldSysTypeItemName_2 NVARCHAR(300);
                            DECLARE @OldDescription_2 NVARCHAR(4000);
                            
                            SELECT @OldId_TypeItem_2 = Id_TypeItem, 
                                   @OldTypeItemName_2 = TypeItemName, 
                                   @OldSysTypeItemName_2 = SysTypeItemName,
                                   @OldDescription_2 = [Description]
                            FROM deleted;

                            SET @ChangeDescription = 'Deleted: '
                                                 + 'Id_TypeItem="' + CAST(@OldId_TypeItem_2 AS NVARCHAR(20)) + '", '
                                                 + 'TypeItemName="' + ISNULL(@OldTypeItemName_2, '') + '", '
                                                 + 'SysTypeItemName="' + ISNULL(@OldSysTypeItemName_2, '') + '", '
                                                 + 'Description="' + ISNULL(@OldDescription_2, '') + '" ';
                            
                          update u
						  set ChangeDescription = @ChangeDescription
						  from TypeItem_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.TypeItem_Audit
                    ( 
                          Id_TypeItem  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.Id_TypeItem
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @Id_TypeItem_3 BIGINT;
                    SELECT @Id_TypeItem_3 = Id_TypeItem FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_TypeItem="' + CAST(@Id_TypeItem_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from TypeItem_Audit i
					where @AuditID_3  = AuditID                

                    END

GO

commit
--rollback
