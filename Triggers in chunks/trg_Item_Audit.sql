

begin tran 

CREATE TABLE Item_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_Item                bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Item_Audit ON Item
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
                    INSERT  INTO dbo.Item_Audit
                            ( 
                               Id_Item            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.Id_Item
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
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
						   DECLARE @OldDate_Сreated                datetime       	;
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
						   DECLARE @NewDate_Сreated                datetime       	;
						   DECLARE @NewQuantity                    int              ;
						   DECLARE @NewDescription                 nvarchar(4000)	;
						   
						   
						   
                         
							SELECT  
							        @NewId_Item                    =  Id_Item                ,
									@NewID_product_measurement	   =  ID_product_measurement ,
									@NewID_TypeItem           	   =  ID_TypeItem            ,
									@NewArticle_number        	   =  Article_number         ,
									@NewName_Item             	   =  Name_Item              ,
									@NewImage_Item            	   =  Image_Item             ,
									@NewManufacturer          	   =  Manufacturer           ,
									@NewCountry               	   =  Country                ,
									@NewCity                  	   =  City                   ,
									@NewAdress                	   =  Adress                 ,
									@NewMail                  	   =  Mail                   ,
									@NewPhone                 	   =  Phone                  ,
									@NewLogo                  	   =  Logo                   ,
									@NewDate_Сreated          	   =  Date_Сreated           ,
									@NewQuantity                   =  Quantity               ,
									@NewDescription                =  [Description]         	
							FROM inserted;									 

							SELECT 
							        @oldId_Item                    =  Id_Item                ,
									@oldID_product_measurement	   =  ID_product_measurement ,
									@oldID_TypeItem           	   =  ID_TypeItem            ,
									@oldArticle_number        	   =  Article_number         ,
									@oldName_Item             	   =  Name_Item              ,
									@oldImage_Item            	   =  Image_Item             ,
									@oldManufacturer          	   =  Manufacturer           ,
									@oldCountry               	   =  Country                ,
									@oldCity                  	   =  City                   ,
									@oldAdress                	   =  Adress                 ,
									@oldMail                  	   =  Mail                   ,
									@oldPhone                 	   =  Phone                  ,
									@oldLogo                  	   =  Logo                   ,
									@oldDate_Сreated          	   =  Date_Сreated           ,
									@oldQuantity                   =  Quantity               ,
									@OldDescription                =  [Description]         								
							FROM Deleted;																		 

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

							IF @NewDate_Сreated <> @OldDate_Сreated
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Сreated = Old ->"' +  ISNULL(CAST(Format(@OldDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
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
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Item_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Item_Audit
                            ( 
                               Id_Item       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.Id_Item
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

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
						   DECLARE @OldDate_Сreated_2                  datetime       ;
						   DECLARE @OldQuantity_2                      int            ;
	                       DECLARE @OldDescription_2                   nvarchar(4000) ;

                            SELECT 
                                @OldId_Item_2                   = Id_Item               ,
								@OldID_product_measurement_2    = ID_product_measurement,
								@OldID_TypeItem_2               = ID_TypeItem           ,
								@OldArticle_number_2            = Article_number        ,
								@OldName_Item_2                 = Name_Item             ,
								@OldImage_Item_2                = Image_Item            ,
								@OldManufacturer_2              = Manufacturer          ,
								@OldCountry_2                   = Country               ,
								@OldCity_2                      = City                  ,
								@OldAdress_2                    = Adress                ,
								@OldMail_2                      = Mail                  ,
								@OldPhone_2                     = Phone                 ,
								@OldLogo_2                      = Logo                  ,
								@OldDate_Сreated_2              = Date_Сreated          ,
								@OldQuantity_2                  = Quantity              ,        
								@OldDescription_2               = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'Id_Item'                +'="'+  ISNULL(CAST(@OldId_Item_2 AS NVARCHAR(20)),'')+ '", '
							+ 'ID_product_measurement' +'="'+  ISNULL(CAST(@OldID_product_measurement_2 AS NVARCHAR(20)),'')+ '", '
							+ 'ID_TypeItem'            +'="'+  ISNULL(CAST(@OldID_TypeItem_2 AS NVARCHAR(20)),'')+ '", '
							+ 'Article_number'         +'="'+  ISNULL(@OldArticle_number_2,'')+ '", '
							+ 'Name_Item'              +'="'+  ISNULL(@OldName_Item_2,'')+ '", '
							+ 'Image_Item'             +'="'+  ISNULL(cast(@OldImage_Item_2 as varchar(max)),'')+ '", '
							+ 'Manufacturer'           +'="'+  ISNULL(@OldManufacturer_2,'')+ '", '
							+ 'Country'                +'="'+  ISNULL(@OldCountry_2,'')+ '", '
							+ 'City'                   +'="'+  ISNULL(@OldCity_2,'')+ '", '
							+ 'Adress'                 +'="'+  ISNULL(@OldAdress_2,'')+ '", '
							+ 'Mail'                   +'="'+  ISNULL(@OldMail_2,'')+ '", '
							+ 'Phone'                  +'="'+  ISNULL(@OldPhone_2,'')+ '", '
							+ 'Logo'                   +'="'+  ISNULL(cast(@OldLogo_2 as varchar(max)),'')+ '", '
							+ 'Date_Сreated'           +'="'+  ISNULL(CAST(Format(@OldDate_Сreated_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'')+ '", '
							+ 'Quantity'               +'="'+  ISNULL(CAST(@OldQuantity_2 AS NVARCHAR(20)),'')+ '", '
							+ 'Description'            +'="'+  ISNULL(@OldDescription_2  ,'')+ '"'



                          update u
						  set ChangeDescription = @ChangeDescription
						  from Item_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Item_Audit
                    ( 
                          Id_Item  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.Id_Item
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @Id_Item_3 BIGINT;
                    SELECT @Id_Item_3 = Id_Item FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_Item = "' + CAST(@Id_Item_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Item_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit