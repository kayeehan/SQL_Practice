

--001 : 테이블에서 특정 열 선택
SELECT empno, ename, sal
FROM emp;

--002 : 테이블에서 모든 열 출력
SELECT *
FROM emp;

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;

--003 : 컬럼 별칭 사용하여 컬럼명 변경
SELECT empno as 사원번호, ename as 사원이름, sal as "Salary" 
FROM emp;

SELECT ename, sal*(12+3000)
FROM emp;

SELECT ename, sal*(12+3000) as 월급
FROM emp
ORDER BY 월급 DESC;

--004 : 연결 연산자 사용
SELECT ename||sal
FROM emp;

SELECT ename||'의 월급은 '||sal||'입니다' as 월급정보
FROM emp;

SELECT ename||'의 직업은 '||job||'입니다' as 직업정보
FROM emp;

--005 : 중복된 데이터를 제거해서 출력
SELECT DISTINCT job
FROM emp;

SELECT UNIQUE job
FROM emp;

--006 : 데이터 정렬해서 출력 (ORDER BY)
SELECT ename, sal
FROM emp
ORDER BY sal asc; --오름차순

SELECT ename, sal as 월급
FROM emp
ORDER BY 월급 asc;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno asc, sal desc;

SELECT ename, sal as 월급
FROM emp
ORDER BY 월급 asc;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno asc, sal desc;

SELECT ename, deptno, sal
FROM emp
ORDER BY 2 asc, 3 desc;

--007 : WHERE 절 (숫자 데이터 검색)








