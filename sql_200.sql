

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
SELECT ename, sal, job
FROM emp
WHERE sal = 3000;

SELECT ename, job
FROM emp
WHERE sal is not null;

SELECT ename as 이름, sal as 월급
FROM emp
WHERE sal >= 3000;

SELECT ename as 이름, sal as 월급
FROM emp
WHERE 월급 >= 3000; --오류발생

SELECT ename as 이름, sal as 월급
FROM emp
WHERE sal >= 3000; --where 절이 select 절보다 먼저 돌아가서 열별칭 사용 불가

--008 : WHERE 절 : 문자와 날짜 검색
SELECT ename, sal, job, hiredate, deptno
FROM emp
WHERE ename='SCOTT';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '81/11/17';

SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT'; --접속한 세션의 날짜 형식 확인

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD'; --세션 날짜 형식 변경
SELECT ename, sal
FROM emp
WHERE hiredate='81/11/17'; --형식이 다르기때문에 조회 불가(RR-1981/YY-2081)

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

--009 : 산술 연산자
SELECT ename, sal*12 as 연봉
FROM emp
WHERE sal*12 >= 36000;

SELECT ename, sal, comm, sal + comm
FROM emp
WHERE deptno = 10; -- comm이 null 인 경우 sal+comm가 null이 나옴

SELECT ename, sal, comm, sal+NVL(comm,0)
FROM emp
WHERE deptno = 10;

--010 : 비교 연산자
SELECT ename, sal, job, deptno
FROM emp
WHERE sal <= 1200;

--011 :  비교 연산자 (BETWEEN AND)
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 3000;

SELECT ename, sal
FROM emp
WHERE sal BETWEEN 3000 AND 1000; --결과 출력 안됨

SELECT ename, sal
FROM emp
WHERE (sal >= 1000 AND sal <= 3000);

SELECT ename, sal
FROM emp
WHERE sal NOT BETWEEN 1000 AND 3000;

SELECT ename, sal
FROM emp
WHERE (sal < 1000 OR sal > 3000);

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';

--012 : 비교 연산자 (LIKE)
SELECT ename, sal
FROM emp
WHERE ename LIKE 'S%'; --첫글자 S로 시작하는 사원들의 이름과 월급

SELECT ename
FROM emp
WHERE ename LIKE '_M%'; --두번째 글자가 M인 사원

SELECT ename
FROM emp
WHERE ename LIKE '%T'; --마지막 글자가 T로 끝나는 사원

SELECT ename
FROM emp
WHERE ename LIKE '%A%'; --이름에 A가 포함된 사원 모두

--013 : 비교 연산자 (IS NULL)
SELECT ename, comm
FROM emp
WHERE comm is null;

--014 : 비교 연산자 (IN)
SELECT ename, sal, job
FROM emp
WHERE job in ('SALESMAN','ANALYST','MANAGER');

SELECT ename, sal, job
FROM emp
WHERE (job = 'SALESMAN' or job = 'ANALYST' or job = 'MANAGER');

SELECT ename, sal, job
FROM emp
WHERE job not in ('SALESMAN','ANALYST','MANAGER');

SELECT ename, sal, job
FROM emp
WHERE (job != 'SALESMAN' or job != 'ANALYST' or job != 'MANAGER');

--015 : 논리 연산자 (AND, OR, NOT)
SELECT ename, sal, job
FROM emp
WHERE job = 'SALESMAN' AND sal >= 1200;

SELECT ename, sal, job
FROM emp
WHERE job = 'ABCDEFG' AND sal >= 1200; --TRUE AND FALSE = FALSE

--016 : 대소문자 변환 함수 (UPPER, LOWER, INITCAP)
SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
FROM emp;

SELECT ename, sal
FROM emp
WHERE LOWER(ename)='scott';

--017 : 문자에서 특정 철자 추출(SUBSTR)
SELECT SUBSTR('SMITH',1,3) --SMI 출력
FROM DUAL;

--018 : 문자열의 길이 출력(LENGTH)
SELECT ename, LENGTH(ename)
FROM emp;

SELECT LENGTH('가나다라마')
FROM DUAL;

SELECT LENGTHB('가나다라마') --바이트의 길이
FROM DUAL;

--019 : 문자에서 특정 철자의 위치 출력(INSTR)
SELECT INSTR('SMITH','M') --2 출력
FROM DUAL;

SELECT INSTR('abcdefg@naver.com','@') --8 출력
FROM DUAL;

SELECT SUBSTR('abcdefgh@naver.com',INSTR('abcedfgh@naver.com','@')+1)
FROM DUAL; -- naver.com 출력

SELECT RTRIM(SUBSTR('abcdefgh@naver.com',INSTR('abcdefgh@naver.com','@')+1),'.com')
FROM DUAL; --naver 출력

--020 : 특정 철자를 다른 철자로 변경 (REPLACE)
SELECT ename, REPLACE(sal,0,'*') -- 0을 *로 변경하여 출력
FROM emp;

SELECT ename, REGEXP_REPLACE(sal,'[0-3]', '*') as SALARY --0~3을 *로 변경하여 출력
FROM emp;

