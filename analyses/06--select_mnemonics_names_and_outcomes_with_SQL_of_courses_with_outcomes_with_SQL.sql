SELECT mnemonic, name, outcome
FROM COURSES_CSV
JOIN OUTCOMES_CSV
ON COURSES_CSV.id = course_id
WHERE LOWER(outcome) LIKE '%sql%'