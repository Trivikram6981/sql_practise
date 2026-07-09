CREATE DATABASE Demo_db;
CREATE TABLE Demo_db.Student_tb(
id INT,
name VARCHAR(169)
);
SELECT * FROM Demo_db.Student_tb;
INSERT INTO Demo_db.Student_tb(student_id,name)
VALUES(13,'Carl');
ALTER TABLE Demo_db.Student_tb
ADD contact INT;
ALTER TABLE Demo_db.Student_tb
RENAME COLUMN student_id TO id;
ALTER TABLE Demo_db.student_tb
ADD PRIMARY KEY(id);
INSERT INTO Demo_db.Student_tb(id,name,contact)
VALUES(12,'Nick',2345671);
UPDATE Demo_db.Student_tb
SET contact=987465384
WHERE id=13;
INSERT INTO Demo_db.Student_tb(id,contact,name)
VALUES(14,7836454,'Luke');
DELETE FROM Demo_db.Student_tb WHERE contact=7836454;
CREATE TABLE Demo_db.subj_tb(
apl_no INT PRIMARY KEY,
Subj VARCHAR(69),
FOREIGN KEY (apl_no) REFERENCES Student_tb(id)
ON DELETE RESTRICT
ON UPDATE CASCADE
);
INSERT INTO Demo_db.subj_tb(apl_no,subj)
VALUES(12,'math,sci,eng'),(13,'ns,ps,cs');
SELECT * FROM Demo_db.subj_tb;
INSERT INTO Demo_db.Student_tb(id,name)
VALUES(14,'mse'),(15,'spc');
INSERT INTO Demo_db.subj_tb(apl_no,subj)
VALUES(15,'k'),(14,'k');
INSERT INTO Demo_db.subj_tb(apl_no,subj)
VALUES(18,'k'),(17,'k');
DROP TABLE Demo_db.Subj_tb;
CREATE TABLE Demo_db.constraints_tb(
country VARCHAR(30) DEFAULT 'USA',
id INT PRIMARY KEY,
mail_id VARCHAR(30) NOT NULL,
age INT CHECK(age>=18),
Contact INT UNIQUE
);
INSERT INTO Demo_db.constraints_tb(id,mail_id,age,Contact)
Values(1,'1email',19,11111);
INSERT INTO Demo_db.constraints_tb(country,id,mail_id,age,Contact) 
Values('France',2,'2email',16,2222);
INSERT INTO Demo_db.constraints_tb(country,id,mail_id,age,Contact) 
Values('germany',3,'2email',19,2222);
SELECT * FROM Demo_db.constraints_tb;
INSERT INTO Demo_db.constraints_tb(id,mail_id,age,Contact)
Values(1,'1email',19,11111);