--테이블 생성
CREATE TABLE TEST_ENAME
(ENAME VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('김인호');
INSERT INTO TEST_ENAME VALUES('안상수');
INSERT INTO TEST_ENAME VALUES('최영희');
COMMIT;

SELECT REPLACE(ename, SUBSTR(ename,2,1), '*') as "전광판_이름"
FROM test_ename;

--021 : 특정 철자를 N개 만큼 채우기 (LPAD, RPAD)
SELECT ename, LPAD(sal,10,'*') as salary1, RPAD(sal,10,'*') as salary2
FROM emp;

SELECT ename, sal, lpad('■',round(sal/100),'■') as bar_chart
FROM emp;

--022 : 특정 철자 잘라내기 (TRIM, RTRIM, LTRIM)
SELECT 'smith', LTRIM('smith','s'),RTRIM('smith','h'),TRIM('s' from 'smiths')
FROM dual; -- smith, mith, smit, mith

--테이블 추가
insert into emp(empno,ename,sal,job,deptno) values(8291,'JACK ',3000,'SALESMAN',30);
commit;

SELECT ename, sal
FROM emp
WHERE ename='JACK';--조회 안됨

SELECT ename, sal
FROM emp
WHERE TRIM(ename)='JACK';

--데이터 삭제
DELETE FROM EMP WHERE TRIM(ENAME)='JACK';
COMMIT;

--023 : 반올림해서 출력(ROUND)
SELECT '876.567' as 숫자, ROUND(876.567,1) --876.6
FROM DUAL;

--024 : 숫자를 버리고 출력 (TRUNC)
SELECT '876.567' as 숫자, TRUNC(876.567,1) --876.5
FROM DUAL;

--025 : 나눈 나머지 값 출력 (MOD)
SELECT MOD(10,3) --1
FROM DUAL;

SELECT empno, MOD(empno,2) --사원번호 홀수면 1, 짝수면 0
FROM emp;

SELECT empno, ename
FROM emp
WHERE MOD(empno,2) = 0; --사원번호 짝수만 출력

SELECT FLOOR(10/3) --3 : 몫을 출력
FROM DUAL;

--026 : 날짜 간 개월수 출력 (MONTHS_BETWEEN)
SELECT ename, MONTHS_BETWEEN(sysdate,hiredate)--(최신날짜, 예전날짜)
FROM emp;

SELECT TO_DATE('2019-06-01','RRRR-MM-DD') - TO_DATE('2018-10-01','RRRR-MM-DD')
FROM dual;

SELECT ROUND((TO_DATE('2019-06-01','RRRR-MM-DD')-TO_DATE('2018-10-01','RRRR-MM-DD'))/7) AS "총 주수"
FROM DUAL;

--027 : 개월 수 더한 날짜 출력(ADD_MONTHS)
SELECT ADD_MONTHS(TO_DATE('2019-05-01','RRRR-MM-DD'),100)
FROM dual;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + 100 --100일 후
FROM dual;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '100' month
FROM DUAL;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '1-3' year(1) to month --1년 3개월 후
FROM DUAL;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '3' year --연도가 세자리인 경우(year(3) 사용)
FROM DUAL;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + TO_YMINTERVAL('03-05') as 날짜 --3년 5개월 뒤
FROM DUAL;

--028 : 특정 날짜 뒤에 오는 요일 날짜 (NEXT_DAY)
SELECT '2019/05/22' as 날짜, NEXT_DAY('2019/05/22','월요일')
FROM DUAL;

SELECT SYSDATE as 오늘날짜
FROM DUAL;

SELECT NEXT_DAY(SYSDATE,'화요일') as "다음 날짜"
FROM DUAL;

SELECT NEXT_DAY(ADD_MONTHS('2019/05/22',100),'화요일') as "다음 날짜"
FROM DUAL;

SELECT NEXT_DAY(ADD_MONTHS(SYSDATE,100),'화요일') as "다음 날짜"
FROM DUAL; --오늘 날짜부터 100달 뒤에 돌아오는 월요일의 날짜 출력

--029 : 특정 날짜가 있는 달의 마지막 날짜 출력 (LAST_DAY)
SELECT '2019/05/22' as 날짜, LAST_DAY('2019/05/22') as "마지막 날짜"
FROM DUAL;

SELECT LAST_DAY(SYSDATE) - SYSDATE as "남은 날짜"
FROM DUAL;

SELECT ename, hiredate, LAST_DAY(hiredate)
FROM emp
WHERE ename='KING';

--030 : 문자형으로 데이터 유형 변환(TO_CHAR)
SELECT ename, TO_CHAR(hiredate,'DAY') as 요일, TO_CHAR(sal,'999,999') as 월급
FROM emp
WHERE ename='SCOTT';

SELECT hiredate, TO_CHAR(hiredate,'RRRR') as 연도, TO_CHAR(hiredate,'MM') as 달,
    TO_CHAR(hiredate,'DD') as 일, TO_CHAR(hiredate,'DAY') as 요일
FROM emp
WHERE ename='KING';

/*연도 : RRRR, YYYY, RR, YY
월 : MM, MON
일 : DD
요일 : DAY, DY
주 : WW, IW, W
시간 : HH, HH24
분 : MI
초 : SS */

SELECT ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate,'RRRR') = '1981'; 

SELECT ename as 이름, EXTRACT(YEAR from hiredate) as 연도,
                    EXTRACT(MONTH from hiredate) as 달,
                    EXTRACT(day from hiredate) as 요일
FROM emp; --연도/월/일/시간/분/초 추출 시 extract 함수 사용 가능

SELECT ename as 이름, to_char(sal,'999,999') as 월급
FROM emp; --월급을 출력할때 천 단위 표시 출력

SELECT ename as 이름, TO_CHAR(sal*200, '999,999,999') as 월급
FROM emp;

SELECT ename as 이름, TO_CHAR(sal*200, 'L999,999,999') as 월급
FROM emp; --화폐단위 출력 원할때 L사용

--031 : 날짜형으로 데이터 유형 변환(TO_DATE)
SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17','RR/MM/DD');

SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '81/11/17';

--날짜형식 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RR';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '17/11/81';

SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17','RR/MM/DD');

--날짜형식 재변환
ALTER SESSION SET NLS_DATE_FORMAT='RR/MM/DD';

--032 : 암시적 형 변환 이해
SELECT ename, sal
FROM emp
WHERE sal = '3000'; --숫자형 = 문자형 : 문자형을 숫자형으로 변환

--문자형으로 생성하는 스크립트
CREATE TABLE EMP32
(ENAME VARCHAR2(10),
SAL VARCHAR2(10));

INSERT INTO EMP32 VALUES('SCOTT','3000');
INSERT INTO EMP32 VALUES('SMITH','1200');
COMMIT;

SELECT ename, sal
FROM emp32
WHERE sal = 3000;

SELECT ename, sal
FROM emp32
WHERE sal = '3000';

