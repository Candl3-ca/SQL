SELECT * FROM EMPLOYEE
SELECT * FROM DEPARTMENT
SELECT * FROM PROJECT
SELECT * FROM WORKS_ON


-- QUESTION 1

SELECT *
FROM EMPLOYEE JOIN DEPARTMENT
ON EMPLOYEE.DEPT_NO = DEPARTMENT.DEPT_NO

-- QUESTION 2

SELECT ENTER_DATE, JOB, DEPT_NO
FROM WORKS_ON W JOIN EMPLOYEE E
ON W.EMP_NO = E.EMP_NO
WHERE UPPER(JOB) = 'CLERK' AND UPPER(DEPT_NO) = 'D1'

-- QUESTION 3

SELECT E.*, PROJECT_NAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON P.PROJECT_NO = W.PROJECT_NO
WHERE UPPER(PROJECT_NAME) = 'GEMINI'

-- QUESTION 4

SELECT *
FROM EMPLOYEE JOIN WORKS_ON
ON EMPLOYEE.EMP_NO = WORKS_ON.EMP_NO
WHERE ENTER_DATE = '2017-10-15'

-- QUESTION 5

SELECT *
FROM EMPLOYEE JOIN DEPARTMENT
ON EMPLOYEE.DEPT_NO = DEPARTMENT.DEPT_NO

-- QUESTION 6

SELECT * 
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE UPPER(JOB) = 'ANALYST' AND UPPER(LOCATION) = 'SEATTLE'

-- QUESTION 7

SELECT DISTINCT PROJECT_NAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON P.PROJECT_NO = W.PROJECT_NO
JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE UPPER(DEPT_NAME) = 'ACCOUNTING'

-- QUESTION 8

SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE E JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE UPPER(DEPT_NAME) = 'RESEARCH' OR UPPER(DEPT_NAME) = 'ACCOUNTING'

-- QUESTION 9

SELECT PROJECT_NAME, COUNT(EMP_NO) AS "CLERKS EMPLOYEES"
FROM PROJECT P JOIN WORKS_ON W
ON P.PROJECT_NO = W.PROJECT_NO
WHERE UPPER(JOB) = 'CLERK'
GROUP BY PROJECT_NAME
HAVING COUNT(EMP_NO) >= 2

-- QUESTION 10

SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON W.PROJECT_NO = P.PROJECT_NO
WHERE UPPER(JOB) = 'MANAGER' AND UPPER(PROJECT_NAME) = 'APOLLO'