

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
SELECT ename, sal, job
FROM emp
WHERE sal = 3000;

SELECT ename, job
FROM emp
WHERE sal is not null;

SELECT ename as �̸�, sal as ����
FROM emp
WHERE sal >= 3000;

SELECT ename as �̸�, sal as ����
FROM emp
WHERE ���� >= 3000; --�����߻�

SELECT ename as �̸�, sal as ����
FROM emp
WHERE sal >= 3000; --where ���� select ������ ���� ���ư��� ����Ī ��� �Ұ�

--008 : WHERE �� : ���ڿ� ��¥ �˻�
SELECT ename, sal, job, hiredate, deptno
FROM emp
WHERE ename='SCOTT';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '81/11/17';

SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT'; --������ ������ ��¥ ���� Ȯ��

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD'; --���� ��¥ ���� ����
SELECT ename, sal
FROM emp
WHERE hiredate='81/11/17'; --������ �ٸ��⶧���� ��ȸ �Ұ�(RR-1981/YY-2081)

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

--009 : ��� ������
SELECT ename, sal*12 as ����
FROM emp
WHERE sal*12 >= 36000;

SELECT ename, sal, comm, sal + comm
FROM emp
WHERE deptno = 10; -- comm�� null �� ��� sal+comm�� null�� ����

SELECT ename, sal, comm, sal+NVL(comm,0)
FROM emp
WHERE deptno = 10;

--010 : �� ������
SELECT ename, sal, job, deptno
FROM emp
WHERE sal <= 1200;

--011 :  �� ������ (BETWEEN AND)
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 3000;

SELECT ename, sal
FROM emp
WHERE sal BETWEEN 3000 AND 1000; --��� ��� �ȵ�

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

--012 : �� ������ (LIKE)
SELECT ename, sal
FROM emp
WHERE ename LIKE 'S%'; --ù���� S�� �����ϴ� ������� �̸��� ����

SELECT ename
FROM emp
WHERE ename LIKE '_M%'; --�ι�° ���ڰ� M�� ���

SELECT ename
FROM emp
WHERE ename LIKE '%T'; --������ ���ڰ� T�� ������ ���

SELECT ename
FROM emp
WHERE ename LIKE '%A%'; --�̸��� A�� ���Ե� ��� ���

--013 : �� ������ (IS NULL)
SELECT ename, comm
FROM emp
WHERE comm is null;

--014 : �� ������ (IN)
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

--015 : �� ������ (AND, OR, NOT)
SELECT ename, sal, job
FROM emp
WHERE job = 'SALESMAN' AND sal >= 1200;

SELECT ename, sal, job
FROM emp
WHERE job = 'ABCDEFG' AND sal >= 1200; --TRUE AND FALSE = FALSE

--016 : ��ҹ��� ��ȯ �Լ� (UPPER, LOWER, INITCAP)
SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
FROM emp;

SELECT ename, sal
FROM emp
WHERE LOWER(ename)='scott';

--017 : ���ڿ��� Ư�� ö�� ����(SUBSTR)
SELECT SUBSTR('SMITH',1,3) --SMI ���
FROM DUAL;

--018 : ���ڿ��� ���� ���(LENGTH)
SELECT ename, LENGTH(ename)
FROM emp;

SELECT LENGTH('�����ٶ�')
FROM DUAL;

SELECT LENGTHB('�����ٶ�') --����Ʈ�� ����
FROM DUAL;

--019 : ���ڿ��� Ư�� ö���� ��ġ ���(INSTR)
SELECT INSTR('SMITH','M') --2 ���
FROM DUAL;

SELECT INSTR('abcdefg@naver.com','@') --8 ���
FROM DUAL;

SELECT SUBSTR('abcdefgh@naver.com',INSTR('abcedfgh@naver.com','@')+1)
FROM DUAL; -- naver.com ���

SELECT RTRIM(SUBSTR('abcdefgh@naver.com',INSTR('abcdefgh@naver.com','@')+1),'.com')
FROM DUAL; --naver ���

--020 : Ư�� ö�ڸ� �ٸ� ö�ڷ� ���� (REPLACE)
SELECT ename, REPLACE(sal,0,'*') -- 0�� *�� �����Ͽ� ���
FROM emp;

SELECT ename, REGEXP_REPLACE(sal,'[0-3]', '*') as SALARY --0~3�� *�� �����Ͽ� ���
FROM emp;