SET AUTOT ON --SQL 실행할때 출력되는 결과와 SQL을 실행하는 실행계획을 한번에 보여달라는 SQLPLUS 명령어

SELECT ename, sal
FROM emp32
WHERE SAL = 3000;

--033 : NULL값 대신 다른 데이터 출력(NVL, NVL2)
SELECT ename, comm, NVL(comm,0)
FROM emp;

SELECT ename, sal, comm, sal+comm
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, sal, comm, NVL(comm,0), sal+NVL(comm,0)
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

--034 : IF문을 SQL로 구현(DECODE)
SELECT ename, deptno, DECODE(deptno,10,300,20,400,0) as 보너스
FROM emp;

SELECT empno, mod(empno, 2), DECODE(mod(empno,2),0,'짝수',1,'홀수') as 보너스
FROM emp;

SELECT ename, job, DECODE(job,'SALESMAN',5000,2000) as 보너스 
FROM emp;

--035 : IF문을 SQL로 구현(CASE)
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                        WHEN sal >= 2000 THEN 300
                        WHEN sal >= 1000 THEN 200
                        ELSE 0 END AS BONUS
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                        ELSE 0 END BONUS --커미션이 null이면 500, 그 외는 0 출력
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, job, CASE WHEN job in ('SALESMAN','ANALYST') THEN 500
                    WHEN job in ('CLERK','MANAGER') THEN 400
                    ELSE 0 END as 보너스
FROM emp;

--036 : 최대값 출력 (MAX)
SELECT MAX(sal)
FROM emp;

SELECT MAX(sal)
FROM emp
WHERE job='SALESMAN';

SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN'; --오류 발생 : job은 여러개의 행이 출력되려고 하는데 max값은 하나가 출력되어 오류 발생

SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN'
GROUP BY job;

SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

--037 : 최소값 출력 (MIN)
SELECT MIN(sal)
FROM emp
WHERE job='SALESMAN';

SELECT job, MIN(sal) 최소값
FROM emp
GROUP BY job
ORDER BY 최소값 DESC;

SELECT MIN(sal)
FROM emp
WHERE 1=2; --NULL출력 where절의 조건이 거짓이어도 항상 null값을 리턴

SELECT NVL(MIN(sal),0)
FROM emp
WHERE 1 = 2; --0출력 

--직업에서 salesman은 제외후 직업별 최소 월급이 높은 것부터 출력
SELECT job, MIN(sal) 
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
ORDER BY MIN(sal) DESC;

--038 : 평균값 출력 (AVG)
SELECT AVG(comm)
FROM emp;

SELECT ROUND(AVG(NVL(comm,0)))
FROM emp;

--039 : 토탈값 출력(SUM)
--부서번호와 부서번호별 총월급
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

--직업과 직업별 토탈 월급을 출력하는데, 직업별 토탈 월급이 높은 것부터 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY job
ORDER BY SUM(sal) DESC;

--직업과 직업별 토탈 월급을 출력하는데, 직업별 토탈 월급이 4000이상인 것만 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY job
HAVING SUM(sal) >= 4000;

--직업과 직업별 토탈 월급을 출력하는데, 직업에서 salesman은 제외하고, 직업별 토탈 월급이 4000이상인 사원들만 출력
SELECT job, SUM(sal)
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal)>=4000;

--040 : 건수 출력하기(Count)
SELECT COUNT(empno)
FROM emp;

SELECT COUNT(COMM)
FROM emp;

--041 : 데이터 분석 함수로 순위 출력 (RANK)
--직업이 ANAYLST, MANAGER인 사원들의 이름, 직업, 월급, 월급의 순위 출력
SELECT ename, job, sal, RANK() over(ORDER BY sal DESC) 순위
FROM emp
WHERE job in ('ANALYST','MANAGER');

--직업별로 월급이 높은 순서대로 순위 부여
SELECT ename, sal, job, RANK() over(PARTITION BY job ORDER BY sal DESC) 순위
FROM emp;

--042 : 데이터 분석 함수로 순위 출력 (DENSE_RANK)
--직업이 ANAYLST, MANAGER인 사원들의 이름, 직업, 월급, 월급의 순위 출력. 1위가 두명일 경우, 다음 순위가 2위로 출력
SELECT ename, job, sal, DENSE_RANK() over(ORDER BY sal DESC) 순위 
FROM emp
WHERE job in ('ANALYST','MANAGER');

--81년도에 입사한 사원들의 직업, 이름, 월급, 순위 출력하는데, 직업별로 월급이 높은 순서대로 순위를 부여
SELECT job, ename, sal, DENSE_RANK() over(PARTITION BY job ORDER BY sal DESC) 순위
FROM emp
WHERE TO_CHAR(hiredate,'YY') = '81';

--월급이 2975인 사원은 사원 테이블에서 월급의 순위가 어떻게 되는지 출력
SELECT DENSE_RANK(2975) within group (ORDER BY sal DESC) 순위
FROM emp;

--입사일 81년 11월17일인 사원 테이블 전체 사원들 중 몇 번째로 입사한 것인지
SELECT DENSE_RANK('81/11/17') within group (ORDER BY hiredate) 순위
FROM emp;

--043 : 데이터 분석 함수로 등급 출력 (NTILE)
--analyst, manager, clerk 중에 이름, 월급, 직업, 월급의 등급 출력(월급의 등급은 4등급으로 나눔)
SELECT ename, job, sal, NTILE(4) over(ORDER BY sal DESC) 등급
FROM emp
WHERE job in ('ANALYST','MANAGER','CLERK');

SELECT ename, job, sal, NTILE(4) over(ORDER BY sal DESC nulls last) 등급 --nulls last는 null을 맨 아래에 출력
FROM emp
WHERE job in ('ANALYST','MANAGER','CLERK');

--044 : 데이터 분석 함수로 순위의 비율 출력 (CUME_DIST)
--이름, 월급, 월급의 순위, 월급의 순위 비율 출력
SELECT ename, sal, RANK() over(ORDER BY sal DESC) 순위,
        CUME_DIST() over(ORDER BY sal DESC) as "월급의 순위 비율"
