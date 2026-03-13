use tutorialdb;
drop table if exists ownership;                                           # make sure to first drop tables that reference anything
drop table if exists friendship;
drop table if exists things;
drop table if exists people;

create table if not exists people (
p_id int primary key auto_increment,
p_name varchar(255),
p_age int,
p_height float,
p_gender enum('female','male')
);

# relationships: 
# 1:1 (1 to 1 = a person can own 1 thing and 1 thing can be owned by 1 person)
# 1:n (1 to many = 1 person can own multiple things but thing can be owned by 1 person)
# n:1 (many to 1 = 1 person can own 1 thing but things can be owned by multiple people)
# n:m (many to many = multiple people can own multiple things, and multiple things can be owned by multiple people)

create table if not exists things (
	t_id int primary key auto_increment,
    t_name varchar(255) not null,
    t_description varchar(255),
    t_owner integer,
    foreign key (t_owner) references people (p_id)                              # key of another table; 1:n relationship bc we have 1 owner here for each row
																				# to have 1:1 you need to make "t_owner integer unique"
                                                                                # to have n:1 you need to remove "t_owner integer" and add p_thing as foreign key into people table
                                                                                # to have n:m you need to remove "t_owner integer" and make a 3rd table ownership (shown below)
									
);

create table if not exists ownership (
	o_owner integer,
    o_thing integer,
    primary key(o_owner,o_thing),													# combination of o_owner & o_thing has to be unique and becomes primary key
	foreign key(o_owner) references people (p_id),
    foreign key (o_thing) references things (t_id)
);

insert into people (p_name, p_age, p_height, p_gender) values
('Alice', 25, 165.5, 'female'),
('Bob', 31, 178.2, 'male'),
('Charlie', 22, 182.0, 'male'),
('Diana', 28, 170.3, 'female'),
('Ethan', 35, 175.1, 'male'),
('Farida', 27, 168.4, 'female'),
('George', 40, 180.0, 'male'),
('Hanna', 24, 162.7, 'female'),
('KarlMarx', 40, 180.0, 'male')
;

insert into things (t_name, t_description, t_owner) values
('Laptop', 'MacBook Pro', 1),
('Phone', 'iPhone 14', 1),
('Bike', 'Mountain bike', 2),
('Camera', 'Sony mirrorless camera', 3),
('Headphones', 'Noise cancelling', 4),
('Gaming Console', 'PlayStation 5', 5),
('Tablet', 'iPad Air', 6),
('Watch', 'Smart watch', 2),
('Drone', 'Photography drone', 3),
('Speaker', 'Bluetooth speaker', 7),
('matlab fan base subscription', 'fan pass', null);

insert into ownership (o_owner, o_thing) values
(1,3),
(2,3),
(3,4),
(4,4),
(5,6),
(1,6),
(6,7),
(7,7),
(8,2),
(3,10);

select p_name, t_name from people join things on people.p_id = things.t_owner;              # default inner join = only people that own something and things that are owned by someone are shown
select p_name, t_name from people left join things on people.p_id = things.t_owner;              # left outer join = all people are shown but only things that are owned by someone are shown
select p_name, t_name from people right join things on people.p_id = things.t_owner;              # right outer join = all things are shown but only people that own something are shown

# note: ctrl + return makes current line execute
# ctrl + shift + return makes entire script execute

select p_name, t_name from people cross join things;									# every possible people matched with every posible thing (even if it doesn't actually have a relationship)

# shows all pairs of people that own the same thing
select p1.p_name as Person1, p2.p_name as Person2, t_name as SharedThing
from ownership o1
join ownership o2 on o1.o_thing = o2.o_thing and o1.o_owner <> o2.o_owner
join people p1 on o1.o_owner = p1.p_id
join people p2 on o2.o_owner = p2.p_id
join things t on o1.o_thing = t.t_id;

create table if not exists friendship (
f_friend1 integer,
f_friend2 integer,
primary key (f_friend1, f_friend2),
foreign key (f_friend1) references people(p_id),
foreign key (f_friend2) references people(p_id)
);

insert into friendship (f_friend1, f_friend2) values
(1,2),
(1,3),
(1,4),
(2,3),
(2,5),
(3,6),
(4,7),
(5,6),
(7,8);

# select people that are friends
select p1.p_name as Friend1, p2.p_name as Friend2						
from friendship
join people p1 on friendship.f_friend1 = p1.p_id
join people p2 on friendship.f_friend2 = p2.p_id;

# select people that are friends and own a common thing
select p1.p_name as Friend1, p2.p_name as Friend2, t.t_name as SharedThing
from friendship
join people p1 on friendship.f_friend1 = p1.p_id
join people p2 on friendship.f_friend2 = p2.p_id
join ownership o1 on p1.p_id = o1.o_owner
join ownership o2 on p2.p_id = o2.o_owner
join things t on o1.o_thing = t.t_id;

# set operations
# bc you can't do full outer join in mysql just like that, you need to use UNION operation - combines 2 queries
# UNION ALL gives you combination with duplicates shown however many times they are present
select p_name, t_name from people left join things on p_id=t_owner
union
select p_name, t_name from people right join things on p_id=t_owner;

# intersection -basically AND (in this case its inner join)
select p_name, t_name from people left join things on p_id=t_owner
intersect
select p_name, t_name from people right join things on p_id=t_owner;

# except gives only those things that are not present in both selections (note that left right vs right left will yield different results)
select p_name, t_name from people right join things on p_id=t_owner
except
select p_name, t_name from people left join things on p_id=t_owner;

# i used union on them to get things not owned by anyone and people who don't own anything
(select p_name, t_name from people right join things on p_id=t_owner
except
select p_name, t_name from people left join things on p_id=t_owner)
union
(select p_name, t_name from people left join things on p_id=t_owner
except
select p_name, t_name from people right join things on p_id=t_owner);
