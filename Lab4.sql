SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM DEPARTMENT;
SELECT * FROM WORKS_ON;

-- PART A

-- QUESTION 1
ALTER TABLE PROJECT
ADD CONSTRAINT PROJECT_BUDGET CHECK (BUDGET >10000 AND BUDGET <1500000);

-- QUESTION 2
ALTER TABLE PROJECT
ADD CONSTRAINT PROJECT_INVALID_NAME UNIQUE (PROJECT_NAME);

-- QUESTION 3
ALTER TABLE EMPLOYEE
MODIFY EMP_FNAME VARCHAR(30);

ALTER TABLE EMPLOYEE
MODIFY EMP_LNAME VARCHAR(30);

-- QUESTION 4
ALTER TABLE EMPLOYEE
ADD TELEPHONE_NO VARCHAR(12);

-- QUESTION 5
ALTER TABLE EMPLOYEE
DROP COLUMN TELEPHONE_NO;


-- PART B

-- QUESTION 1
SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE
WHERE DEPT_NO IN (
                    SELECT DEPT_NO FROM DEPARTMENT
                    WHERE DEPT_NAME = 'Research');
                    

-- QUESTION 2
SELECT * FROM EMPLOYEE
WHERE DEPT_NO IN (
                   SELECT DEPT_NO FROM DEPARTMENT
                   WHERE LOCATION = 'Dallas');
                   

-- QUESTION 3
SELECT EMP_LNAME FROM EMPLOYEE
WHERE EMP_NO IN  (
                    SELECT EMP_NO FROM WORKS_ON
                    WHERE PROJECT_NO = (
                                         SELECT PROJECT_NO FROM PROJECT
                                         WHERE PROJECT_NAME = 'Apollo'));
                                         

-- QUESTION 4
SELECT EMP_NO, ENTER_DATE
FROM WORKS_ON
WHERE ENTER_DATE = (SELECT MIN(ENTER_DATE) FROM WORKS_ON);


-- QUESTION 5
SELECT EMP_LNAME, EMP_FNAME
FROM EMPLOYEE
WHERE EMP_NO = (
                SELECT EMP_NO FROM WORKS_ON
                WHERE ENTER_DATE = '2017-01-04');
                

-- QUESTION 6
SELECT EMP_NO FROM WORKS_ON
WHERE JOB = 'Clerk'
OR EMP_NO IN (
               SELECT EMP_NO FROM EMPLOYEE
               WHERE DEPT_NO = (
                                 SELECT DEPT_NO FROM DEPARTMENT
                                 WHERE DEPT_NO = 'd3'));
                                 

-- QUESTION 7
SELECT PROJECT_NO, PROJECT_NAME
FROM PROJECT
WHERE BUDGET = (
                SELECT MAX(BUDGET) FROM PROJECT);


-- QUESTION 8
SELECT PROJECT_NAME FROM PROJECT
WHERE PROJECT_NO = (
                        SELECT PROJECT_NO FROM WORKS_ON
                        WHERE JOB = 'Clerk'
                        GROUP BY PROJECT_NO
                        HAVING COUNT(JOB)>1);
                        
-- QUESTION 9
SELECT EMP_LNAME FROM EMPLOYEE
WHERE EMP_NO IN (
                  SELECT EMP_NO FROM WORKS_ON
                  WHERE PROJECT_NO = NULL);
                
--Q10
SELECT EMP_LNAME FROM EMPLOYEE
WHERE DEPT_NO NOT IN (
                       SELECT DEPT_NO FROM DEPARTMENT
                       WHERE LOCATION = 'Seattle');