FROM emp;

--직업별로 CUME_DIST 출력
SELECT job, ename, sal, RANK() over(PARTITION BY job ORDER BY sal DESC) 순위,
        CUME_DIST() over(PARTITION BY job ORDER BY sal DESC) as "월급의 순위 비율"
FROM emp;

--045 : 데이터 분석 함수로 데이터를 가로로 출력 (LISTAGG)
--부서번호 출력, 부서 번호 옆에 해당 부서에 속하는 사원들의 이름을 가로로 출력
SELECT deptno, LISTAGG(ename,',') within group(ORDER BY ename) EMPLOYEE
FROM emp
GROUP BY deptno; --listagg 함수를 사용하려면 group by절 필수로 사용되어야함.

--직업과 그 직업에 속한 사원들의 이름을 가로로 출력
SELECT job, LISTAGG(ename,'/') within group(ORDER BY ename) EMPLOYEE
FROM emp
GROUP BY job;

--직업과 그 직업에 속한 사원들의 이름을 가로로 출력 + 월급도 같이 출력
SELECT job, LISTAGG(ename||'('||sal||')','/') within group(ORDER BY ename) EMPLOYEE
FROM emp
GROUP BY job;

--046 : 데이터 분석 함수로 바로 전 행과 다음 행 출력 (LAG, LEAD)
SELECT empno, ename, sal,
        LAG(sal,1) over(ORDER BY sal) "전 행",
        LEAD(sal,1) over(ORDER BY sal) "다음 행"
FROM emp
WHERE job in ('ANALYST','MANAGER');

--직업이 ANALYST 또는 MANAGER인 사원들의 사원번호, 이름, 입사일, 바로 전에 입사한 사원의 입사일, 바로 다음에 입사한 사원의 입사일 출력
SELECT empno, ename, hiredate,
        LAG(hiredate,1) over(ORDER BY hiredate) "전 행",
        LEAD(hiredate,1) over(ORDER BY hiredate) "다음 행"
FROM emp
WHERE job in ('ANALYST','MANAGER');

--부서번호, 사원번호, 이름, 입사일, 바로 전에 입사한 사원의 입사일 출력, 다음에 입사한 사원의 입사일 출력 (부서번호별로 구분)
SELECT deptno, empno, ename, hiredate,
        LAG(hiredate,1) over(PARTITION BY deptno ORDER BY hiredate) "전 행",
        LEAD(hiredate,1) over(PARTITION BY deptno ORDER BY hiredate) "다음 행"
FROM emp;

--047 : COLUMN을 ROW로 출력 (SUM+DECODE)
--부서번호, 부서번호별 토탈 월급 출력, 가로로 출력
SELECT SUM(DECODE(deptno,10,sal)) "10",
        SUM(DECODE(deptno,20,sal)) "20",
        SUM(DECODE(deptno,30,sal)) "30"
FROM emp;

SELECT deptno, DECODE(deptno,10,sal) "10"
FROM emp;

--직업, 직업별 토탈 월급을 가로로 출력
SELECT SUM(DECODE(job,'ANALYST',sal)) "ANALYST",
        SUM(DECODE(job,'CLERK',sal)) "CLERK",
        SUM(DECODE(job,'MANAGER',sal)) "MANAGER",
        SUM(DECODE(job,'SALESMAN',sal)) "SALESMAN"
FROM emp;

SELECT deptno, SUM(DECODE(job,'ANALYST',sal)) "ANALYST",
        SUM(DECODE(job,'CLERK',sal)) "CLERK",
        SUM(DECODE(job,'MANAGER',sal)) "MANAGER",
        SUM(DECODE(job,'SALESMAN',sal)) "SALESMAN"
FROM emp
GROUP BY deptno;

--048 : COLUMN을 ROW로 출력 (PIVOT)
--부서번호, 부서번호별 토탈 월급을 pivot문을 사용하여 가로로 출력
SELECT *
FROM (select deptno, sal from emp)
PIVOT (SUM(sal) for deptno in (10,20,30));

--직업과 직업별 토탈 월급을 가로로 출력
SELECT *
FROM (select job, sal from emp)
PIVOT (SUM(sal) for job in ('ANALYST','CLERK','MANAGER','SALESMAN'));

--싱글 쿼테이션 마크 없이 출력되게 하기
SELECT *
FROM (select job, sal from emp)
PIVOT (SUM(sal) for job in ('ANALYST' "ANALYST",'CLERK' "CLERK",'MANAGER' "MANAGER",'SALESMAN' "SALESMAN"));

--049 : ROW를 COLUMN으로 출력(UNPIVOT)
--UNPIVOT을 사용하여 컬럼을 로우로 출력
SELECT *
FROM order2
UNPIVOT (건수 for 아이템 in (BICYCLE, CAMERA, NOTEBOOK));

SELECT *
FROM order2
UNPIVOT (건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));

UPDATE ORDER2 SET NOTEBOOK=NULL WHERE ENAME='SMITH';

SELECT *
FROM order2
UNPIVOT INCLUDE NULLS (건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));

--050 : 데이터 분석 함수로 누적 데이터 출력 (SUM OVER)
SELECT empno, ename, sal, SUM(sal) over(ORDER BY empno ROWS
                                        BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 누적치 
FROM emp
WHERE job in ('ANALYST','MANAGER');
/*UNBOUNDED PRECEDING : 맨 첫 번째 행
UNBOUNDED FOLLOWING : 맨 마지막 행
*/

--051 : 데이터 분석 함수로 비율 출력 (RATIO_TO_REPORT)
--부서 번호가 20번인 사원들의 사원번호, 이름, 월급, 부서내에서 자신의 월급 비율이 어떻게 되는지 출력
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over() as 비율
FROM emp
WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over() as 비율,
        SAL/SUM(sal) over() as "비교 비율"
FROM emp
WHERE deptno = 20;

--052 : 데이터 분석 함수로 집계 결과 출력 (ROLLUP)
--직업과 직업별 토탈 월급 출력, 맨 마지막 행에 토탈 월급 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY rollup(job);

--ROLLUP에 컬럼 두개 사용할 경우 부서별 토탈과 전체 합이 출력
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno, job);

