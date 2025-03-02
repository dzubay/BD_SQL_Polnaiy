

begin tran 

CREATE TABLE Item_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_Item                bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(Max)         null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Item_Audit ON Item
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
							SELECT d.Id_Item,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_Item,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
                           
                           DECLARE @OldId_Item                     bigint         	;
						   DECLARE @OldID_product_measurement      bigint         	;
						   DECLARE @OldID_TypeItem                 bigint         	;
						   DECLARE @OldArticle_number              nvarchar(300)  	;
						   DECLARE @OldName_Item                   nvarchar(500)  	;
						   DECLARE @OldImage_Item                  varbinary(max) 	;
						   DECLARE @OldManufacturer                nvarchar(500)  	;
						   DECLARE @OldCountry                     nvarchar(200)  	;
						   DECLARE @OldCity                        nvarchar(200)  	;
						   DECLARE @OldAdress                      nvarchar(800)  	;
						   DECLARE @OldMail                        nvarchar(250)  	;
						   DECLARE @OldPhone                       nvarchar(30)   	;
						   DECLARE @OldLogo                        varbinary(max) 	;
						   DECLARE @OldDate_Created                datetime       	;
						   DECLARE @OldQuantity                    int              ;
	                       DECLARE @OldDescription                 nvarchar(4000)	;

                           DECLARE @NewId_Item                     bigint         	;
						   DECLARE @NewID_product_measurement      bigint         	;
						   DECLARE @NewID_TypeItem                 bigint         	;
						   DECLARE @NewArticle_number              nvarchar(300)  	;
						   DECLARE @NewName_Item                   nvarchar(500)  	;
						   DECLARE @NewImage_Item                  varbinary(max) 	;
						   DECLARE @NewManufacturer                nvarchar(500)  	;
						   DECLARE @NewCountry                     nvarchar(200)  	;
						   DECLARE @NewCity                        nvarchar(200)  	;
						   DECLARE @NewAdress                      nvarchar(800)  	;
						   DECLARE @NewMail                        nvarchar(250)  	;
						   DECLARE @NewPhone                       nvarchar(30)   	;
						   DECLARE @NewLogo                        varbinary(max) 	;
						   DECLARE @NewDate_Created                datetime       	;
						   DECLARE @NewQuantity                    int              ;
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
							                        @NewId_Item                    =  I.Id_Item                ,
							                		@NewID_product_measurement	   =  I.ID_product_measurement ,
							                		@NewID_TypeItem           	   =  I.ID_TypeItem            ,
							                		@NewArticle_number        	   =  I.Article_number         ,
							                		@NewName_Item             	   =  I.Name_Item              ,
							                		@NewImage_Item            	   =  I.Image_Item             ,
							                		@NewManufacturer          	   =  I.Manufacturer           ,
							                		@NewCountry               	   =  I.Country                ,
							                		@NewCity                  	   =  I.City                   ,
							                		@NewAdress                	   =  I.Adress                 ,
							                		@NewMail                  	   =  I.Mail                   ,
							                		@NewPhone                 	   =  I.Phone                  ,
							                		@NewLogo                  	   =  I.Logo                   ,
							                		@NewDate_Created          	   =  I.Date_Created           ,
							                		@NewQuantity                   =  I.Quantity               ,
							                		@NewDescription                =  I.[Description]         	
							                FROM inserted I									 
											where @ID_entity_D = I.Id_Item;
							
							                SELECT 
							                        @oldId_Item                    =  D.Id_Item                ,
							                		@oldID_product_measurement	   =  D.ID_product_measurement ,
							                		@oldID_TypeItem           	   =  D.ID_TypeItem            ,
							                		@oldArticle_number        	   =  D.Article_number         ,
							                		@oldName_Item             	   =  D.Name_Item              ,
							                		@oldImage_Item            	   =  D.Image_Item             ,
							                		@oldManufacturer          	   =  D.Manufacturer           ,
							                		@oldCountry               	   =  D.Country                ,
							                		@oldCity                  	   =  D.City                   ,
							                		@oldAdress                	   =  D.Adress                 ,
							                		@oldMail                  	   =  D.Mail                   ,
							                		@oldPhone                 	   =  D.Phone                  ,
							                		@oldLogo                  	   =  D.Logo                   ,
							                		@oldDate_Created          	   =  D.Date_Created           ,
							                		@oldQuantity                   =  D.Quantity               ,
							                		@OldDescription                =  D.[Description]         								
							                FROM Deleted D
											where @ID_entity_D = D.Id_Item;

                                            IF @NewID_product_measurement <> @OldID_product_measurement
							                   begin
                                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_product_measurement = Old ->"' +  ISNULL(CAST(@OldID_product_measurement AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_product_measurement AS NVARCHAR(20)),'') + '", ';
							                   end
                                            
							                IF @NewID_TypeItem <> @OldID_TypeItem
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_TypeItem = Old ->"' +  ISNULL(CAST(@OldID_TypeItem AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_TypeItem AS NVARCHAR(20)),'') + '", ';
							                   end
					                        
							                IF @NewArticle_number <> @OldArticle_number
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Article_number = Old ->"' +  ISNULL(@OldArticle_number,'') + ' " NEW -> " ' + isnull(@NewArticle_number,'') + '", ';
							                   end
					                        
							                IF @NewName_Item <> @OldName_Item
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_Item = Old ->"' +  ISNULL(@OldName_Item,'') + ' " NEW -> " ' + isnull(@NewName_Item,'') + '", ';
							                   end
					                        
							                IF @NewImage_Item <> @OldImage_Item
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Image_Item = '  +  '"Изображение было изменено или удалено", ';
							                   end
					                        
							                IF @NewManufacturer <> @OldManufacturer
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Manufacturer = Old ->"' +  ISNULL(@OldManufacturer,'') + ' " NEW -> " ' + isnull(@NewManufacturer,'') + '", ';
							                   end
					                        
							                IF @NewCountry <> @OldCountry
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Country = Old ->"' +  ISNULL(@OldCountry,'') + ' " NEW -> " ' + isnull(@NewCountry,'') + '", ';
							                   end
					                        
							                IF @NewCity <> @OldCity
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  City = Old ->"' +  ISNULL(@OldCity,'') + ' " NEW -> " ' + isnull(@NewCity,'') + '", ';
							                   end
					                        
							                IF @NewAdress <> @OldAdress
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Adress = Old ->"' +  ISNULL(@OldAdress,'') + ' " NEW -> " ' + isnull(@NewAdress,'') + '", ';
							                   end
					                        
							                IF @NewMail <> @OldMail
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Mail = Old ->"' +  ISNULL(@OldMail,'') + ' " NEW -> " ' + isnull(@NewMail,'') + '", ';
							                   end
					                        
							                IF @NewPhone <> @OldPhone
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Phone = Old ->"' +  ISNULL(@OldPhone,'') + ' " NEW -> " ' + isnull(@NewPhone,'') + '", ';
							                   end
					                        
							                IF @NewLogo <> @OldLogo
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Logo = ' +  '"Изображение было изменено или удалено", ';
							                   end
							                
							                IF @NewDate_Created <> @OldDate_Created
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Created = Old ->"' +  ISNULL(CAST(Format(@OldDate_Created,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Created,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							                   end
							                
					                        IF @NewQuantity <> @OldQuantity
							                   begin
                                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Quantity = Old ->"' +  ISNULL(CAST(@OldQuantity AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewQuantity AS NVARCHAR(20)),'') + '", ';
							                   end
                                            
							                
                                            IF @NewDescription <> @OldDescription
							                   begin
                                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                               end
                                            SET @ChangeDescription = 'Updated: ' + ' Id_Item = "' +  isnull(cast(@OldId_Item as nvarchar(20)),'')+ '" ' + @ChangeDescription + '"'
                                             --Удаляем запятую на конце
                                            IF LEN(@ChangeDescription) > 0
                                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                                             INSERT  INTO dbo.Item_Audit
                                             ( 
                                              Id_Item,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.Id_Item,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ; 

						   DECLARE @OldId_Item_2                       bigint         ;
						   DECLARE @OldID_product_measurement_2        bigint         ;
						   DECLARE @OldID_TypeItem_2                   bigint         ;
						   DECLARE @OldArticle_number_2                nvarchar(300)  ;
						   DECLARE @OldName_Item_2                     nvarchar(500)  ;
						   DECLARE @OldImage_Item_2                    varbinary(max) ;
						   DECLARE @OldManufacturer_2                  nvarchar(500)  ;
						   DECLARE @OldCountry_2                       nvarchar(200)  ;
						   DECLARE @OldCity_2                          nvarchar(200)  ;
						   DECLARE @OldAdress_2                        nvarchar(800)  ;
						   DECLARE @OldMail_2                          nvarchar(250)  ;
						   DECLARE @OldPhone_2                         nvarchar(30)   ;
						   DECLARE @OldLogo_2                          varbinary(max) ;
						   DECLARE @OldDate_Created_2                  datetime       ;
						   DECLARE @OldQuantity_2                      int            ;
	                       DECLARE @OldDescription_2                   nvarchar(4000) ;


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
                                                    @OldId_Item_2                   = D.Id_Item               ,
							                    	@OldID_product_measurement_2    = D.ID_product_measurement,
							                    	@OldID_TypeItem_2               = D.ID_TypeItem           ,
							                    	@OldArticle_number_2            = D.Article_number        ,
							                    	@OldName_Item_2                 = D.Name_Item             ,
							                    	@OldImage_Item_2                = D.Image_Item            ,
							                    	@OldManufacturer_2              = D.Manufacturer          ,
							                    	@OldCountry_2                   = D.Country               ,
							                    	@OldCity_2                      = D.City                  ,
							                    	@OldAdress_2                    = D.Adress                ,
							                    	@OldMail_2                      = D.Mail                  ,
							                    	@OldPhone_2                     = D.Phone                 ,
							                    	@OldLogo_2                      = D.Logo                  ,
							                    	@OldDate_Created_2              = D.Date_Created          ,
							                    	@OldQuantity_2                  = D.Quantity              ,        
							                    	@OldDescription_2               = D.[Description]        
							                    FROM deleted D
												where @ID_entity_D_2 = D.Id_Item;

                                                SET @ChangeDescription = 'Deleted: '
							                    + 'Id_Item'                +' = "'+  ISNULL(CAST(@OldId_Item_2 AS NVARCHAR(20)),'')+ '", '
							                    + 'ID_product_measurement' +' = "'+  ISNULL(CAST(@OldID_product_measurement_2 AS NVARCHAR(20)),'')+ '", '
							                    + 'ID_TypeItem'            +' = "'+  ISNULL(CAST(@OldID_TypeItem_2 AS NVARCHAR(20)),'')+ '", '
							                    + 'Article_number'         +' = "'+  ISNULL(@OldArticle_number_2,'')+ '", '
							                    + 'Name_Item'              +' = "'+  ISNULL(@OldName_Item_2,'')+ '", '
							                    + 'Image_Item'             +' = "'+  ISNULL(cast(@OldImage_Item_2 as varchar(max)),'')+ '", '
							                    + 'Manufacturer'           +' = "'+  ISNULL(@OldManufacturer_2,'')+ '", '
							                    + 'Country'                +' = "'+  ISNULL(@OldCountry_2,'')+ '", '
							                    + 'City'                   +' = "'+  ISNULL(@OldCity_2,'')+ '", '
							                    + 'Adress'                 +' = "'+  ISNULL(@OldAdress_2,'')+ '", '
							                    + 'Mail'                   +' = "'+  ISNULL(@OldMail_2,'')+ '", '
							                    + 'Phone'                  +' = "'+  ISNULL(@OldPhone_2,'')+ '", '
							                    + 'Logo'                   +' = "'+  ISNULL(cast(@OldLogo_2 as varchar(max)),'')+ '", '
							                    + 'Date_Created'           +' = "'+  ISNULL(CAST(Format(@OldDate_Created_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'')+ '", '
							                    + 'Quantity'               +' = "'+  ISNULL(CAST(@OldQuantity_2 AS NVARCHAR(20)),'')+ '", '
							                    + 'Description'            +' = "'+  ISNULL(@OldDescription_2  ,'')+ '"'

                                                IF LEN(@ChangeDescription) > 0
                                                      SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                                
												INSERT  INTO dbo.Item_Audit
                                                ( 
                                                 Id_Item,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.Id_Item,@login_name,GETDATE(),'I'  
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
                                                    + 'Id_Item = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                    
                                         INSERT  INTO dbo.Item_Audit
                                         ( 
                                          Id_Item,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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