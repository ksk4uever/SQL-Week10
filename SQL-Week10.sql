USE sakila;

select first_name, last_name
from actor;


select concat(first_name, ' ', last_name) as 'Actor Name'
from actor;

select actor_id, first_name, last_name
from actor 
where first_name = 'Joe';


select *
from actor 
where last_name like '%GEN%';


select *
from actor 
where last_name like '%LI%'
order by last_name, first_name;


select country_ID, country
from country
where country IN ('Afghanistan', 'Bangladesh', 'China');


ALTER TABLE actor ADD COLUMN description BLOB;


alter table actor drop column description;


select last_name, count(*) as name_count
from actor
group by last_name;

select last_name, count(*) as name_count
from actor
group by last_name
having count(*) > 1;


select *
from actor
where first_name = 'GROUCHO';

update actor
set first_name = 'HARPO' 
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';


update actor
set first_name = 'GROUCHO' 
where first_name = 'HARPO' and last_name = 'WILLIAMS';


show create table address;


select s.first_name, s.last_name, a.address, a.address2, a.district, a.city_id, a.postal_code, a.phone, a.location
from staff s
join address a on s.address_id = a.address_id;


select s.first_name, s.last_name, sum(amount) as total_amount
from staff s
join payment p on s.staff_id = p.staff_id
group by s.first_name, s.last_name;

select f.title, count(fa.actor_id) as actor_count
from film f
join film_actor fa on f.film_id = fa.film_id
group by f.title;

select f.title, count(i.film_id) as inventory_count
from film f
join inventory i on f.film_id = i.film_id
group by f.title;

select c.first_name, c.last_name, sum(amount) as total_amount
from customer c
join payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by 1,2;

select title
from film 
where (title like 'K%' or title like 'Q%') and
	language_id IN (
		select language_id 
        from language
        where name = 'English'
);


select *
from actor
where actor_id in (
	select actor_id 
    from film_actor
    where film_id in (
		select film_id 
		from film 
		where title = 'Alone Trip')
);


select c.first_name, c.last_name, c.email
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Canada';


select f.title
from film f
join film_category fc on f.film_id = fc.film_id  
join category c on c.category_id = fc.category_id
where c.name = 'Family';


select f.title, count(r.rental_id) as rental_count
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.title
order by 2 desc;


select i.store_id, sum(p.amount) as total_amount
from inventory i
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by i.store_id;


select s.store_id, c.city, co.country
from store s
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country co on c.country_id = co.country_id;


select c.name, sum(p.amount) as gross_revenue
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.name
order by 2 desc
limit 5;


create view top5_genre_by_revenue as 
select c.name, sum(p.amount) as gross_revenue
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.name
order by 2 desc
limit 5;


select *
from top5_genre_by_revenue;


drop view top5_genre_by_revenue;








