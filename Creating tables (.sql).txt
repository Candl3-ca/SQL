CREATE TABLE TableName
 
{ (colName dataType [(size)] [CONSTRAINT constraint_name] [constraint_type], [,...n]);}




VARCHAR  ( MaxLength ) 

- we use it to store strings

- max size is 8000 characters



CHAR ( FixedLength )

- we use it to store fixed lengths

-- e.g. a phone number is always 9 numbers

-- good to use when we dont use calculations on a number

- by deault size == 1



NUMERIC [( precission, sclae )]



DATE and TIME 



ALL CONSTRAINTS :

1) NOT NULL
2) UNIQUE -- dissallows for multiple same values ( but could allow for it to be null ) 
3) PRIMARY KEY
4) SECONDARY KEY
5) CHECK -- 


-----------------------------------------------------

-----  CREATING A TABLE -----------



CREATE TABLE DEPARTMENT 
(DEP_ID CHAR(6) PRIMARY KEY,
DEPT_NAME VARCHAR(30) NOT NULL UNIQUE,
DEPT_TELL CHAR(9)
);

SELECT * FROM DEPARTMENT

SELECT TABLE_NAME FROM USER_TABLES -- to check the tables

SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS -- To check the constraints 

DROP TABLE DEPARTMENT -- to delete the table



-- naming the constraints is a better habbit

CREATE TABLE DEPARTMENT 
(DEP_ID CHAR(6) CONSTRAINT DEPARTEMENT_DEPTID_PK PRIMARY KEY,
DEPT_NAME VARCHAR(30) CONSTRAINT DEPARTMENT_DEPTNAME_UK UNIQUE,
DEPT_TELL CHAR(9)
);


INSERT INTO DEPARTMENT VALES ( '1000', 'COMP_SCI', '123456');
INSERT INTO DEPARTMENT VALES ( '2000', 'HR', '123456');

--------------------------------------------------------------


CREATE TABLE EMPLOYEE
(EMP_ID CHAR(9) CONSTRAINT EMP_PK PRIMARY KEY,
FNAME VARCHAR(25) CONSTRAINT EMP_FNAME NOT NULL,
LNAME VARCHAR(25) CONSTRAINT EMP_LNAME NOT NULL,
DOB DATE,
SALARY NUMBER(9,2) CHECK ( SALARY BETWEEN 1000 AND 100000),                 -- can allow for a max of 9 numbers with 2 of them being in decimal places
DEPT_ID CHAR(6),                                                            -- must match the same data type from the other table
CONSTRAINT EMPLOYEE_DEPTID_FK FOREIGN KEY (DEPT_ID) REFERENCES DEPARTEMENT
);

INSERT INTO EMPLOYEE VALUES ('123456', 'AAAA', 'BBBB', NULL, 1200, '100');
INSERT INTO EMPLOYEE VALUES ('123457', 'CCCC', 'DDDD', NULL, 2000, '100');
INSERT INTO EMPLOYEE VALUES ('123458', 'CCCC', 'DDDD', NULL, 12000, '200');



