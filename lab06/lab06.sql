DROP FUNCTION dodaj_jeden(int4);
DROP FUNCTION dodaj_jeden(float8);

CREATE FUNCTION dodaj_jeden(int4) RETURNS int4 AS '
BEGIN
    RETURN $1+1;
END;
'LANGUAGE 'plpgsql';

-- Przeciazenie funkcji
CREATE FUNCTION dodaj_jeden (float8) RETURNS float8 AS '
BEGIN
    RETURN $1+1;
END;
'LANGUAGE 'plpgsql';

SELECT prosrc FROM pg_proc WHERE proname='dodaj_jeden';

CREATE OR REPLACE FUNCTION ex01()
RETURNS text
LANGUAGE plpgsql AS '
BEGIN
    RETURN `HELLO!`;
END;
';

-- w języku SQL

-- CREATE OR REPLACE FUNCTION klienci(text) RETURNS setof customer AS'
--     SELECT * FROM customer WHERE town=$1;
-- 'LANGUAGE 'SQL';


-- Aliasy parametrów wejściowych
CREATE OR REPLACE FUNCTION ex04(real)
RETURNS real
LANGUAGE plpgsql AS '
DECLARE
param ALIAS FOR $1;
BEGIN
RETURN param*param;
END;
';

-- \echo test
-- CREATE OR REPLACE FUNCTION c_test() RETURNS int4 AS'
-- printf("hello");
-- return 0;
-- 'LANGUAGE 'c';


\echo ZAD1
CREATE OR REPLACE FUNCTION vec_len(real, real) RETURNS real AS'
BEGIN
    RETURN sqrt($1*$1 + $2*$2);
END
'LANGUAGE 'plpgsql';


\echo ZAD2
-- Utworzyć funkcję tablicującą wartości funkcji y = A*x^2+B*x+C dla wartości A,B,C
-- podanych przez użytkownika i x w zakresie od 1 do 100. Rezultat ma być zwracany
-- w postaci dwukolumnowej (jako x oraz wartość funkcji dla danego x).
CREATE TYPE point AS (
	x real,
	y real
);

CREATE OR REPLACE FUNCTION quadratic(A real, B real, C real)
RETURNS SETOF point
AS'
DECLARE
	value RECORD;
BEGIN
    FOR x IN 1..100 LOOP
        RETURN NEXT (x, A*x*x+B*x+C);
    END LOOP;
    RETURN;
END;
'LANGUAGE 'plpgsql';

\echo ZAD3
-- Utworzyć funkcję tablicującą wartości temperatury w skali Fahrenheita dla
-- temperatur w Celsjusza w przedziale 1 do 100 co 0.1 stopnia

CREATE OR REPLACE FUNCTION c_to_f()
RETURNS SETOF point
AS'
DECLARE
	value RECORD;
BEGIN
    FOR x IN 10 .. 1000 LOOP
        RETURN NEXT (x*0.1, x*0.1*9/5 + 32);
    END LOOP;
    RETURN;
END;
'LANGUAGE 'plpgsql';


\echo ZAD4
-- Utworzyć bezargumentową funkcję liczba_studentow zwracającą liczbę studentów
-- w tabeli szkola.studenci

CREATE OR REPLACE FUNCTION liczba_studentow()
RETURNS int
AS'
DECLARE
	x int;
BEGIN
	SELECT COUNT(*) INTO x FROM student;
	RETURN x;
END;
'LANGUAGE 'plpgsql';

\echo ZAD5
-- Utworzyć funkcję liczba_studentow_1 zwracającą liczbę studentów w podanej jako
-- argument grupie

CREATE OR REPLACE FUNCTION liczba_studentow_1(group_name text)
RETURNS int
AS'
DECLARE
	x int;
BEGIN
	SELECT COUNT(*) INTO x FROM student s GROUP BY s.grupa HAVING s.grupa=$1;
	RETURN x;
END;
'LANGUAGE 'plpgsql';

\echo ZAD6
-- Utworzyć funkcję srednia zwracającą średnią ocen studenta o nazwisku podanym
-- jako argument funkcji

CREATE OR REPLACE FUNCTION srednia(surname text)
RETURNS real
as '
	DECLARE
		result real;
		id int;
	BEGIN
		SELECT nr_s INTO id FROM Student WHERE nazwisko=$1;
		SELECT avg(ocena) INTO result FROM ocena WHERE student_id=id;
		return result;
	END;
'
LANGUAGE 'plpgsql'; 

\echo ZAD7
-- Login studenta składa się z połączenia jego nazwiska i pierwszej litery imienia
-- (wszystko małymi literami). Napisać funkcję generującą login na podstawie wiersza
-- tabeli szkola.studenci.

CREATE OR REPLACE FUNCTION get_login(surname text)
RETURNS text
as '
	DECLARE
		s student%rowtype;
	BEGIN
		SELECT * INTO s FROM student d WHERE d.nazwisko=$1;
		RETURN s.nazwisko||substring(s.nazwisko, 1, 1);
	END;
'
LANGUAGE 'plpgsql'; 




\echo ZAD8
-- Utworzyć funkcję zwracającą (jako typ złożony zdefiniowany przez użytkownika)
-- nazwisko studenta oraz średnią ocen studenta którego numer indeksu przekazany
-- został jako argument funkcji

\echo ZAD9
-- Utworzyć funkcję zwracającą listę ocen studentów. Lista ma zawierać imię i nazwisko
-- studenta, nazwę przedmiotu i
-- ocenę.
-- Wariant 1: Wykorzystać wcześniej zdefiniowany widok
-- Wariant 2: Wykorzystać własny typ zwracanych danych
