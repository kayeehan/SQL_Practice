

--001 : ���̺��� Ư�� �� ����
SELECT empno, ename, sal
FROM emp;

--002 : ���̺��� ��� �� ���
SELECT *
FROM emp;

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;

--003 : �÷� ��Ī ����Ͽ� �÷��� ����
SELECT empno as �����ȣ, ename as ����̸�, sal as "Salary" 
FROM emp;

SELECT ename, sal*(12+3000)
FROM emp;

SELECT ename, sal*(12+3000) as ����
FROM emp
ORDER BY ���� DESC;

--004 : ���� ������ ���
SELECT ename||sal
FROM emp;

SELECT ename||'�� ������ '||sal||'�Դϴ�' as ��������
FROM emp;

SELECT ename||'�� ������ '||job||'�Դϴ�' as ��������
FROM emp;

--005 : �ߺ��� �����͸� �����ؼ� ���
SELECT DISTINCT job
FROM emp;

SELECT UNIQUE job
FROM emp;

--006 : ������ �����ؼ� ��� (ORDER BY)
SELECT ename, sal
FROM emp
ORDER BY sal asc; --��������

SELECT ename, sal as ����
FROM emp
ORDER BY ���� asc;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno asc, sal desc;

SELECT ename, sal as ����
FROM emp
ORDER BY ���� asc;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno asc, sal desc;

SELECT ename, deptno, sal
FROM emp
ORDER BY 2 asc, 3 desc;

--007 : WHERE �� (���� ������ �˻�)








