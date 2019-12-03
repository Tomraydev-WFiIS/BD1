CREATE OR REPLACE FUNCTION addSkill(name TEXT,skill TEXT)
RETURNS void
LANGUAGE plpgsql AS '
DECLARE
	skill_id INT;
	name_id INT;
BEGIN
	SELECT p.P_ID INTO name_id from postacie p WHERE p.Imie = name; 
	SELECT u.UM_ID INTO skill_id from umiejetnosci u WHERE u.Nazwa = skill; 
	INSERT INTO UM_P VALUES(skill_id, name_id); 
	RETURN;
END;
';


CREATE OR REPLACE FUNCTION getStats(name TEXT)
RETURNS void
LANGUAGE plpgsql AS '
DECLARE
	character_id INT;
BEGIN
	SELECT p.P_ID INTO character_id from postacie p WHERE p.Imie = name;
	RETURN;
END
';
