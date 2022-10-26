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
 IS_QUALIFIED VARCHAR(3) NOT NULL,
 NO_OF_TRIPS VARCHAR(4));
 
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

INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Savannah', 'Mollie', '112', 'Port Tiqua', 'Montreal', 'F2F3D3', '2020-06-01', 'NO', '1', '1234');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Alfie', 'Ava', '1145', 'Limes Elms', 'La Lynn', 'J3V9D2', '2019-10-11', 'YES', '4', '1235');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Christine', 'Scarlet', '1012', 'Gresham Holt', 'Mckuujleigh', 'K3F9H5', '2022-03-04', 'YES', '3', '1236');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Eleanor', 'Mary', '1543', 'Whitehouse Links', 'Richtim', 'L3F8H4', '2015-02-09', 'YES', '5', '1237');
INSERT INTO GUIDES VALUES (GEN_GUIDE_ID.NEXTVAL, 'Melissa', 'Darcie', '1875', 'Evergreen Poplars', 'Bampglens', 'Q9F4N1', '2014-12-01', 'NO', '2', '1238');
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
 
 

 
 
 
