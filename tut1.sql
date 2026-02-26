SHOW DATABASES;                  ### you don't have to use uppercase; show databases would work as well, the upper case is just a convention
CREATE DATABASE IF NOT EXISTS tutorialdb;   ### ";" is necesary to end line
#CREATE DATABASE tutorialdb;     ### if i just run this code without if statement it will result in an error because it runs the entire script, not just a line, so if you already have a database it won't allow ou to create a new database
USE tutorialdb;                  ### to choose database for showing tables inside it
SHOW TABLES;                     ### show list of tables inside that database
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
SHOW TABLES;

SELECT p_id, p_name, p_height FROM people;              ### selecting only those 3 columns and printing it
SELECT * FROM people;                                   ### selecting all columns from that table and printing it; 
														### can also select from multiple tables after FROM
                                                        
ALTER TABLE people                                      ### NOTE NO ";" - this is technically the same line
ADD COLUMN p_city TEXT;                                        ### adds new column to people table

SELECT * FROM people;                                  ###note that after each request in the script it prints as separate tab in results 

INSERT INTO people (P_ID, P_NAME) VALUES (1, "Mike");         ### adding new row into people with values p_id and p_name; note it's not case-sensitive; also note that other fields will just be null
INSERT INTO people  VALUES (2, 32, "034GH","Anna","Random text","java",175.6,15.6666,45.899999,TRUE,"2002-09-30","15:52",'2025-02-23 17:02:00','2025-02-23 17:02:10',"Astana");   ### i had to enter all values if i don't specify columns
														### note that primary key has to be added when you insert
INSERT INTO people (P_ID, P_NAME) VALUES                ### adding multiple rows with the same columns
(3, "Alen"),
(4, "Ainur"),
(5, "Aygerim");

SELECT * FROM people;                                  