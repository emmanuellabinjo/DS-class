-- Retrieve all columns and all rows from the customers table.
SELECT *
FROM customers

-- Select the first name, country, and score for every customer.
SELECT 
    firstname,
    country, 
    score
FROM customers

-- Select the first name and country for all customers who are from Germany.
SELECT
    firstname,
    country
FROM customers
WHERE country = 'Germany'

-- Retrieve all columns for all customers, sorted by their score in ascending order (lowest score first).
SELECT *
FROM customers
ORDER BY score ASC

-- Calculate the total score for all customers, grouped by their country.
SELECT 
    country, SUM(score) AS total_score
FROM customers
GROUP BY country

-- Calculate the average score per country and only show countries where the average score is greater than 430.
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
GROUP BY country
HAVING AVG(score) > 430

-- Retrieve a list of unique (non-repeated) country names from the customers table.
SELECT DISTINCT country
FROM customers

-- Retrieve all columns for the top 3 customers with the highest scores.
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;

-- Calculate the average score per country, excluding any customer with a score of 0.
-- Only show countries with an average score greater than 430, and sort the results by the highest average score first.
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AVG(score) DESC