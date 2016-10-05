USE nicholas_university2;


SELECT
    (students_null / (students_notnull + students_null)) AS fraction_null,
     department, course_number
FROM
    (SELECT 
        SUM(CASE WHEN major IS NULL THEN 1 ELSE 0 END) AS students_null,
        SUM(CASE WHEN major IS NOT NULL THEN 1 ELSE 0 END) AS students_notnull,
        course_number,
        department
     FROM
        (SELECT 
            enroll.student_id,
            enroll.course_number,
            student.major,
            enroll.department
         FROM
            enroll
         JOIN student ON
            enroll.student_id = student.person_id
         WHERE
            semester = 'Spring' AND year = '2016') AS tempTable
     GROUP BY department, course_number) as tempTable2;


