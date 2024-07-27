SELECT
    year,
    season,
    INSTRUCTORS_CSV.name,
    COUNT(course_id) AS number_of_courses
FROM TEACHING_ASSIGNMENTS_CSV
JOIN COURSES_CSV
ON course_id = COURSES_CSV.id
JOIN INSTRUCTORS_CSV
ON instructor_id = INSTRUCTORS_CSV.id
JOIN TERMS_CSV
ON term_id = TERMS_CSV.id
GROUP BY 
    year, season, INSTRUCTORS_CSV.name
ORDER BY
    year,
    CASE
        WHEN season = 'Spring' THEN 1
        WHEN season = 'Summer' THEN 2
        WHEN season = 'Fall' THEN 3
        ELSE 4
    END,
    INSTRUCTORS_CSV.name