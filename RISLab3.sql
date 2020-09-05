--������� 2 ������������ + ����������
--system_connection
create user KNV identified by natashakasper;
grant all privileges to KNV; 

create user KNV1 identified by natasha1;
grant all privileges to KNV1;

--������� connection
--lab3_ris1 - KNV(natashakasper)
--lab3_ris2 - KNV1(natasha1)

--������� 2 ������� �� 2 ��������
--lab3_ris1
drop table XXX;
create table XXX(
  x int primary key
);

--lab3_ris2
drop table YYY;
create table YYY(
  y int primary key
);

--������� dblink ���� user1-user1 ����� ������� �� ������ �
--lab3_ris1
CREATE DATABASE LINK knv1_db 
   CONNECT TO KNV1
   IDENTIFIED BY natasha1
   USING 'DESKTOP-4K3JN12:1521/orcl';
   
Select * from YYY@knv1_db;
 
--insert - insert   
begin
   INSERT INTO YYY@knv1_db values(1);
   INSERT INTO XXX values(1);
   Commit;
end;
select * from XXX;
select * from YYY@knv1_db;

--insert-update   
begin
   insert into XXX values(3);
   update YYY@knv1_db SET y=2 where y=1;
   commit;
end;
select * from XXX;
select * from YYY@knv1_db;

--update-insert
begin
   insert into YYY@knv1_db values(3);
   update XXX set x=4 where x=1;
   commit;
end;
select * from XXX;
select * from YYY@knv1_db;

--��������� ������������ �� ��������� �������
begin
   insert into XXX values(5);
   insert into YYY@knv1_db values(3);
end;

--��������� ������������
begin
   insert into XXX values(5);
   update YYY@knv1_db set y ='x' where y = 2;
end;
  
--������������� � ����� ������� ������������ �������  
begin
   delete YYY@knv1_db;
   update YYY set y ='x' where y = 2;
end;  
  
--�������� �������   
begin
   delete XXX;
   delete YYY@knv1_db;
end;
select * from xxx;
select * from YYY@knv1_db;