--���̺� ����
CREATE TABLE TEST_ENAME
(ENAME VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('����ȣ');
INSERT INTO TEST_ENAME VALUES('�Ȼ��');
INSERT INTO TEST_ENAME VALUES('�ֿ���');
COMMIT;

SELECT REPLACE(ename, SUBSTR(ename,2,1), '*') as "������_�̸�"
FROM test_ename;

--021 : Ư�� ö�ڸ� N�� ��ŭ ä��� (LPAD, RPAD)
SELECT ename, LPAD(sal,10,'*') as salary1, RPAD(sal,10,'*') as salary2
FROM emp;

SELECT ename, sal, lpad('��',round(sal/100),'��') as bar_chart
FROM emp;

--022 : Ư�� ö�� �߶󳻱� (TRIM, RTRIM, LTRIM)
SELECT 'smith', LTRIM('smith','s'),RTRIM('smith','h'),TRIM('s' from 'smiths')
FROM dual; -- smith, mith, smit, mith

--���̺� �߰�
insert into emp(empno,ename,sal,job,deptno) values(8291,'JACK ',3000,'SALESMAN',30);
commit;

SELECT ename, sal
FROM emp
WHERE ename='JACK';--��ȸ �ȵ�

SELECT ename, sal
FROM emp
WHERE TRIM(ename)='JACK';

--������ ����
DELETE FROM EMP WHERE TRIM(ENAME)='JACK';
COMMIT;

--023 : �ݿø��ؼ� ���(ROUND)
SELECT '876.567' as ����, ROUND(876.567,1) --876.6
FROM DUAL;

--024 : ���ڸ� ������ ��� (TRUNC)
SELECT '876.567' as ����, TRUNC(876.567,1) --876.5
FROM DUAL;

--025 : ���� ������ �� ��� (MOD)
SELECT MOD(10,3) --1
FROM DUAL;

SELECT empno, MOD(empno,2) --�����ȣ Ȧ���� 1, ¦���� 0
FROM emp;

SELECT empno, ename
FROM emp
WHERE MOD(empno,2) = 0; --�����ȣ ¦���� ���

SELECT FLOOR(10/3) --3 : ���� ���
FROM DUAL;

--026 : ��¥ �� ������ ��� (MONTHS_BETWEEN)
SELECT ename, MONTHS_BETWEEN(sysdate,hiredate)--(�ֽų�¥, ������¥)
FROM emp;

SELECT TO_DATE('2019-06-01','RRRR-MM-DD') - TO_DATE('2018-10-01','RRRR-MM-DD')
FROM dual;

SELECT ROUND((TO_DATE('2019-06-01','RRRR-MM-DD')-TO_DATE('2018-10-01','RRRR-MM-DD'))/7) AS "�� �ּ�"
FROM DUAL;

--027 : ���� �� ���� ��¥ ���(ADD_MONTHS)
SELECT ADD_MONTHS(TO_DATE('2019-05-01','RRRR-MM-DD'),100)
FROM dual;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + 100 --100�� ��
FROM dual;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '100' month
FROM DUAL;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '1-3' year(1) to month --1�� 3���� ��
FROM DUAL;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + interval '3' year --������ ���ڸ��� ���(year(3) ���)
FROM DUAL;

SELECT TO_DATE('2019-05-01','RRRR-MM-DD') + TO_YMINTERVAL('03-05') as ��¥ --3�� 5���� ��
FROM DUAL;

--028 : Ư�� ��¥ �ڿ� ���� ���� ��¥ (NEXT_DAY)
SELECT '2019/05/22' as ��¥, NEXT_DAY('2019/05/22','������')
FROM DUAL;

SELECT SYSDATE as ���ó�¥
FROM DUAL;

SELECT NEXT_DAY(SYSDATE,'ȭ����') as "���� ��¥"
FROM DUAL;

SELECT NEXT_DAY(ADD_MONTHS('2019/05/22',100),'ȭ����') as "���� ��¥"
FROM DUAL;

SELECT NEXT_DAY(ADD_MONTHS(SYSDATE,100),'ȭ����') as "���� ��¥"
FROM DUAL; --���� ��¥���� 100�� �ڿ� ���ƿ��� �������� ��¥ ���

--029 : Ư�� ��¥�� �ִ� ���� ������ ��¥ ��� (LAST_DAY)
SELECT '2019/05/22' as ��¥, LAST_DAY('2019/05/22') as "������ ��¥"
FROM DUAL;

SELECT LAST_DAY(SYSDATE) - SYSDATE as "���� ��¥"
FROM DUAL;

SELECT ename, hiredate, LAST_DAY(hiredate)
FROM emp
WHERE ename='KING';

--030 : ���������� ������ ���� ��ȯ(TO_CHAR)
SELECT ename, TO_CHAR(hiredate,'DAY') as ����, TO_CHAR(sal,'999,999') as ����
FROM emp
WHERE ename='SCOTT';

SELECT hiredate, TO_CHAR(hiredate,'RRRR') as ����, TO_CHAR(hiredate,'MM') as ��,
    TO_CHAR(hiredate,'DD') as ��, TO_CHAR(hiredate,'DAY') as ����
FROM emp
WHERE ename='KING';

/*���� : RRRR, YYYY, RR, YY
�� : MM, MON
�� : DD
���� : DAY, DY
�� : WW, IW, W
�ð� : HH, HH24
�� : MI
�� : SS */

SELECT ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate,'RRRR') = '1981'; 