--053 : 데이터 분석 함수로 집계 결과 출력 (CUBE)
--직업, 직업별 토탈 월급 출력, 첫 번째 행에 토탈 월급 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY cube(job);

--cube에 컬럼 두개를 사용(deptno, job) : 직업별 토탈 월급, 총 토탈 월급이 상단에 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY CUBE(deptno, job);

--054 : 데이터 분석 함수로 집계 결과 출력 (GROUPING SETS)
--부서 번호와 직업, 부서 번호별 토탈 월급과 직업별 토탈 월급, 전체 토탈 월급을 출력
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((deptno),(job),()); 

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno); 

SELECT deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((deptno),()); --rollup과 동일

--055 : 데이터 분석 함수로 출력 결과 넘버링 (ROW_NUMBER)
SELECT empno, ename, sal, RANK() over(ORDER BY sal DESC) RANK,
    DENSE_RANK() over(ORDER BY sal DESC) DENSE_RANK,
    ROW_NUMBER() over(ORDER BY sal DESC) 번호
FROM emp
WHERE deptno = 20;

--ROW_NUMBER의 over 다음에 order by절을 반드시 기술해야함. 아니면 오류 발생
SELECT empno, ename, sal, ROW_NUMBER() OVER() 번호
FROM emp
WHERE deptno = 20; --오류발생

--부서번호별로 월급에 대한 순위 출력. PARTITION BY를 사용하여 부서 번호별로 파티션해서 순위 부여
SELECT deptno, ename, sal, ROW_NUMBER() over(PARTITION BY deptno ORDER BY sal DESC) 번호
FROm emp
WHERE deptno in (10,20);

--056 : 출력되는 행 제한 (ROWNUM)
--사원 테이블에서 사원 번호, 이름, 직업, 월급을 상단 5개의 행만 출력
SELECT ROWNUM, empno, ename, job, sal
FROM emp
WHERE ROWNUM <= 5; --가짜 컬럼인 ROWNUM을 where절에 사용하여 5개의 행으로 제한

--057 : 출력되는 행 제한 (Simple TOP-n Queries)
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;

--월급이 높은 사원들 중 20%에 해당하는 사원들만 출력
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal desc
FETCH FIRST 20 PERCENT ROWS ONLY;

--n번째 행의 값과 동일하다면 같이 출력해줌.
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;

--OFFSET옵션은 출력이 시작되는 행의 위치를 지정 가능 (offset9 : 10번행 부터)
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC OFFSET 9 ROWS;

SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC OFFSET 9 ROWS
FETCH FIRST 2 ROWS ONLY;

--058 : 여러 테이블의 데이터를 조인해서 출력 (EQUI JOIN)
--사원 테이블과 부서 테이블을 조인하여 이름과 부서 위치 출력
SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--where절에 부서번호가 같다는 조건을 주지 않으면 n x m 개가 출력됨
SELECT ename, loc
FROM emp, dept;

--사원 테이블과 부서 테이블을 조인하여 이름과 부서 위치 출력, job이 ANALYST인 사원들만 출력
SELECT ename, loc, job
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.job = 'ANALYST';

SELECT ename, loc, job, deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.job = 'ANALYST'; --오류 발생 : deptno의 정의가 애매함. 테이블명을 접두어로 사용해야함.

SELECT ename, loc, job, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.job = 'ANALYST';

--테이블 별칭으로 조인 코드 간결하게 작성
SELECT e.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.job = 'ANALYST';

SELECT emp.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.job = 'ANALYST'; --오류발생 : emp 테이블을 e라고 별칭했으므로 이를 따라야함.

--059 : 여러 테이블의 데이터를 조인해서 출력 (NON EQUI JOIN)
--사원 테이블과 급여 등급 테이블을 조인하여 이름, 월급, 급여 등급을 출력
SELECT e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal between s.losal and s.hisal;

--060 : 여러 테이블의 데이터를 조인해서 출력 (OUTER JOIN)
--사원과 부서 테이블을 조인하여 이름과 부서 위치 출력, Boston(ename이 null값)도 같이 출력
SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno;

--061 : 여러 테이블의 데이터를 조인해서 출력 (SELF JOIN)
--사원 테이블 자기 자신의 테이블과 조인하여 직업이 salesman인 이름, 직업, 해당 사원의 관리자 이름과 관리자 직업 출력
SELECT e.ename as 사원, e.job as 직업, m.ename as 관리자, m.job as 직업
FROM emp e, emp m
WHERE e.mgr = m.empno
AND e.job = 'SALESMAN';

--062 : 여러 테이블의 데이터를 조인해서 출력 (ON절)
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
FROM emp e JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.job = 'SALESMAN';

--063 : 여러 테이블의 데이터를 조인해서 출력(USING절)
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
FROM emp e join dept d
USING (deptno)
WHERE e.job = 'SALESMAN';

--064 : 여러 테이블의 데이터를 조인해서 출력 (NATURAL JOIN)
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
FROM emp e natural join dept d
WHERE e.job = 'SALESMAN'; --둘다 존재하는 동일한 컬럼을 기반으로 암시적인 조인 수행

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
FROM emp e natural join dept d
WHERE e.job = 'SALESMAN'
AND e.deptno = 30; --오류 발생 : 조인의 연결고리가 되는 컬럼인 deptno은 테이블명을 별칭 없이 기술해야함.

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
FROM emp e natural join dept d
WHERE e.job = 'SALESMAN'
AND deptno = 30;

--065 : 여러 테이블의 데이터를 조인해서 출력 (LEFT/RIGHT OUTER JOIN)
--이름, 직업, 월급, 부서 위치 출력 (emp가 null값인 boston까지 출력)
SELECT e.ename as 이름, e.job 직업, e.sal 월급, d.loc 부서위치
FROM emp e RIGHT OUTER JOIN dept d
ON (e.deptno = d.deptno);

