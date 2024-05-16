
-- Mahammad Basheer K S, Project 1: Corona Virus Analysis using SQL for Mentorness

-- --------------------------------------------------------------------
-- Data Initialization and Preparation Step:

-- Let's look at Dataset by Retrieving all the data.
SELECT * FROM coronadb1.coronadata;

-- Converting the date column datatype from string to Date datatype.
UPDATE coronadata
SET Date = DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m-%d');


-- Changing the column name from 'Country/Region' to 'country' to avoid potential errors 
-- caused by the '/' symbol in the column name.

ALTER TABLE coronadb1.coronadata
CHANGE COLUMN `Country/Region` country VARCHAR(255);

-- The number of distinct Countries with coronavirus data.
SELECT COUNT(DISTINCT country) AS No_of_Countries FROM coronadb1.coronadata;
-- (There are records for 121 countries in the dataset.)


-- -------------------------------------------------------------------------
-- Project: COVID-19 Data Analysis and Insights


-- Q1. A code to check NULL values

SELECT *
FROM coronadb1.coronadata
WHERE Province IS NULL 
    OR Country IS NULL 
    OR Latitude IS NULL 
    OR Date IS NULL 
    OR Confirmed IS NULL 
    OR Deaths IS NULL 
    OR Recovered IS NULL;



-- Q2. If NULL values are present, update them with zeros for all columns. 

UPDATE coronadb1.coronadata
SET Confirmed = CASE WHEN Confirmed IS NULL THEN 0 ELSE Confirmed END,
    Deaths = CASE WHEN Deaths IS NULL THEN 0 ELSE Deaths END,
    Recovered = CASE WHEN Recovered IS NULL THEN 0 ELSE Recovered END;

-- (None of Rows affected, because no Null values found)


-- Q3. check total number of rows 
SELECT COUNT(*)
FROM coronadb1.coronadata;

-- (Total No. of Rows 78386)


-- Q4. Check what is start_date and end_date

SELECT
	MIN(Date) AS Start_Date,
	MAX(Date) AS End_Date
FROM coronadb1.coronadata;

-- (Start_Date: 2020-01-22,	End_Date: 2021-06-13)


-- Q5. Number of month present in dataset

SELECT
	COUNT(DISTINCT DATE_FORMAT(Date, '%Y-%m')) AS Num_Months
FROM coronadb1.coronadata;

-- (Num of Months: 18)


-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    AVG(Confirmed) AS Avg_Confirmed,
    AVG(Deaths) AS Avg_Deaths,
    AVG(Recovered) AS Avg_Recovered
FROM coronadb1.coronadata
GROUP BY YEAR(Date), MONTH(Date);



-- Q7. Find most frequent value for confirmed, deaths, recovered each month

SELECT
	Year(Date) as Year,
    Month(Date) as Month,
    SUBSTRING_INDEX(GROUP_CONCAT(confirmed ORDER BY confirmed DESC),',',1) AS Most_Frequent_Confirmed,
    SUBSTRING_INDEX(GROUP_CONCAT(Deaths ORDER BY Deaths DESC),',',1) AS Most_Frequent_Deaths,
    SUBSTRING_INDEX(GROUP_CONCAT(Recovered ORDER BY Recovered DESC),',',1) AS Most_Frequent_Recovered
FROM
	coronadb1.coronadata
GROUP BY
	Month,Year
ORDER BY
	Year,Month;



-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT
	Year(Date) as Year,
    MIN(Confirmed) as Min_Confirmed,
    MIN(Deaths) as Min_Deaths,
    MIN(Recovered) as Min_Recovered
FROM 
	coronadb1.coronadata
GROUP BY
	Year;
    
    
    
-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT
	Year(Date) as Year,
    MAX(Confirmed) as Max_Confirmed,
    MAX(Deaths) as Max_Deaths,
    MAX(Recovered) as Max_Recovered
FROM 
	coronadb1.coronadata
GROUP BY
	Year;



-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT
	Year(Date) as Year,
    Month(Date) as Month,
    SUM(Confirmed) as Total_Confirmed,
    SUM(Deaths) AS Total_Deaths,
    SUM(Recovered) AS Total_Recovered
FROM 
	coronadb1.coronadata
GROUP BY
	Year,Month;
    
  
  
-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    SUM(Confirmed) AS Total_Confirmed_Cases,
    AVG(Confirmed) AS Average_Confirmed_Cases,
    VARIANCE(Confirmed) AS Variance_Confirmed_Cases,
    STDDEV(Confirmed) AS Std_Dev_Confirmed_Cases
FROM coronadb1.coronadata;

-- (Total confirmed cases:169065144, Average confirmed cases:2156.8283)
-- (Variance of confirmed cases:157288925.07796532, Standard deviation of confirmed cases:12541.488152446875)



-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Deaths) AS Total_Death_Cases,
    AVG(Deaths) AS Average_Death_Cases,
    VARIANCE(Deaths) AS Variance_Death_Cases,
    STDDEV(Deaths) AS Std_Dev_Death_Cases
FROM coronadb1.coronadata
GROUP BY 
	YEAR, MONTH;



-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    SUM(Recovered) AS Total_Recovered_Cases,
    AVG(Recovered) AS Average_Recovered_Cases,
    VARIANCE(Recovered) AS Variance_Recovered_Cases,
    STDDEV(Recovered) AS Std_Dev_Recovered_Cases
FROM coronadb1.coronadata;

-- (Total recovered cases:113089548, Average recovered cases:1442.7264)
-- (Variance of recovered cases:107029523.26229636, Standard deviation of recovered cases:10345.507395110999)


-- Q14. Find Country having highest number of the Confirmed case

SELECT 
	Country,
    SUM(Confirmed) AS Highest_Confirmed_Cases
FROM 
	coronadb1.coronadata
GROUP BY 
	Country
ORDER BY 
	Highest_Confirmed_Cases DESC
LIMIT 1;

-- (The Country having highest number of the Confirmed case is United State with  33461982 cases.)


-- Q15. Find Country having lowest number of the death case

SELECT 
	Country,
    SUM(Deaths) AS Lowest_Death_Cases
FROM 
	coronadb1.coronadata
GROUP BY 
	Country
ORDER BY 
	Lowest_Death_Cases ASC
LIMIT 5;

-- ( Adjust the limit to get more countries list with lowest Death case.)



-- Q16. Find top 5 countries having highest recovered case

SELECT 
	Country, 
    SUM(Recovered) AS Total_Recovered_Cases
FROM 
	coronadb1.coronadata
GROUP BY 
	Country
ORDER BY 
	Total_Recovered_Cases DESC
LIMIT 5;


-- -----------------------------------------------
--                   */The End/*






