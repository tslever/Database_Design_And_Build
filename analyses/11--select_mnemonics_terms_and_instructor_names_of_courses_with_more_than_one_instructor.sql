WITH table_of_mnemonics_and_terms_of_courses_with_more_than_one_instructor AS (
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
)
SELECT 
    COURSES_CSV.mnemonic,
    TERMS_CSV.season,
    TERMS_CSV.year,
    INSTRUCTORS_CSV.name
FROM TEACHING_ASSIGNMENTS_CSV
JOIN COURSES_CSV ON course_id = COURSES_CSV.id
JOIN TERMS_CSV ON term_id = TERMS_CSV.id
JOIN INSTRUCTORS_CSV ON instructor_id = INSTRUCTORS_CSV.id
JOIN table_of_mnemonics_and_terms_of_courses_with_more_than_one_instructor
ON
    COURSES_CSV.mnemonic = table_of_mnemonics_and_terms_of_courses_with_more_than_one_instructor.mnemonic AND
    TERMS_CSV.year = table_of_mnemonics_and_terms_of_courses_with_more_than_one_instructor.year AND
    TERMS_CSV.season = table_of_mnemonics_and_terms_of_courses_with_more_than_one_instructor.season