INSERT INTO emp(empno, ename, sal, job, deptno)
        VALUES (8282, 'JACK', 3000, 'ANALYST', 50) ;

--left outer join 수행
SELECT e.ename 이름, e.job 직업, e.sal 월급, d.loc 부서위치
FROM emp e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno);

--066 : 여러 테이블의 데이터를 조인해서 출력 (FULL OUTER JOIN)
--FULL OUTER 조인 방법으로 이름, 직업 월급, 부서 위치 출력
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc 부서위치
FROM emp e FULL OUTER JOIN dept d
ON (e.deptno = d.deptno);

--full outer join을 사용하지 않고 동일한 결과 출력
SELECT e.ename 이름, e.job 직업, e.sal 월급, d.loc 부서위치
FROM emp e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno)
UNION
SELECT e.ename, e.job, e.sal, d.loc
FROM emp e RIGHT OUTER JOIN dept d
ON (e.deptno = d.deptno);

--067 : 집합 연산자로 데이터를 위아래로 연결 (UNION ALL)
--부서번호와 부서번호별 토탈 월급을 출력하는데, 맨 아래쪽 행에 토탈 월급을 출력
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION ALL
SELECT TO_NUMBER(null) as deptno, SUM(sal)
FROM emp;

/*-union all 위쪽 쿼리와 아래쪽 쿼리 컬럼의 개수가 동일
-union all 위쪽 쿼리와 아래쪽 쿼리 컬럼의 데이터 타입이 동일
-결과로 출력되는 컬럼명은 위쪽 쿼리의 컬럼명으로 출력
-order by절은 제일 아래쪽 쿼리에만 작성할 수 있음.
*/

DROP TABLE A;
DROP TABLE B;

CREATE TABLE A (COL1 NUMBER(10) );
INSERT INTO A VALUES(1);
INSERT INTO A VALUES(2);
INSERT INTO A VALUES(3);
INSERT INTO A VALUES(4);
INSERT INTO A VALUES(5);
commit;

CREATE TABLE B (COL1 NUMBER(10) );
INSERT INTO A VALUES(3);
INSERT INTO A VALUES(4);
INSERT INTO A VALUES(5);
INSERT INTO A VALUES(6);
INSERT INTO A VALUES(7);
commit;

--A테이블과 B테이블의 합집합 출력
SELECT col1 FROM a
UNION ALL
SELECT col1 FROM b;

--068 : 집합 연산자로 데이터를 위아래로 연결 (UNION)
--부서 번호와 부서번호별 토탈 월급을 출력, 맨 아래 행에 토탈 월급을 출력
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION
SELECT null as deptno, SUM(sal)
FROM emp;

/*union 연산자가 union all과 다른 점
-중복된 데이터를 하나의 고유한 값으로 출력
-첫 번째 컬럼의 데이터를 기준으로 내림차순으로 정렬하여 출력
*/

DROP  TABLE   C;
DROP  TABLE   D;

CREATE TABLE C (COL1 NUMBER(10) );
INSERT INTO C VALUES(1);
INSERT INTO C VALUES(2);
INSERT INTO C VALUES(3);
INSERT INTO C VALUES(4);
INSERT INTO C VALUES(5);
COMMIT;

CREATE TABLE D (COL1 NUMBER(10) );
INSERT INTO D VALUES(3);
INSERT INTO D VALUES(4);
INSERT INTO D VALUES(5);
INSERT INTO D VALUES(6);
INSERT INTO D VALUES(7);
COMMIT;

SELECT col1 FROM c
UNION 
SELECT col1 FROM D;

--069 : 집합 연산자로 데이터의 교집합 출력 (intersect)
--부서 번호 10번, 20번인 사원들을 출력하는 쿼리의 결과와 부서번호 20번, 30번을 출력하는 쿼리 결과의 교집합을 출력
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (10,20)
INTERSECT
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (20,30); --교집합인 20번 데이터 출력

DROP TABLE  E;
DROP TABLE  F;

CREATE TABLE E (COL1 NUMBER(10) );
INSERT INTO E VALUES(1);
INSERT INTO E VALUES(2);
INSERT INTO E VALUES(3);
INSERT INTO E VALUES(4);
INSERT INTO E VALUES(5);
COMMIT;

CREATE TABLE F (COL1 NUMBER(10) );
INSERT INTO F VALUES(3);
INSERT INTO F VALUES(4);
INSERT INTO F VALUES(5);
INSERT INTO F VALUES(6);
INSERT INTO F VALUES(7);
COMMIT;

SELECT col1 FROM e
INTERSECT
SELECT col1 FROM f;.

--070 : 집합 연산자로 데이터의 차이 출력 (MINUS)
--부서 번호 10번, 20번을 출력하는 쿼리에서 부서 번호 20번, 30버을 출력하는 쿼리의 결과 차이 출력
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (10,20)
MINUS
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (20,30);
--결과 데이터를 내림차순 정렬, 중복 제거

--071 : 서브 쿼리 사용 (단일행 서브쿼리)
--Jones보다 더 많은 월급을 받는 사원들의 이름과 월급 출력
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal
            FROM emp
            WHERE UPPER(ename)='JONES');

--Scott과 동일한 월급을 받는 사원들의 이름과 월급 출력(scott은 제외)
SELECT ename, sal
FROM emp
WHERE sal = (SELECT sal
            FROM emp
            WHERE ename='SCOTT')
AND ename != 'SCOTT';

--072 : 서브 쿼리 사용(다중 행 서브쿼리)
--직업이 SALESMAN인 사원들과 같은 월급을 받는 사원들의 이름과 월급 출력
SELECT ename, sal
FROM emp
WHERE sal in (SELECT sal
            FROM emp
            WHERE job = 'SALESMAN');

/*
>all : 리스트에서 가장 큰 값보다 크다
>any : 리스트에서 가장 작은 값보다 크다
<all : 리스트에서 가장 작은 값보다 작다
<any : 리스트에서 가장 큰 값보다 작다
*/

