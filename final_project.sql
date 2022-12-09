CREATE SEQUENCE GEN_GUIDE_ID
START WITH 000001
INCREMENT BY 13
CYCLE
MAXVALUE 999999;

 CREATE TABLE GUIDES (
 GUIDES_ID NUMERIC GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 FULL_NAME VARCHAR(30) NOT NULL,
 STREET_NO VARCHAR(5) NOT NULL,
 STREET_NAME VARCHAR(20) NOT NULL,
 CITY VARCHAR(10) NOT NULL,
 ZIPCODE VARCHAR(6) NOT NULL,
 DATE_OF_HIRE DATE,
 IS_QUALIFIED CHAR(3) NOT NULL,
 NO_OF_TRIPS VARCHAR(4));

 CREATE INDEX GUIDES_ISQUALIFIED_IDX 
 ON GUIDES (IS_QUALIFIED);
 --CREATING AN INDEX FOR GUIDES SINCE WE WANNA QUICKLY CHECK IF THEY'RE QUALIFIED OR NOT
 --BY INDEXING THIS TABLE, WE CAN SEE QUALIFIED GUIDES EASILY


 CREATE TABLE TRIP (
 TRIP_ID CHAR(4) PRIMARY KEY,
 DATE_ DATE,
 TIME VARCHAR(10),
 IS_NEW CHAR(3),
 GUIDES_ID NUMERIC REFERENCES GUIDES ON DELETE CASCADE); -- SO WE DELETEINFORMATION ABOUT UNAVAILABLE GUIDES

 ALTER TABLE GUIDES
 ADD TRIP_ID CHAR(4);

 ALTER TABLE GUIDES
 ADD CONSTRAINT INV_ID FOREIGN KEY(TRIP_ID) REFERENCES TRIP ON DELETE CASCADE; -- SO WE DONT SHOW INFORMATION ABOUT UNAVAILABLE TRIPS

 CREATE TABLE TOURS (
 TOURS_ID CHAR(6) PRIMARY KEY,
 TOUR_NAME VARCHAR(20) UNIQUE,
 LENGTH VARCHAR(10),
 FEE NUMERIC,
 TRACKER VARCHAR(10),
 TRIP_ID CHAR(4) REFERENCES TRIP ON DELETE CASCADE); -- SO WE DONT SHOW INFORMATION ABOUT UNAVAILABLE TOURS

 ALTER TABLE TRIP
 ADD TOURS_ID CHAR(6) REFERENCES TOURS;

 CREATE TABLE TOURS_TO_GUIDE (
 GUIDES_ID NUMERIC REFERENCES GUIDES,
 TOURS_ID CHAR(6) REFERENCES TOURS,
 PRIMARY KEY(GUIDES_ID, TOURS_ID));


 --GUIDS--

INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Savannah', 'Mollie', '112', 'Port Tiqua', 'Montreal', 'F2F3D3', '2020-06-01', 'NO.', '1', '1234');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Alfie', 'Ava', '1145', 'Limes Elms', 'La Lynn', 'J3V9D2', '2019-10-11', 'YES', '4', '1235');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Christine', 'Scarlet', '1012', 'Gresham Holt', 'Mckuujleigh', 'K3F9H5', '2022-03-04', 'YES', '3', '1236');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Eleanor', 'Mary', '1543', 'Whitehouse Links', 'Richtim', 'L3F8H4', '2015-02-09', 'YES', '5', '1237');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Melissa', 'Darcie', '1875', 'Evergreen Poplars', 'Bampglens', 'Q9F4N1', '2014-12-01', 'NO.', '2', '1238');
..................................................................................................................
--TRIP--

INSERT INTO TRIP VALUES ('1234', '2022-12-12', '12:00 PM', 'YES','123456', GEN_GUIDE_ID.NEXTVAL);
INSERT INTO TRIP VALUES ('1235', '2022-11-12', '12:00 PM', 'YES','123457', GEN_GUIDE_ID.NEXTVAL);
INSERT INTO TRIP VALUES ('1236', '2022-10-12', '12:00 PM', 'YES','123458' , GEN_GUIDE_ID.NEXTVAL);
INSERT INTO TRIP VALUES ('1237', '2022-09-12', '12:00 PM', 'NO','123459' , GEN_GUIDE_ID.NEXTVAL);
INSERT INTO TRIP VALUES ('1238', '2022-08-12', '12:00 PM', 'NO','123450' , GEN_GUIDE_ID.NEXTVAL);
..................................................................................................................
--TOURS--

