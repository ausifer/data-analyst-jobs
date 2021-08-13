-- 1. How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10; --ExxonMobil

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location LIKE 'TN';

-- 4a. How many are there in either Tennessee or Kentucky?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location='TN' OR location='KY';
-- 4b. How many postings in Tennessee have a star rating above 4?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE star_rating >= 4;

-- 5. How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT company, ROUND(AVG(star_rating),2) AS avg_rating, location AS state
FROM data_analyst_jobs
WHERE location IS NOT NULL 
AND star_rating IS NOT NULL
GROUP BY state, company
ORDER BY avg_rating DESC; 
---- Which state shows the highest average rating? MA shows the highest rating

-- 7a. Select unique job titles from the data_analyst_jobs table. 
SELECT DISTINCT title
FROM data_analyst_jobs;
-- 7b. How many are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

-- 8. How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location='CA';

-- 9a. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations.
SELECT company, ROUND(AVG(star_rating),2)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;
-- 9b. How many companies are there with more that 5000 reviews across all locations?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count > 5000;

-- 10a. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
SELECT company, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;
-- 10b. What is that rating? General Motors at 4.2

-- 11a. Find all the job titles that contain the word ‘Analyst’. 
SELECT title
FROM data_analyst_jobs
WHERE title LIKE '%analyst%';
-- 11b. How many different job titles are there?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE title LIKE '%analyst%';

-- 12a. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE lower(title) NOT LIKE '%analyst%'
AND lower(title) NOT LIKE '%analytics%';
-- 12b. What word do these positions have in common? 
SELECT title
FROM data_analyst_jobs
WHERE lower(title) NOT LIKE '%analyst%'
AND lower(title) NOT LIKE '%analytics%';
---- They have the word "tableau" in common

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. 
-- Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
SELECT title, domain, days_since_posting
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%'
AND days_since_posting > 21
AND domain IS NOT NULL
ORDER BY --STILL TRYING TO FIGURE OUT IF THIS IS A SUBQUERY OR NOT********************************************
(SELECT domain, days_since_posting
FROM data_analyst_jobs
GROUP BY domain
ORDER BY days_since_posting;);


-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?;
