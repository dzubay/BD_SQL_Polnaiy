
begin tran 

CREATE TABLE Country_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_Country             bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)        null
  --  PRIMARY KEY CLUSTERED ( AuditID ) 
) on Employee_Group_2


go

CREATE TRIGGER trg_Country_Audit ON Country
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
							SELECT d.Id_Country,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_Country,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;


						   DECLARE @OldId_Country         bigint        ;
						   DECLARE @OldName_Country       nvarchar(150) ;
						   DECLARE @OldName_English       nvarchar(150) ;
						   DECLARE @OldCod_Country_Phone  nvarchar(10)  ;

						   DECLARE @NewId_Country         bigint        ;
						   DECLARE @NewName_Country       nvarchar(150) ;
						   DECLARE @NewName_English       nvarchar(150) ;
						   DECLARE @NewCod_Country_Phone  nvarchar(10)  ;
						   
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
									     @OldId_Country        =   D.Id_Country       ,
										 @OldName_Country      =   D.Name_Country     ,
										 @OldName_English      =   D.Name_English     ,
										 @OldCod_Country_Phone =   D.Cod_Country_Phone
									 FROM   Deleted D 
									 where @ID_entity_D = D.Id_Country 

									 SELECT 
										@NewId_Country       	 = I.Id_Country       ,
										@NewName_Country     	 = I.Name_Country     ,
										@NewName_English     	 = I.Name_English     ,
										@NewCod_Country_Phone    = I.Cod_Country_Phone 
									 FROM inserted I  
									 where @ID_entity_D = I.Id_Country;					
														
                                     
									 IF @NewName_Country <> @OldName_Country 
							            begin
                                         SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_Country = Old ->"' +  ISNULL(@OldName_Country,'') + ' " NEW -> " ' + isnull(@NewName_Country,'') + '", ';
							            end
                            
							        IF @NewName_English <> @OldName_English
							           begin
							             SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_English = Old ->"' +  ISNULL(@OldName_English,'') + ' " NEW -> " ' + isnull(@NewName_English,'') + '", ';
							           end

							        IF @NewCod_Country_Phone <> @OldCod_Country_Phone 
							           begin
							             SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Cod_Country_Phone = Old ->"' +  ISNULL(@OldCod_Country_Phone,'') + ' " NEW -> " ' + isnull(@NewCod_Country_Phone,'') + '", ';
							           end
                                    
									SET @ChangeDescription = 'Updated: ' + ' Id_Country = "' +  isnull(cast(@OldId_Country as nvarchar(20)),'')+ '" ' + @ChangeDescription

									IF LEN(@ChangeDescription) > 0
                                                 SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);


                                    INSERT  INTO dbo.Country_Audit
                                     ( 
                                      Id_Country,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.Id_Country,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

						   DECLARE @OldId_Country_2         bigint        ;
						   DECLARE @OldName_Country_2       nvarchar(150) ;
						   DECLARE @OldName_English_2       nvarchar(150) ;
						   DECLARE @OldCod_Country_Phone_2  nvarchar(10)  ;
						   
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
									     @OldId_Country_2        =   D.Id_Country       ,
										 @OldName_Country_2      =   D.Name_Country     ,
										 @OldName_English_2      =   D.Name_English     ,
										 @OldCod_Country_Phone_2 =   D.Cod_Country_Phone
									 FROM   Deleted D 
									 where @ID_entity_D_2 = D.Id_Country 
					
					                 SET @ChangeDescription = 'Deleted: '
							         + 'Id_Country'                +' = "'+  ISNULL(CAST(@OldId_Country_2  AS NVARCHAR(50)),'')+ '", '
							         + 'Name_Country'              +' = "'+  ISNULL(@OldName_Country_2,'')+ '", '				
							         + 'Name_English'              +' = "'+  ISNULL(@OldName_English_2,'')+ '", '
							         + 'Cod_Country_Phone'         +' = "'+  ISNULL(@OldCod_Country_Phone_2,'') + '", '


                                     IF LEN(@ChangeDescription) > 0
						                     SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                    INSERT  INTO dbo.Country_Audit
                                     ( 
                                      Id_Country,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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

				           DECLARE @ID_entity_I_2    bigint       ;
				           DECLARE @login_name_2_I_2 nvarchar(128);
				           DECLARE @ModifiedDate_I_2 DATETIME     ;
				           DECLARE @Name_action_I_2  char(1)      ;

							declare @t_I_I table 
							(
							Id_Num         bigint        identity(1,1) not null,
							ID_entity      bigint        null,
							login_name     nvarchar(128) null,
							ModifiedDate   DATETIME      null,
							Name_action    char(1)       null
							);


							insert into @t_I_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT I.Id_Country,@login_name,GETDATE(),'I'  
							FROM  inserted I
						   
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
                                         + 'Id_Country = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
  
                                    INSERT  INTO dbo.Country_Audit
                                     ( 
                                      Id_Country,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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


