# i commented out all select staements because when there are too many it gives too many results and it overwhelmes my computer
#SHOW DATABASES;                  ### you don't have to use uppercase; show databases would work as well, the upper case is just a convention
CREATE DATABASE IF NOT EXISTS tutorialdb;   ### ";" is necesary to end line
#CREATE DATABASE tutorialdb;     ### if i just run this code without if statement it will result in an error because it runs the entire script, not just a line, so if you already have a database it won't allow ou to create a new database
USE tutorialdb;                  ### to choose database for showing tables inside it
#SHOW TABLES;                     ### show list of tables inside that database
DROP TABLE IF EXISTS people;                ### deleting a table that was created to run this code anew without an error
CREATE TABLE IF NOT EXISTS people (
	p_id INTEGER PRIMARY KEY,             ### p_id becomes a column with integer format that serves as a primary key - unique and can't be null/empty
											### you cannot have multiple primary keys in 1 table! only 1
	p_age INT,
	p_ssn CHAR(32),                ### social security number is a string o length 32; charachter is fixed size always and its faster than TEXT
    p_name VARCHAR(255),              	### variable size string of maximum size 32
    pid2 TEXT,                      ### when you have lareg texts
    pid3 ENUM('C++','Python','Java'),    ### an item from this specific list
    p_height FLOAT,                    ### floating point apprximation
    pid5 DOUBLE,                     ### floating point apprximation but more precise than FLOAT
    PID6 DECIMAL,                       ### has an exact value (precise)
    pid7 BOOLEAN,
    pid8 DATE,
    pid9 TIME,
    pid10 DATETIME,
    pid11 TIMESTAMP
    # and some others but the ones above are the most important
);
#SHOW TABLES;

#SELECT p_id, p_name, p_height FROM people;              ### selecting only those 3 columns and printing it
#SELECT * FROM people;                                   ### selecting all columns from that table and printing it; 
														### can also select from multiple tables after FROM
                                                        
ALTER TABLE people                                      ### NOTE NO ";" - this is technically the same line
ADD COLUMN p_city TEXT;                                        ### adds new column to people table

#SELECT * FROM people;                                  ###note that after each request in the script it prints as separate tab in results 

INSERT INTO people (P_ID, P_NAME) VALUES (1, "Mike");         ### adding new row into people with values p_id and p_name; note it's not case-sensitive; also note that other fields will just be null
INSERT INTO people  VALUES (2, 32, "034GH","Anna","Random text","java",175.6,15.6666,45.899999,TRUE,"2002-09-30","15:52",'2025-02-23 17:02:00','2025-02-23 17:02:10',"Astana");   ### i had to enter all values if i don't specify columns
														### note that primary key has to be added when you insert
INSERT INTO people (P_ID, P_NAME, p_height,p_age) VALUES                ### adding multiple rows with the same columns
(3, "Mike",188,18),
(4, "Anna",170,48),
(5, "Aysha",175,23),
(6, "Ben", 160,12),
(7, "Rory",177,56),
(8, "Jeso",145,34),
(9, "Pablo",175,56),
(10, "Aysha",145,67);

#SELECT * FROM people;    

#SELECT p_name, p_age, p_height FROM people WHERE p_height > 165;           ### selects people with p_heght > 165
#SELECT p_name, p_age, p_height FROM people WHERE p_height = 160;    		   ### only those exactly 160
#SELECT p_name, p_age, p_height FROM people WHERE p_height <> 175;    		   ### only those not equal to 175
#SELECT p_name, p_age, p_height FROM people WHERE p_height IS NOT NULL;    		   ### only those that are not empty
#SELECT p_name, p_age, p_height FROM people WHERE p_height IS NOT NULL AND p_age > 40;    		   ### only those that are not empty and age is >40
#SELECT p_name, p_age, p_height FROM people WHERE p_height IS NOT NULL OR p_age > 40;    		   ### only those that are not empty or age is >40
#SELECT p_name, p_age, p_height FROM people WHERE p_height IS NOT NULL XOR p_age > 40;    		   ### only those that are either not empty or age is >40 (but not both)