--074 : 서브 쿼리 사용 (EXISTS, NOT EXISTS)
--부서 테이블에 있는 부서 번호 중 사원 테이블에도 존재하는 부서 번호의 부서번호, 부서명, 부서위치 출력
SELECT *
FROM dept d
WHERE EXISTS (SELECT *
            FROM emp
            WHERE deptno = d.deptno);

--부서 테이블 중 emp 테이블에 존재하지 않는 데이터 출력 
SELECT *
FROM dept d
WHERE NOT EXISTS (SELECT *
                FROM emp e
                WHERE e.deptno = d.deptno);

--075 : 서브쿼리 사용 (HAVING절의 서브 쿼리)
--직업과 직업별 토탈 월급 출력, 직업이 SALESMAN인 사원들의 토탈 월급보다 더 큰 값들만 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY job
HAVING SUM(sal) > (SELECT SUM(sal)
                    FROM emp
                    WHERE job = 'SALESMAN'); --where절 사용시 에러 발생

/*
SELECT : 스칼라 서브 쿼리
FROM : IN LINE VIEW
WHERE : 서브 쿼리
GROUP BY : 서브쿼리 불가능
HAVING : 서브 쿼리
ORDER BY : 스칼라 서브 쿼리
*/

--076 : 서브 쿼리 사용 (FROM절의 서브 쿼리)
--이름과 월급과 순위를 출력하는데 순위가 1위인 사원만 출력
SELECT ename, sal, RANK() OVER(order by sal desc) 순위
FROM emp
WHERE 순위 = 1; --오류 발생

SELECT ename, sal, 순위
FROM (SELECT ename, sal, RANK() OVER(order by sal desc) 순위
    FROM emp)
WHERE 순위 = 1;

--077 : 서브 쿼리 사용 (SELECT절의 서브 쿼리)
--직업이 SALESMAN인 사원들의 이름과 월급 출력, 직업이 SALESMAN인 사원들의 최대월급과 최소월급도 같이 출력
SELECT ename, sal, max(sal), min(sal)
FROm emp
WHERE job='SALESMAN'; --오류 발생 : 단일 그룹의 그룹함수가 아님

