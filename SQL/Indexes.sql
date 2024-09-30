#select movies whose description has either car or boat
select * from sakila.film
where description like "%car%"
or description like "%boat%";

#add a full text index
select * from film
where match(description) against ("car boat");
#return movies with car but not boat
select * from film
where match(description) against ("car -boat" in boolean mode)