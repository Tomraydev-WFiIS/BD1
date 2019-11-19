--1.  Dla  bazy student –przedmiot –ocena napisać procedurę
--	wyzwalaną, która pozwoli jedynie na trzykrotne zdawanie egzaminu z danego przedmiotu przez każdego studenta.

CREATE OR REPLACE FUNCTION exam_check() 
RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS '
	DECLARE
		n_exam INT;
		new_rec RECORD;
	BEGIN
		SELECT count(*) INTO n_exam FROM ocena o WHERE o.student_id = new.student_id AND o.przedmiot_id = new.przedmiot_id;
		IF (n_exam < 3) THEN
			RAISE NOTICE ''Operacja wykonana poprawnie.'';
			RETURN NEW;
		END IF;
		RAISE NOTICE ''Wszystkie terminy egzaminu wykorzystane'';
		RETURN NULL;
	END
';
CREATE TRIGGER exam_trig
BEFORE INSERT ON ocena
FOR EACH ROW EXECUTE PROCEDURE exam();

--2. Napisać procedurę aktualizującą średnią po każdym zdanym egzaminie.
CREATE OR REPLACE FUNCTION update_avg()
RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS '
	DECLARE
		average real;
	BEGIN
		SELECT AVG(ocena) INTO average FROM ocena o WHERE o.student_id = new.student_id AND o.przedmiot_id = new.przedmiot_id;
		RAISE NOTICE ''srednia %'', average;
		RETURN NULL;
	END
';

CREATE TRIGGER avg_trig
AFTER INSERT ON ocena
FOR EACH ROW EXECUTE PROCEDURE update_avg();



--3. Napisać wyzwalacz zapisujący do tabeli logi wszystkie operacje wykonywane na tabeli ocena
DROP TABLE logs CASCADE;
CREATE TABLE logs(
	logs TEXT
);

CREATE OR REPLACE FUNCTION log()
RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS '
	BEGIN
		RAISE NOTICE ''% '', TG_OP;
		INSERT INTO logs VALUES(TG_OP);
		RETURN NULL;
	END
';

CREATE TRIGGER log_trig 
AFTER INSERT or UPDATE or DELETE ON ocena
FOR EACH ROW EXECUTE PROCEDURE log();


INSERT INTO Ocena VALUES (100,3,'09-11-2014', 6,1);
INSERT INTO Ocena VALUES (100,3,'09-11-2014', 6,2);
INSERT INTO Ocena VALUES (100,3,'09-11-2014', 6,3);
INSERT INTO Ocena VALUES (100,3,'09-11-2014', 6,4);
INSERT INTO Ocena VALUES (100,3,'09-11-2014', 6,5);
