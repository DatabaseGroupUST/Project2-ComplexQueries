--A 1,3,4,5,8
--N 2,10,11,12,13,14
--C 6,7,9,15,16

--Query 1
SELECT first_name, last_name
    FROM person
    WHERE admission IN	
        (SELECT admission
         FROM student
         WHERE admission= 2016);

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