INSERT INTO TOURS VALUES('123456', 'Minute To Visit', '3 MONTHS', 3050, '4 P.M. 2014-14-22', '1234');
INSERT INTO TOURS VALUES('123457', 'Minute To Visit', '4 MONTHS', 4020, '8 A.M. 2019-09-11', '1235');
INSERT INTO TOURS VALUES('123458', 'Minute To Visit', '5 MONTHS', 5600, '1:15 P.M. 2018-10-05', '1236');
INSERT INTO TOURS VALUES('123459', 'Minute To Visit', '6 MONTHS', 6100, '6:45 A.M. 2017-10-31', '1237');
INSERT INTO TOURS VALUES('123450', 'Minute To Visit', '7 MONTHS', 7080, '9 A.M 2016-05-02', '1238');
..................................................................................................................
--TOURS-TO-GUIDE--

INSERT INTO TOURS_TO_GUIDE VALUES(GEN_GUIDE_ID.NEXTVAL, '123456');
INSERT INTO TOURS_TO_GUIDE VALUES(GEN_GUIDE_ID.NEXTVAL, '123457');
INSERT INTO TOURS_TO_GUIDE VALUES(GEN_GUIDE_ID.NEXTVAL, '123458');
INSERT INTO TOURS_TO_GUIDE VALUES(GEN_GUIDE_ID.NEXTVAL, '123459');
INSERT INTO TOURS_TO_GUIDE VALUES(GEN_GUIDE_ID.NEXTVAL, '123450');
..................................................................................................................
 --Locations--
INSERT INTO LOCATION VALUES(GENN_LOCATION_ID.NEXTVAL, 'Quebec Walking Tour', 'Walking Tour', 'Take this Private Quebec Walking Tour and get the chance to enjoy the best of Quebec City.');
INSERT INTO LOCATION VALUES(GENN_LOCATION_ID.NEXTVAL, 'Montreal Tour from Quebec City', 'Chilling Tour', 'Join us on this Private Montreal Tour from Ottawa and get the chance to enjoy the historical part of Montreal.');
INSERT INTO LOCATION VALUES(GENN_LOCATION_ID.NEXTVAL, 'Montmorency Falls from Quebec City', 'Discovering Tour' ,'Take this Montmorency Falls from Quebec City and get the chance to enjoy the best of Quebec City.');
INSERT INTO LOCATION VALUES(GENN_LOCATION_ID.NEXTVAL, 'Private Quebec Tour', 'Enjoable Tour', 'Take this Private Quebec Tour and get the chance to enjoy the best of Quebec City.');
INSERT INTO LOCATION VALUES(GENN_LOCATION_ID.NEXTVAL, 'Parc de la Chute-Montmorency', 'Adventure/Activities', 'The cable car is the perfect vantage point from which to watch the 83-metre-high waterfall flow into the St. Lawrence River.');
..................................................................................................................
 --Tourists--
 INSERT INTO TOURISTS VALUES('111222', 'Forty', 'Horty', '4381112222', '112', 'K0G3H6', 'Montreal', 'Saint Bob');
 INSERT INTO TOURISTS VALUES('111333', 'Mario', 'Carty', '4381113333', '154', 'G5H5D7', 'Montreal', 'Saint Mars');
 INSERT INTO TOURISTS VALUES('111444', 'Kevin', 'Emile', '4381114444', '168', 'G8W6N7', 'Montreal', 'Saint Part2');
 INSERT INTO TOURISTS VALUES('111555', 'Hojin', 'Lont', '4381115555', '182', 'E8W4T8', 'Montreal', 'Saint Ontomy');
 INSERT INTO TOURISTS VALUES('111666', 'Sejin', 'Pont', '4381117777', '194', 'J5K0G5', 'Montreal', 'Saint Marku');
 ..................................................................................................................
 --TOUR-TO-LOCATION--

INSERT INTO TOUR_TO_LOCATION VALUES ('123456',GENN_LOCATION_ID.NEXTVAL);
INSERT INTO TOUR_TO_LOCATION VALUES ('123457',GENN_LOCATION_ID.NEXTVAL);
INSERT INTO TOUR_TO_LOCATION VALUES ('123458',GENN_LOCATION_ID.NEXTVAL);
INSERT INTO TOUR_TO_LOCATION VALUES ('123459',GENN_LOCATION_ID.NEXTVAL);
INSERT INTO TOUR_TO_LOCATION VALUES ('123450',GENN_LOCATION_ID.NEXTVAL);