SELECT ename as �̸�, EXTRACT(YEAR from hiredate) as ����,
                    EXTRACT(MONTH from hiredate) as ��,
                    EXTRACT(day from hiredate) as ����
FROM emp; --����/��/��/�ð�/��/�� ���� �� extract �Լ� ��� ����

SELECT ename as �̸�, to_char(sal,'999,999') as ����
FROM emp; --������ ����Ҷ� õ ���� ǥ�� ���

SELECT ename as �̸�, TO_CHAR(sal*200, '999,999,999') as ����
FROM emp;

SELECT ename as �̸�, TO_CHAR(sal*200, 'L999,999,999') as ����
FROM emp; --ȭ����� ��� ���Ҷ� L���

--031 : ��¥������ ������ ���� ��ȯ(TO_DATE)
SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17','RR/MM/DD');

SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '81/11/17';

--��¥���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RR';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '17/11/81';

SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17','RR/MM/DD');

--��¥���� �纯ȯ
ALTER SESSION SET NLS_DATE_FORMAT='RR/MM/DD';

--032 : �Ͻ��� �� ��ȯ ����
SELECT ename, sal
FROM emp
WHERE sal = '3000'; --������ = ������ : �������� ���������� ��ȯ

--���������� �����ϴ� ��ũ��Ʈ
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

SET AUTOT ON --SQL �����Ҷ� ��µǴ� ����� SQL�� �����ϴ� �����ȹ�� �ѹ��� �����޶�� SQLPLUS ��ɾ�

SELECT ename, sal
FROM emp32
WHERE SAL = 3000;

--033 : NULL�� ��� �ٸ� ������ ���(NVL, NVL2)
SELECT ename, comm, NVL(comm,0)
FROM emp;

SELECT ename, sal, comm, sal+comm
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, sal, comm, NVL(comm,0), sal+NVL(comm,0)
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

--034 : IF���� SQL�� ����(DECODE)
SELECT ename, deptno, DECODE(deptno,10,300,20,400,0) as ���ʽ�
FROM emp;

SELECT empno, mod(empno, 2), DECODE(mod(empno,2),0,'¦��',1,'Ȧ��') as ���ʽ�
FROM emp;

SELECT ename, job, DECODE(job,'SALESMAN',5000,2000) as ���ʽ� 
FROM emp;

--035 : IF���� SQL�� ����(CASE)
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                        WHEN sal >= 2000 THEN 300
                        WHEN sal >= 1000 THEN 200
                        ELSE 0 END AS BONUS
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                        ELSE 0 END BONUS --Ŀ�̼��� null�̸� 500, �� �ܴ� 0 ���
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, job, CASE WHEN job in ('SALESMAN','ANALYST') THEN 500
                    WHEN job in ('CLERK','MANAGER') THEN 400
                    ELSE 0 END as ���ʽ�
FROM emp;

--036 : �ִ밪 ��� (MAX)
SELECT MAX(sal)
FROM emp;

SELECT MAX(sal)
FROM emp
WHERE job='SALESMAN';

SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN'; --���� �߻� : job�� �������� ���� ��µǷ��� �ϴµ� max���� �ϳ��� ��µǾ� ���� �߻�

SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN'
GROUP BY job;

SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

