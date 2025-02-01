
begin tran 

CREATE TABLE Type_Storage_location_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Type_Storage_location  bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(max)         null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Type_Storage_location_Audit ON Type_Storage_location
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
							SELECT d.ID_Type_Storage_location,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Type_Storage_location,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
                           
						   DECLARE @OldID_Type_Storage_location    bigint           ;
						   DECLARE @OldName_Type_Storage_location  nvarchar(300)	;
						   DECLARE @OldSysNameTypeStoragelocation  nvarchar(300)	;
	                       DECLARE @OldDescription                 nvarchar(4000)	;

                           DECLARE @NewID_Type_Storage_location    bigint           ;
						   DECLARE @NewName_Type_Storage_location  nvarchar(300)	;
						   DECLARE @NewSysNameTypeStoragelocation  nvarchar(300)	;
						   DECLARE @NewDescription                 nvarchar(4000)	;
                           
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
                         
							            SELECT 
							                @NewID_Type_Storage_location    = I.ID_Type_Storage_location  ,
							            	@NewName_Type_Storage_location	= I.Name_Type_Storage_location,
							            	@NewSysNameTypeStoragelocation  = I.SysNameTypeStoragelocation,            
							            	@NewDescription                 = I.[Description]        	
							            FROM inserted I
										where @ID_entity_D = I.ID_Type_Storage_location;	
							            
							            SELECT 
							                @OldID_Type_Storage_location    = D.ID_Type_Storage_location  ,
							            	@OldName_Type_Storage_location  = D.Name_Type_Storage_location,
							            	@OldSysNameTypeStoragelocation	= D.SysNameTypeStoragelocation,
							            	@OldDescription                 = D.[Description]        							
							            FROM Deleted D	
										where @ID_entity_D = D.ID_Type_Storage_location; 

                            
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
                            
                            
                                        INSERT  INTO dbo.Type_Storage_location_Audit
                                        ( 
                                         ID_Type_Storage_location,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Type_Storage_location,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

                           DECLARE @OldID_Type_Storage_location_2    bigint         ;
						   DECLARE @OldName_Type_Storage_location_2  nvarchar(300)	;
						   DECLARE @OldSysNameTypeStoragelocation_2  nvarchar(300)	;
	                       DECLARE @OldDescription_2                 nvarchar(4000)	;

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
							                    @OldID_Type_Storage_location_2    = D.ID_Type_Storage_location   ,
							                	@OldName_Type_Storage_location_2  = D.Name_Type_Storage_location ,
							                	@OldSysNameTypeStoragelocation_2  = D.SysNameTypeStoragelocation ,
							                	@OldDescription_2                 = D.[Description]        
							                FROM deleted D
											where @ID_entity_D_2 = D.ID_Type_Storage_location

                                            SET @ChangeDescription = 'Deleted: '
							                + 'ID_Type_Storage_location'   +' = "'+  ISNULL(CAST(@OldID_Type_Storage_location_2  AS NVARCHAR(50)),'')+ '", '
							                + 'Name_Type_Storage_location' +' = "'+  ISNULL(@OldName_Type_Storage_location_2,'')+ '", '
							                + 'SysNameTypeStoragelocation' +' = "'+  ISNULL(@OldSysNameTypeStoragelocation_2,'')+ '", '
							                + 'Description'                +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '
                          
						                    IF LEN(@ChangeDescription) > 0
                                                  SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                            INSERT  INTO dbo.Type_Storage_location_Audit
                                            ( 
                                             ID_Type_Storage_location,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
				   SELECT I.ID_Type_Storage_location,@login_name,GETDATE(),'I'  
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
                                               + 'ID_Type_Storage_location = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                       
									   INSERT  INTO dbo.Type_Storage_location_Audit
                                       ( 
                                        ID_Type_Storage_location,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
--rollback
commit
