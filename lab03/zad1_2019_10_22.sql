DROP TABLE emp;
DROP TABLE dept;
DROP TABLE bonus;
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

CREATE TABLE bonus
(
	ename	varchar(10),
	job	varchar(9),
	sal	numeric,
	comm	numeric
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

-- 1. Wyświetlić nazwiska i nazwy departamentów wszystkich pracowników w kolejności alfabetycznej.
SELECT emp.ename, dept.dname FROM emp JOIN dept ON emp.deptno = dept.deptno ORDER BY emp.ename;
--or
SELECT emp.ename, dept.dname FROM emp, dept WHERE emp.deptno=dept.deptno ORDER BY emp.ename;
-- 2. Wyświetl nazwiska pracowników zatrudnionych w Dallas
SELECT emp.ename FROM emp JOIN dept ON emp.deptno=dept.deptno WHERE dept.loc = 'DALLAS';
-- 3. Wyświetl nazwiska i pensje pracowników oraz ich klasę zaszeregowania
SELECT emp.ename, emp.sal, salgrade.grade FROM emp JOIN salgrade ON emp.sal> salgrade.losal AND emp.sal < salgrade.hisal;
-- 4. Wybierz nazwiska, pensje i klasę zaszeregowania. Pracowników(emp) których zarobki odpowiadają klasie 3
SELECT emp.ename, emp.sal, salgrade.grade FROM emp JOIN salgrade ON emp.sal> salgrade.losal AND emp.sal < salgrade.hisal WHERE salgrade.grade=3;
-- 5. Wyświetl nazwiska i pensje pracowników którzy zarabiają mniej od swoich kierowników
SELECT e.ename, e.sal FROM emp e, emp m WHERE e.mgr=m.empno AND e.sal<m.sal;
-- 6. Wyświetl stanowiska występujące w działach 10 i 30
SELECT DISTINCT emp.job FROM emp, dept WHERE dept.deptno=10 OR dept.deptno=30;
-- 7. Oblicz średni zarobek w firmie
SELECT AVG(sal) FROM emp;
-- 8. Znajdź minimalne zarobki na stanowisku CLERK
SELECT MIN(sal) FROM emp WHERE emp.job='CLERK';
-- 9. Ilu pracowników zatrudniono w departamencie 20
SELECT COUNT(emp.empno) FROM emp, dept WHERE emp.deptno=dept.deptno AND dept.deptno=20;
-- 10.Jakie są średnie zarobki na każdym stanowisku pracy
SELECT emp.job, AVG(sal) FROM emp GROUP BY emp.job;
-- 11.Jakie są maksymalne zarobki dla każdego stanowiska
SELECT emp.job, MAX(sal) FROM emp GROUP BY emp.job;
-- 12.Wyświetlić średnie zarobki dla departamentów zatrudniających powyżej 3 pracowników
SELECT dept.dname, AVG(emp.sal) FROM dept, emp WHERE emp.deptno=dept.deptno GROUP BY dept.dname HAVING COUNT(*)>3;
-- 13.Jaka jest różnica między najwyższą i najniższą pensją?
SELECT MAX(sal) - MIN(sal) FROM emp;
-- 14.Ilu podwładnych ma każdy kierownik?
SELECT m.ename, COUNT(e.empno) FROM emp e, emp m WHERE m.job='MANAGER' AND e.mgr=m.empno GROUP BY m.ename;
-- 15.Jaka jest średnia pensja w każdej klasie zarobkowej?
SELECT salgrade.grade, AVG(emp.sal) FROM salgrade, emp WHERE emp.sal> salgrade.losal AND emp.sal < salgrade.hisal GROUP BY salgrade.grade ORDER BY salgrade.grade;
-- 16.Ilu pracowników jest w każdej klasie zarobkowej?
SELECT salgrade.grade, COUNT(emp.empno) FROM salgrade, emp WHERE emp.sal> salgrade.losal AND emp.sal < salgrade.hisal GROUP BY salgrade.grade ORDER BY salgrade.grade;
-- 17. Znaleźć pracowników z pensją równą minimalnej pensji w firmie
SELECT ename, sal FROM emp WHERE sal = (SELECT min(sal) FROM emp);
-- 18.Wyświetlić nazwy działów w których pracują urzędnicy (CLERK)
SELECT dept.dname FROM dept, emp WHERE emp.deptno=dept.deptno GROUP BY dept.dname HAVING COUNT(emp.ename='CLERK')>1;
-- 19.Którzy pracownicy zarabiają powyżej średniej w swoich departamentach?
SELECT e.ename FROM emp e WHERE e.sal > (SELECT AVG(emp.sal) FROM dept, emp WHERE emp.deptno=dept.deptno AND e.deptno=dept.deptno GROUP BY dept.dname);
-- 20. Znaleźć departamenty w których nie ma pracowników.
SELECT dept.dname FROM dept WHERE NOT EXISTS (SELECT * FROM emp WHERE dept.deptno=emp.deptno);