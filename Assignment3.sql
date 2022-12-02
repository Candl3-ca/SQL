/*1. Write a PL/SQL function. The function is passed a CsId as a parameter, and it returns
maximum number of seats available in the course section. The function performs
NO_DATA_FOUND exception when nothing is returned and, in this case, it will return –1
*/

CREATE OR REPLACE FUNCTION MAXIMUM_NUM (CRS_ID crssection.CsId%TYPE)
RETURN NUMBER
AS
MAX_NUM NUMBER;
BEGIN
SELECT MAX(MaxCount) INTO MAX_NUM
FROM crssection
WHERE CsId = CRS_ID;

IF (MAX_NUM > 0) THEN
RETURN MAX_NUM;
END IF; 
EXCEPTION WHEN NO_DATA_FOUND THEN
 RETURN -1;

END;

/*2. Write a PL/SQL stored procedure that is passed a room number as a parameter. if the
room number exists, the procedure gets the capacity of the room and the building name
from the location table. If the room number does not exist, the procedure performs the
appropriate exception-handling routine. Test your procedure.
*/

CREATE OR REPLACE PROCEDURE ROOM_NUM (ROOM_ID location.ROOMID%TYPE )
AS
VCOUNT NUMBER;
BEGIN
SELECT COUNT(*) INTO VCOUNT
FROM location
WHERE ROOM_ID = ROOMID;
IF (VCOUNT > 0) THEN 
FOR V IN (SELECT CAPACITY, BUILDING
            FROM LOCATION 
            WHERE ROOM_ID = ROOMID)LOOP
            DBMS_OUTPUT.PUT_LINE(V.CAPACITY || ' ' || V.BUILDING);
            END LOOP;
ELSE
    DBMS_OUTPUT.PUT_LINE('ROOMID DOESNT EXIST');

END IF;
END;



/*3. Create a PL/SQL function that calculates the salary ranking of the faculty based on the
current minimum and maximum salaries for faculties in the same department. The
function will accept the faculty id as a parameter. The ranking returned as a decimal,
based on the following calculation: ((sal - minsal)/(maxsal - minsal)) */

CREATE OR REPLACE FUNCTION salary_rank (p_fac_id IN NUMBER) RETURN NUMBER
IS
  v_min_sal NUMBER;
  v_max_sal NUMBER;
  v_sal NUMBER;
BEGIN
    SELECT MIN (salary), MAX (salary), salary INTO v_min_sal, v_max_sal, v_sal FROM faculty WHERE DeptId = (SELECT DeptId FROM faculty WHERE FacultyId = p_fac_id);
    RETURN ((v_sal - v_min_sal) / (v_max_sal - v_min_sal));
END;


/*4. Write a PL/SQL function where a department number is passed as parameter to it. If the
department number does exist, the function returns True, otherwise, it returns a FALSE
value. Print the appropriate message in the calling block based on the result. */

CREATE OR REPLACE FUNCTION USER_VALID_DEPTID(V_DEPTID DEPARTMENT.DEPTID%type)
RETURN BOOLEAN
AS
    DEPT_EXIST NUMBER;
BEGIN
    SELECT COUNT(*) INTO DEPT_EXIST 
    FROM DEPARTMENT 
    WHERE DEPTID = V_DEPTID;

    IF DEPT_EXIST = 1 THEN 
        DBMS_OUTPUT.PUT_LINE('DeptId exists');
    RETURN TRUE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('DeptId does not exists');
    RETURN FALSE;
    END IF;
END;




/*5. Write a trigger that is fired before the INSERT, UPDATE, DELETE statements execution on
the student table. The trigger checks the day based on Sysdate. If the day is Sunday, the
trigger does not allow the execution of the statements and raises an exception. Write
the appropriate message in the exception-handling section. Test your trigger with the
DML statements.*/

CREATE OR REPLACE TRIGGER day_check
BEFORE INSERT OR UPDATE OR DELETE ON student
FOR EACH ROW
BEGIN
    IF TO_CHAR(SYSDATE, 'D') = '7' THEN
        RAISE_APPLICATION_ERROR (-20000, 'You cannot perform DML operations on Sunday');
    END IF;
END;


/*6. Write a trigger that is fired after an update statement is executed for the salary of the
faculty table. The trigger writes the old faculty ID, and system’s date, the new and old
salary in a table called Facultytracking Table. (Note: you must create the table first)*/

CREATE TABLE facultytracking
(
    fac_id NUMBER(5),
    old_salary NUMBER(8,2),
    new_salary NUMBER(8,2),
    date_ DATE
);

CREATE OR REPLACE TRIGGER TRG_Facultytracking
AFTER UPDATE OF SALARY ON FACULTY
FOR EACH ROW
BEGIN 
    INSERT INTO Facultytracking VALUES (:OLD.fac_id,:OLD.old_salary , :NEW.new_salary,SYSDATE );
END;

UPDATE FACULTY
SET SALARY = SALARY + 50
WHERE FACULTYID = '222';







