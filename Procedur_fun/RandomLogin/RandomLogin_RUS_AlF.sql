set nocount,xact_abort on
go


create procedure RandomLogin_RUS_AlF
(
 @Reportstart int,
 @Reportend int,
 @RandomLogin nvarchar(max) output
)
as
begin 
    declare @Length int = round(@Reportstart + rand() * @Reportend, 0);
    declare @Characters nvarchar(200) = 
           'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';   -- русские заглавные буквы

    declare @Result nvarchar(max) = '';
    while len(@Result) < @Length
        begin
            set @Result = @Result + substring(@Characters, cast(round(1+ rand() * 140, 0)as int) % len(@Characters) + 1, 1);
        end
	set  @RandomLogin = @Result;
end


--declare @RandomLogin nvarchar(max)
--exec RandomLogin_RUS_AlF 2,0,  @RandomLogin output
--select  @RandomLogin