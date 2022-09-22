SELECT TABLE_NAME FROM USER_TABLES

SELECT * FROM STAFF

SELECT *
FROM STAFF
WHERE SALARY > ( SELECT SALARY
                 FROM STAFF
                 WHERE UPPER(FNAME) = 'DAVID'
                 )
ORDER BY SALARY;

-- ls staff who work in '163 main st' street' branch

SELECT *
FROM STAFF
WHERE BRANCHNO = ( SELECT BRANCHNO
                   FROM BRANCH
                   WHERE UPPER(STREET) = '163 MAIN ST');
                   
-- or can be done like this

SELECT S.*
FROM STAFF S JOIN BRANCH B
ON S.BRANCHNO = B.BRANCHNO
WHERE UPPER(STREET) = '163 MAIN ST';

-- disp staff whose position is the same as that of the staff sg14 and whose salary is greater than the staff sl41

SELECT *
FROM STAFF
WHERE POSITION = ( SELECT POSITION
                   FROM STAFF
                   WHERE STAFFNO = 'SG14')
                   
AND SALARY >
            ( SELECT SALARY FROM STAFF
              WHERE STAFFNO = 'SL41');
              
              

SELECT * 
FROM STAFF
WHERE BRANCHNO IN ( SELECT BRANCHNO
                    FORM BRANCH
                    WHERE UPPER(CITY) = 'LONDON');
              

SELECT *
FROM PROPERTYFORRENT
WHERE STAFFNO IN ( SELECT STAFFNO
                  FROM STAFF
                  WHERE BRANCHNO = ( SELECT BRANCHNO
                                     FROM BRANCH
                                     WHERE UPPER(STREET) = '163 MAIN ST');
              
              
