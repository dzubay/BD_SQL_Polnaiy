
begin tran 

CREATE TABLE Exemplar_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Exemplar               bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Exemplar_Audit ON Exemplar
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
                    INSERT  INTO dbo.Exemplar_Audit
                            ( 
                               ID_Exemplar            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Exemplar
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
                           DECLARE @OldID_Exemplar                bigint         ;
						   DECLARE @OldId_Item                    bigint         ;
						   DECLARE @OldID_Currency                bigint         ;
						   DECLARE @OldID_Storage_location        bigint         ;
						   DECLARE @OldKeySource                  bigint         ;
						   DECLARE @OldSerial_number              nvarchar(500)  ;
						   DECLARE @OldID_Condition_of_the_item   bigint         ;
						   DECLARE @OldOld_Price_no_NDS           float          ;
						   DECLARE @OldRefund                     bit            ;
						   DECLARE @OldDate_Refund                datetime       ;
						   DECLARE @OldReturn_Note                nvarchar(4000) ;
						   DECLARE @OldOld_Price_NDS              float          ;
						   DECLARE @OldJSON_Size_Volume           nvarchar(max)  ;
						   DECLARE @OldNew_Price_NDS              float          ;
						   DECLARE @OldNew_Price_no_NDS           float          ;
						   DECLARE @OldDate_Сreated               datetime       ;
						   DECLARE @OldDescription                nvarchar(4000) ;

						   DECLARE @NewID_Exemplar                bigint         ;
						   DECLARE @NewId_Item                    bigint         ;
						   DECLARE @NewID_Currency                bigint         ;
						   DECLARE @NewID_Storage_location        bigint         ;
						   DECLARE @NewKeySource                  bigint         ;
						   DECLARE @NewSerial_number              nvarchar(500)  ;
						   DECLARE @NewID_Condition_of_the_item   bigint         ;
						   DECLARE @NewOld_Price_no_NDS           float          ;
						   DECLARE @NewRefund                     bit            ;
						   DECLARE @NewDate_Refund                datetime       ;
						   DECLARE @NewReturn_Note                nvarchar(4000) ;
						   DECLARE @NewOld_Price_NDS              float          ;
						   DECLARE @NewJSON_Size_Volume           nvarchar(max)  ;
						   DECLARE @NewNew_Price_NDS              float          ;
						   DECLARE @NewNew_Price_no_NDS           float          ;
						   DECLARE @NewDate_Сreated               datetime       ;
						   DECLARE @NewDescription                nvarchar(4000) ;

							SELECT 
							    @NewID_Exemplar             	= ID_Exemplar             , 
								@NewId_Item                 	= Id_Item                 ,
								@NewID_Currency             	= ID_Currency             ,
								@NewID_Storage_location     	= ID_Storage_location     ,
								@NewKeySource               	= KeySource               ,
								@NewSerial_number           	= Serial_number           ,
								@NewID_Condition_of_the_item	= ID_Condition_of_the_item,
								@NewOld_Price_no_NDS        	= Old_Price_no_NDS        ,
								@NewRefund                  	= Refund                  ,
								@NewDate_Refund             	= Date_Refund             ,
								@NewReturn_Note             	= Return_Note             ,
								@NewOld_Price_NDS           	= Old_Price_NDS           ,
								@NewJSON_Size_Volume        	= JSON_Size_Volume        ,
								@NewNew_Price_NDS           	= New_Price_NDS           ,
								@NewNew_Price_no_NDS        	= New_Price_no_NDS        ,
								@NewDate_Сreated                = Date_Сreated            ,
								@NewDescription                 = [Description]        	  
							FROM inserted;									 

							SELECT 
							    @OldID_Exemplar             	= ID_Exemplar             ,
								@OldId_Item                 	= Id_Item                 ,
								@OldID_Currency             	= ID_Currency             ,
								@OldID_Storage_location     	= ID_Storage_location     ,
								@OldKeySource               	= KeySource               ,
								@OldSerial_number           	= Serial_number           ,
								@OldID_Condition_of_the_item	= ID_Condition_of_the_item,
								@OldOld_Price_no_NDS        	= Old_Price_no_NDS        ,
								@OldRefund                  	= Refund                  ,
								@OldDate_Refund             	= Date_Refund             ,
								@OldReturn_Note             	= Return_Note             ,
								@OldOld_Price_NDS           	= Old_Price_NDS           ,
								@OldJSON_Size_Volume        	= JSON_Size_Volume        ,
								@OldNew_Price_NDS           	= New_Price_NDS           ,
								@OldNew_Price_no_NDS        	= New_Price_no_NDS        ,
								@OldDate_Сreated                = Date_Сreated            , 
								@OldDescription                 = [Description]        	  					
							FROM Deleted;																		 

                            IF @NewId_Item  <> @OldId_Item  
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Id_Item  = Old ->"' +  ISNULL(CAST(@OldId_Item  AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewId_Item  AS NVARCHAR(20)),'') + '", ';
							   end
                            
							IF @NewID_Currency <> @OldID_Currency
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency = Old ->"' +  ISNULL(CAST(@OldID_Currency AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Currency AS NVARCHAR(20)),'') + '", ';
							   end

							IF @NewID_Storage_location <> @OldID_Storage_location
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Storage_location = Old ->"' +  ISNULL(CAST(@OldID_Storage_location AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Storage_location AS NVARCHAR(20)),'') + '", ';
							   end                  
							
							IF @NewKeySource <> @OldKeySource
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  KeySource = Old ->"' +  ISNULL(CAST(@OldKeySource AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewKeySource AS NVARCHAR(20)),'') + '", ';
							   end

							IF @NewSerial_number <> @OldSerial_number
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Serial_number = Old ->"' +  ISNULL(@OldSerial_number,'') + ' " NEW -> "' + isnull(@NewSerial_number,'') + '", ';
							   end

							IF @NewID_Condition_of_the_item <> @OldID_Condition_of_the_item
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Condition_of_the_item = Old ->"' +  ISNULL(CAST(@OldID_Condition_of_the_item AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Condition_of_the_item AS NVARCHAR(20)),'') + '", ';
							   end

							IF @NewOld_Price_no_NDS <> @OldOld_Price_no_NDS
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Old_Price_no_NDS = Old ->"' +  ISNULL(CAST(@OldOld_Price_no_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewOld_Price_no_NDS AS NVARCHAR(50)),'') + '", ';
							   end

                            IF @NewRefund <> @OldRefund
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Refund = Old ->"' +  ISNULL(CAST(@OldRefund AS NVARCHAR(1)),'') + ' " NEW -> "' + isnull(CAST(@NewRefund AS NVARCHAR(1)),'') + '", ';
							   end

                            IF @NewDate_Refund <> @OldDate_Refund
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Refund = Old ->"' +  ISNULL(CAST(Format(@OldDate_Refund,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Refund,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end
                            -----
							IF @NewReturn_Note <> @OldReturn_Note
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Return_Note = Old ->"' +  ISNULL(@OldReturn_Note,'') + ' " NEW -> "' + isnull(@NewReturn_Note,'') + '", ';
							   end
                            
							IF @NewOld_Price_NDS <> @OldOld_Price_NDS
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Old_Price_NDS = Old ->"' +  ISNULL(CAST(@OldOld_Price_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewOld_Price_NDS AS NVARCHAR(50)),'') + '", ';
							   end

							IF @NewJSON_Size_Volume <> @OldJSON_Size_Volume
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  JSON_Size_Volume = Old ->"' +  ISNULL(CAST(@OldJSON_Size_Volume AS NVARCHAR(max)),'') + ' " NEW -> "' + isnull(CAST(@NewJSON_Size_Volume AS NVARCHAR(max)),'') + '", ';
							   end
                            
							IF @NewNew_Price_NDS <> @OldNew_Price_NDS
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  New_Price_NDS = Old ->"' +  ISNULL(CAST(@OldNew_Price_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewNew_Price_NDS AS NVARCHAR(50)),'') + '", ';
							   end

							IF @NewNew_Price_no_NDS <> @OldNew_Price_no_NDS
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  New_Price_no_NDS = Old ->"' +  ISNULL(CAST(@OldNew_Price_no_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewNew_Price_no_NDS AS NVARCHAR(50)),'') + '", ';
							   end
                            
							IF @NewDate_Сreated <> @OldDate_Сreated
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Сreated = Old ->"' +  ISNULL(CAST(Format(@OldDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end

                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> "' + ISNULL(@NewDescription,'') + '",';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Exemplar = "' +  isnull(cast(@OldID_Exemplar as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Exemplar_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Exemplar_Audit
                            ( 
                               ID_Exemplar       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Exemplar
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

		                   DECLARE @OldID_Exemplar_2                bigint         ;
						   DECLARE @OldId_Item_2                    bigint         ;
						   DECLARE @OldID_Currency_2                bigint         ;
						   DECLARE @OldID_Storage_location_2        bigint         ;
						   DECLARE @OldKeySource_2                  bigint         ;
						   DECLARE @OldSerial_number_2              nvarchar(500)  ;
						   DECLARE @OldID_Condition_of_the_item_2   bigint         ;
						   DECLARE @OldOld_Price_no_NDS_2           float          ;
						   DECLARE @OldRefund_2                     bit            ;
						   DECLARE @OldDate_Refund_2                datetime       ;
						   DECLARE @OldReturn_Note_2                nvarchar(4000) ;
						   DECLARE @OldOld_Price_NDS_2              float          ;
						   DECLARE @OldJSON_Size_Volume_2           nvarchar(max)  ;
						   DECLARE @OldNew_Price_NDS_2              float          ;
						   DECLARE @OldNew_Price_no_NDS_2           float          ;
						   DECLARE @OldDate_Сreated_2               datetime       ;
						   DECLARE @OldDescription_2                nvarchar(4000) ;    	  	

                            SELECT 
							    @OldID_Exemplar_2             	  = ID_Exemplar              ,
								@OldId_Item_2                 	  = Id_Item                  ,
								@OldID_Currency_2             	  = ID_Currency              ,
								@OldID_Storage_location_2     	  = ID_Storage_location      ,
								@OldKeySource_2               	  = KeySource                ,
								@OldSerial_number_2           	  = Serial_number            ,
								@OldID_Condition_of_the_item_2	  = ID_Condition_of_the_item ,
								@OldOld_Price_no_NDS_2        	  = Old_Price_no_NDS         ,
								@OldRefund_2                  	  = Refund                   ,
								@OldDate_Refund_2             	  = Date_Refund              ,
								@OldReturn_Note_2             	  = Return_Note              ,
								@OldOld_Price_NDS_2           	  = Old_Price_NDS            ,
								@OldJSON_Size_Volume_2        	  = JSON_Size_Volume         ,
								@OldNew_Price_NDS_2           	  = New_Price_NDS            ,
								@OldNew_Price_no_NDS_2        	  = New_Price_no_NDS         ,
								@OldDate_Сreated_2                = Date_Сreated             ,
								@OldDescription_2                 = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Exemplar'             +' = "'+  ISNULL(CAST(@OldID_Exemplar_2     AS NVARCHAR(20)),'')+ '", '
							+ 'Id_Item'                 +' = "'+  ISNULL(CAST(@OldId_Item_2  AS NVARCHAR(20)),'')+ '", '
							+ 'ID_Currency'             +' = "'+  ISNULL(CAST(@OldID_Currency_2 AS NVARCHAR(20)),'') + '", '
							+ 'ID_Storage_location'     +' = "'+  ISNULL(CAST(@OldID_Storage_location_2 AS NVARCHAR(20)),'') + '", '
							+ 'KeySource'               +' = "'+  ISNULL(CAST(@OldKeySource_2 AS NVARCHAR(50)),'')+ '", '				
							+ 'Serial_number'           +' = "'+  ISNULL(@OldSerial_number_2,'')+ '", '
							+ 'ID_Condition_of_the_item'+' = "'+  ISNULL(CAST(@OldID_Condition_of_the_item_2 AS NVARCHAR(20)),'') + '", '
							+ 'Old_Price_no_NDS'        +' = "'+  ISNULL(CAST(@OldOld_Price_no_NDS_2 AS NVARCHAR(50)),'')+ '", '
							+ 'Refund'                  +' = "'+  ISNULL(CAST(@OldRefund_2 AS NVARCHAR(1)),'') + '", '
							+ 'Date_Refund'             +' = "'+  ISNULL(CAST(Format(@OldDate_Refund_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							+ 'Return_Note'             +' = "'+  ISNULL(@OldReturn_Note_2,'')+ '", '
							+ 'Old_Price_NDS'           +' = "'+  ISNULL(CAST(@OldOld_Price_NDS_2 AS NVARCHAR(50)),'') + '", '
							+ 'JSON_Size_Volume'        +' = "'+  ISNULL(CAST(@OldJSON_Size_Volume_2 AS NVARCHAR(MAX)),'') + '", '
							+ 'New_Price_NDS'           +' = "'+  ISNULL(CAST(@OldNew_Price_NDS_2 AS NVARCHAR(50)),'') + '", '
							+ 'New_Price_no_NDS'        +' = "'+  ISNULL(CAST(@OldNew_Price_no_NDS_2 AS NVARCHAR(50)),'') + '", '
							+ 'Date_Сreated'            +' = "'+  ISNULL(CAST(Format(@OldDate_Сreated_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
            				+ 'Description'             +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

							IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Exemplar_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Exemplar_Audit
                    ( 
                          ID_Exemplar  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Exemplar
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Exemplar_3 BIGINT;
                    SELECT @ID_Exemplar_3 = ID_Exemplar FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Exemplar = "' + CAST(@ID_Exemplar_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Exemplar_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit


