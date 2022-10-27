-- 1
CREATE SEQUENCE PARKING_NUM_SEQ
START WITH 100
INCREMENT BY 5
NOCACHE
CYCLE
MINVALUE 100
MAXVALUE 256;

--2
ALTER TABLE EMPLOYEE
ADD PARKING_NUM NUMERIC;

--3
UPDATE EMPLOYEE 
SET PARKING_NUM = PARKING_NUM_SEQ.NEXTVAL;

--4
SELECT * FROM EMPLOYEE;

-- 5 
ALTER SEQUENCE PARKING_NUM_SEQ
NOCYCLE

ALTER SEQUENCE PARKING_NUM_SEQ
CACHE 100

-- Part 2

--1 

CREATE TABLE EMAIL_LOG
( EMAIL_ID NUMERIC GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
EMAIL_DATE DATE,
EMP_NO INTEGER,
CONSTRAINT EMAILLOG_EMPNO_FK FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE);

-- Part 3

--1

CREATE VIEW VW_EMPOFD1
AS
SELECT E.*
FROM EMPLOYEE E JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE E.DEPT_NO = 'd1';

--2
CREATE VIEW VW_EMPOFPROJ
AS
SELECT P.PROJECT_NO, P.PROJECT_NAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON P.PROJECT_NO = W.PROJECT_NO;

-- 3
CREATE VIEW VW_EMPFLNAME_P2017
AS
SELECT E.EMP_FNAME, E.EMP_LNAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
WHERE TO_CHAR (ENTER_DATE, 'MM') > 06 AND TO_CHAR(ENTER_DATE, 'YYYY') > 2017;

--4
CREATE OR REPLACE VIEW VW_EMPFLNAME_P2017 (EMPLOYEE_FIRST_NAME, EMPLOYEE_LAST_NAME)
AS
SELECT E.EMP_FNAME, E.EMP_LNAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
WHERE TO_CHAR (ENTER_DATE, 'MM') > 06 AND TO_CHAR(ENTER_DATE, 'YYYY') > 2017;

--5
SELECT * FROM VW_EMPOFD1
WHERE EMP_LNAME LIKE 'M%'

--6
CREATE OR REPLACE VIEW VW_EMPOFD1
AS
SELECT E.*
FROM EMPLOYEE E JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE E.DEPT_NO = 'd1' AND E.DEPT_NO = 'd2';
-- WHERE UPPER(DEPT_NO) IN ('D1', 'D2');


--7
DROP VIEW VW_EMPFLNAME_P2017

--8
SELECT * FROM VW_EMPOFPROJ
INSERT INTO VW_EMPOFPROJ VALUES ('p2', 'Moon');

--9
CREATE VIEW VW_EMPFLNAME_WCHECK
AS
SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE
WHERE EMP_NO < 10000
WITH CHECK OPTION;

-- 10
CREATE OR REPLACE VIEW VW_EMPFLNAME_WCHECK
AS
SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE
WHERE EMP_NO < 10000;

--11
CREATE VIEW VW_E11
AS
SELECT *
FROM WORKS_ON
WHERE TO_CHAR (ENTER_DATE, 'YYYY') = 2017 AND TO_CHAR (ENTER_DATE, 'YYYY') = 2018
WITH CHECK OPTION;

UPDATE VW_E11
SET ENTER_DATE = '2016-06-01'
WHERE EMP_NO = 29346