SELECT ename, sal, (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN') 최대월급,
        (SELECT MIN(sal) FROM emp WHERE job = 'SALESMAN') 최소월급
FROM emp
WHERE job='SALESMAN';

--078 : 데이터 입력 (INSERT)
--사원 테이블에 데이터를 입력하는데 사원번호 2812, 사원이름 JACK, 월급 3500, 입사일 2019년 6월 5일, 직업 ANALYST
INSERT INTO emp (empno, ename, sal, hiredate, job)
VALUES (2812, 'JACK', 3500, TO_DATE('2019/06/05','RRRR/MM/DD'), 'ANALYST');

/* insert ino 다음에 괄호로 컬럼명을 기술하지 않으면, 전체 컬럼의 모두 데이터를 입력해야함.

DML문
INSERT
UPDATE
DELETE
MERGE : 데이터 입력, 수정, 삭제를 한번에 수행
*/

--079 : 데이터 수정(UPDATE)
--Scott의 월급을 3200으로 수정
UPDATE emp
SET sal = 3200
WHERE ename='SCOTT';
--where절에 제한 조건을 기술하지 않는 경우 테이블의 모든 월급이 3200으로 갱신됨.

UPDATE emp
SET sal = 3200, comm = 200
WHERE ename='SCOTT'; -- SET절에 변경할 컬럼을 콤마로 작성하여 동시에 변경 가능

--scott의 월급을 king의 월급으로 변경
UPDATE emp
SET sal = (SELECT sal FROM emp WHERE ename='KING')
WHERE ename='SCOTT';

/*
UPDATE : 서브 쿼리 가능
SET : 서브 쿼리 가능
WHERE : 서브 쿼리 가능
*/

--080 : 데이터 삭제 (DELETE, TRUNCATE, DROP)
--사원 테이블에서 SCOTT의 행 데이터 삭제
DELETE FROM emp
WHERE ename='SCOTT';

/*
DELETE : 데이터 삭제/저장공간 남김/저장구조 남김/취소 가능/플래쉬백 가능
TRUNCATE : 데이터 삭제/저장공간 삭제/저장구조 남김/취소 불가능/플래쉬백 불가능
DROP : 데이터 삭제/저장공간 삭제/저장구조 삭제/취소 불가능/플래쉬백 가능
*/

--테이블은 삭제하고 구조는 남겨두는 것
TRUNCATE TABLE emp;

--테이블 전체를 삭제 rollback불가능하지만 플래쉬백으로 복구 가능
DROP TABLE emp;

/* DDL문 (암시적 commit 발생)
CREATE : 객체 생성
ALTER : 객체 수정
DROP : 객체 삭제
TRUNCATE : 객체 삭제
RENAME : 객체 이름 변경
*/

--081 : 데이터 저장 및 취소(COMMIT, ROLLBACK)
INSERT INTO emp(empno, ename, sal, deptno)
VALUES(1122,'JACK',3000,20);

COMMIT;

UPDATE emp
SET sal = 4000
WHERE ename='SCOTT';

ROLLBACK;
/* TCL(Transaction Control Language)
COMMIT : 모든 변경 사항을 데이터베이스에 반영
ROLLBACK : 모든 변경 사항을 취소
SAVEPOINT : 특정 지점까지의 변경을 취소
*/

--082 : 데이터 입력, 수정, 삭제 한번에 (MERGE)
/*사원 테이블에 부서 위치 컬럼 추가, 부서 테이블을 이용하여 해당 사원의 부서 위치로 값이 갱신되도록 함.
만약 부서 테이블에는 존재하는 부서인데 사원 테이블에 없는 부서 번호라면 새롭게 사원 테이블에 입력되도록 함.
*/
ALTER TABLE emp
ADD loc varchar2(10);

MERGE INTO emp e
USING dept d
ON (e.deptno = d.deptno)
WHEN MATCHED THEN --merge update 절
UPDATE set e.loc = d.loc
WHEN NOT MATCHED THEN --merge insert 절
INSERT (e.empno, e.deptno, e.loc) VALUES (1111,d.deptno,d.loc);

SELECT *
FROM emp;

--merge문을 사용하지 않을때
UPDATE emp e
SET loc = (SELECT loc
            FROM dept d
            WHERE e.deptno = d.deptno);

--083 : 락(LOCK) 이해하기
/*같은 데이터를 동시에 갱신할 수 없도록 하는 락
UPDATE를 수행하면 대상이되는 행을 락함.
터미널 1에서 커밋을 수행하면 터미널 2에서 해당 컬럼으로 수정 가능함.
*/

--084 : SELECT FOR UPDATE절 이해
SELECT ename, sal, deptno
FROM emp
WHERE ename='JONES'
FOR UPDATE;
COMMIT;
/*위 쿼리는 검색하는 행에 락을 거는 SQL문
commit전에 다른 터미널에서 update를 수행하면 락이 걸려 변경이 되지 않고 waiting하게 됨.
commit 시행 후 lock이 해제되며 터미널2의 update문이 수행됨.
*/

--085 : 서브 쿼리를 사용하여 데이터 입력
--emp테이블의 구조를 복제해 emp2테이블을 만들고 부서번호가 10번인 사원들의 사번, 이름, 월급, 부서번호를 한 번에 입력
CREATE TABLE emp2
as
SELECT *
FROM emp
WHERE 1=2;

INSERT INTO emp2(empno, ename, sal, deptno)
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 10;

--086 : 서브 쿼리를 사용하여 데이터 수정
--직업이 SALESMAN인 사원들의 월급을 ALLEN의 월급으로 변경
UPDATE emp
SET sal = (SELECT sal
            FROM emp
            WHERE ename='ALLEN')
WHERE job='SALESMAN';

--여러 개의 컬럼들을 기술하여 한 번에도 갱신 가능
UPDATE emp
SET (sal,comm) = (SELECT sal, comm
                FROM emp
                WHERE ename='ALLEN')
WHERE ename='SCOTT';

--087 : 서브 쿼리를 사용하여 데이터 삭제
--Scott보다 더 많은 월급을 받는 사원들 삭제
DELETE FROM emp
WHERE sal > (SELECT sal
            FROM emp
            WHERE ename='SCOTT');

--월급이 해당 사원이 속한 부서 번호의 평균 월급보다 크면 삭제하는 서브 쿼리를 사용한 DELETE문
DELETE FROM emp m
WHERE sal > (SELECT avg(sal)
            FROM emp s
            WHERE s.deptno = m.deptno);
            
--088 : 서브쿼리를 사용하여 데이터 합치기
--부서 테이블에 숫자형으로 sumsal 컬럼 추가, 사원 테이블을 이용하여 sumsal컬럼의 데이터를 부서 테이블의 부서 번호별 토탈 월급으로 갱신
ALTER TABLE dept
ADD sumsal number(10);

MERGE INTO dept d
USING (SELECT deptno, SUM(sal) sumsal
        FROM emp
        GROUP BY deptno) v
ON (d.deptno = v.deptno)
WHEN MATCHED THEN --부서번호가 일치하는지 확인하여 토탈월급으로 값 갱신
UPDATE set d.sumsal = v.sumsal;

--update문으로 수행한 쿼리
UPDATE dept d
SET sumsal = (SELECT SUM(sal)
            FROM emp e
            WHERE e.deptno = d.deptno);
            
--089 : 계층형 질의문으로 서열을 주고 데이터 출력
--계층형 질의문을 이용하여 사원 이름, 월급, 직업을 출력하고 사원들 간의 서열(LEVEL)을 같이 출력
SELECT rpad(' ',level*3) || ename as employee, level, sal, job
FROM emp
START WITH ename = 'KING' --루트 노드(최상위 노드)의 데이터를 지정. 
CONNECT BY prior empno = mgr; --부모와 자식 노드들 간의 관계 지정. prior을 두고 왼쪽: 부모노드, 오른쪽: 자식노드

--090 : 계층형 질의문으로 서열을 주고 데이터 출력
--계층형 질의문을 이용하여 사원 이름, 월급, 직업을 출력하고 사원들 간의 서열(LEVEL)을 같이 출력(BLAKE와 BLAKE 직속 부하들은 출력X)
SELECT rpad(' ',level*3)||ename as employee, level, sal, job
FROM emp
START WITH ename='KING'
CONNECT BY prior empno = mgr
AND ename != 'BLAKE';

--091 : 계층형 질의문으로 서열을 주고 데이터 출력
--계층형 질의문을 이용하여 사원 이름, 월급, 직업을 서열과 같이 출력, 서열 순위를 유지하면서 월급이 높은 사원부터 출력
SELECT rpad(' ',level*3)||ename as employee, level, sal, job
FROM emp
START WITH ename='KING'
CONNECT BY prior empno=mgr
ORDER SIBLINGS BY sal desc; 
--siblings을 사용하지 않을 경우 월급이 높은 순서대로만 출력되며 서열순서가 섞임
SELECT rpad(' ',level*3)||ename as employee, level, sal, job
FROM emp
START WITH ename='KING'
CONNECT BY prior empno=mgr
ORDER BY sal desc;

--092 : 계층형 질의문으로 서열을 주고 데이터 출력
--계층형 질의문과 SYS_CONNECT_BY 함수를 이용하여 서열 순서를 가로로 출력
SELECT ename, SYS_CONNECT_BY_PATH(ename,'/') as path
FROM emp
START WITH ename='KING'
CONNECT BY prior empno = mgr;

SELECT ename, LTRIM(SYS_CONNECT_BY_PATH(ename,'/'),'/') as path --앞에 '/'을 제거하고 출력
FROM emp
START WITH ename='KING'
CONNECT BY prior empno = mgr;

--093 : 일반 테이블 생성