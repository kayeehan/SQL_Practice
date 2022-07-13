

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


