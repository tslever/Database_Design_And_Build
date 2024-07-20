# Database Design and Build

## Introduction

There have been several questions from students, faculty, and staff on the topic of courses and curriculum in the University of Virginia (UVA) School of Data Science (SDS) Online Master of Science in Data Science (MSDS) program. It will be helpful to construct a database containing some information about the courses. One use case might be to view active learning outcomes for each active course. One use case might be to view the currently employed, active instructors assigned to teach the different active courses for each term in 2021. We may wish to ask ourselves, "Are there any other use cases we’d want this database to support?"

An active course is a course that will be taught again. An inactive course is a course that will not be taught again. A currently employed instructor is an instructor who presently works for the School of Data Science. A currently not employed instructor is an instructor who does not presently work for the School of Data Science. An active instructor is an instructor who will teach again. An inactive instructor is an instructor who will not teach again. An active learning outcome of a course is a learning outcome that will be achieved again by students who receive grade A+ for the course. An inactive learning outcome is a learning outcome that will not be achieved by students due to the intention due to faculty and staff leading the course.

See specifications for this UVA SDS Online MSDS Program Database Project in this Git repository.

## Data

The database is based on Excel workbook Current_Learning_Objectives_Raw_Data.xlsx in this repository provided by Efrain Olivares on 07/16/2024. The workbook contains a worksheet entitled, "Teaching Assignments: Instructors to Courses by Term" that contains tables of information for courses that were active for each of terms Spring 2021, Summer 2021, and Fall 2021 and the names of the instructors who were employed and active during those terms and taught those courses. One or more courses are taught in a given semester. A course might have one instructor or more instructors. Two instructors may teach different sections of the same course or co-teach a section of a course.

The workbook contains a worksheet with a table of instructor names and notes about which instructors are currently employed by the School of Data Science, a table of names of terms, and a table of course mnemonics (e.g., "DS 5001"), names, and short descriptions (i.e., briefs).

The workbook contains worksheets for all courses except for "SARC 5400: Data Visualization", each with a table of course mnemonics and learning outcomes.

## Database Design

### Database

We construct database UVA_SDS_Online_MSDS_Program_Database on server tom-levers-server.database.windows.net. We used Microsoft Azure: Cloud Computing Services. We used Visual Studio Code and the following ADO.NET connection string with SQL authentication to create, retrieve, update, and delete objects in the database.

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

### Tables

Please see the below Entity Relationship Diagram.

Learning outcomes (LOs) capture what students should be able to do after taking a course (e.g., design and build a MySQL database). Learning outcomes vary in terms of detail as they are written by different instructors. Learning outcomes for each course must be in the database. We constructed table outcomes with columns id, course_id, outcome, and is_active. Column id is a not null primary key of whole numbers. Column course_id is a not null column of whole numbers that is a foreign key that references column id in table courses. Column outcome is a not null column of strings. Column is_active is a not null column of bits.

The employed, active instructors assigned to teach the different active courses for each term in 2021 must be in the database. We constructed table instructors with columns id, name, is_current_employee, and is_active. Column id is a not null primary key of whole numbers. Column name is a not null column of strings. Column is_current_employee is a not null column of bits. Column is_active is a not null column of bits.

We constructed table courses with columns id, mnemonic, name, brief, and is_active. Column id is a not null primary key of whole numbers. Column mnemonic is a not null, unique column of strings. Column name is a not null, unique column of strings. Column brief is a not null column of strings. Column is_active is a not null column of bits.

We constructed table terms with columns id, season, and year. Column id is a not null primary key of whole numbers. Column season is a not null column of instances of "Spring", "Summer", and "Fall". Column year is a not null natural number greater than or equal to 2021.

We constructed table teaching_assignments with columns id, course_id, term_id, and instructor_id. Column id is a not null primary key of whole numbers. Column course_id is a not null column of whole numbers that is a foreign key that references column id in table courses. Column term_id is a not null column of whole numbers that is a foreign key that references column id in table terms. Column instructor_id is a not null primary key of whole numbers that references column id in table instructors.

# Indexes

According to [1], "An index is a database structure that makes it quicker and easier to find records based on the values in one or more fields... For example, suppose you have a Customers table that holds customer information: name, address, phone number, Swiss bank account number, and so forth. The table also contains a CustomerId field that it uses as its primary key. Unfortunately customers usually don't remember their customer IDs, so you need to be able to look them up by name or phone number. If you make Name and Phone Number be two different keys, you can quickly locate a customer's record in three ways: by customer ID, by name, and by phone number... Place indexes on the fields you are most likely to need to search."

We should build indexes for fields name of table instructors and name of table courses. We are most likely to need to search for instructor and course information.

## Database Analysis

Learning outcomes for each course must be in the database. A view of a table of mnemonics of active courses, names of those courses, and active learning outcomes of those courses may be selected using the following code written in Transact SQL.

```
SELECT mnemonic, name, outcome
FROM courses
LEFT JOIN outcomes
ON courses.id = course_id
WHERE courses.is_active = 1 AND outcomes.is_active = 1;
```

The employed, active instructors assigned to teach the different active courses for each term in 2021 must be in the database. A view of a table of mnemonics of active courses, names of those courses, seasons, years, and names of active, employed instructors may be selected using the following code written in Transact SQL.

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

## References

1. Rod Stephens (2008). "Chapter 3. Relational Database Fundamentals". Beginning Database Design Solutions. https://learning.oreilly.com/library/view/beginning-database-design/9780470385494/ch03.html#indexes. Accessed 07/20/2024.