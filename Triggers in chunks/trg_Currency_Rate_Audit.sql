begin tran 

CREATE TABLE Currency_Rate_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Currency_Rate       bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Currency_Rate_Audit ON Currency_Rate
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
                    INSERT  INTO dbo.Currency_Rate_Audit
                            ( 
                               ID_Currency_Rate            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Currency_Rate
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
							DECLARE @OldID_Currency_Rate        bigint          ;
							DECLARE @OldID_Currency             bigint       	;
							DECLARE @OldAmount_Rate             float        	;
							DECLARE @OldValid_from              datetime     	;
							DECLARE @OldValid_to                datetime     	;
							DECLARE @OldJSON_Currency_Rate_Data nvarchar(max)	;
							DECLARE @OldDescription             nvarchar(4000)	;

							DECLARE @NewID_Currency_Rate        bigint          ;
							DECLARE @NewID_Currency             bigint       	;
							DECLARE @NewAmount_Rate             float        	;
							DECLARE @NewValid_from              datetime     	;
							DECLARE @NewValid_to                datetime     	;
							DECLARE @NewJSON_Currency_Rate_Data nvarchar(max)	;
							DECLARE @NewDescription             nvarchar(4000)	;
                         
							SELECT  
                                  @NewID_Currency_Rate         =  ID_Currency_Rate         ,
								  @NewID_Currency              =  ID_Currency              ,
								  @NewAmount_Rate              =  Amount_Rate              ,
								  @NewValid_from               =  Valid_from               ,
								  @NewValid_to                 =  Valid_to                 ,
								  @NewJSON_Currency_Rate_Data  =  JSON_Currency_Rate_Data  ,
								  @NewDescription              =  [Description]              
							FROM inserted;									 

							SELECT  
							      @OldID_Currency_Rate         =  ID_Currency_Rate         ,
								  @OldID_Currency              =  ID_Currency              ,
								  @OldAmount_Rate              =  Amount_Rate              ,
								  @OldValid_from               =  Valid_from               ,
								  @OldValid_to                 =  Valid_to                 ,
								  @OldJSON_Currency_Rate_Data  =  JSON_Currency_Rate_Data  ,
								  @OldDescription              =  [Description]              
							FROM Deleted;																		 

                            IF @NewID_Currency <> @OldID_Currency 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency = Old ->"' +  ISNULL(cast(@OldID_Currency as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewID_Currency as nvarchar(20)),'') + '", ';
							   end
                            
							IF @NewAmount_Rate <> @OldAmount_Rate
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Amount_Rate = Old ->"' +  ISNULL(cast(@OldAmount_Rate as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewAmount_Rate as nvarchar(20)),'') + '", ';
							   end
							
							   				
							IF @NewValid_from <> @OldValid_from
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Valid_from = Old ->"' +  ISNULL(CAST(Format(@OldValid_from,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewValid_from,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end
							
													   				
							IF @NewValid_to <> @OldValid_to
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Valid_to = Old ->"' +  ISNULL(CAST(Format(@OldValid_to,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewValid_to,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end

							IF @NewJSON_Currency_Rate_Data <> @OldJSON_Currency_Rate_Data
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  JSON_Currency_Rate_Data = Old ->"' +  ISNULL(CAST(@OldAmount_Rate AS NVARCHAR(max)),'') + ' " NEW -> " ' + isnull(CAST(@NewAmount_Rate AS NVARCHAR(max)),'') + '", ';
							   end

                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Currency_Rate = "' +  isnull(cast(@OldID_Currency_Rate as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Currency_Rate_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Currency_Rate_Audit
                            ( 
                               ID_Currency_Rate       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Currency_Rate
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

							DECLARE @OldID_Currency_Rate_2        bigint          ;
							DECLARE @OldID_Currency_2             bigint       	  ;
							DECLARE @OldAmount_Rate_2             float        	  ;
							DECLARE @OldValid_from_2              datetime     	  ;
							DECLARE @OldValid_to_2                datetime     	  ;
							DECLARE @OldJSON_Currency_Rate_Data_2 nvarchar(max)	  ;
							DECLARE @OldDescription_2             nvarchar(4000)  ;

                            SELECT
							    @OldID_Currency_Rate_2        = ID_Currency_Rate       	 ,
								@OldID_Currency_2             = ID_Currency            	 ,
								@OldAmount_Rate_2             = Amount_Rate           	 ,
								@OldValid_from_2              = Valid_from             	 ,
								@OldValid_to_2                = Valid_to               	 ,
								@OldJSON_Currency_Rate_Data_2 = JSON_Currency_Rate_Data  ,
								@OldDescription_2             = [Description]            
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Currency_Rate'         +'="'+  ISNULL(CAST(@OldID_Currency_Rate_2 AS NVARCHAR(50)),'')     + '", '
							+ 'ID_Currency'              +'="'+  ISNULL(CAST(@OldID_Currency_2 AS NVARCHAR(50)),'')     + '", '
							+ 'Amount_Rate'              +'="'+  ISNULL(cast(@OldAmount_Rate_2 as nvarchar(20)),'')+ '", '	
							+ 'Valid_from'               +'="'+  ISNULL(CAST(Format(@OldValid_from_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							+ 'Valid_to'                 +'="'+  ISNULL(CAST(Format(@OldValid_to_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							+ 'JSON_Currency_Rate_Data'  +'="'+  ISNULL(cast(@OldJSON_Currency_Rate_Data_2 as nvarchar(max)),'')+ '", '
							+ 'Description'              +'="'+  ISNULL(@OldDescription_2  ,'') + '", '

                          IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Currency_Rate_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Currency_Rate_Audit
                    ( 
                          ID_Currency_Rate  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Currency_Rate
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Currency_Rate_3 BIGINT;
                    SELECT @ID_Currency_Rate_3 = ID_Currency_Rate FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Currency_Rate = "' + CAST(@ID_Currency_Rate_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Currency_Rate_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit
