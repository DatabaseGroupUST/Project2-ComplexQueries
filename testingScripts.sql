USE nicholas_university2;

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

       

