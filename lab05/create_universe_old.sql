-- Wszystkie obiekty mają naleŜeć do schematu nazwakonta.univers
-- 1.Stworzyć domeny:
--     - domStartUpEndNum – typ umoŜliwiając wprowadzanie tekstu wyłącznie zaczynającego się z duŜej litery kończącego się liczbą lub podkreśleniem i liczbą np. Nazwa1, Nazwa_1.
--     - domUrl – typ umoŜliwiając wprowadzanie tekstu nie zaleŜnie od wielkości liter jako odnośnika do strony www, tekst musi zaczynać się od http:// i kończyć na .org np. http://planeta1.org
--     - domStamp – typ umoŜliwiający wprowadzenie tekstu w postacie 'YYYY-MM-DD LOGIN' gdzie login to nazwa kąta np. 2011-01-01 LOGIN
-- 2. Na podstawie powyŜszego diagramu ERD naleŜy stworzyć tabele z uwzględnieniem zachodzących relacji. --DONE
-- 3. Stworzone domeny zastosować w tabelach:
--     - domStartUpEndNum – zastosować dla wszystkich pól tekstowych dotyczących nazwy,- domUrl - zastosować dla pola url w tabeli tabPlanet,
--     - domStamp – zastosować dla pola discStamp w tabeli tabSystem.
-- 4. Stworzyć unikalny indeksy na pola NAME. --DONE
-- 5. Stworzyć i zastosować sekwencje seqID dla pola ID w tabeli tabMoon i tabPlanet. --DONE



DROP TABLE univers.tabMoon;
DROP TABLE univers.tabPlanet2Sun;
DROP TABLE univers.tabPlanet;
DROP TABLE univers.tabSun;
DROP TABLE univers.tabSystem;
DROP TABLE univers.tabUniverse;
DROP SCHEMA univers CASCADE;
DROP SEQUENCE seqID;


CREATE SCHEMA univers;
CREATE SEQUENCE seqID   START   1   MAXVALUE    5   CYCLE;


CREATE TABLE univers.tabUniverse (
    id  INT PRIMARY KEY,
    name    CHAR(20) UNIQUE NOT NULL
);

CREATE TABLE univers.tabSystem(
    id  INT PRIMARY KEY,
    idUnivers   INT REFERENCES univers.tabUniverse(id) NOT NULL,
    name    CHAR(20) UNIQUE NOT NULL,
    discStamp   CHAR(50) NOT NULL
);

CREATE TABLE univers.tabSun(
    id  INT PRIMARY KEY,
    idSystem   INT REFERENCES univers.tabSystem(id) NOT NULL,
    name    CHAR(20) UNIQUE NOT NULL
);

CREATE TABLE univers.tabPlanet(
    id  INT PRIMARY KEY,
    idSystem   INT REFERENCES univers.tabSystem(id),
    name    CHAR(20) UNIQUE NOT NULL,
    period  DECIMAL(5,2),
    distance DECIMAL(10,2),
    url CHAR(50)
);

CREATE TABLE univers.tabPlanet2Sun(
    idSun   INT REFERENCES univers.tabSun(id) NOT NULL,
    idPlanet   INT REFERENCES univers.tabPlanet(id) NOT NULL
);

CREATE TABLE univers.tabMoon(
    id  INT PRIMARY KEY,
    name    CHAR(20) UNIQUE NOT NULL,
    period  DECIMAL(5,2),
    distance DECIMAL(10,2),
    idPlanet   INT REFERENCES univers.tabPlanet(id),
    idMoon   INT REFERENCES univers.tabMoon(id)
);


CREATE INDEX universe_name_idx ON univers.tabUniverse(name);
CREATE INDEX sun_name_idx ON univers.tabSun(name);
CREATE INDEX system_name_idx ON univers.tabSystem(name);
CREATE INDEX planet_name_idx ON univers.tabPlanet(name);
CREATE INDEX moon_name_idx ON univers.tabMoon(name);