UPDATE people SET p_age  = 30, p_height = 190, p_city = "Almaty" WHERE p_id = 1;         ### adding new values to p_id 1
#SELECT * FROM people;

SET SQL_SAFE_UPDATES = 0;																	### prevents deleting records not based on primary key or index; 0 allows it
DELETE FROM people WHERE p_height < 175;														### removes those with heughtt < 175
#SELECT * FROM people;

INSERT INTO people (p_id, p_name, p_height) VALUES (10, "James", 178.23);
#SELECT * FROM people;

ALTER TABLE people MODIFY COLUMN p_height INTEGER;            ### ROUNDS UP ALL P_HEIGTH VALUES
#SELECT * FROM people;

ALTER TABLE people RENAME COLUMN p_height TO p_rounded_height;      ### renames column 
#SELECT * FROM people;

ALTER TABLE people ADD COLUMN p_weight FLOAT;						### ADDS A NEW COLUMN (EMPTY FOR NOW)
ALTER TABLE people DROP COLUMN p_weight;						### REMOVES THAT COLUMN 

truncate table people;											### removes data but keeps columns
drop table people;												### removes table entirely
drop table if exists people;								    ### removes table if exists (so it doesn't get the error)

# constraints
create table if not exists people (
p_id integer primary key auto_increment,							# primary key
p_name varchar(255) not null,					    # have to provide name for each entry even tho its not primary key 
p_age integer default 21,							# if not provided will be 21
p_ssn char(32) unique,								# if present has to be unique
constraint age_constraint check (p_age >= 0 and  p_age < 200)    # range for age entries
);

insert into people (p_id, p_name) values (1,"Mike");
#insert into people (p_id, p_name) values (1,"Jane");    # would give error because primary key has to be unique
insert into people (p_id, p_name, p_age, p_ssn) values (2,"Jane",25,"AH4578");    
#insert into people (p_id, p_name, p_age, p_ssn) values (3,"Angela",25,"AH4578");    # violates unique constraint on p_ssn
insert into people (p_id, p_name, p_age, p_ssn) values (3,"Angela",25,"AH4579");    
#insert into people (p_id, p_name, p_age, p_ssn) values (4,"John",-15,"AH4579");    # violates age constraint

# adding constrain increment of id
drop table people;
create table if not exists people (
p_id integer primary key auto_increment,			# primary key is increased by 1 fo every new entry
p_name varchar(255) not null,					    # have to provide name for each entry even tho its not primary key 
p_age integer default 21,							# if not provided will be 21
p_ssn char(32) unique,								# if present has to be unique
constraint age_constraint check (p_age >= 0 and  p_age < 200)    # range for age entries
);
insert into people (p_name, p_age, p_ssn) values ("Ruby",25,"AH4589");    

# adding constraint to have unique combination of firstname + lastname
drop table people;
create table if not exists people (
p_id integer primary key auto_increment,			# primary key is increased by 1 fo every new entry
p_firstname varchar(255) not null,					    # have to provide name for each entry even tho its not primary key 
p_lastname varchar(255) not null,					    # have to provide name for each entry even tho its not primary key 
p_age integer default 21,							# if not provided will be 21
p_ssn char(32) unique,								# if present has to be unique
constraint age_constraint check (p_age >= 0 and  p_age < 200),    # range for age entries
constraint name_constraint unique(p_firstname, p_lastname)
);
#insert into people (p_firstname, p_lastname) values ("Ruby","Rose"), ("Martha","Rose"),("Ruby","Stewart"),("Ruby","Rose");                 # doesn't wprk because duplicate entry for combo firstname + lastname
insert into people (p_firstname, p_lastname) values ("Ruby","Rose"), ("Martha","Rose"),("Ruby","Stewart");                
select * from people