..................................................................................................................
--TRIP-TO-TOURIST--

INSERT INTO TRIP_TO_TOURIST VALUES ( '1234', '111222');
INSERT INTO TRIP_TO_TOURIST VALUES ( '1235', '111333');
INSERT INTO TRIP_TO_TOURIST VALUES ( '1236', '111444');
INSERT INTO TRIP_TO_TOURIST VALUES ( '1237', '111555');
INSERT INTO TRIP_TO_TOURIST VALUES ( '1238', '111666');

CREATE SEQUENCE GENN_LOCATION_ID
START WITH 11
INCREMENT BY 11
NOCYCLE
MAXVALUE 999999;

CREATE TABLE LOCATION(
LOCATION_ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
NAME VARCHAR(50) NOT NULL,
TYPE VARCHAR(10) NOT NULL,
DESCRIPTION VARCHAR(200)
);

CREATE INDEX LOCATION_IDANDTYPE_IDX
ON LOCATION (LOCATION_ID, TYPE);
--CREATING AN INDEX FOR LOCATION SINCE IT IS ONE OF THE LEAST MANIPULATED TABLE AND
--BY INDEXING THIS TABLE, WE CAN SEE TOURS(WHICH CONTAINS TRIPS) EASILY.

CREATE TABLE TOUR_TO_LOCATION(
TOURS_ID CHAR(6),
LOCATION_ID INT,
CONSTRAINT TOURS_ID_FK FOREIGN KEY (TOURS_ID) REFERENCES TOURS ON DELETE CASCADE,
--SO THAT IT DOES NOT LEAVE ANY TOUR WITHOUT A LOCATION (A TOUR NEEDS AT LEAST THREE LOCATIONS)
CONSTRAINT PK_TOUR_TO_LOCATION PRIMARY KEY(TOURS_ID,LOCATION_ID)
);

ALTER TABLE TOUR_TO_LOCATION
ADD FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION ON DELETE CASCADE;
--SO THAT IT DOES NOT SHOW ANY LOCATION WITHOUT A TOUR(ALL LOCATIONS ARE VISITED BY AT LEAST ONE TOUR)

CREATE TABLE TOURIST(
TOURIST_ID CHAR(4) PRIMARY KEY,
FNAME VARCHAR(30) NOT NULL,
LNAME VARCHAR(30) NOT NULL,
PHONE# CHAR(10),
STREET# VARCHAR(10),
ZIPCODE VARCHAR(20),
CITY VARCHAR(30),
STREET_NAME VARCHAR(30)
);

CREATE TABLE TRIP_TO_TOURIST(
TRIP_ID CHAR(6),
TOURIST_ID CHAR(4),
CONSTRAINT TRIP_ID_FK FOREIGN KEY (TRIP_ID) REFERENCES TRIP ON DELETE CASCADE,
--SO THAT THERE IS NO TRIP WITHOUT A TOURIST
CONSTRAINT PK_TRIP_TO_TOURIST PRIMARY KEY(TRIP_ID,TOURIST_ID)
);

ALTER TABLE TRIP_TO_TOURIST
ADD FOREIGN KEY (TOURIST_ID) REFERENCES TOURIST ON DELETE CASCADE;
--SO THAT THERE IS NO TOURIST WITHOUT A TRIP



 -- //////////////////////////////////////////////////////////////////////////

 /*1. Develop at least 3 complex queries and 2 views. SELECT queries that represent answers
to likely business questions to be faced by the users of your database system. */

--1.1. SELECT queries that represent answers to likely business questions to be faced by the users of your database system.

--1.1.1. SELECT queries that represent answers to likely business questions to be faced by the users of your database system.


--COMPLEX SELECT QUERY 1 (TOURS WITH MORE THAN 3 LOCATIONS AND MORE THAN 2 TOURISTS)
SELECT TOURS_ID, COUNT(LOCATION_ID) AS NUMBER_OF_LOCATIONS, COUNT(TOURIST_ID) AS NUMBER_OF_TOURISTS
FROM TOUR_TO_LOCATION NATURAL JOIN TRIP_TO_TOURIST
GROUP BY TOURS_ID
HAVING COUNT(LOCATION_ID) > 3 AND COUNT(TOURIST_ID) > 2;

