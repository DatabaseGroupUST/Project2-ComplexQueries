USE nicholas_university2;

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
ORDER BY average_students ASC 
LIMIT 5;
