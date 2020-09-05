--создать 2 пользователя + привилегии
--system_connection
create user KNV identified by natashakasper;
grant all privileges to KNV; 

create user KNV1 identified by natasha1;
grant all privileges to KNV1;

--создаем connection
--lab3_ris1 - KNV(natashakasper)
--lab3_ris2 - KNV1(natasha1)

--создать 2 таблицы на 2 серверах
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

--создать dblink типа user1-user1 между юзерами на разных С
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

--нарушение уникальности на удаленном сервере
begin
   insert into XXX values(5);
   insert into YYY@knv1_db values(3);
end;

--нарушение уникальности
begin
   insert into XXX values(5);
   update YYY@knv1_db set y ='x' where y = 2;
end;
  
--заблокируется и будет ожидать освобождения ресурса  
begin
   delete YYY@knv1_db;
   update YYY set y ='x' where y = 2;
end;  
  
--очистить таблицы   
begin
   delete XXX;
   delete YYY@knv1_db;
end;
select * from xxx;
select * from YYY@knv1_db;
