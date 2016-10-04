USE nicholas_university2;

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

