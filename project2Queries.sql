--A 1,3,4,5,8
--N 2,10,11,12,13,14
--C 6,7,9,15,16

--Query 1
SELECT
    person.person_id,
    first_name,
    last_name
FROM
    person
JOIN student ON
    person.person_id = student.person_id
WHERE student.admission = 2016;

--Query 2
--This query does not account for time of year.
--Does this query need to?
SELECT AVG(admission - EXTRACT(YEAR FROM date_of_birth)) AS average_age  
FROM
    (SELECT 
        person.date_of_birth,
        student.admission
     FROM
        person
     JOIN student ON
        person.person_id = student.person_id) AS newTable;

--Query 3
SELECT first_name, last_name
    FROM person
    WHERE major IN
        (SELECT major
         FROM student
         WHERE major= 'MATH');

--Query 4
SELECT DISTINCT state
    FROM person
    WHERE admission IN
        (SELECT admission
         FROM student
         WHERE admission= 2016);

--Query 5
SELECT DISTINCT state
    FROM person
    WHERE major IN
        (SELECT major
         FROM student
         WHERE major= 'MATH');

--Query 10
--This does not account for time of year.
SELECT AVG(EXTRACT(YEAR FROM date_of_birth)) AS average_age, major 
FROM
    (SELECT 
        person.date_of_birth,
        student.admission,
        student.major
     FROM
        person
     JOIN student ON
        person.person_id = student.person_id) AS newTable
GROUP BY major;

--Query 11
--The names can be fixed up a bit, but i think it works
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

--Query 14
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

