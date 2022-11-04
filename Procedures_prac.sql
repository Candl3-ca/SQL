/* 1) Create a stored procedure Proc_increase_budget that increases the budgets of all 
projects for a certain percentage value that is defined using the parameter percent. 
Use EXECUTE statement to execute the stored procedure Proc_increase_budget and 
increases the budgets of all projects by 10 percent. */

CREATE OR REPLACE PROCEDURE PROC_INC_BUDGET  (PERCENT NUMERIC)
AS
BEGIN
UPDATE PROJECT
SET BUDGET = BUDGET + BUDGET * (PERCENT/100);
DBMS_OUTPUT.PUT_LINE('***** BUDGET HAS BEEN UPDATED SUCCESSFULLY *****');
END;


EXECUTE PROC_INC_BUDGET (20);

/* 2) Create a simple stored procedure Proc_employees_in_dept that displays the id 
numbers and family names of all employees working for a particular department. (The 
department number is a parameter that must be specified when the procedure is 
invoked.) Execute the procedure by passing a department number. */


CREATE OR REPLACE PROCEDURE PROC_EMP_INDETP (VDEPT_NO DEPARTMENT.DEPT_NO%TYPE)
AS
DCOUNT NUMBER;
BEGIN
-- VALIDATE DEPARTMENT NUMBER
SELECT COUNT(*) INTO DCOUNT
FROM EMPLOYEE 
WHERE DEPT_NO = VDEPT_NO;
IF (DCOUNT > 0) THEN -- IF NUMBER RETURNS POSITIVE (LIKE) DEPARTMENT EXISTS AND HAS EMPLOYEES
FOR V IN (  SELECT EMP_NO, EMP_LNAME FROM EMPLOYEE 
            WHERE DEPT_NO = VDEPT_NO) LOOP
            DBMS_OUTPUT.PUT_LINE(V.EMP_NO || ' HAS THE LAST NAME ' || V.EMP_LNAME);
            END LOOP;
ELSE
    DBMS_OUTPUT.PUT_LINE('NO EMPLOYEES ARE FOUND IN SELECTED DEPARTMENT');
END IF;
END;

EXECUTE PROC_EMP_INDETP ('d1');



/* 3) Create Proc_employees_name_project procedure to display names of all employees 
that belong to a particular project. Use input parameter pr_number to specify a 
project number.  */


CREATE OR REPLACE PROCEDURE PROC_EMPNAME_PROJ (VPROJECT_NO PROJECT.PROJECT_NO%TYPE)
AS
BEGIN
FOR V IN (SELECT EMP_FNAME, EMP_LNAME
          FROM EMPLOYEE E JOIN WORKS_ON W
          ON E.EMP_NO = W.EMP_NO
          WHERE PROJECT_NO = VPROJECT_NO) LOOP
          DBMS_OUTPUT.PUT_LINE(V.EMP_FNAME || ' ' || V.EMP_LNAME);
END LOOP;
END;

EXECUTE PROC_EMPNAME_PROJ ('p2');



/* 4) Write a procedure named PRC_EMPLOYEE_ADD to add a new employee record to the 
Employee table. Use the following values in the new record: (1100, ‘Jain’, ‘Smith’, ‘d1’). 
You should execute the procedure and verify that the new employee was added to 
ensure your code is correct. */


CREATE OR REPLACE PROCEDURE PROC_EMP_ADD (VNO INTEGER, VFNAME VARCHAR, VLNAME VARCHAR, VDNO VARCHAR)
AS
BEGIN
INSERT INTO EMPLOYEE VALUES (VNO, VFNAME, VLNAME, VDNO);
DBMS_OUTPUT.PUT_LINE('NEW EMPLOYEE HAS SUCCESSFULLY BEEN ADDED');
END;


EXECUTE PROC_EMP_ADD (1100, 'Jain', 'Smith', 'd1');




/* 5) Write a stored procedure named Proc_MaxBudget which will return as output the 
highest project budget.  */


CREATE OR REPLACE PROCEDURE PROC_MAX_BUDGET (HIGHEST OUT NUMBER)
AS
BEGIN
SELECT MAX(BUDGET) INTO HIGHEST
FROM PROJECT;
END;


-- TO CALL

DECLARE
RESULT NUMBER;
BEGIN
PROC_MAX_BUDGET(RESULT);
DBMS_OUTPUT.PUT_LINE('THE HIGHEST BUDGET FOR THE PROJECTS IS ' || RESULT);
END;


/* 6) Write a stored procedure named Proc_GetEmployeesNames which will display the 
employee’s first name and last name who works at department located at a given 
location. If the location is empty, please print a message saying, “The input location 
cannot be empty.” */

CREATE OR REPLACE PROCEDURE PROC_GETEMP_NAME (VLOCATION VARCHAR)
AS
BEGIN
IF (VLOCATION IS NOT NULL) THEN
    FOR V IN (SELECT EMP_FNAME, EMP_LNAME FROM 
                EMPLOYEE E JOIN DEPARTMENT D  
                ON E.DEPT_NO = D.DEPT_NO
                WHERE LOCATION = VLOCATION) LOOP
                DBMS_OUTPUT.PUT_LINE(V.EMP_FNAME ||  V.EMP_LNAME);
                END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('THE INPUT LOCATION CANNOT BE EMPTY');
    END IF;
END;

EXECUTE PROC_GETEMP_NAME ('Dallas');



/* 7) Create Proc_delete_emp procedure to delete an employee from employee and 
works_on tables respectively, giving the employee number as a parameter. Test the 
procedure by deleting employee number 28559.  */


CREATE OR REPLACE PROCEDURE PROC_DELEMP (VEMP_NO INTEGER)
AS
BEGIN
DELETE FROM WORKS_ON WHERE EMP_NO = VEMP_NO;
DELETE FROM EMPLOYEE WHERE EMP_NO = VEMP_NO;
END;

-- CALL

EXEC PROC_DELEMP (28559);


/* 8) Create a procedure to calculate the number of projects on which the employee (with 
the employee number employee_no) works. The calculated value is then assigned to 
the @counter parameter. The counter parameter must be declared with the OUTPUT 
option in the procedure as well as in the EXECUTE statement.  */


CREATE OR REPLACE PROCEDURE PROC_EMP_COUNT (VEMP_NO IN INTEGER, COUNTER OUT NUMBER)
AS
BEGIN
SELECT COUNT(PROJECT_NO) INTO COUNTER
FROM WORKS_ON
WHERE EMP_NO = VEMP_NO;
END;

-- TO CALL

DECLARE
COUNT_PROJ NUMBER;
BEGIN
PROC_EMP_COUNT (28559, COUNT_PROJ);
DBMS_OUTPUT.PUT_LINE('THE NUMBER OF PROJECTS ON WHICH THE EMPLOYEE WORKS ON IS ' || COUNT_PROJ );
END;
