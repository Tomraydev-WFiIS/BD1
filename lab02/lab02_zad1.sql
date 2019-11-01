CREATE TABLE emp
(
	empno	NUMERIC(4,0)	PRIMARY KEY,
	ename	VARCHAR(10),
	job	VARCHAR(10),
	mgr	VARCHAR(10),
	sal	NUMERIC(7,2),
	comm	NUMERIC(7,2),
	deptno	INT
);

INSERT INTO emp(empno, ename, job, mgr, sal, deptno)    VALUES (7369, 'SMITH', 'CLERK', 7902, 800,20);
INSERT INTO emp(empno, ename, job, mgr, sal, comm, deptno)    VALUES (7499, 'ALLEN', 'SALESMAN', 7698, 1600, 300, 30);
INSERT INTO emp(empno, ename, job, mgr, sal, comm, deptno)    VALUES (7521, 'WARD', 'SALESMAN', 7698, 1250, 500, 30);
INSERT INTO emp(empno, ename, job, mgr, sal, deptno)    VALUES (7566, 'JONES', 'MANAGER', 7839, 2975,20);
INSERT INTO emp(empno, ename, job, mgr, sal, comm, deptno)    VALUES (7654, 'MARTIN', 'SALESMAN', 7698, 1250, 1400, 30);
INSERT INTO emp(empno, ename, job, mgr, sal, deptno)    VALUES (7698, 'BLAKE', 'MANAGER', 7839, 2850, 20);
INSERT INTO emp(empno, ename, job, mgr, sal, deptno)    VALUES (7782, 'CLARK', 'MANAGER', 7839, 2450,10);
INSERT INTO emp(empno, ename, job, mgr, sal, deptno)    VALUES (7788, 'SCOTT', 'ANALYST', 7566, 3000,20);

SELECT * FROM emp;
SELECT deptno, ename, empno, mgr FROM emp;
SELECT (sal+250)*12 FROM emp;
SELECT DISTINCT deptno FROM emp;
SELECT * FROM emp WHERE job = 'CLERK';
SELECT * FROM emp WHERE (comm > sal);
SELECT * FROM emp WHERE (sal > 1000 AND sal < 2000);
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename LIKE '____';
SELECT * FROM emp WHERE mgr IS NULL;
SELECT * FROM emp WHERE ename NOT LIKE 'M%';
