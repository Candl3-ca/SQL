-- Write PL/SQL code that searches for a specific project by its project ID and displays the 
-- project ID and the project name for that project.

DECLARE 
VPNUM PROJECT.PROJECT_NO%TYPE := 'p1';
VPNAME VARCHAR(40);
VBUDGET NUMERIC(10,3);


BEGIN
SELECT PROJECT_NAME, BUDGET INTO VPNAME, VBUDGET 
FROM PROJECT
WHERE PROJECT_NO = VPNUM;
DBMS_OUTPUT.PUT_LINE('PROJECT NAME IS ' || VPNAME);
DBMS_OUTPUT.PUT_LINE('PROJECT BUDGET IS ' || VBUDGET);

EXCEPTION 
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS RETURNED');
    
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO DATA ROWS RETURNED');

END;


-- Create a PL/SQL block that inserts 300 rows in the employee table. The values of the 
-- emp_no column should be unique and between 1 and 300. All values of the columns 
-- emp_lname, emp_fname, and dept_no should be set to 'Jane', 'Smith', and 'd1', 
-- respectively.

DECLARE
VEMP_NUM NUMBER :=1;
VFNAME EMPLOYEE.EMP_FNAME%TYPE := 'JANE';
VLNAME EMPLOYEE.EMP_LNAME%TYPE := 'SMITH';
VDNO EMPLOYEE.DEPT_NO%TYPE := 'd1';




BEGIN
WHILE( VEMP_NUM <= 300) LOOP
    INSERT INTO EMPLOYEE VALUES (VEMP_NUM, VFNAME, VLNAME, VDNO);
    VEMP_NUM := VEMP_NUM +1;
    
END LOOP;
END;



-- calculate the average of all project budgets and compares this value with the budget of 
-- ‘p1’ project stored in the project table. If the latter value is smaller than the calculated 
-- value, the budget of project p1 will be increased by the value of the local variable 
-- extra_budget, which is (15000). 


DECLARE 
VAVG NUMERIC (10,2); 
PBUDGET NUMERIC;
PNUM PROJECT.PROJECT_NO%TYPE := 'd1';
EXTRA_BUDGET NUMERIC := 15000;

BEGIN
SELECT AVG(BUDGET) INTO VAVG FROM PROJECT;
SELECT BUDGET INTO PBUDGET FROM PROJECT WHERE PROJECT_NO = PNUM
IF (PBUDGET < VAVG) THEN
    UPDATE PROJECT
    SET BUDGET = BUDGET + EXTRA_BUDGET;
DBMS_OUTPUT.PUT_LINE('PROJECT ' || PNUM || ' HAS BEEN UPDATED');
END;



/* Write PL/SQL block that calculates the number of years each employee has worked based 
 on the enter_DATE column of the works_on table. If the employee has worked for ten or 
 less years the system prints the message “Consider a Bonus for: <employee name>”. */
 
 DECLARE
NOYEARS NUMBER;
BEGIN
 FOR V IN ( SELECT E.EMP_NO, ENTER_DATE , EMP_FNAME || EMP_LNAME AS FULLNAME
            FROM EMPLOYEE E JOIN WORKS_ON W
            ON E.EMP_NO = W.EMP_NO) LOOP
   -- NOYEARS := TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(V.ENTER_DATE, 'YYYY');
    NOYEARS := EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM V.ENTER_DATE);
    IF (NOYEARS <= 10 ) THEN
          DBMS_OUTPUT.PUT_LINE('Consider a Bonus for:' || V.FULLNAME);
    END IF;
 
END LOOP;
END;

/*Get the number of employees that work on project 'p1'. Print a message If the number of
employees is greater than 2. If not find those employees who work in project p1 and
belong to the Sales department. */

DECLARE
VCOUNT NUMBER ;
VPNUM PROJECT.PROJECT_NO%TYPE := 'p1';
VEMP_NO NUMBER;
BEGIN
SELECT COUNT(*) INTO VCOUNT FROM WORKS_ON WHERE PROJECT_NO = VPNUM;
IF (VCOUNT > 2) THEN
    DBMS_OUTPUT.PUT_LINE('The number of employees is greater than 2');
ELSE
 SELECT E.EMP_NO INTO VEMP_NO
 FROM EMPLOYEE E JOIN WORKS_ON W
 ON E.EMP_NO = W.EMP_NO
 JOIN DEPARTMENT D
 ON E.DEPT_NO = D.DEPT_NO
 WHERE UPPER(DEPT_NAME) = 'SALES' AND PROJECT_NO = VPNUM;
END IF;
 EXCEPTION
 WHEN TOO_MANY_ROWS THEN 
  DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS RETURNED');
 WHEN NO_DATA_FOUND THEN 
  DBMS_OUTPUT.PUT_LINE('NO DATA FOUND'); 

END;





