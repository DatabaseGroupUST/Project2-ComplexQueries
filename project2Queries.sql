-- Nicholas Hayden
-- Claude Robin
-- Alexander Avila
--
-- Project 2
-- We skipped 12 and 13

USE nicholas_university2;

-- Query 1
SELECT
    person.person_id,
    first_name,
    last_name
FROM
    person
JOIN student ON
    person.person_id = student.person_id
WHERE student.admission = 2016;

-- Query 2
SELECT AVG(admission - EXTRACT(YEAR FROM date_of_birth)) AS average_age  
FROM
    (SELECT 
        person.date_of_birth,
        student.admission
     FROM
        person
     JOIN student ON
        person.person_id = student.person_id) AS newTable;

-- Query 3
SELECT 
    person.person_ID,
    person.first_name,
    person.last_name,
    student.major
FROM
    person
JOIN student ON
    person.person_id = student.person_id
WHERE 
    major = 'MATH';
 
-- Query 4
SELECT DISTINCT
    state
FROM
    person
JOIN student ON
    person.person_id = student.person_id
WHERE
    admission = 2016;

-- Query 5
SELECT DISTINCT
    state
FROM
    person
JOIN student ON
    person.person_id = student.person_id
WHERE major = 'MATH';

-- Query 6		
SELECT DISTINCT 
    first_name,
    last_name 
FROM
    person 
JOIN faculty JOIN student ON
    person.person_id = faculty.person_id AND
    person.person_id = student.person_id;
        
-- Query 7
SELECT
    first_name,
    last_name
FROM 
    person
WHERE 
    person_id NOT IN (SELECT person_id FROM student) AND
    person_id NOT IN (SELECT person_id FROM faculty) AND
    YEAR(date_of_birth) < 1990;

    
-- Query 8
SELECT DISTINCT 
    faculty.person_id,
    person.first_name,
    person.last_name
FROM
    faculty
JOIN person ON
    faculty.person_id = person.person_id
WHERE
    faculty.person_id
NOT IN
    (SELECT 
        faculty.person_id 
    FROM
        faculty
    JOIN section ON 
        faculty.person_id = section.instructor
    WHERE faculty.department = section.department);

-- Query 9 
SELECT
    student_id_count,
    course_number,
    department,
    year,
    semester
FROM
    (SELECT
        COUNT(student_id) AS student_id_count,
        course_number,
        department,
        year,
        semester
    FROM
        enroll
    GROUP BY
        course_number,
        department,
        year,
        semester) AS tempTable
WHERE 
    student_id_count >= 10;

-- Query 10
SELECT AVG(TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) AS average_age, major 
FROM
    (SELECT 
        person.date_of_birth,
        student.major
     FROM
        person
     JOIN student ON
        person.person_id = student.person_id) AS newTable
GROUP BY major;

-- Query 11
SELECT
    (students_null / (students_notnull + students_null)) AS fraction_null,
    course_number
FROM
    (SELECT 
        SUM(CASE WHEN major IS NULL THEN 1 ELSE 0 END) AS students_null,
        SUM(CASE WHEN major IS NOT NULL THEN 1 ELSE 0 END) AS students_notnull,
        course_number
     FROM
        (SELECT 
            enroll.student_id,
            enroll.course_number,
            student.major
         FROM
            enroll
         JOIN student ON
            enroll.student_id = student.person_id
         WHERE
            semester = 'Spring' AND year = '2016') AS tempTable
     GROUP BY course_number) AS tempTable2;

-- Query 14
SELECT
    person_id,
    first_name,
    last_name
FROM
    (SELECT
        person.person_id,
        person.first_name,
        person.last_name,
        student.major
     FROM 
        person
     JOIN student ON
        person.person_id = student.person_id
     WHERE
        major = 'MATH') AS tempTable
WHERE tempTable.person_id NOT IN (SELECT student_id
                                  FROM enroll 
                                  WHERE department = 'MATH');

-- Query 16
UPDATE enroll
	SET grade = 'F'
	WHERE enroll.year = 2016 AND enroll.semester = 'Spring' AND enroll.grade IS NULL;


-- Query 17
-- List the top 5 popular professors as defined as the professor that teaches the most average amount of students
SELECT
    AVG(tempTable2.counted_students) AS average_students,
    tempTable2.instructor,
    person.first_name,
    person.last_name
FROM
    (SELECT
        COUNT(enroll.student_id) AS counted_students, 
        tempTable.instructor
    FROM
        enroll
    NATURAL JOIN
        (SELECT
            section.instructor,
            section.department,
            section.course_number,
            section.year,
            section.semester
         FROM
            section
         JOIN
            faculty
         ON
            faculty.person_id = section.instructor) AS tempTable
    GROUP BY
        tempTable.instructor,
        tempTable.department,
        tempTable.course_number,
        tempTable.year,
        tempTable.semester) AS tempTable2
JOIN
    person
ON
    person.person_id = tempTable2.instructor
GROUP BY instructor
ORDER BY average_students DESC
LIMIT 5;