--037 : �ּҰ� ��� (MIN)
SELECT MIN(sal)
FROM emp
WHERE job='SALESMAN';

SELECT job, MIN(sal) �ּҰ�
FROM emp
GROUP BY job
ORDER BY �ּҰ� DESC;

SELECT MIN(sal)
FROM emp
WHERE 1=2; --NULL��� where���� ������ �����̾ �׻� null���� ����

SELECT NVL(MIN(sal),0)
FROM emp
WHERE 1 = 2; --0��� 

--�������� salesman�� ������ ������ �ּ� ������ ���� �ͺ��� ���
SELECT job, MIN(sal) 
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
ORDER BY MIN(sal) DESC;

--038 : ��հ� ��� (AVG)
SELECT AVG(comm)
FROM emp;

SELECT ROUND(AVG(NVL(comm,0)))
FROM emp;

--039 : ��Ż�� ���(SUM)
--�μ���ȣ�� �μ���ȣ�� �ѿ���
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

--������ ������ ��Ż ������ ����ϴµ�, ������ ��Ż ������ ���� �ͺ��� ���
SELECT job, SUM(sal)
FROM emp
GROUP BY job
ORDER BY SUM(sal) DESC;

--������ ������ ��Ż ������ ����ϴµ�, ������ ��Ż ������ 4000�̻��� �͸� ���
SELECT job, SUM(sal)
FROM emp
GROUP BY job
HAVING SUM(sal) >= 4000;

--������ ������ ��Ż ������ ����ϴµ�, �������� salesman�� �����ϰ�, ������ ��Ż ������ 4000�̻��� ����鸸 ���
SELECT job, SUM(sal)
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal)>=4000;

--040 : �Ǽ� ����ϱ�(Count)
SELECT COUNT(empno)
FROM emp;

SELECT COUNT(COMM)
FROM emp;

--041 : ������ �м� �Լ��� ���� ��� (RANK)
--������ ANAYLST, MANAGER�� ������� �̸�, ����, ����, ������ ���� ���
SELECT ename, job, sal, RANK() over(ORDER BY sal DESC) ����
FROM emp
WHERE job in ('ANALYST','MANAGER');

--�������� ������ ���� ������� ���� �ο�
SELECT ename, sal, job, RANK() over(PARTITION BY job ORDER BY sal DESC) ����
FROM emp;

--042 : ������ �м� �Լ��� ���� ��� (DENSE_RANK)
--������ ANAYLST, MANAGER�� ������� �̸�, ����, ����, ������ ���� ���. 1���� �θ��� ���, ���� ������ 2���� ���
SELECT ename, job, sal, DENSE_RANK() over(ORDER BY sal DESC) ���� 
FROM emp
WHERE job in ('ANALYST','MANAGER');

--81�⵵�� �Ի��� ������� ����, �̸�, ����, ���� ����ϴµ�, �������� ������ ���� ������� ������ �ο�
SELECT job, ename, sal, DENSE_RANK() over(PARTITION BY job ORDER BY sal DESC) ����
FROM emp
WHERE TO_CHAR(hiredate,'YY') = '81';

--������ 2975�� ����� ��� ���̺��� ������ ������ ��� �Ǵ��� ���
SELECT DENSE_RANK(2975) within group (ORDER BY sal DESC) ����
FROM emp;

--�Ի��� 81�� 11��17���� ��� ���̺� ��ü ����� �� �� ��°�� �Ի��� ������
SELECT DENSE_RANK('81/11/17') within group (ORDER BY hiredate) ����
FROM emp;

--043 : ������ �м� �Լ��� ��� ��� (NTILE)
--analyst, manager, clerk �߿� �̸�, ����, ����, ������ ��� ���(������ ����� 4������� ����)
SELECT ename, job, sal, NTILE(4) over(ORDER BY sal DESC) ���
FROM emp
WHERE job in ('ANALYST','MANAGER','CLERK');

SELECT ename, job, sal, NTILE(4) over(ORDER BY sal DESC nulls last) ��� --nulls last�� null�� �� �Ʒ��� ���
FROM emp
WHERE job in ('ANALYST','MANAGER','CLERK');

--044 : ������ �м� �Լ��� ������ ���� ��� (CUME_DIST)
--�̸�, ����, ������ ����, ������ ���� ���� ���
SELECT ename, sal, RANK() over(ORDER BY sal DESC) ����,
        CUME_DIST() over(ORDER BY sal DESC) as "������ ���� ����"
