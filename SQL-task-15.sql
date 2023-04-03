create database task15
use task15
--TABLE CREATION
Create table students(sid int identity(1,1),sname varchar(20),department varchar(20), yearofcompletion int) 
--TABLE INSERTION
insert into students 
values('Harshan','IT',2023),
('vasanth','CT',2024),
('vikram','CT',2024),
('karthi','IT',2023),
('harita','CT',2023),
('ranita','IT',2024),
('hari','CT',2023),
('hemanth','CT',2024),
('Yamini','IT',2023),
('sharon','IT',2023),
('vignesh','CT',2024),
('venkit','CT',2023),
('dhana','IT',2024),
('selva','CT',2023),
('divyaprakash','IT',2024),
('harishmitha','IT',2023),
('arun','CT',2024),
('srikanth','IT',2024),
('dharsan','IT',2024),
('siva','CT',2023)
--SELECT QUERY
select * from students;
--TRUNCATE TABLE
truncate table students;
--DROP TABLE
drop table students;

--1. Auto-commit and Auto-rollback transactions.
--Auto-commit
Begin Tran
UPDATE students 
SET    department = 'ICT'
WHERE  sid = 2
SELECT @@TRANCOUNT AS no_of_transactions
--Auto-rollback 
Begin Tran 
insert into students values('Dhilip','CT',2023)
select * from students;
commit tran
UPDATE students set sname=123 where sid=1;


--2. Implicit transactions
SET IMPLICIT_TRANSACTIONS ON 
UPDATE students set sname='jeya' where sid=1;
SELECT 
    IIF(@@OPTIONS & 2 = 2, 
    'Implicit Mode ON', 
    'Implicit Mode OFF'
    ) as 'Transaction Mode' 
SELECT @@TRANCOUNT AS Done_Tran_Before_Commit  
COMMIT TRAN 
--UPDATE students set sname='dummy' where sid=2;
SELECT @@TRANCOUNT AS Done_Tran_After_Commit
SET IMPLICIT_TRANSACTIONS OFF
select * from students;
--3. Explicit transactions
--a. Only Commit - insert statement
begin tran
insert into students values('sanjeev','BCA',2025)
select* from students;
select @@TRANCOUNT as Transaction_count
commit tran
insert into students values('santhosh','CA',2025)
select @@TRANCOUNT as Transaction_count

--b. Only Rollback - update statement
begin tran
update students set yearofcompletion=2002 where sid=1;
select * from students;
rollback tran
select * from students;

--c. Savepoint - commit update and insert statements, rollback delete statement
BEGIN TRANSACTION 
DELETE students WHERE sid=2;
SAVE TRANSACTION transpoint
INSERT INTO students 
VALUES('nakul','BCOM',2023)
update students set yearofcompletion=2002 where sid=1;
ROLLBACK TRANSACTION transpoint
commit
SELECT * FROM students; 