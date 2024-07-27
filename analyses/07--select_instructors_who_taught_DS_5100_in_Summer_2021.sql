SELECT
    mnemonic,
    COURSES_CSV.name,
    INSTRUCTORS_CSV.name,
    season,
    year
FROM TEACHING_ASSIGNMENTS_CSV
LEFT JOIN COURSES_CSV
ON COURSES_CSV.id = course_id
LEFT JOIN INSTRUCTORS_CSV
ON INSTRUCTORS_CSV.id = instructor_id
LEFT JOIN TERMS_CSV
ON TERMS_CSV.id = term_id
WHERE
    mnemonic = 'DS 5100' AND
    season = 'Summer' AND
    year = 2021