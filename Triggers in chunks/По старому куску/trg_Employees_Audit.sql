
begin tran 

CREATE TABLE Employees_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Employee            bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)         null
  --  PRIMARY KEY CLUSTERED ( AuditID ) 
) on Employee_Group_2


go

CREATE TRIGGER trg_Employees_Audit ON Employees
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
							SELECT d.ID_Employee,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Employee,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;



                           DECLARE @OldID_Employee                bigint        ;
						   DECLARE @OldID_Department              bigint        ;
						   DECLARE @OldID_Group                   bigint        ;
						   DECLARE @OldID_The_Subgroup            bigint        ;
						   DECLARE @OldID_Passport                bigint        ;
						   DECLARE @OldID_Branch                  bigint        ;
						   DECLARE @OldID_Post                    bigint        ;
						   DECLARE @OldID_Status_Employee         bigint        ;
						   DECLARE @OldID_Connection_String       bigint        ;
						   DECLARE @OldID_Chief                   bigint        ;
						   DECLARE @OldName                       nvarchar(100) ;
						   DECLARE @OldSurName                    nvarchar(100) ;
						   DECLARE @OldLastName                   nvarchar(100) ;
						   DECLARE @OldDate_Of_Hiring             datetime      ;
						   DECLARE @OldDate_Сard_Сreated_Employee datetime      ;
						   DECLARE @OldResidential_Address        nvarchar(400) ;
						   DECLARE @OldHome_Phone                 nvarchar(30)  ;
						   DECLARE @OldCell_Phone                 nvarchar(30)  ;
						   DECLARE @OldImage_Employees            varbinary(max);
						   DECLARE @OldWork_Phone                 nvarchar(30)  ;
						   DECLARE @OldMail                       nvarchar(150) ;
						   DECLARE @OldPol                        char(1)       ;
						   DECLARE @OldDate_Of_Dismissal          datetime      ;
						   DECLARE @OldDate_Of_Birth              datetime      ;
						   DECLARE @OldDescription                nvarchar(1000);

						   DECLARE @NewID_Employee                bigint        ;
						   DECLARE @NewID_Department              bigint        ;
						   DECLARE @NewID_Group                   bigint        ;
						   DECLARE @NewID_The_Subgroup            bigint        ;
						   DECLARE @NewID_Passport                bigint        ;
						   DECLARE @NewID_Branch                  bigint        ;
						   DECLARE @NewID_Post                    bigint        ;
						   DECLARE @NewID_Status_Employee         bigint        ;
						   DECLARE @NewID_Connection_String       bigint        ;
						   DECLARE @NewID_Chief                   bigint        ;
						   DECLARE @NewName                       nvarchar(100) ;
						   DECLARE @NewSurName                    nvarchar(100) ;
						   DECLARE @NewLastName                   nvarchar(100) ;
						   DECLARE @NewDate_Of_Hiring             datetime      ;
						   DECLARE @NewDate_Сard_Сreated_Employee datetime      ;
						   DECLARE @NewResidential_Address        nvarchar(400) ;
						   DECLARE @NewHome_Phone                 nvarchar(30)  ;
						   DECLARE @NewCell_Phone                 nvarchar(30)  ;
						   DECLARE @NewImage_Employees            varbinary(max);
						   DECLARE @NewWork_Phone                 nvarchar(30)  ;
						   DECLARE @NewMail                       nvarchar(150) ;
						   DECLARE @NewPol                        char(1)       ;
						   DECLARE @NewDate_Of_Dismissal          datetime      ;
						   DECLARE @NewDate_Of_Birth              datetime      ;
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
									     @OldID_Employee               	  = D.ID_Employee               ,	
										 @OldID_Department             	  = D.ID_Department             ,
										 @OldID_Group                  	  = D.ID_Group                  ,
										 @OldID_The_Subgroup           	  = D.ID_The_Subgroup           ,
										 @OldID_Passport               	  = D.ID_Passport               ,
										 @OldID_Branch                 	  = D.ID_Branch                 ,
										 @OldID_Post                   	  = D.ID_Post                   ,
										 @OldID_Status_Employee        	  = D.ID_Status_Employee        ,
										 @OldID_Connection_String      	  = D.ID_Connection_String      ,
										 @OldID_Chief                  	  = D.ID_Chief                  ,
										 @OldName                      	  = D.Name                      ,
										 @OldSurName                   	  = D.SurName                   ,
										 @OldLastName                  	  = D.LastName                  ,
										 @OldDate_Of_Hiring            	  = D.Date_Of_Hiring            ,
										 @OldDate_Сard_Сreated_Employee	  = D.Date_Сard_Сreated_Employee,
										 @OldResidential_Address       	  = D.Residential_Address       ,
										 @OldHome_Phone                	  = D.Home_Phone                ,
										 @OldCell_Phone                	  = D.Cell_Phone                ,
										 @OldImage_Employees           	  = D.Image_Employees           ,
										 @OldWork_Phone                	  = D.Work_Phone                ,
										 @OldMail                      	  = D.Mail                      ,
										 @OldPol                       	  = D.Pol                       ,
										 @OldDate_Of_Dismissal         	  = D.Date_Of_Dismissal         ,
										 @OldDate_Of_Birth             	  = D.Date_Of_Birth             ,
										 @OldDescription                  = D.[Description]               
									 FROM   Deleted D 
									 where @ID_entity_D = D.ID_Employee; 

                                     SELECT  
									     @NewID_Employee               	  = I.ID_Employee               ,	
										 @NewID_Department             	  = I.ID_Department             ,
										 @NewID_Group                  	  = I.ID_Group                  ,
										 @NewID_The_Subgroup           	  = I.ID_The_Subgroup           ,
										 @NewID_Passport               	  = I.ID_Passport               ,
										 @NewID_Branch                 	  = I.ID_Branch                 ,
										 @NewID_Post                   	  = I.ID_Post                   ,
										 @NewID_Status_Employee        	  = I.ID_Status_Employee        ,
										 @NewID_Connection_String      	  = I.ID_Connection_String      ,
										 @NewID_Chief                  	  = I.ID_Chief                  ,
										 @NewName                      	  = I.Name                      ,
										 @NewSurName                   	  = I.SurName                   ,
										 @NewLastName                  	  = I.LastName                  ,
										 @NewDate_Of_Hiring            	  = I.Date_Of_Hiring            ,
										 @NewDate_Сard_Сreated_Employee	  = I.Date_Сard_Сreated_Employee,
										 @NewResidential_Address       	  = I.Residential_Address       ,
										 @NewHome_Phone                	  = I.Home_Phone                ,
										 @NewCell_Phone                	  = I.Cell_Phone                ,
										 @NewImage_Employees           	  = I.Image_Employees           ,
										 @NewWork_Phone                	  = I.Work_Phone                ,
										 @NewMail                      	  = I.Mail                      ,
										 @NewPol                       	  = I.Pol                       ,
										 @NewDate_Of_Dismissal         	  = I.Date_Of_Dismissal         ,
										 @NewDate_Of_Birth             	  = I.Date_Of_Birth             ,
										 @NewDescription                  = I.[Description]               
									 FROM inserted I  
									 where @ID_entity_D = I.ID_Employee;					
														
                                     IF @NewID_Department <> @OldID_Department 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Department = Old ->"' +  ISNULL(CAST(@OldID_Department AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Department AS NVARCHAR(50)),'') + '", ';
							              end

								     IF @NewID_Group <> @OldID_Group 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Group = Old ->"' +  ISNULL(CAST(@OldID_Group AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Group AS NVARCHAR(50)),'') + '", ';
							              end

                                     IF @NewID_The_Subgroup <> @OldID_The_Subgroup 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_The_Subgroup = Old ->"' +  ISNULL(CAST(@OldID_The_Subgroup AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_The_Subgroup AS NVARCHAR(50)),'') + '", ';
							              end
                                     
									 IF @NewID_Passport <> @OldID_Passport 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Passport = Old ->"' +  ISNULL(CAST(@OldID_Passport AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Passport AS NVARCHAR(50)),'') + '", ';
							              end

								     IF @NewID_Branch <> @OldID_Branch 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Branch = Old ->"' +  ISNULL(CAST(@OldID_Branch AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Branch AS NVARCHAR(50)),'') + '", ';
							              end

                                     IF @NewID_Post <> @OldID_Post
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Post = Old ->"' +  ISNULL(CAST(@OldID_Post AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Post AS NVARCHAR(50)),'') + '", ';
							              end

                                     IF @NewID_Status_Employee <> @OldID_Status_Employee
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Status_Employee = Old ->"' +  ISNULL(CAST(@OldID_Status_Employee AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Status_Employee AS NVARCHAR(50)),'') + '", ';
							              end

								     IF @NewID_Connection_String <> @OldID_Connection_String 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Connection_String = Old ->"' +  ISNULL(CAST(@OldID_Connection_String AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Connection_String AS NVARCHAR(50)),'') + '", ';
							              end

                                     IF @NewID_Chief <> @OldID_Chief 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Chief = Old ->"' +  ISNULL(CAST(@OldID_Chief AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Chief AS NVARCHAR(50)),'') + '", ';
							              end

									 IF @NewName <> @OldName 
							            begin
                                         SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name = Old ->"' +  ISNULL(@OldName,'') + ' " NEW -> " ' + isnull(@NewName,'') + '", ';
							            end

									 IF @NewSurName <> @OldSurName 
							            begin
                                         SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SurName = Old ->"' +  ISNULL(@OldSurName,'') + ' " NEW -> " ' + isnull(@NewSurName,'') + '", ';
							            end

									 IF @NewLastName <> @OldLastName 
							            begin
                                         SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  LastName = Old ->"' +  ISNULL(@OldLastName,'') + ' " NEW -> " ' + isnull(@NewLastName,'') + '", ';
							            end

                                     IF @NewDate_Of_Hiring <> @OldDate_Of_Hiring
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Of_Hiring = Old ->"' +  ISNULL(CAST(Format(@OldDate_Of_Hiring,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Of_Hiring,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							              end

									IF @NewDate_Сard_Сreated_Employee <> @OldDate_Сard_Сreated_Employee
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Сard_Сreated_Employee = Old ->"' +  ISNULL(CAST(Format(@OldDate_Сard_Сreated_Employee,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Сard_Сreated_Employee,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							              end
                                   
									IF @NewResidential_Address <> @OldResidential_Address 
							            begin
                                          SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Residential_Address = Old ->"' +  ISNULL(@OldResidential_Address,'') + ' " NEW -> " ' + isnull(@NewResidential_Address,'') + '", ';
							            end

									IF @NewHome_Phone <> @OldHome_Phone
							            begin
                                          SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Home_Phone = Old ->"' +  ISNULL(@OldHome_Phone,'') + ' " NEW -> " ' + isnull(@NewHome_Phone,'') + '", ';
							            end

									IF @NewCell_Phone <> @OldCell_Phone
							            begin
                                          SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Cell_Phone = Old ->"' +  ISNULL(@OldCell_Phone,'') + ' " NEW -> " ' + isnull(@NewCell_Phone,'') + '", ';
							            end

								    IF @NewImage_Employees <> @OldImage_Employees
							                   begin
							                     SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Image_Employees = '  +  '"Изображение было изменено или удалено", ';
							                   end

									IF @NewWork_Phone <> @OldWork_Phone
							            begin
                                          SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Work_Phone = Old ->"' +  ISNULL(@OldWork_Phone,'') + ' " NEW -> " ' + isnull(@NewWork_Phone,'') + '", ';
							            end 

									IF @NewMail <> @OldMail
							            begin
                                          SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Mail = Old ->"' +  ISNULL(@OldMail,'') + ' " NEW -> " ' + isnull(@NewMail,'') + '", ';
							            end 

							        IF @NewPol <> @OldPol 
							              begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Pol = Old ->"' +  ISNULL(CAST(@OldPol AS NVARCHAR(1)),'') + ' " NEW -> " ' + isnull(CAST(@NewPol AS NVARCHAR(1)),'') + '", ';
							              end

                                   IF @NewDate_Of_Dismissal <> @OldDate_Of_Dismissal
							              begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Of_Dismissal = Old ->"' +  ISNULL(CAST(Format(@OldDate_Of_Dismissal,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Of_Dismissal,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							              end

								   IF @NewDate_Of_Birth <> @OldDate_Of_Birth
							              begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Of_Birth = Old ->"' +  ISNULL(CAST(Format(@OldDate_Of_Birth,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Of_Birth,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							              end

                                   IF @NewDescription <> @OldDescription
							              begin
                                             SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                          end
                                    
									SET @ChangeDescription = 'Updated: ' + ' ID_Employee = "' +  isnull(cast(@OldID_Employee as nvarchar(20)),'')+ '" ' + @ChangeDescription

									IF LEN(@ChangeDescription) > 0
                                                 SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);


                                    INSERT  INTO dbo.Employees_Audit
                                     ( 
                                      ID_Employee,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Employee,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

                            DECLARE @OldID_Employee_2                bigint        ;
						    DECLARE @OldID_Department_2              bigint        ;
						    DECLARE @OldID_Group_2                   bigint        ;
						    DECLARE @OldID_The_Subgroup_2            bigint        ;
						    DECLARE @OldID_Passport_2                bigint        ;
						    DECLARE @OldID_Branch_2                  bigint        ;
						    DECLARE @OldID_Post_2                    bigint        ;
						    DECLARE @OldID_Status_Employee_2         bigint        ;
						    DECLARE @OldID_Connection_String_2       bigint        ;
						    DECLARE @OldID_Chief_2                   bigint        ;
						    DECLARE @OldName_2                       nvarchar(100) ;
						    DECLARE @OldSurName_2                    nvarchar(100) ;
						    DECLARE @OldLastName_2                   nvarchar(100) ;
						    DECLARE @OldDate_Of_Hiring_2             datetime      ;
						    DECLARE @OldDate_Сard_Сreated_Employee_2 datetime      ;
						    DECLARE @OldResidential_Address_2        nvarchar(400) ;
						    DECLARE @OldHome_Phone_2                 nvarchar(30)  ;
						    DECLARE @OldCell_Phone_2                 nvarchar(30)  ;
						    DECLARE @OldImage_Employees_2            varbinary(max);
						    DECLARE @OldWork_Phone_2                 nvarchar(30)  ;
						    DECLARE @OldMail_2                       nvarchar(150) ;
						    DECLARE @OldPol_2                        char(1)       ;
						    DECLARE @OldDate_Of_Dismissal_2          datetime      ;
						    DECLARE @OldDate_Of_Birth_2              datetime      ;
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
									     @OldID_Employee_2               	  = D.ID_Employee               ,	
										 @OldID_Department_2             	  = D.ID_Department             ,
										 @OldID_Group_2                  	  = D.ID_Group                  ,
										 @OldID_The_Subgroup_2           	  = D.ID_The_Subgroup           ,
										 @OldID_Passport_2               	  = D.ID_Passport               ,
										 @OldID_Branch_2                 	  = D.ID_Branch                 ,
										 @OldID_Post_2                   	  = D.ID_Post                   ,
										 @OldID_Status_Employee_2        	  = D.ID_Status_Employee        ,
										 @OldID_Connection_String_2      	  = D.ID_Connection_String      ,
										 @OldID_Chief_2                  	  = D.ID_Chief                  ,
										 @OldName_2                      	  = D.Name                      ,
										 @OldSurName_2                   	  = D.SurName                   ,
										 @OldLastName_2                  	  = D.LastName                  ,
										 @OldDate_Of_Hiring_2            	  = D.Date_Of_Hiring            ,
										 @OldDate_Сard_Сreated_Employee_2	  = D.Date_Сard_Сreated_Employee,
										 @OldResidential_Address_2       	  = D.Residential_Address       ,
										 @OldHome_Phone_2                	  = D.Home_Phone                ,
										 @OldCell_Phone_2                	  = D.Cell_Phone                ,
										 @OldImage_Employees_2           	  = D.Image_Employees           ,
										 @OldWork_Phone_2                	  = D.Work_Phone                ,
										 @OldMail_2                      	  = D.Mail                      ,
										 @OldPol_2                       	  = D.Pol                       ,
										 @OldDate_Of_Dismissal_2         	  = D.Date_Of_Dismissal         ,
										 @OldDate_Of_Birth_2             	  = D.Date_Of_Birth             ,
										 @OldDescription_2                    = D.[Description]               
									 FROM  Deleted D 
									 where @ID_entity_D_2 = D.ID_Employee; 
					
					                 SET @ChangeDescription = 'Deleted: '
									 +  'ID_Employee'                 +' = "'+ ISNULL(CAST(@OldID_Employee_2 AS NVARCHAR(50)),'')  + '", '
									 +	'ID_Department'               +' = "'+ ISNULL(CAST(@OldID_Department_2 AS NVARCHAR(50)),'') + '", '
									 +	'ID_Group'                    +' = "'+ ISNULL(CAST(@OldID_Group_2 AS NVARCHAR(50)),'') + '", '
									 +	'ID_The_Subgroup'             +' = "'+ ISNULL(CAST(@OldID_The_Subgroup_2 AS NVARCHAR(50)),'')+ '", '
									 +	'ID_Passport'                 +' = "'+ ISNULL(CAST(@OldID_Passport_2 AS NVARCHAR(50)),'')+ '", '
									 +	'ID_Branch'                   +' = "'+ ISNULL(CAST(@OldID_Branch_2 AS NVARCHAR(50)),'')+ '", '
									 +	'ID_Post'                     +' = "'+ ISNULL(CAST(@OldID_Post_2 AS NVARCHAR(50)),'')+ '", '
									 +	'ID_Status_Employee'          +' = "'+ ISNULL(CAST(@OldID_Status_Employee_2 AS NVARCHAR(50)),'')+ '", '
									 +	'ID_Connection_String'        +' = "'+ ISNULL(CAST(@OldID_Connection_String_2 AS NVARCHAR(50)),'')+ '", '
									 +	'ID_Chief'                    +' = "'+ ISNULL(CAST(@OldID_Chief_2 AS NVARCHAR(50)),'')+ '", '
							         +  'Name'                        +' = "'+ ISNULL(@OldName_2,'')+ '", '				
							         +  'SurName'                     +' = "'+ ISNULL(@OldSurName_2,'')+ '", '
							         +  'LastName'                    +' = "'+ ISNULL(@OldLastName_2,'') + '", '	
									 +  'Date_Of_Hiring'              +' = "'+ ISNULL(CAST(Format(@OldDate_Of_Hiring_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
									 +  'Date_Сard_Сreated_Employee'  +' = "'+ ISNULL(CAST(Format(@OldDate_Сard_Сreated_Employee_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							         +  'Residential_Address'         +' = "'+ ISNULL(@OldResidential_Address_2,'') + '", '
							         +  'Home_Phone'                  +' = "'+ ISNULL(@OldHome_Phone_2,'')+ '", '				
							         +  'Cell_Phone'                  +' = "'+ ISNULL(@OldCell_Phone_2,'')+ '", '
							         +  'Image_Employees'             +' = "'+ ISNULL(cast(@OldImage_Employees_2 as varchar(max)),'')+ '", '
							         +  'Work_Phone'                  +' = "'+ ISNULL(@OldWork_Phone_2,'')+ '", '				
							         +  'Mail'                        +' = "'+ ISNULL(@OldMail_2,'')+ '", ' 
                                     +  'Pol'                         +' = "'+ ISNULL(CAST(@OldPol_2 AS NVARCHAR(1)),'') 	   + '", '
									 +  'Date_Of_Dismissal'           +' = "'+ ISNULL(CAST(Format(@OldDate_Of_Dismissal_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
									 +  'Date_Of_Birth'               +' = "'+ ISNULL(CAST(Format(@OldDate_Of_Birth_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							         +  'Description'                 +' = "'+ ISNULL(@OldDescription_2  ,'') + '", '

                                     IF LEN(@ChangeDescription) > 0
						                     SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                    INSERT  INTO dbo.Employees_Audit
                                     ( 
                                      ID_Employee,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT I.ID_Employee,@login_name,GETDATE(),'I'  
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
                                         + 'ID_Employee = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
  
                                    INSERT  INTO dbo.Employees_Audit
                                     ( 
                                      ID_Employee,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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


