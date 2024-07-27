SELECT mnemonic, season, year
FROM TEACHING_ASSIGNMENTS_CSV
JOIN COURSES_CSV
ON course_id = COURSES_CSV.id
JOIN TERMS_CSV
ON term_id = TERMS_CSV.id
JOIN INSTRUCTORS_CSV
ON instructor_id = INSTRUCTORS_CSV.id
GROUP BY mnemonic, year, season
HAVING COUNT(instructor_id) > 1