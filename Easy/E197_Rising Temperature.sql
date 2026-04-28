-- ===============================================
-- ID: 197
-- Title: Rising Temperature
-- Link: https://leetcode.com/problems/rising-temperature/
-- Difficulty: Easy
-- Date: 2026-04-28
-- ===============================================

/* --- SQL SCHEMA --- */

Create table If Not Exists Weather (id int, recordDate date, temperature int)
Truncate table Weather
insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10')
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25')
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20')
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30')

-- Table: Weather

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | recordDate    | date    |
-- | temperature   | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- There are no different rows with the same recordDate.
-- This table contains information about the temperature on a certain day.
 

-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Weather table:
-- +----+------------+-------------+
-- | id | recordDate | temperature |
-- +----+------------+-------------+
-- | 1  | 2015-01-01 | 10          |
-- | 2  | 2015-01-02 | 25          |
-- | 3  | 2015-01-03 | 20          |
-- | 4  | 2015-01-04 | 30          |
-- +----+------------+-------------+
-- Output: 
-- +----+
-- | id |
-- +----+
-- | 2  |
-- | 4  |
-- +----+
-- Explanation: 
-- In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
-- In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

/* --- MY SOLUTION --- */
-- Self join
SELECT w1.id FROM Weather w1
JOIN Weather w2
    ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature

-- LAG()
SELECT id 
FROM (
    SELECT id,
           temperature,
           recordDate,
           LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp,
           LAG(recordDate) OVER (ORDER BY recordDate) AS prev_date
    FROM Weather
) t 
WHERE temperature > prev_temp AND DATEDIFF(recordDate, prev_date) = 1

-- self join
SELECT w1.id FROM Weather w1, Weather w2
WHERE w1.recordDate = date_add(w2.recordDate, interval 1 day) AND w1.temperature > w2.temperature
;