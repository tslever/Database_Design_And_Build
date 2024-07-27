SELECT course_id, COUNT(*) AS number_of_outcomes
FROM OUTCOMES_CSV
GROUP BY course_id
ORDER BY course_id