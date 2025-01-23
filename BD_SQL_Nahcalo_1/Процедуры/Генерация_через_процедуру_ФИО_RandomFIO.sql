begin tran
     exec RandomFIO @gender = 2
--rollback
commit

--Указываем Пол 2 - Женский, 1 - Мужской