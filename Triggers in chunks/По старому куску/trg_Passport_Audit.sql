
begin tran 

CREATE TABLE Passport_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Passport            bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)        null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Employee_Group_2;


go

CREATE TRIGGER trg_Passport_Audit ON Passport
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
							SELECT d.ID_Passport,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Passport,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;


							DECLARE @OldID_Passport                bigint        ;
							DECLARE @OldNumber_Series              nvarchar(100) ;
							DECLARE @OldDate_Of_Issue              Datetime      ;
							DECLARE @OldDepartment_Code            nvarchar(20)  ;
							DECLARE @OldIssued_By_Whom             nvarchar(400) ;
							DECLARE @OldRegistration               nvarchar(200) ;
							DECLARE @OldMilitary_Duty              nvarchar(200) ;
							DECLARE @OldDescription                nvarchar(1000);

							DECLARE @NewID_Passport                bigint        ;
							DECLARE @NewNumber_Series              nvarchar(100) ;
							DECLARE @NewDate_Of_Issue              Datetime      ;
							DECLARE @NewDepartment_Code            nvarchar(20)  ;
							DECLARE @NewIssued_By_Whom             nvarchar(400) ;
							DECLARE @NewRegistration               nvarchar(200) ;
							DECLARE @NewMilitary_Duty              nvarchar(200) ;
							DECLARE @NewDescription                nvarchar(1000);



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
                                              @OldID_Passport    = D.ID_Passport    ,
											  @OldNumber_Series  = D.Number_Series  ,
											  @OldDate_Of_Issue  = D.Date_Of_Issue  ,
											  @OldDepartment_Code= D.Department_Code,
											  @OldIssued_By_Whom = D.Issued_By_Whom ,
											  @OldRegistration   = D.Registration   ,
											  @OldMilitary_Duty  = D.Military_Duty  ,
											  @OldDescription    = D.[Description]     							
							            FROM Deleted D
										where @ID_entity_D = D.ID_Passport;

							            SELECT 
                                              @NewID_Passport    = I.ID_Passport    ,
											  @NewNumber_Series  = I.Number_Series  ,
											  @NewDate_Of_Issue  = I.Date_Of_Issue  ,
											  @NewDepartment_Code= I.Department_Code,
											  @NewIssued_By_Whom = I.Issued_By_Whom ,
											  @NewRegistration   = I.Registration   ,
											  @NewMilitary_Duty  = I.Military_Duty  ,
											  @NewDescription    = I.[Description]      	
							            FROM inserted I									 
							            where @ID_entity_D = I.ID_Passport;

                                       
							           IF @NewNumber_Series <> @OldNumber_Series 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Number_Series = Old ->"' +  ISNULL(@OldNumber_Series,'') + ' " NEW -> " ' + isnull(@NewNumber_Series,'') + '", ';
							              end

							           IF @NewDate_Of_Issue <> @OldDate_Of_Issue
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Of_Issue = Old ->"' +  ISNULL(CAST(Format(@OldDate_Of_Issue,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Of_Issue,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							              end

							           IF @NewDepartment_Code <> @OldDepartment_Code 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Department_Code = Old ->"' +  ISNULL(@OldDepartment_Code,'') + ' " NEW -> " ' + isnull(@NewDepartment_Code,'') + '", ';
							              end

							           IF @NewIssued_By_Whom <> @OldIssued_By_Whom 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Issued_By_Whom = Old ->"' +  ISNULL(@OldIssued_By_Whom,'') + ' " NEW -> " ' + isnull(@NewIssued_By_Whom,'') + '", ';
							              end

							           IF @NewRegistration <> @OldRegistration 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Registration = Old ->"' +  ISNULL(@OldRegistration,'') + ' " NEW -> " ' + isnull(@NewRegistration,'') + '", ';
							              end

							           IF @NewMilitary_Duty <> @OldMilitary_Duty
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Military_Duty = Old ->"' +  ISNULL(@OldMilitary_Duty,'') + ' " NEW -> " ' + isnull(@NewMilitary_Duty,'') + '", ';
							              end
     
                                       IF @NewDescription <> @OldDescription
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                          end
                                       SET @ChangeDescription = 'Updated: ' + ' ID_Passport = "' +  isnull(cast(@OldID_Passport as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                        --Удаляем запятую на конце
                                       IF LEN(@ChangeDescription) > 0
                                           SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                       
									   INSERT  INTO dbo.Passport_Audit
                                        ( 
                                         ID_Passport,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Passport,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

                            DECLARE @OldID_Passport_2                bigint        ;
							DECLARE @OldNumber_Series_2              nvarchar(100) ;
							DECLARE @OldDate_Of_Issue_2              Datetime      ;
							DECLARE @OldDepartment_Code_2            nvarchar(20)  ;
							DECLARE @OldIssued_By_Whom_2             nvarchar(400) ;
							DECLARE @OldRegistration_2               nvarchar(200) ;
							DECLARE @OldMilitary_Duty_2              nvarchar(200) ;
							DECLARE @OldDescription_2                nvarchar(1000);



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
                                              @OldID_Passport_2     = D.ID_Passport    ,
											  @OldNumber_Series_2   = D.Number_Series  ,
											  @OldDate_Of_Issue_2   = D.Date_Of_Issue  ,
											  @OldDepartment_Code_2 = D.Department_Code,
											  @OldIssued_By_Whom_2  = D.Issued_By_Whom ,
											  @OldRegistration_2    = D.Registration   ,
											  @OldMilitary_Duty_2   = D.Military_Duty  ,
											  @OldDescription_2     = D.[Description]            
							                FROM deleted D									 
											where @ID_entity_D_2 = D.ID_Passport;

                                            SET @ChangeDescription = 'Deleted: '
                                            + 'ID_Passport'     +' = "'+  ISNULL(CAST(@OldID_Passport_2     AS NVARCHAR(50)),'')     + '", '
							                + 'Number_Series'   +' = "'+  ISNULL(@OldNumber_Series_2,'')+ '", '				
							                + 'Date_Of_Issue'   +' = "'+  ISNULL(CAST(Format(@OldDate_Of_Issue_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'Department_Code' +' = "'+  ISNULL(@OldDepartment_Code_2,'')+ '", '
							                + 'Issued_By_Whom'  +' = "'+  ISNULL(@OldIssued_By_Whom_2,'')+ '", '
							                + 'Registration'    +' = "'+  ISNULL(@OldRegistration_2,'')+ '", '
							                + 'Military_Duty'   +' = "'+  ISNULL(@OldMilitary_Duty_2,'')+ '", '
							                + 'Description'     +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

                                           IF LEN(@ChangeDescription) > 0
						                       SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                           INSERT  INTO dbo.Passport_Audit
                                           ( 
                                            ID_Passport,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.ID_Passport,@login_name,GETDATE(),'I'  
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
                                         + 'ID_Passport = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                       
									   INSERT  INTO dbo.Passport_Audit
                                       ( 
                                        ID_Passport,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
