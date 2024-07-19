# Database Design and Build

## Introduction

There have been several questions from students, faculty, and staff on the topic of courses and curriculum in the University of Virginia (UVA) School of Data Science (SDS) Online Master of Science in Data Science (MSDS) program. It will be helpful to construct a database containing some information about the courses. One use case might be to view learning outcomes for each course. One use case might be to view the instructors assigned to teach the different courses for each term in 2021. We may wish to ask ourselves, "Are there any other use cases we’d want this database to support?"

## Data

The database is based on Excel workbook Current_Learning_Objectives_Raw_Data.xlsx provided by Efrain Olivares on 07/16/2024. The workbook contains a worksheet entitled, "Teaching Assignments: Instructors to Courses by Term" that contains a of course information and instructor name for each of terms Spring 2021, Summer 2021, and Fall 2021. Not all courses are taught in a given semester. A course might have one instructor in one semester and many instructors in another semester.

The workbook contains a worksheet with a table of instructor names and notes about which instructors are currently employed by the School of Data Science, a table of names of terms, and a table of course mnemonics (e.g., "DS 5001"), names, and short descriptions (i.e., briefs).

The workbook contains worksheets for all courses except for "SARC 5400: Data Visualization", each with a table of course mnemonics and learning outcomes.

## Database Design

# Database

We construct database UVA_SDS_Online_MSDS_Program_Database on server tom-levers-server.database.windows.net. We used Microsoft Azure: Cloud Computing Services. We used Visual Studio Code and the following connection string to create, retrieve, update, and delete objects in the database.

```
Server=tcp:tom-levers-server.database.windows.net,1433;Initial Catalog=UVA_SDS_Online_MSDS_Program_Database;Persist Security Info=False;User ID=thomas.lever.business@gmail.com@tom-levers-server;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

We may view a table of the names of all tables in our database using the following code written in Transact SQL.

```
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
```

# Tables

Please see the below Entity Relationship Diagram.

Learning outcomes (LOs) capture what students should be able to do after taking a course (e.g., design and build a MySQL database). Learning outcomes vary in terms of detail as they are written by different instructors. Learning outcomes for each course must be in the database. We constructed table outcomes with columns id, course_id, and outcome. Column id is a not null primary key of integers. Column course_id is a not null column of integers that is a foreign key that references column id in table courses. Column outcome is a not null column of strings.

## Database Analysis

Learning outcomes for each course must be in the database. A view of a table of course mnemonics, names, and outcomes may be selected using the following code written in Transact SQL.

```
SELECT mnemonic, name, outcome
FROM courses
LEFT JOIN outcomes
ON courses.id = course_id;
```

The instructors assigned to teach the different courses for each term in 2021 must be in the database. A view of a table of course mnemonics, course names, seasons, years, and instructor names may be selected using the following code written in Transact SQL.

```
SELECT
    mnemonic,
    courses.name as course_name,
    season,
    year,
    instructors.name as instructor_name
FROM teaching_assignments
LEFT JOIN courses
ON course_id = courses.id
LEFT JOIN terms
ON term_id = terms.id
LEFT JOIN instructors
ON instructor_id = instructors.id
```