begin tran
     exec RandomFIO @gender = 2
--rollback
commit

--��������� ��� 2 - �������, 1 - �������