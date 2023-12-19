select *
from film;

-- 1.1 Determine the **shortest and longest movie durations** --
select length, title as "max_duration"
from film
order by length desc
limit 1; 
select length as "min_duration"
from film
order by length asc
limit 1;

-- 1.2. Express the **average movie duration in hours and minutes** --
select (floor((round(avg(length))/60)) ) as hour,
      (round(avg(length))%60) as `minutes` -- modulo operator
from film;

--  2.1 Calculate the **number of days that the company has been operating**
select *
from rental
order by rental_date desc;

-- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**
select min(rental_date) as `min_date`, 
max(rental_date) as `max_date`, 
datediff(max(rental_date), min(rental_date)) as `days in business`
 from rental;

-- 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**
select *,
month(rental_date) as `rental_month`,
weekday(rental_date) as `rental_weekday`,
case when weekday(rental_date) in (5,6) then 'weekend'
else 'workday'
end as `DAY_TYPE`
from rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**
select title, IFNULL(rental_duration, 'Not Available') as "rental_duration"
from film;

-- *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the **concatenated first and last names of customers**, along with the **first 3 characters of their email** address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.*
select 
    first_name,
    last_name, 
    email,
    concat(first_name,' ',last_name) as `cust_name`, 
    left(email,3) as `First 3 char of email`
 from customer order by last_name asc;
 
 -- The **total number of films** that have been released.
select count(title) as "Number of films"
from film;

-- The **number of films for each rating** 
select count(rating),rating from film group by rating order by count(rating) desc;

-- The **mean film duration for each rating**
select round(avg(length),2),rating from film group by rating order by avg(length) desc;

-- Identify **which ratings have a mean duration of over two hours**
select round(avg(length),2),rating from film 
group by rating having round(avg(length),2) >= 120
order by avg(length) desc;

-- *Bonus: determine which last names are not repeated in the table `actor`.*
select last_name, count(last_name)
from actor group by last_name
having count(*)=1;
