DROP TABLE osoba;
CREATE TABLE osoba (
    pesel    CHAR(11) PRIMARY KEY, 
    imie     CHAR(20), 
    nazwisko CHAR(30), 
    adres_m  CHAR(30) 
);

INSERT INTO OSOBA VALUES ( 11111112 , 'Ala' , 'nazwisko1' , 'miasto1' );
INSERT INTO OSOBA VALUES ( 11111113 , 'Ela' , 'nazwisko2' , 'miasto2' );
INSERT INTO OSOBA VALUES ( 11111114 , 'Ula' , 'nazwisko3' , 'miasto3' );
SELECT * FROM osoba;

-- TRANSAKCJA
BEGIN;
UPDATE osoba
SET imie='Janek'
WHERE pesel = '11111112';
COMMIT;
-- ROLLBACK; --odrzucenie
SELECT * FROM osoba;

-- KURSORY
BEGIN;
DECLARE all_osoba CURSOR FOR SELECT * FROM OSOBA;
\echo 4 wiersze
FETCH 4 FROM all_osoba;
\echo nastepna osoba
FETCH NEXT FROM all_osoba;
\echo poprzednia osoba
FETCH PRIOR FROM all_osoba;
CLOSE all_osoba;
COMMIT;

-- kursory w funkcjach
CREATE TABLE test (col text);
INSERT INTO test VALUES ('123');

CREATE OR REPLACE FUNCTION reffunc(refcursor) RETURNS refcursor AS '
BEGIN
    OPEN $1 FOR SELECT col FROM test;
    RETURN $1;
END;
' LANGUAGE plpgsql;

BEGIN;
SELECT reffunc('funccursor');
FETCH ALL IN funccursor;
COMMIT;