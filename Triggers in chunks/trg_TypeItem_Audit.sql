


begin tran 

CREATE TABLE TypeItem_Audit
(
    AuditID              bigint IDENTITY(1,1)  not null,
    Id_TypeItem          bigint                null,
 	ModifiedBy           nVARCHAR(128)         null,
    ModifiedDate         DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation            CHAR(1)               null,
    ChangeDescription    nvarchar(max)        null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_TypeItem_Audit ON TypeItem
AFTER INSERT, UPDATE, DELETE

AS
    set nocount,xact_abort on;

    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(max);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN       
				            declare @t_U_D table 
							(
							Id_Num         bigint        identity(1,1) not null,
							ID_entity      bigint        null,
							login_name     nvarchar(128) null,
							ModifiedDate   DATETIME      null,
							Name_action    char(1)       null
							);

							declare @t_U_I table 
							(
							Id_Num         bigint        identity(1,1) not null,
							ID_entity      bigint        null,
							login_name     nvarchar(128) null,
							ModifiedDate   DATETIME      null,
							Name_action    char(1)       null
							);

							insert into @t_U_D (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_TypeItem,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_TypeItem,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ; 

                            
                            DECLARE @OldId_TypeItem BIGINT;
                            DECLARE @OldTypeItemName NVARCHAR(300);
                            DECLARE @OldSysTypeItemName NVARCHAR(300);
                            DECLARE @OldDescription NVARCHAR(4000);	                    
	                       
							DECLARE @NewId_TypeItem BIGINT;
                            DECLARE @NewTypeItemName NVARCHAR(300);
                            DECLARE @NewSysTypeItemName NVARCHAR(300);
                            DECLARE @NewDescription NVARCHAR(4000);

							declare cr cursor local fast_forward for
						   
						    select 
						    ID_entity    
						    ,login_name   
						    ,ModifiedDate 
						    ,Name_action  
						    from @t_U_D 
                            open cr       
						    
						    fetch next from cr into 
						    @ID_entity_D,@login_name_2_D,@ModifiedDate_D,@Name_action_D 
						    while @@FETCH_STATUS  = 0
						         begin
							         begin try
									       SELECT @OldId_TypeItem     = D.Id_TypeItem    , 
                                                  @OldTypeItemName    = D.TypeItemName   , 
                                                  @OldSysTypeItemName = D.SysTypeItemName,
                                                  @OldDescription     = D.[Description]
                                           FROM deleted D
										   where @ID_entity_D = D.Id_TypeItem;

							               SELECT @NewId_TypeItem     = I.Id_TypeItem    ,
							                      @NewTypeItemName    = I.TypeItemName   , 
							                      @NewSysTypeItemName = I.SysTypeItemName,
							                      @NewDescription     = I.[Description]
							               FROM inserted I
										   where @ID_entity_D = I.Id_TypeItem;
							               
                                          IF @NewTypeItemName <> @OldTypeItemName 
							                 begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  TypeItemName = Old ->"' +  ISNULL(@OldTypeItemName,'') + ' " NEW -> " ' + isnull(@NewTypeItemName,'') + '", ';
							                 end
                                          IF @NewSysTypeItemName <> @OldSysTypeItemName
							                 begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SysTypeItemName = Old ->"' + ISNULL(@OldSysTypeItemName,'') + ' " NEW -> "' + ISNULL(@NewSysTypeItemName,'') + '", ';
							                 end
                                          IF @NewDescription <> @OldDescription
							                 begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                             end
                                          SET @ChangeDescription = 'Updated: ' + ' Id_TypeItem = "' +  isnull(cast(@OldId_TypeItem as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                           --Удаляем запятую на конце
                                          IF LEN(@ChangeDescription) > 0
                                              SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                              			  INSERT  INTO dbo.TypeItem_Audit
                                          ( 
                                           Id_TypeItem,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
                                          )
                                            SELECT  @ID_entity_D,@login_name_2_D,@ModifiedDate_D,@Name_action_D,@ChangeDescription;              
                                     
									      set @ChangeDescription = null 
								  end try
								  begin catch
								     if xact_state() in (1, -1)
									    begin
									       ROLLBACK TRAN
									    end
								     SELECT 
									   ERROR_NUMBER() AS ErrorNumber_U_D,
									   ERROR_SEVERITY() AS ErrorSeverity_U_D,
									   ERROR_STATE() as ErrorState_U_D,
									   ERROR_PROCEDURE() as ErrorProcedure_U_D,
									   ERROR_LINE() as ErrorLine_U_D,
									   ERROR_MESSAGE() as ErrorMessage_U_D;
								  end catch;
							     fetch next from cr into 
								 @ID_entity_D,@login_name_2_D,@ModifiedDate_D,@Name_action_D
						         end
						   close cr
                           deallocate cr
                END
            ELSE
                BEGIN        
				            declare @t_D_D table 
							(
							Id_Num         bigint        identity(1,1) not null,
							ID_entity      bigint        null,
							login_name     nvarchar(128) null,
							ModifiedDate   DATETIME      null,
							Name_action    char(1)       null
							);


							insert into @t_D_D (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_TypeItem,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

							DECLARE @OldId_TypeItem_2 BIGINT;
                            DECLARE @OldTypeItemName_2 NVARCHAR(300);
                            DECLARE @OldSysTypeItemName_2 NVARCHAR(300);
                            DECLARE @OldDescription_2 NVARCHAR(4000);
                            
							declare cr_2 cursor local fast_forward for
						   
						    select 
						    ID_entity   
						    ,login_name  
						    ,ModifiedDate
						    ,Name_action 
						    from @t_D_D 
                            open cr_2       
						   
						    fetch next from cr_2 into 
						    @ID_entity_D_2,@login_name_2_D_2,@ModifiedDate_D_2,@Name_action_D_2 
						    while @@FETCH_STATUS  = 0
						         begin
							         begin try
									       SELECT
										          @OldId_TypeItem_2     = D.Id_TypeItem    , 
                                                  @OldTypeItemName_2    = D.TypeItemName   , 
                                                  @OldSysTypeItemName_2 = D.SysTypeItemName,
                                                  @OldDescription_2     = D.[Description]
                                           FROM deleted D
										   where @ID_entity_D_2 = D.Id_TypeItem;
										   
                                           SET @ChangeDescription = 'Deleted: '
                                              + 'Id_TypeItem'    + ' = "' + isnull(CAST(@OldId_TypeItem_2 AS NVARCHAR(20)),'') + '", '
                                              + 'TypeItemName'   + ' = "' + ISNULL(@OldTypeItemName_2, '') + '", '
                                              + 'SysTypeItemName'+ ' = "' + ISNULL(@OldSysTypeItemName_2, '') + '", '
                                              + 'Description'    + ' = "' + ISNULL(@OldDescription_2, '') + '" ';
                            
                                           IF LEN(@ChangeDescription) > 0
                                                 SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                           
										  INSERT  INTO dbo.TypeItem_Audit
                                          ( 
                                           Id_TypeItem,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
                                          )
                                           SELECT  @ID_entity_D_2,@login_name_2_D_2,@ModifiedDate_D_2,@Name_action_D_2,@ChangeDescription;              
                                          
									      set @ChangeDescription = null 

								  end try
								  begin catch
								     if xact_state() in (1, -1)
									    begin
									       ROLLBACK TRAN
									    end
								     SELECT 
									   ERROR_NUMBER() AS ErrorNumber_D_D,
									   ERROR_SEVERITY() AS ErrorSeverity_D_D,
									   ERROR_STATE() as ErrorState_D_D,
									   ERROR_PROCEDURE() as ErrorProcedure_D_D,
									   ERROR_LINE() as ErrorLine_D_D,
									   ERROR_MESSAGE() as ErrorMessage_D_D;
								  end catch;
							     fetch next from cr_2 into 
								 @ID_entity_D_2,@login_name_2_D_2,@ModifiedDate_D_2,@Name_action_D_2
						         end
						   close cr_2
                           deallocate cr_2

                END  
        END
    ELSE
        BEGIN       
		            declare @t_I_I table 
					(
					Id_Num         bigint        identity(1,1) not null,
					ID_entity      bigint        null,
					login_name     nvarchar(128) null,
					ModifiedDate   DATETIME      null,
					Name_action    char(1)       null
					);

					insert into @t_I_I (ID_entity,login_name,ModifiedDate,Name_action)
					SELECT I.Id_TypeItem,@login_name,GETDATE(),'I'  
					FROM  inserted I

					DECLARE @ID_entity_I_2    bigint       ;
				    DECLARE @login_name_2_I_2 nvarchar(128);
				    DECLARE @ModifiedDate_I_2 DATETIME     ;
				    DECLARE @Name_action_I_2  char(1)      ;

		            declare cr_3 cursor local fast_forward for
						   
					select 
					ID_entity   
					,login_name  
					,ModifiedDate
					,Name_action 
					from @t_I_I 
                    open cr_3       
					
					fetch next from cr_3 into 
					@ID_entity_I_2,@login_name_2_I_2,@ModifiedDate_I_2,@Name_action_I_2 
					while @@FETCH_STATUS  = 0
						  begin
							    begin try 
                                       SET @ChangeDescription = 'Inserted: '
                                            + 'Id_TypeItem = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                       
									   INSERT  INTO dbo.TypeItem_Audit
                                        ( 
                                         Id_TypeItem,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
                                        )
                                         SELECT  @ID_entity_I_2,@login_name_2_I_2,@ModifiedDate_I_2,@Name_action_I_2,@ChangeDescription;              
                                     
									   set @ChangeDescription = null
                                 end try
								 begin catch
								     if xact_state() in (1, -1)
									    begin
									       ROLLBACK TRAN
									    end
								     SELECT 
									   ERROR_NUMBER() AS ErrorNumber_I_I,
									   ERROR_SEVERITY() AS ErrorSeverity_I_I,
									   ERROR_STATE() as ErrorState_I_I,
									   ERROR_PROCEDURE() as ErrorProcedure_I_I,
									   ERROR_LINE() as ErrorLine_I_I,
									   ERROR_MESSAGE() as ErrorMessage_I_I;
								  end catch;
							     fetch next from cr_3 into 
								 @ID_entity_I_2,@login_name_2_I_2,@ModifiedDate_I_2,@Name_action_I_2
						         end
						   close cr_3
                           deallocate cr_3

                    END

GO

commit
--rollback

