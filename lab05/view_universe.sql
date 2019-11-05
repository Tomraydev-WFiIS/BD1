-- 6. Stworzyć raport w postaci SELECT --DONE
--     nazwakontaKolegi.univers.tabSystem.DISCSTAM,
--     nazwakonta.univers.tabSystem.DISCSTAM,
--     nazwakonta.univers.tabSystem.NAME
--     gdzie wartość pola ID dla tabeli tabSystem w róŜnych schematach jest równa.
DROP VIEW common_systems;
CREATE VIEW common_systems AS SELECT o.discstamp, u.discstamp, u.name FROM u7rajchel.univers.tabSystem u, u7litarowicz.univers.tabSystem o WHERE u.id=o.id;
-- CREATE VIEW common_systems AS SELECT u.discstamp, u.name FROM tomray.univers.tabSystem u;


\echo Systems in common with u7rajchel
SELECT * FROM common_systems;
