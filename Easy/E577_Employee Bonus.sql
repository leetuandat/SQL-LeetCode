-- ===============================================
-- ID: 577
-- Title: Employee Bonus
-- Link: URL_bài_tập
-- Difficulty: Easy
-- Date: 2026-05-28
-- ===============================================

/* --- SQL SCHEMA --- */


/* --- MY SOLUTION --- */
SELECT 
    e.name,
    b.bonus
FROM Employee e
LEFT JOIN Bonus b
    ON e.empId = b.empId
WHERE b.bonus < 1000
   OR b.bonus IS NULL;