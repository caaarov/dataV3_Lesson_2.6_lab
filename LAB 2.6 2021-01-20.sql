use sakila;

#1. Get release years.
SELECT* from sakila.film;
SELECT DISTINCT(release_year) from sakila.film;

#2. Get all films with ARMAGEDDON in the title.
SELECT title FROM sakila.film 
where title like '%Armageddon%';

SELECT count(title) FROM sakila.film 
where title like '%Armageddon%';

#3. Get all films which title ends with APOLLO.
SELECT title FROM sakila.film 
where title regexp 'APOLLO$';

#4.Get 10 the longest films.
Select * from sakila.film
order by length desc limit 10;

#5. How many films include **Behind the Scenes** content?
Select * from sakila.film;
Select count(film_id) from sakila.film
where special_features like '%Behind the Scenes%'; #538

#6.Drop column `picture` from `staff`.
alter table staff
drop column picture;

#7.A new person is hired to help Jon. 
#Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * from sakila.staff;
SELECT * from sakila.customer;
insert into staff (first_name, last_name, adress_id, email, store_id, active, last_update)
SELECT first_name, last_name, adress_id, email, store_id, active, last_update FROM customer
WHERE last_name="Sanders";

#different approach
insert into staff values
(3,'Tammy', 'Sanders', 79, 'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy',0,'2020-01-20 18:58:00');

#Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
#You can use current date for the `rental_date` column in the `rental` table.
#TO_TIMESTAMP(:ts_val, 'YYYY-MM-DD HH24:MI:SS')

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; #130

SELECT* from sakila.rental;
SELECT* from sakila.rental
WHERE inventory_id>1 and inventory_id<5;
SELECT max(rental_id) from sakila.rental; #16049
#(16050,TO_TIMESTAMP(:ts_val, 'YYYY-MM-DD HH24:MI:SS');
insert into rental values
(16050, '2020-01-20-19:03:00', 1, 130, NULL, 1, '2020-01-20-19:03:00');

#9. Delete non-active users, but first, create a _backup table_ `deleted_users` 
#to store `customer_id`, `email`, and the `date` for the users that would be deleted.

#Check if there are any non-active users
select * from sakila.customer Where active=0;

# Create a table _backup table_ as suggested
select * from sakila.customer;
create table table_backup like customer;
select * from sakila.table_backup;

#Insert the non active users in the table _backup table
select * from sakila.customer
where active=0;
insert into table_backup values
('16','2','SANDRA','MARTIN','SANDRA.MARTIN@sakilacustomer.org','20','0','2006-02-14 22:04:36','2006-02-15 04:57:20'),
('64','2','JUDITH','COX','JUDITH.COX@sakilacustomer.org','68','0','2006-02-14 22:04:36','2006-02-15 04:57:20'),
('124','1','SHEILA','WELLS','SHEILA.WELLS@sakilacustomer.org','128','0','2006-02-14 22:04:36','2006-02-15 04:57:20'),
('169','2','ERICA','MATTHEWS','ERICA.MATTHEWS@sakilacustomer.org','173','0','2006-02-14 22:04:36','2006-02-15 04:57:20'),
('241','2','HEIDI','LARSON','HEIDI.LARSON@sakilacustomer.org','245','0','2006-02-14 22:04:36','2006-02-15 04:57:20'),
('271','1','PENNY','NEAL','PENNY.NEAL@sakilacustomer.org','276','0','2006-02-14 22:04:36','2006-02-15 04:57:20'),
('315','2','KENNETH','GOODEN','KENNETH.GOODEN@sakilacustomer.org','320','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('368','1','HARRY','ARCE','HARRY.ARCE@sakilacustomer.org','373','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('406','1','NATHAN','RUNYON','NATHAN.RUNYON@sakilacustomer.org','411','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('446','2','THEODORE','CULP','THEODORE.CULP@sakilacustomer.org','451','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('482','1','MAURICE','CRAWLEY','MAURICE.CRAWLEY@sakilacustomer.org','487','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('510','2','BEN','EASTER','BEN.EASTER@sakilacustomer.org','515','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('534','1','CHRISTIAN','JUNG','CHRISTIAN.JUNG@sakilacustomer.org','540','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('558','1','JIMMIE','EGGLESTON','JIMMIE.EGGLESTON@sakilacustomer.org','564','0','2006-02-14 22:04:37','2006-02-15 04:57:20'),
('592','1','TERRANCE','ROUSH','TERRANCE.ROUSH@sakilacustomer.org','598','0','2006-02-14 22:04:37','2006-02-15 04:57:20');

select * from sakila.table_backup;

#Delete the non active users from the table _customer
Delete from customer Where customer_id in ('16','64','124','169','241','271','315','368','406','446','482','510','534','558','592');