/*7. Write a PL/SQL trigger that when a student tries to enroll to a course (add a course in
registration table), the trigger checks the prerequisite of that course and if the course is
not exist in registration table which means student has not taken the prerequisite before
(prerequisites are not completed) the trigger will give an error and will report the
prerequisites of that course. Consider only one level pre-requisite check. For example, for
'CIS265', prerequisite is ('CIS253'). Test your trigger.*/

CREATE OR REPLACE TRIGGER prereq_check
BEFORE INSERT ON registration
FOR EACH ROW
DECLARE
  v_prereq VARCHAR2(20);
BEGIN
    SELECT prereq INTO v_prereq FROM course WHERE courseId = :NEW.courseId;
    IF v_prereq IS NOT NULL THEN
        IF NOT EXISTS (SELECT * FROM registration WHERE course = v_prereq AND student = :NEW.student) THEN
            RAISE_APPLICATION_ERROR (-20000, 'You must take ' || v_prereq || ' before taking ' || :NEW.courseId);
        END IF;
    END IF;
END;

--;lgkrnodbjsk flmdvekas;w,ofkrpitjwguhknbfm vd,cz.ksxl:EOKfrpaijgtuhnbvmd,lcs;opefrijsgtuhknfbvmdl;cso,preisgtjudhknfbmvld,;osrepa[ktisgjyhug

/*8. Write a PL/SQL stored procedure that is passed a student’s identification number as a
parameter. Verify that the student has enrolled in some courses. If it does not enroll in
any course, then a message should be displayed stating that the student does not exist. If
it does exist, return the number of courses taken by this student to the calling program.
Test the procedure*/

CREATE OR REPLACE PROCEDURE course_count (p_student IN NUMBER)
IS
  v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM registration WHERE student = p_student;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE ('Student ' || p_student || ' does not exist');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Student ' || p_student || ' has taken ' || v_count || ' courses');
    END IF;
END;

--jfknhbgvmc d,xksl,;aopewirfjgtufhjbknvc m,kxlsd,;oewpirtughjknfbvmdls;oewpri34tjughknfdvlmerw;opr34i5tjuhykgnfmel;lewrokltgijnfm,b d.ksel;wokprijtguhkfbndvmklsew;or3p4ij5tuhgkfn


/*9. The student average of the specified course is automatically inserted whenever a grade
is inserted in the registration table. Write a row-level trigger that updates the student
average in the registration table after a new midterm or final grades added to the table.
(Average should be the sum of the two grades divided by 2) check the average after the
update and if it’s less than 60 display a warning message with the student Id.
*/

CREATE OR REPLACE TRIGGER TRG_AVG
AFTER UPDATE OR INSERT OF MIDTERM, FINAL ON REGISTRATION
FOR EACH ROW
DECLARE 
STUDID REGISTRATION.STUDENTID%TYPE;
VAVERAGE REGISTRATION.AVERAGE%TYPE;
BEGIN
VAVERAGE := (:NEW.MIDTERM + :NEW.FINAL)/2;
UPDATE REGISTRATION
SET AVERAGE = VAVERAGE
WHERE STUDENTID = :OLD.STUDENTID;

IF (VAVERAGE < 60) THEN
DBMS_OUTPUT.PUT_LINE('WARNING STUDENT' || STUDID || ' AVERAGE TOO LOW');
END IF;
END;

/*10. Create a PL/SQL procedure to add bonus to student final grade. The procedure will
accept student id, course id and bonus rate as parameters. The procedure checks
whether the final grade for the student is null, if so, raise an exception that you declared
to catch when the grade is null. If the final grade is more than 80%, increase the grade
by the bonus rate and display a message to show the new grade along with the
student_id and course_id, otherwise, display No Bonus Allowed.*/

CREATE OR REPLACE PROCEDURE add_bonus (p_student IN NUMBER, p_course IN VARCHAR2, p_bonus IN NUMBER)
IS
  v_final NUMBER;
BEGIN
    SELECT final INTO v_final FROM registration WHERE student = p_student AND course = p_course;
    IF v_final IS NULL THEN
        RAISE_APPLICATION_ERROR (-20000, 'Student ' || p_student || ' has not taken course ' || p_course);
    END IF;
    IF v_final > 80 THEN
        UPDATE registration SET final = final + p_bonus WHERE student = p_student AND course = p_course;
        DBMS_OUTPUT.PUT_LINE ('Student ' || p_student || ' has taken course ' || p_course || ' and has been given a bonus of ' || p_bonus);
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Student ' || p_student || ' has taken course ' || p_course || ' and has not been given a bonus');
    END IF;
END;

--tgirhukjbfnvdmls;erowpigtjuhyjkfdbndvlms;c,opersigtjdhuyknfbm,dvl.;spe[aros9tilgjdhukfxbnvmzld;sopera09ist8guldhkjfnxbdmlvz;soper9istg8ujdhknfbm,dvl.s;cpf'[erogiktjhukgyfnbml,vd,;s