--COMPLEX SELECT QUERY 2 WITH MULTIPLE SELECT STATEMENTS (SELECTING GUIDE NAME WHERE LOCATION IS MONTREAL)
SELECT GUIDES_ID, FULL_NAME
FROM GUIDES
WHERE GUIDES_ID IN (SELECT GUIDES_ID
FROM TOURS
WHERE TOURS_ID IN (SELECT TOURS_ID
FROM TOURS_TO_LOCATION
WHERE LOCATION_ID IN (SELECT LOCATION_ID
FROM LOCATION
WHERE NAME = 'Montreal')));

--COMPLEX SELECT QUERY 3 (SELECTING TOURISTS WITH THE MOST TRIPS AND THEIR GUIDE)
SELECT TOURIST_ID, FNAME, LNAME, GUIDES_ID, COUNT(TRIP_ID) AS NUMBER_OF_TRIPS
FROM TOURIST NATURAL JOIN TRIP_TO_TOURIST
GROUP BY TOURIST_ID, GUIDE_ID
HAVING COUNT(TRIP_ID) = (SELECT MAX(NUMBER_OF_TRIPS)
FROM (SELECT TOURIST_ID, COUNT(TRIP_ID) AS NUMBER_OF_TRIPS
FROM TOURIST NATURAL JOIN TRIP_TO_TOURIST
GROUP BY TOURIST_ID));

-- COMPLEX SELECT QUERY 4 (SELECTING TRIPS WITH THE MOST TOURISTS)
SELECT TRIP_ID, COUNT(TOURIST_ID) AS NUMBER_OF_TOURISTS
FROM TRIP_TO_TOURIST
GROUP BY TRIP_ID
HAVING COUNT(TOURIST_ID) = (SELECT MAX(NUMBER_OF_TOURISTS)
FROM (SELECT TRIP_ID, COUNT(TOURIST_ID) AS NUMBER_OF_TOURISTS
FROM TRIP_TO_TOURIST
GROUP BY TRIP_ID));







/* 3 SELECT queries that represent answers
to likely business questions to be faced by the users of your database system. */





    --complex query that shows all guides that are connected to tours that are connected to locations that are adventure/activities


/*a. For each of these queries, provide a 1-2 sentence, for why that query is relevant and interesting to the owners of the system. */

/*The first query is relevant and interesting to the owners of the system because it shows all the tours that have adventure/activities as one of their locations.
The second query is relevant and interesting to the owners of the system because it shows all the tours that have Discovering Tour as one of their locations.
The third query is relevant and interesting to the owners of the system because it shows all the tours that have Private Quebec Tour as one of their locations.*/


/*d. In the queries and views, you must demonstrate the uses of aggregate
 operators, group by clause, order by clause, subqueries and involve table joins*/



--1.1. making a view that shows the number of tourists in each trip
CREATE VIEW TOURIST_IN_TRIP AS
SELECT TRIP_ID, COUNT(TOURIST_ID) AS TOURIST_IN_TRIP
FROM TRIP_TO_TOURIST
GROUP BY TRIP_ID;

--1.2. making a view that shows the number of trips in each tour
CREATE VIEW TRIP_IN_TOUR AS
SELECT TOURS_ID, COUNT(TRIP_ID) AS TRIP_IN_TOUR
FROM TRIP
GROUP BY TOURS_ID;

--  1.3. making a view that shows how many tourists are in each tour
CREATE VIEW TOURIST_IN_TOUR AS
SELECT TOURS_ID, COUNT(TOURIST_ID) AS TOURIST_IN_TOUR
FROM TRIP_TO_TOURIST NATURAL JOIN TRIP
GROUP BY TOURS_ID;



/*b. Motivate and explain at least one view, with at least part of each rationale being
related to security, or the principle of “need to know” (e.g., a “user” only needs
access to information concerning them).*/

/*The first view is made to show the number of tourists in each trip. This view is made to show the number of tourists in each trip so that the owner of the system can see how many tourists are in each trip and can make decisions accordingly.*/
/*The second view is made to show the number of trips in each tour. This view is made to show the number of trips in each tour so that the owner of the system can see how many trips are in each tour and can make decisions accordingly.*/


/*Create 2 stored procedures that enact business rules that must be supported by the
database (for example, to allow the user to insert, delete or update through the stored
procedures). At least one of the stored procedures must use parameters and use
conditional logic and exception-handling. Explain the purpose of each of the stored
procedures.*/

