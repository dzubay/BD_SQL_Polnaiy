

begin tran 

CREATE TABLE Type_of_product_measurement_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_product_measurement bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Type_of_product_measurement_Audit ON Type_of_product_measurement
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
                    INSERT  INTO dbo.Type_of_product_measurement_Audit
                            ( 
                               ID_product_measurement            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_product_measurement
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
						   DECLARE @OldID_product_measurement      bigint           ; 
						   DECLARE @OldProduct_measurement_Name    nvarchar(300)	;
						   DECLARE @OldSysProductMeasurementName   nvarchar(300)	;
	                       DECLARE @OldDescription                 nvarchar(4000)	;

                           DECLARE @NewID_product_measurement      bigint           ;
						   DECLARE @NewProduct_measurement_Name    nvarchar(300)	;
						   DECLARE @NewSysProductMeasurementName   nvarchar(300)	;
						   DECLARE @NewDescription                 nvarchar(4000)	;
                         
							SELECT 
							        @NewID_product_measurement     =  ID_product_measurement   ,
									@NewProduct_measurement_Name   =  Product_measurement_Name ,
									@NewSysProductMeasurementName  =  SysProductMeasurementName,
									@NewDescription                =  [Description]         	
							FROM inserted;									 

							SELECT 
                                    @OldID_product_measurement     =  ID_product_measurement   ,
									@OldProduct_measurement_Name   =  Product_measurement_Name ,
									@OldSysProductMeasurementName  =  SysProductMeasurementName,
									@OldDescription                =  [Description]         								
							FROM Deleted;																		 

                            IF @NewProduct_measurement_Name <> @OldProduct_measurement_Name
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Product_measurement_Name = Old ->"' +  ISNULL(CAST(@OldProduct_measurement_Name AS NVARCHAR(300)),'') + ' " NEW -> " ' + isnull(CAST(@NewProduct_measurement_Name AS NVARCHAR(300)),'') + '", ';
							   end
                            
							IF @NewSysProductMeasurementName <> @OldSysProductMeasurementName
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SysProductMeasurementName = Old ->"' +  ISNULL(CAST(@OldSysProductMeasurementName AS NVARCHAR(300)),'') + ' " NEW -> " ' + isnull(CAST(@NewSysProductMeasurementName AS NVARCHAR(300)),'') + '", ';
							   end
					
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_product_measurement ="' +  isnull(cast(@OldID_product_measurement as nvarchar(20)),'')+ '" ' + @ChangeDescription + '"'
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Type_of_product_measurement_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Type_of_product_measurement_Audit
                            ( 
                               ID_product_measurement       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_product_measurement
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

						   DECLARE @OldID_product_measurement_2      bigint         ; 
						   DECLARE @OldProduct_measurement_Name_2    nvarchar(300)	;
						   DECLARE @OldSysProductMeasurementName_2   nvarchar(300)	;
	                       DECLARE @OldDescription_2                 nvarchar(4000)	;

                            SELECT 
							    @OldID_product_measurement_2   	= ID_product_measurement    ,
								@OldProduct_measurement_Name_2 	= Product_measurement_Name  ,
								@OldSysProductMeasurementName_2 = SysProductMeasurementName ,            
								@OldDescription_2               = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_product_measurement'     +'="'+  ISNULL(CAST(@OldID_product_measurement_2 AS NVARCHAR(20)),'')     + '", '
							+ 'Product_measurement_Name'   +'="'+  ISNULL(@OldProduct_measurement_Name_2,'')     + '", '
							+ 'SysProductMeasurementName'  +'="'+  ISNULL(@OldSysProductMeasurementName_2,'')     + '", '
							+ 'Description'                +'="'+  ISNULL(@OldDescription_2  ,'') + '"'



                          update u
						  set ChangeDescription = @ChangeDescription
						  from Type_of_product_measurement_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Type_of_product_measurement_Audit
                    ( 
                          ID_product_measurement  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_product_measurement
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_product_measurement_3 BIGINT;
                    SELECT @ID_product_measurement_3 = ID_product_measurement FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_product_measurement="' + CAST(@ID_product_measurement_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Type_of_product_measurement_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit

