-- Rental Payment vs. Rental Duration
SELECT 
    f.rental_duration, 
    ROUND(AVG(p.amount), 2) AS avg_payment
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rental_duration
ORDER BY f.rental_duration;

-- Rental Rate vs. Film Length
SELECT 
    f.length AS film_length, 
    f.rental_rate 
FROM film f
ORDER BY f.length;

--Customer Spending vs. Number of Rentals
SELECT 
    r.customer_id, 
    COUNT(r.rental_id) AS total_rentals, 
    SUM(p.amount) AS total_spent
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY r.customer_id
ORDER BY total_rentals DESC;

-- Revenue by film catagories 
SELECT 
  category.name AS category,
  SUM(payment.amount) AS total_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_revenue DESC;

--