/*The first stored procedure is made to insert a new trip into the database. This stored procedure is made to insert a new trip into the database so that the owner of the system can add a new trip to the database.*/

CREATE OR REPLACE PROCEDURE DELETE_TRIP (VTRIP_ID TRIP.TRIP_ID%TYPE)
AS
VTRIP_ID TRIP.TRIP_ID%TYPE;
BEGIN
     IF (VTRIP_ID IS NOT NULL) THEN
            SELECT TRIP_ID INTO VTRIP_ID FROM TRIP WHERE TRIP_ID = VTRIP_ID;
            DELETE FROM TRIP WHERE TRIP_ID = VTRIP_ID;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'TRIP DOES NOT EXIST');
    END IF;
END;

--------------------------------

CREATE TABLE INS_TRIP(
TRIP_ID CHAR(6),
TOURS_ID CHAR(6),
START_DATE DATE,
END_DATE DATE,
CONSTRAINT PK_INS_TOURS FOREIGN KEY (TOURS_ID) REFERENCES TOURS ON DELETE CASCADE,
--SO THAT IT DOES NOT LEAVE ANY TOUR WITHOUT A TRIP (A TOUR NEEDS AT LEAST ONE TRIP)
CONSTRAINT PK_INS_TRIP PRIMARY KEY(TRIP_ID)
);


ALTER TABLE INS_TRIP
ADD FOREIGN KEY (TRIP_ID) REFERENCES TRIP ON DELETE CASCADE;
--SO THAT IT DOES NOT SHOW ANY TRIP WITHOUT A TOUR(ALL TRIPS ARE IN AT LEAST ONE TOUR)

CREATE OR REPLACE PROCEDURE INSERT_TRIP
AS
TRIP_ID CHAR(6);
TOURS_ID CHAR(6);
START_DATE DATE;
END_DATE DATE;
BEGIN
INSERT INTO INS_TRIP VALUES(TRIP_ID, TOURS_ID, START_DATE, END_DATE);
END;




--The second stored procedure is made TO DISPLAY ALL THE NAMES OF THE LOCATIONS IN A TOUR.
CREATE OR REPLACE PROCEDURE DISPLAY_LOCATION (VTOURS_ID TOURS.TOURS_ID%TYPE)
AS
BEGIN
    IF(VTOURS_ID IS NOT NULL) THEN
    FOR V IN( SELECT LOCATION_ID, NAME, DESCRIPTION
    FROM LOCATION NATURAL JOIN TOUR_TO_LOCATION
    WHERE TOURS_ID = VTOURS_ID) LOOP
    DBMS_OUTPUT.PUT_LINE(   V.LOCATION_ID || ' ' || V.NAME || ' ' || V.DESCRIPTION);
END LOOP;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'TOUR DOES NOT EXIST');
    END IF;
END;




/*c. Explain the purpose of each of the stored procedures.*/
--2ND IS TO DELETE A TOURIST FROM THE DATABASE AND THROW AN EXCEPTION IF THE TOURIST IS CONNECTED TO A TRIP









/* Write a database trigger that prevents a guide from leading a trip of a tour if the guide is
not officially qualified to lead a trip of that tour. Imagine that the business rules specify
that a guide is never, under any circumstance, allowed to lead a trip unless he or she is
qualified to lead trips of that tour. Your trigger should raise user defined exception.
Write the appropriate message in the exception-handling section. Test your trigger in all
cases */


CREATE OR REPLACE TRIGGER TRIP_TO_TOUR_TRIG
BEFORE INSERT OR UPDATE OF TOURS_ID, GUIDES_ID ON TRIP
FOR EACH ROW
DECLARE
    VIS_QUALIFIED GUIDES.IS_QUALIFIED%TYPE;
BEGIN
    SELECT COUNT(*) INTO VIS_QUALIFIED
    FROM TRIP JOIN TOURS JOIN TOUR_TO_GUIDES  JOIN GUIDES
    ON TRIP.TOURS_ID = TOURS.TOURS_ID AND TOURS.TOURS_ID = TOURS_TO_GUIDE.TOURS_ID AND TOURS_TO_GUIDE.GUIDES_ID = GUIDES.GUIDES_ID
    AND TRIP.TOURS_ID = :NEW.TOURS_ID AND TRIP.GUIDES_ID = :NEW.GUIDES_ID;
    IF VIS_QUALIFIED = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'GUIDE IS NOT QUALIFIED TO LEAD THIS TOUR');
    END IF;
END;
