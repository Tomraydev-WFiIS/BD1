DROP TABLE emp;
DROP TABLE dept;
DROP TABLE salgrade;

CREATE TABLE dept
(
	deptno	real	PRIMARY KEY,
	dname	character(14),
	loc	character(13)
);

CREATE TABLE emp
(
	empno	numeric(4,0)	PRIMARY KEY,
	ename	varchar(10),
	job	varchar(9),
	mgr	numeric(4,0),
	hiredate	date,
	sal	numeric(7,2),
	comm	numeric(7,2),
	deptno	numeric(2,0)	NOT NULL REFERENCES dept(deptno)
);

CREATE TABLE salgrade
(
	grade	numeric,
	losal	numeric,
	hisal	numeric
);


INSERT INTO DEPT VALUES   (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES   (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES   (40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,'17-12-1980',800,NULL,20);
INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,'20-2-1981',1600,300,30);
INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,'22-2-1981',1250,500,30);
INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,'2-4-1981',2975,NULL,20);
INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,'28-9-1981',1250,1400,30);
INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,'1-5-1981',2850,NULL,30);
INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,'9-6-1981',2450,NULL,10);
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,date '13-JUL-87'-85,3000,NULL,20);
INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,'17-11-1981',5000,NULL,10);
INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,'8-9-1981',1500,0,30);
INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,date '13-JUL-87'-51,1100,NULL,20);
INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,'3-12-1981',950,NULL,30);
INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,'3-12-1981',3000,NULL,20);
INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,'23-1-1982',1300,NULL,10);


INSERT INTO SALGRADE VALUES (1,700,1200); 
INSERT INTO SALGRADE VALUES (2,1201,1400); 
INSERT INTO SALGRADE VALUES (3,1401,2000); 
INSERT INTO SALGRADE VALUES (4,2001,3000); 
INSERT INTO SALGRADE VALUES (5,3001,9999);


\echo 1. Wypisać osoby, które zarabiają najwięcej ze wszystkich pracowników.
SELECT p.job, p.ename FROM emp p WHERE p.sal = (SELECT MAX(sal) FROM emp  WHERE job=p.job) ORDER BY p.job;

\echo 2. Wypisać pracowników, którzy pracują na tym samym stanowisku co pracownik o numerze 7369 i których zarobki są większe niż zarobki pracownika o numerze 7876.

SELECT e.ename FROM emp e WHERE e.job=(SELECT job FROM emp WHERE empno=7369) AND e.sal>(SELECT sal FROM emp WHERE empno=7876);
\echo 3. Wypisać działy, w których pracują urzędnicy (CLERK)
SELECT d.dname FROM dept d WHERE EXISTS (SELECT e.empno FROM emp e WHERE e.deptno=d.deptno);

\echo 4. Dla każdego działu wypisać osobę, która zarabia najwięcej w tym dziale.
SELECT d.dname, e.ename FROM dept d, emp e WHERE d.deptno=e.deptno AND e.sal=(SELECT MAX(sal) FROM emp WHERE deptno=e.deptno);

\echo 5. Wypisać działy, w których aktualnie nie ma zatrudnionych pracowników.
SELECT dept.dname FROM dept WHERE NOT EXISTS (SELECT * FROM emp WHERE dept.deptno=emp.deptno);

\echo 6. Wypisać wszystkich pracowników podając dla każdego z nich nazwę działu, w którym pracuje.
SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno=d.deptno ORDER BY d.deptno; 

\echo 7. Wypisać wszystkie działy dla każdego z nich podając sumaryczne zarobki zatrudnionych w nim pracowników.
SELECT d.dname, SUM(e.sal) FROM dept d, emp e WHERE e.deptno=d.deptno GROUP BY d.dname;

\echo 8. Wypisać nazwiska pracowników z nazwami departamentów, w których są zatrudnieni podając również pracowników, którzy nie zostali przypisani do żadnego departamentu a także nazwy departamentów, w których nie ma zatrudnionych pracowników
SELECT e.ename, d.dname FROM emp e FULL OUTER JOIN dept d USING(deptno); --nie moze byc pracownikow bez departamentu

\echo 9. Wybrać nazwiska pracowników, których zarobki są w tej samej klasie zaszeregowania co zarobki ich kierowników. Obok nazwiska pracownika zamieścić nazwisko jego kierownika i klasę zaszeregowania zarobków tego kierownika.
SELECT e.ename, e.sal, s.grade, m.empno, m.sal FROM emp m, emp e JOIN salgrade s ON e.sal > s.losal AND e.sal < s.hisal WHERE e.mgr=m.empno AND s.grade=(SELECT s2.grade FROM salgrade s2 WHERE m.sal > s2.losal AND m.sal < s2.hisal);--TODO

\echo 10. Wybrać nazwiska pracowników, którzy pracują w tych samych działach co ich kierownicy. Obok nazwiska pracownika zamieścić nazwisko jego kierownika i nazwę działu.
SELECT e.ename, m.ename, d.dname FROM emp e JOIN emp m ON e.mgr=m.empno AND e.deptno=m.deptno JOIN dept d ON e.deptno=d.deptno ORDER BY d.dname;

\echo 11. Wyznaczyć stanowiska (bez powtórzeń), na których nikt nie dostał prowizji.
SELECT DISTINCT e.job FROM emp e WHERE e.comm IS NULL;
\echo 12. Ustawić w pary pracowników, którzy mają tego samego kierownika. Nazwiska w parze powinny być różne i pary nie powinny się powtarzać.

\echo 13. Wybrać kierowników (pracowników pracujących na stanowisku MANAGER), którzy mają dokładnie jednego podwładnego. Podać, gdzie oni pracują i w jakiej klasie zaszeregowania są ich zarobki.

\echo 14. Znaleźć nazwę działu, w którym pracownicy zarabiają średnio najwięcej oraz nazwę działu, w którym pracownicy zarabiają średnio najmniej.