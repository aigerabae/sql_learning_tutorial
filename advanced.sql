USE tutorialdb;
drop table if exists people;
create table if not exists people (
p_id integer primary key auto_increment,			# primary key is increased by 1 fo every new entry
p_name varchar(255) not null,					    # have to provide name for each entry even tho its not primary key 
p_age integer default 21,							# if not provided will be 21
p_height int,
p_gender enum('male','female')
);

insert into people (p_name, p_age, p_height, p_gender) values 
('mike',21,176,'male'),
('anna',45,167,'female'),
('lisa',76,188,'female'),
('roberta',11,170,'female'),
('jeff',66,188,'male'),
('angela',34,156,'female'),
('sam',19,187,'male'),
('sam',19,187,'male'),
('sam',19,187,'male'),
('kate',23,141,'female');

#select distinct p_age from people;					# shows unique entries in p_age
#select distinct p_age, p_gender from people;					# shows unique entries in p_age + p_gender combination

select * from people;
#select * from people where p_age in (21,45);          ### where p_age is exactly 21 or 45
#select * from people where p_name like '%a';          ### where p_name ends with a
#select * from people where p_name like 'm%';          ### where p_name starts with m
#select * from people where p_name like '%e%';          ### where p_name contains e

#select p_name as 'Name', p_age as 'Age' from people where p_name like '%e%';          # shows those columns under custom names
# select sum(p_age) from people;						### aggregate funcion shows sum of all values in p_age; 
														# can also use min, mac, count, avg
#select avg(p_height) from people where p_gender = 'Male';
#select avg(p_height) from people where p_gender = 'Female';
#select p_gender, avg(p_height) from people group by p_gender;           # does the same aS ABOVE BUT SHORTER - GROUPS BY P_GENDER
#select p_gender, p_age, avg(p_height) from people group by p_gender, p_age;           # can group by combination of multiple groups

#select * from people order by p_age desc,p_name desc;             # ordered by age and the by name and age both descending
select * from people order by p_age desc,p_name desc limit 5;             # only shows the first 5 entries