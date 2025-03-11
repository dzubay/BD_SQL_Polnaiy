set nocount,xact_abort on
go


create procedure RandomLogin
(
 @Reportstart int,
 @Reportend int,
 @RandomLogin nvarchar(max) output
)
as
begin 
    declare @Length int = round(@Reportstart + rand() * @Reportend, 0);
    declare @Characters nvarchar(200) = 
           'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +          -- английские заглавные буквы
           'abcdefghijklmnopqrstuvwxyz' +          -- английские строчные буквы
           'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ' +   -- русские заглавные буквы
           'абвгдеёжзийклмнопрстуфхцчшщъыьэюя' +   -- русские строчные буквы
           ' ,.;:!?-_+/\@#№$%^&*()';               -- Символы
    declare @Result nvarchar(max) = '';
    while len(@Result) < @Length
        begin
            set @Result = @Result + substring(@Characters, cast(round(1+ rand() * 140, 0)as int) % len(@Characters) + 1, 1);
        end
	set  @RandomLogin = @Result;
end


--declare @RandomLogin nvarchar(max)
--exec RandomLogin 10,20,  @RandomLogin output
--select  @RandomLogin