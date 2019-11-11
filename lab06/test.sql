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


\echo zadanie 1
CREATE OR REPLACE FUNCTION vec_len(real, real) RETURNS real AS'
BEGIN
    RETURN sqrt($1*$1 + $2*$2);
END
'LANGUAGE 'plpgsql'
