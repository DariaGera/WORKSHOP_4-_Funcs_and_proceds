-----------------------TOWN-------------------------------------------
INSERT INTO TOWN (TOWN) VALUES ('NEW HANOVER');
INSERT INTO TOWN (TOWN) VALUES ('NORRISTOWN');
INSERT INTO TOWN (TOWN) VALUES ('SKIPPACK');
INSERT INTO TOWN (TOWN) VALUES ('LOWER SALFORD');

-------------------------ADDRESS---------------------------------------
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('REINDEER CT and DEAD END', 'NEW HANOVER', 1);
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('CHARLOTTE ST and MILES RD', 'NEW HANOVER', 2);
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('HAWS AVE', 'NORRISTOWN', 3);
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('1', 'NORRISTOWN', 4);
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('COLLEGEVILLE RD and LYWISKI RD', 'SKIPPACK', 5);
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('MAIN ST and OLD SUMNEYTOWN PIKE', 'LOWER SALFORD', 6);
INSERT INTO ADDRESS (ADDRESS, TOWN, PLACE_ID) VALUES('1', 'LOWER SALFORD', 7);

------------------------CALL_CENTER_911--------------------------------
INSERT INTO CALL_CENTER_911 (DEPART_IDENTIF_ID, DEPARTMENT_NUMBER, PLACE_ID) VALUES(1, 1562, 4);
INSERT INTO CALL_CENTER_911 (DEPART_IDENTIF_ID, DEPARTMENT_NUMBER, PLACE_ID) VALUES(2, 2163, 5);

-------------------------PERSON-----------------------------------------
INSERT INTO PERSON (NAME, PASSPORT_ID) VALUES('Bob Bobanenko', 'ID65738UKR');
INSERT INTO PERSON (NAME, PASSPORT_ID) VALUES('Boba Smith', 'ID54321USA');
INSERT INTO PERSON (NAME, PASSPORT_ID) VALUES('Kate Poy', 'ID64888USA');
INSERT INTO PERSON (NAME, PASSPORT_ID) VALUES('Mark Bobanchuk', 'ID12345USA');
INSERT INTO PERSON (NAME, PASSPORT_ID) VALUES('Paul Goro', 'ID11111PO');

-------------------------PHONE-------------------------------------------
INSERT INTO PHONE (PHONE_NUMBER) VALUES('0128-44-34');
INSERT INTO PHONE (PHONE_NUMBER) VALUES('0134-56-67');
INSERT INTO PHONE (PHONE_NUMBER) VALUES('0500-01-01');

-------------------------PHONE_OWNER-------------------------------------
INSERT INTO PHONE_OWNER (PHONE_NUMBER, PASSPORT_ID, DATA_OWN, STATUS) VALUES('0128-44-34', 'ID65738UKR', to_date('25-JUL-18','DD-MON-RR'), 0);
INSERT INTO PHONE_OWNER (PHONE_NUMBER, PASSPORT_ID, DATA_OWN, STATUS) VALUES('0134-56-67', 'ID64888USA', to_date('26-JUL-18','DD-MON-RR'), 0);
INSERT INTO PHONE_OWNER (PHONE_NUMBER, PASSPORT_ID, DATA_OWN, STATUS) VALUES('0134-56-67', 'ID54321USA', to_date('25-JUL-19','DD-MON-RR'), 1);
INSERT INTO PHONE_OWNER (PHONE_NUMBER, PASSPORT_ID, DATA_OWN, STATUS) VALUES('0128-44-34', 'ID11111PO', to_date('25-JUL-19','DD-MON-RR'), 1);
INSERT INTO PHONE_OWNER (PHONE_NUMBER, PASSPORT_ID, DATA_OWN, STATUS) VALUES('0500-01-01', 'ID12345USA', to_date('27-JUL-19','DD-MON-RR'), 0);
INSERT INTO PHONE_OWNER (PHONE_NUMBER, PASSPORT_ID, DATA_OWN, STATUS) VALUES('0500-01-01', 'ID65738UKR', to_date('28-AUG-19','DD-MON-RR'), 1);

-------------------------OPERATOR_911------------------------------------
INSERT INTO OPERATOR_911 (DEPART_IDENTIF_ID, OPERATOR_PASS_ID) VALUES(1, 'ID64888USA');
INSERT INTO OPERATOR_911 (DEPART_IDENTIF_ID, OPERATOR_PASS_ID) VALUES(1, 'ID12345USA');
INSERT INTO OPERATOR_911 (DEPART_IDENTIF_ID, OPERATOR_PASS_ID) VALUES(2, 'ID11111PO');

--------------------------WITNESS_ACCIDENT------------------------------------
INSERT INTO WITNESS_ACCIDENT(WITNESS_ID, PLACE_ID, PHONE_NUMBER, TITLE) values (1, 4, '0128-44-34', 'EMS: CARDIAC EMERGENCY');
INSERT INTO WITNESS_ACCIDENT(WITNESS_ID, PLACE_ID, PHONE_NUMBER, TITLE) values (2, 3, '0134-56-67', 'Traffic: VEHICLE ACCIDENT');
INSERT INTO WITNESS_ACCIDENT(WITNESS_ID, PLACE_ID, PHONE_NUMBER, TITLE) values (3, 5, '0500-01-01', 'EMS: FALL VICTIM');
INSERT INTO WITNESS_ACCIDENT(WITNESS_ID, PLACE_ID, PHONE_NUMBER, TITLE) values (4, 3, '0128-44-34', 'Fire: BUILDING FIRE');

-------------------------CALL_911------------------------------------------
INSERT INTO CALL_911(WITNESS_ID, OPERATOR_PASS_ID, CALL_BEGIN, CALL_END) values (1, 'ID64888USA', to_timestamp('25-JUL-18 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'), to_timestamp('25-JUL-18 03.33.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
INSERT INTO CALL_911(WITNESS_ID, OPERATOR_PASS_ID, CALL_BEGIN, CALL_END) values (4, 'ID12345USA', to_timestamp('25-JUL-19 09.24.40.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'), to_timestamp('25-JUL-19 09.33.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
INSERT INTO CALL_911(WITNESS_ID, OPERATOR_PASS_ID, CALL_BEGIN, CALL_END) values (3, 'ID11111PO', to_timestamp('29-AUG-19 07.33.31.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'), to_timestamp('29-AUG-19 07.45.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
INSERT INTO CALL_911(WITNESS_ID, OPERATOR_PASS_ID, CALL_BEGIN, CALL_END) values (1, 'ID64888USA', null, null);
INSERT INTO CALL_911(WITNESS_ID, OPERATOR_PASS_ID, CALL_BEGIN, CALL_END) values (2, 'ID12345USA', null, null);