FROM emp;

--�������� CUME_DIST ���
SELECT job, ename, sal, RANK() over(PARTITION BY job ORDER BY sal DESC) ����,
        CUME_DIST() over(PARTITION BY job ORDER BY sal DESC) as "������ ���� ����"
FROM emp;

--045 : ������ �м� �Լ��� �����͸� ���η� ��� (LISTAGG)
--�μ���ȣ ���, �μ� ��ȣ ���� �ش� �μ��� ���ϴ� ������� �̸��� ���η� ���
SELECT deptno, LISTAGG(ename,',') within group(ORDER BY ename) EMPLOYEE
FROM emp
GROUP BY deptno; --listagg �Լ��� ����Ϸ��� group by�� �ʼ��� ���Ǿ����.

--������ �� ������ ���� ������� �̸��� ���η� ���
SELECT job, LISTAGG(ename,'/') within group(ORDER BY ename) EMPLOYEE
FROM emp
GROUP BY job;

--������ �� ������ ���� ������� �̸��� ���η� ��� + ���޵� ���� ���
SELECT job, LISTAGG(ename||'('||sal||')','/') within group(ORDER BY ename) EMPLOYEE
FROM emp
GROUP BY job;

--046 : ������ �м� �Լ��� �ٷ� �� ��� ���� �� ��� (LAG, LEAD)
SELECT empno, ename, sal,
        LAG(sal,1) over(ORDER BY sal) "�� ��",
        LEAD(sal,1) over(ORDER BY sal) "���� ��"
FROM emp
WHERE job in ('ANALYST','MANAGER');

--������ ANALYST �Ǵ� MANAGER�� ������� �����ȣ, �̸�, �Ի���, �ٷ� ���� �Ի��� ����� �Ի���, �ٷ� ������ �Ի��� ����� �Ի��� ���
SELECT empno, ename, hiredate,
        LAG(hiredate,1) over(ORDER BY hiredate) "�� ��",
        LEAD(hiredate,1) over(ORDER BY hiredate) "���� ��"
FROM emp
WHERE job in ('ANALYST','MANAGER');

--�μ���ȣ, �����ȣ, �̸�, �Ի���, �ٷ� ���� �Ի��� ����� �Ի��� ���, ������ �Ի��� ����� �Ի��� ��� (�μ���ȣ���� ����)
SELECT deptno, empno, ename, hiredate,
        LAG(hiredate,1) over(PARTITION BY deptno ORDER BY hiredate) "�� ��",
        LEAD(hiredate,1) over(PARTITION BY deptno ORDER BY hiredate) "���� ��"
FROM emp;

--047 : COLUMN�� ROW�� ��� (SUM+DECODE)
--�μ���ȣ, �μ���ȣ�� ��Ż ���� ���, ���η� ���
SELECT SUM(DECODE(deptno,10,sal)) "10",
        SUM(DECODE(deptno,20,sal)) "20",
        SUM(DECODE(deptno,30,sal)) "30"
FROM emp;

SELECT deptno, DECODE(deptno,10,sal) "10"
FROM emp;

--����, ������ ��Ż ������ ���η� ���
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

--048 : COLUMN�� ROW�� ��� (PIVOT)
--�μ���ȣ, �μ���ȣ�� ��Ż ������ pivot���� ����Ͽ� ���η� ���
SELECT *
FROM (select deptno, sal from emp)
PIVOT (SUM(sal) for deptno in (10,20,30));

--������ ������ ��Ż ������ ���η� ���
SELECT *
FROM (select job, sal from emp)
PIVOT (SUM(sal) for job in ('ANALYST','CLERK','MANAGER','SALESMAN'));

--�̱� �����̼� ��ũ ���� ��µǰ� �ϱ�
SELECT *
FROM (select job, sal from emp)
PIVOT (SUM(sal) for job in ('ANALYST' "ANALYST",'CLERK' "CLERK",'MANAGER' "MANAGER",'SALESMAN' "SALESMAN"));

--049 : ROW�� COLUMN���� ���(UNPIVOT)
--UNPIVOT�� ����Ͽ� �÷��� �ο�� ���
SELECT *
FROM order2
UNPIVOT (�Ǽ� for ������ in (BICYCLE, CAMERA, NOTEBOOK));

SELECT *
FROM order2
UNPIVOT (�Ǽ� for ������ in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));

