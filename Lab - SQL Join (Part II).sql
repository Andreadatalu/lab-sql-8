USE sakila;

-- 1 Write a query to display for each store its store ID, city, and country.
SELECT * FROM sakila.store;
SELECT * FROM sakila.country;
SELECT * FROM sakila.city;

SELECT store.store_id, city.city, country.country
FROM sakila.store
JOIN sakila.address ON store.address_id = address.address_id
JOIN sakila.city ON address.city_id = city.city_id
JOIN sakila.country ON city.country_id = country.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.

SELECT * FROM sakila.payment;
SELECT * FROM sakila.staff;

SELECT store.store_id, SUM(payment.amount) AS total_business
FROM sakila.store
JOIN sakila.staff ON store.store_id = staff.store_id
JOIN sakila.payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 3 Which film categories are longest?

SELECT category.name AS category_name, AVG(film.length) AS average_length
FROM sakila.category
JOIN sakila.film_category ON category.category_id = film_category.category_id
JOIN sakila.film ON film_category.film_id = film.film_id
GROUP BY category.category_id, category_name
ORDER BY average_length DESC;

-- 4 Display the most frequently rented movies in descending order.
SELECT * FROM sakila.film;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.inventory;

SELECT f.film_id, f.title, COUNT(*) AS rental_frequently
FROM sakila.film f
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_frequently DESC;


-- 5 List the top five genres in gross revenue in descending order.
SELECT * FROM sakila.film_category;
SELECT c.name AS genre, SUM(p.amount) AS gross_revenue
FROM sakila.payment p
JOIN sakila.rental r ON p.rental_id = r.rental_id
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON i.film_id = f.film_id
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 6 Is "Academy Dinosaur" available for rent from Store 1?
SELECT film.title, inventory.inventory_id, store.store_id
FROM sakila.film
JOIN sakila.inventory ON film.film_id = inventory.film_id
JOIN sakila.store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;

-- Answer: Yes, it's available.

-- 7 Get all pairs of actors that worked together.

SELECT DISTINCT fa1.actor_id AS actor1_id, CONCAT(a1.first_name) AS actor1_name, fa2.actor_id AS actor2_id, CONCAT(a2.first_name) AS actor2_name
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN sakila.actor a1 ON fa1.actor_id = a1.actor_id
JOIN sakila.actor a2 ON fa2.actor_id = a2.actor_id
WHERE fa1.actor_id < fa2.actor_id
GROUP BY actor1_id, actor1_name, actor2_id, actor2_name;

-- Second solution
SELECT DISTINCT fa1.actor_id AS actor1_id, a1.first_name AS actor1_name,
       fa2.actor_id AS actor2_id, a2.first_name AS actor2_name
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN sakila.actor a1 ON fa1.actor_id = a1.actor_id
JOIN sakila.actor a2 ON fa2.actor_id = a2.actor_id
WHERE fa1.actor_id < fa2.actor_id;

