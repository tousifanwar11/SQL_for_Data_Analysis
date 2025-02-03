-- Data Frequency distribution

-- Rating
SELECT 
rating,
COUNT (*) AS absolute_frequency,
ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (), 4) AS relative_frequency
FROM film
GROUP BY rating
ORDER BY absolute_frequency DESC;

--Rental Rate
SELECT 
  rental_rate,
  COUNT(*) AS absolute_frequency,
  ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (), 4) AS relative_frequency
FROM film
GROUP BY rental_rate
ORDER BY absolute_frequency DESC;

-- Quartile Analysis
SELECT
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY rental_duration) AS Q1,
  PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY rental_duration) AS Median,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY rental_duration) AS Q3
FROM film;

SELECT
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY replacement_cost) AS Q1,
  PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY replacement_cost) AS Median,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY replacement_cost) AS Q3
FROM film;

--Central Tendencies
-- Mean, Median, and Mode for payment amount
SELECT 
    'Payment Amount' AS metric,
    AVG(amount) AS mean,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY amount) AS median,
    MODE() WITHIN GROUP (ORDER BY amount) AS mode
FROM payment
UNION ALL
-- Mean, Median, and Mode for film rental duration
SELECT 
    'Rental Duration' AS metric,
    AVG(rental_duration) AS mean,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY rental_duration) AS median,
    MODE() WITHIN GROUP (ORDER BY rental_duration) AS mode
FROM film
UNION ALL
-- Mean, Median, and Mode for film rental rate
SELECT 
    'Rental Rate' AS metric,
    AVG(rental_rate) AS mean,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY rental_rate) AS median,
    MODE() WITHIN GROUP (ORDER BY rental_rate) AS mode
FROM film;

-- Dispersion analysis for payment amount
SELECT 
    'Payment Amount' AS metric,
    MAX(amount) - MIN(amount) AS range,
    STDDEV(amount) AS standard_deviation,
    VARIANCE(amount) AS variance,
    (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY amount) - 
     PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY amount)) AS interquartile_range
FROM payment
UNION ALL
-- Dispersion analysis for film rental duration
SELECT 
    'Rental Duration' AS metric,
    MAX(rental_duration) - MIN(rental_duration) AS range,
    STDDEV(rental_duration) AS standard_deviation,
    VARIANCE(rental_duration) AS variance,
    (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY rental_duration) - 
     PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY rental_duration)) AS interquartile_range
FROM film
UNION ALL
-- Dispersion analysis for film rental rate
SELECT 
    'Rental Rate' AS metric,
    MAX(rental_rate) - MIN(rental_rate) AS range,
    STDDEV(rental_rate) AS standard_deviation,
    VARIANCE(rental_rate) AS variance,
    (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY rental_rate) - 
     PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY rental_rate)) AS interquartile_range
FROM film;