UPDATE ORDER2 SET NOTEBOOK=NULL WHERE ENAME='SMITH';

SELECT *
FROM order2
UNPIVOT INCLUDE NULLS (�Ǽ� for ������ in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));

--050 : ������ �м� �Լ��� ���� ������ ��� (SUM OVER)
SELECT empno, ename, sal, SUM(sal) over(ORDER BY empno ROWS
                                        BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ����ġ 
FROM emp
WHERE job in ('ANALYST','MANAGER');
/*UNBOUNDED PRECEDING : �� ù ��° ��
UNBOUNDED FOLLOWING : �� ������ ��
*/

--051 : ������ �м� �Լ��� ���� ��� (RATIO_TO_REPORT)
--�μ� ��ȣ�� 20���� ������� �����ȣ, �̸�, ����, �μ������� �ڽ��� ���� ������ ��� �Ǵ��� ���
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over() as ����
FROM emp
WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over() as ����,
        SAL/SUM(sal) over() as "�� ����"
FROM emp
WHERE deptno = 20;

--052 : ������ �м� �Լ��� ���� ��� ��� (ROLLUP)
--������ ������ ��Ż ���� ���, �� ������ �࿡ ��Ż ���� ���
SELECT job, SUM(sal)
FROM emp
GROUP BY rollup(job);

--ROLLUP�� �÷� �ΰ� ����� ��� �μ��� ��Ż�� ��ü ���� ���
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno, job);

--053 : ������ �м� �Լ��� ���� ��� ��� (CUBE)
--����, ������ ��Ż ���� ���, ù ��° �࿡ ��Ż ���� ���
SELECT job, SUM(sal)
FROM emp
GROUP BY cube(job);

--cube�� �÷� �ΰ��� ���(deptno, job) : ������ ��Ż ����, �� ��Ż ������ ��ܿ� ���
SELECT job, SUM(sal)
FROM emp
GROUP BY CUBE(deptno, job);

--054 : ������ �м� �Լ��� ���� ��� ��� (GROUPING SETS)
--�μ� ��ȣ�� ����, �μ� ��ȣ�� ��Ż ���ް� ������ ��Ż ����, ��ü ��Ż ������ ���
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((deptno),(job),()); 

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno); 

SELECT deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((deptno),()); --rollup�� ����

--055 : ������ �м� �Լ��� ��� ��� �ѹ��� (ROW_NUMBER)
SELECT empno, ename, sal, RANK() over(ORDER BY sal DESC) RANK,
    DENSE_RANK() over(ORDER BY sal DESC) DENSE_RANK,
    ROW_NUMBER() over(ORDER BY sal DESC) ��ȣ
FROM emp
WHERE deptno = 20;

--ROW_NUMBER�� over ������ order by���� �ݵ�� ����ؾ���. �ƴϸ� ���� �߻�
SELECT empno, ename, sal, ROW_NUMBER() OVER() ��ȣ
FROM emp
WHERE deptno = 20; --�����߻�

--�μ���ȣ���� ���޿� ���� ���� ���. PARTITION BY�� ����Ͽ� �μ� ��ȣ���� ��Ƽ���ؼ� ���� �ο�
SELECT deptno, ename, sal, ROW_NUMBER() over(PARTITION BY deptno ORDER BY sal DESC) ��ȣ
FROm emp
WHERE deptno in (10,20);

--056 : ��µǴ� �� ���� (ROWNUM)
--��� ���̺��� ��� ��ȣ, �̸�, ����, ������ ��� 5���� �ุ ���
SELECT ROWNUM, empno, ename, job, sal
FROM emp
WHERE ROWNUM <= 5; --��¥ �÷��� ROWNUM�� where���� ����Ͽ� 5���� ������ ����

--057 : ��µǴ� �� ���� (Simple TOP-n Queries)
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;

--������ ���� ����� �� 20%�� �ش��ϴ� ����鸸 ���
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal desc
FETCH FIRST 20 PERCENT ROWS ONLY;

--n��° ���� ���� �����ϴٸ� ���� �������.
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;

--OFFSET�ɼ��� ����� ���۵Ǵ� ���� ��ġ�� ���� ���� (offset9 : 10���� ����)
SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC OFFSET 9 ROWS;

SELECT empno, ename, job, sal
FROM emp
ORDER BY sal DESC OFFSET 9 ROWS
FETCH FIRST 2 ROWS ONLY;


