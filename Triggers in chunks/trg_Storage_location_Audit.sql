
begin tran 

CREATE TABLE Storage_location_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Storage_location       bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Storage_location_Audit ON Storage_location
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
                    INSERT  INTO dbo.Storage_location_Audit
                            ( 
                               ID_Storage_location            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Storage_location
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
                           DECLARE @OldID_Storage_location        bigint         ;
						   DECLARE @OldID_Type_Storage_location   bigint         ;
						   DECLARE @OldKeySource                  bigint         ;
						   DECLARE @OldName                       nvarchar(400)  ;
						   DECLARE @OldCountry                    nvarchar(200)  ;
						   DECLARE @OldCity                       nvarchar(200)  ;
						   DECLARE @OldAdress                     nvarchar(800)  ;
						   DECLARE @OldMail                       nvarchar(250)  ;
						   DECLARE @OldPhone                      nvarchar(30)   ;
						   DECLARE @OldDate_Сreated               datetime       ;
						   DECLARE @OldDescription                nvarchar(4000) ;

                           DECLARE @NewID_Storage_location        bigint         ;
						   DECLARE @NewID_Type_Storage_location   bigint         ;
						   DECLARE @NewKeySource                  bigint         ;
						   DECLARE @NewName                       nvarchar(400)  ;
						   DECLARE @NewCountry                    nvarchar(200)  ;
						   DECLARE @NewCity                       nvarchar(200)  ;
						   DECLARE @NewAdress                     nvarchar(800)  ;
						   DECLARE @NewMail                       nvarchar(250)  ;
						   DECLARE @NewPhone                      nvarchar(30)   ;
						   DECLARE @NewDate_Сreated               datetime       ;
						   DECLARE @NewDescription                nvarchar(4000) ; 
						   
							SELECT 
							    @NewID_Storage_location     	= ID_Storage_location     ,
								@NewID_Type_Storage_location	= ID_Type_Storage_location,
								@NewKeySource               	= KeySource               ,
								@NewName                    	= Name                    ,
								@NewCountry                 	= Country                 ,
								@NewCity                    	= City                    ,
								@NewAdress                  	= Adress                  ,
								@NewMail                    	= Mail                    ,
								@NewPhone                   	= Phone                   ,
								@NewDate_Сreated                = Date_Сreated            ,
								@NewDescription                 = [Description]        	  
							FROM inserted;									 

							SELECT 
							    @OldID_Storage_location     	= ID_Storage_location     ,
								@OldID_Type_Storage_location	= ID_Type_Storage_location,
								@OldKeySource               	= KeySource               ,
								@OldName                    	= Name                    ,
								@OldCountry                 	= Country                 ,
								@OldCity                    	= City                    ,
								@OldAdress                  	= Adress                  ,
								@OldMail                    	= Mail                    ,
								@OldPhone                   	= Phone                   ,
								@OldDate_Сreated                = Date_Сreated            ,
								@OldDescription                 = [Description]        	  					
							FROM Deleted;																		 

                            IF @NewID_Type_Storage_location  <> @OldID_Type_Storage_location  
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Type_Storage_location  = Old ->"' +  ISNULL(CAST(@OldID_Type_Storage_location  AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Type_Storage_location  AS NVARCHAR(20)),'') + '", ';
							   end
                            
							IF @NewKeySource <> @OldKeySource
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  KeySource = Old ->"' +  ISNULL(CAST(@OldKeySource AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewKeySource AS NVARCHAR(50)),'') + '", ';
							   end

							IF @NewName <> @OldName
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name = Old ->"' +  ISNULL(@OldName,'') + ' " NEW -> "' + isnull(@NewName,'') + '", ';
							   end                  
							
							IF @NewCountry <> @OldCountry
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Country = Old ->"' +  ISNULL(@OldCountry,'') + ' " NEW -> "' + isnull(@NewCountry,'') + '", ';
							   end

							IF @NewCity <> @OldCity
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  City = Old ->"' +  ISNULL(@OldCity,'') + ' " NEW -> "' + isnull(@NewCity,'') + '", ';
							   end

							IF @NewAdress <> @OldAdress
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Adress = Old ->"' +  ISNULL(@OldAdress,'') + ' " NEW -> "' + isnull(@NewAdress,'') + '", ';
							   end

							IF @NewMail <> @OldMail
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Mail = Old ->"' +  ISNULL(@OldMail,'') + ' " NEW -> "' + isnull(@NewMail,'') + '", ';
							   end

                            IF @NewPhone <> @OldPhone
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Phone = Old ->"' +  ISNULL(@OldPhone,'') + ' " NEW -> "' + isnull(@NewPhone,'') + '", ';
							   end

                            IF @NewDate_Сreated <> @OldDate_Сreated
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Сreated = Old ->"' +  ISNULL(CAST(Format(@OldDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end

                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> "' + ISNULL(@NewDescription,'') + '",';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Storage_location = "' +  isnull(cast(@OldID_Storage_location as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Storage_location_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Storage_location_Audit
                            ( 
                               ID_Storage_location       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Storage_location
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

							DECLARE @OldID_Storage_location_2        bigint         ;
							DECLARE @OldID_Type_Storage_location_2   bigint         ;
							DECLARE @OldKeySource_2                  bigint         ;
							DECLARE @OldName_2                       nvarchar(400)  ;
							DECLARE @OldCountry_2                    nvarchar(200)  ;
							DECLARE @OldCity_2                       nvarchar(200)  ;
							DECLARE @OldAdress_2                     nvarchar(800)  ;
							DECLARE @OldMail_2                       nvarchar(250)  ;
							DECLARE @OldPhone_2                      nvarchar(30)   ;
							DECLARE @OldDate_Сreated_2               datetime       ;
							DECLARE @OldDescription_2                nvarchar(4000) ;

                            SELECT 
							    @OldID_Storage_location_2         = ID_Storage_location     ,
								@OldID_Type_Storage_location_2	  = ID_Type_Storage_location,
								@OldKeySource_2               	  = KeySource               ,
								@OldName_2                    	  = Name                    ,
								@OldCountry_2                 	  = Country                 ,
								@OldCity_2                    	  = City                    ,
								@OldAdress_2                  	  = Adress                  ,
								@OldMail_2                    	  = Mail                    ,
								@OldPhone_2                   	  = Phone                   ,
								@OldDate_Сreated_2                = Date_Сreated            ,
								@OldDescription_2                 = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Storage_location'      +' = "'+  ISNULL(CAST(@OldID_Storage_location_2     AS NVARCHAR(20)),'')+ '", '
							+ 'ID_Type_Storage_location' +' = "'+  ISNULL(CAST(@OldID_Type_Storage_location_2  AS NVARCHAR(20)),'')+ '", '
							+ 'KeySource'                +' = "'+  ISNULL(CAST(@OldKeySource_2 AS NVARCHAR(50)),'') + '", '
							+ 'Name'                     +' = "'+  ISNULL(@OldName_2,'')+ '", '				
							+ 'Country'                  +' = "'+  ISNULL(@OldCountry_2,'')+ '", '
							+ 'City'                     +' = "'+  ISNULL(@OldCity_2,'') + '", '
							+ 'Adress'                   +' = "'+  ISNULL(@OldAdress_2,'')+ '", '
							+ 'Mail'                     +' = "'+  ISNULL(@OldMail_2,'') + '", '
							+ 'Phone'                    +' = "'+  ISNULL(@OldPhone_2,'')+ '", '
							+ 'Date_Сreated'             +' = "'+  ISNULL(CAST(Format(@OldDate_Сreated_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
            				+ 'Description'              +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

							IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Storage_location_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Storage_location_Audit
                    ( 
                          ID_Storage_location  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Storage_location
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Storage_location_3 BIGINT;
                    SELECT @ID_Storage_location_3 = ID_Storage_location FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Storage_location = "' + CAST(@ID_Storage_location_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Storage_location_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit