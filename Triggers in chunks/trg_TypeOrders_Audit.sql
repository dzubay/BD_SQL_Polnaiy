

begin tran 

CREATE TABLE TypeOrders_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_TypeOrders          bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_TypeOrders_Audit ON TypeOrders
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
                    INSERT  INTO dbo.TypeOrders_Audit
                            ( 
                               ID_TypeOrders            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_TypeOrders
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                            
                            DECLARE @OldID_TypeOrders       bigint        ;
                            DECLARE @OldTypeOrdersName      nvarchar(300) ;
                            DECLARE @OldTypeOrdersSysName   nvarchar(300) ;
                            DECLARE @OldDescription         nvarchar(4000);                  
	                       
							DECLARE @NewID_TypeOrders       bigint        ;
                            DECLARE @NewTypeOrdersName      nvarchar(300) ;
                            DECLARE @NewTypeOrdersSysName   nvarchar(300) ;
                            DECLARE @NewDescription         nvarchar(4000); 

							SELECT 
							       @NewID_TypeOrders     = ID_TypeOrders     ,
							       @NewTypeOrdersName    = TypeOrdersName    ,
							       @NewTypeOrdersSysName = TypeOrdersSysName ,
							       @NewDescription       = [Description]      
							FROM inserted;									 

							SELECT 
                                   @OldID_TypeOrders     = ID_TypeOrders     ,
                                   @OldTypeOrdersName    = TypeOrdersName    ,
                                   @OldTypeOrdersSysName = TypeOrdersSysName ,
                                   @OldDescription       = [Description]      
							FROM Deleted;									 
                         
                            IF @NewTypeOrdersName <> @OldTypeOrdersName 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  TypeOrdersName = Old ->"' +  ISNULL(@OldTypeOrdersName,'') + ' " NEW -> " ' + isnull(@NewTypeOrdersName,'') + '", ';
							   end
                            IF @NewTypeOrdersSysName <> @OldTypeOrdersSysName
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  TypeOrdersSysName = Old ->"' + ISNULL(@OldTypeOrdersSysName,'') + ' " NEW -> "' + ISNULL(@NewTypeOrdersSysName,'') + '", ';
							   end
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' TypeItem = (' +  isnull(cast(@OldID_TypeOrders as nvarchar(20)),'')+ ') ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from TypeOrders_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.TypeOrders_Audit
                            ( 
                               ID_TypeOrders       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_TypeOrders
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

							DECLARE @OldID_TypeOrders_2       bigint        ;
                            DECLARE @OldTypeOrdersName_2      nvarchar(300) ;
                            DECLARE @OldTypeOrdersSysName_2   nvarchar(300) ;
                            DECLARE @OldDescription_2         nvarchar(4000);     
                            


							SELECT 
							       @OldID_TypeOrders_2     = ID_TypeOrders     ,
							       @OldTypeOrdersName_2    = TypeOrdersName    ,
							       @OldTypeOrdersSysName_2 = TypeOrdersSysName ,
							       @OldDescription_2       = [Description]      
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
                                                 + 'ID_TypeOrders="' + CAST(@OldID_TypeOrders_2 AS NVARCHAR(20)) + '", '
                                                 + 'TypeOrdersName="' + ISNULL(@OldTypeOrdersName_2, '') + '", '
                                                 + 'TypeOrdersSysName="' + ISNULL(@OldTypeOrdersSysName_2, '') + '", '
                                                 + 'Description="' + ISNULL(@OldDescription_2, '') + '" ';
                            
                          update u
						  set ChangeDescription = @ChangeDescription
						  from TypeOrders_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.TypeOrders_Audit
                    ( 
                          ID_TypeOrders  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_TypeOrders
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_TypeOrders_3 BIGINT;
                    SELECT @ID_TypeOrders_3 = ID_TypeOrders FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_TypeItem="' + CAST(@ID_TypeOrders_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from TypeOrders_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
rollback

--commit



  