

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

--058 : ���� ���̺��� �����͸� �����ؼ� ��� (EQUI JOIN)
--��� ���̺�� �μ� ���̺��� �����Ͽ� �̸��� �μ� ��ġ ���
SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--where���� �μ���ȣ�� ���ٴ� ������ ���� ������ n x m ���� ��µ�
SELECT ename, loc
FROM emp, dept;

--��� ���̺�� �μ� ���̺��� �����Ͽ� �̸��� �μ� ��ġ ���, job�� ANALYST�� ����鸸 ���
SELECT ename, loc, job
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.job = 'ANALYST';

SELECT ename, loc, job, deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.job = 'ANALYST'; --���� �߻� : deptno�� ���ǰ� �ָ���. ���̺���� ���ξ�� ����ؾ���.

SELECT ename, loc, job, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.job = 'ANALYST';

--���̺� ��Ī���� ���� �ڵ� �����ϰ� �ۼ�
SELECT e.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.job = 'ANALYST';

SELECT emp.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.job = 'ANALYST'; --�����߻� : emp ���̺��� e��� ��Ī�����Ƿ� �̸� �������.

--059 : ���� ���̺��� �����͸� �����ؼ� ��� (NON EQUI JOIN)
--��� ���̺�� �޿� ��� ���̺��� �����Ͽ� �̸�, ����, �޿� ����� ���
SELECT e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal between s.losal and s.hisal;

--060 : ���� ���̺��� �����͸� �����ؼ� ��� (OUTER JOIN)
--����� �μ� ���̺��� �����Ͽ� �̸��� �μ� ��ġ ���, Boston(ename�� null��)�� ���� ���
SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno;

--061 : ���� ���̺��� �����͸� �����ؼ� ��� (SELF JOIN)
--��� ���̺� �ڱ� �ڽ��� ���̺�� �����Ͽ� ������ salesman�� �̸�, ����, �ش� ����� ������ �̸��� ������ ���� ���
SELECT e.ename as ���, e.job as ����, m.ename as ������, m.job as ����
FROM emp e, emp m
WHERE e.mgr = m.empno
AND e.job = 'SALESMAN';

--062 : ���� ���̺��� �����͸� �����ؼ� ��� (ON��)
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as �μ���ġ
FROM emp e JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.job = 'SALESMAN';

--063 : ���� ���̺��� �����͸� �����ؼ� ���(USING��)
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as �μ���ġ
FROM emp e join dept d
USING (deptno)
WHERE e.job = 'SALESMAN';

--064 : ���� ���̺��� �����͸� �����ؼ� ��� (NATURAL JOIN)
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as �μ���ġ
FROM emp e natural join dept d
WHERE e.job = 'SALESMAN'; --�Ѵ� �����ϴ� ������ �÷��� ������� �Ͻ����� ���� ����

SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as �μ���ġ
FROM emp e natural join dept d
WHERE e.job = 'SALESMAN'
AND e.deptno = 30; --���� �߻� : ������ ������� �Ǵ� �÷��� deptno�� ���̺���� ��Ī ���� ����ؾ���.

SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as �μ���ġ
FROM emp e natural join dept d
WHERE e.job = 'SALESMAN'
AND deptno = 30;

--065 : ���� ���̺��� �����͸� �����ؼ� ��� (LEFT/RIGHT OUTER JOIN)
--�̸�, ����, ����, �μ� ��ġ ��� (emp�� null���� boston���� ���)
SELECT e.ename as �̸�, e.job ����, e.sal ����, d.loc �μ���ġ
FROM emp e RIGHT OUTER JOIN dept d
ON (e.deptno = d.deptno);

INSERT INTO emp(empno, ename, sal, job, deptno)
        VALUES (8282, 'JACK', 3000, 'ANALYST', 50) ;

--left outer join ����
SELECT e.ename �̸�, e.job ����, e.sal ����, d.loc �μ���ġ
FROM emp e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno);

--066 : ���� ���̺��� �����͸� �����ؼ� ��� (FULL OUTER JOIN)
--FULL OUTER ���� ������� �̸�, ���� ����, �μ� ��ġ ���
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc �μ���ġ
FROM emp e FULL OUTER JOIN dept d
ON (e.deptno = d.deptno);

--full outer join�� ������� �ʰ� ������ ��� ���
SELECT e.ename �̸�, e.job ����, e.sal ����, d.loc �μ���ġ
FROM emp e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno)
UNION
SELECT e.ename, e.job, e.sal, d.loc
FROM emp e RIGHT OUTER JOIN dept d
ON (e.deptno = d.deptno);

--067 : ���� �����ڷ� �����͸� ���Ʒ��� ���� (UNION ALL)
--�μ���ȣ�� �μ���ȣ�� ��Ż ������ ����ϴµ�, �� �Ʒ��� �࿡ ��Ż ������ ���
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION ALL
SELECT TO_NUMBER(null) as deptno, SUM(sal)
FROM emp;

/*-union all ���� ������ �Ʒ��� ���� �÷��� ������ ����
-union all ���� ������ �Ʒ��� ���� �÷��� ������ Ÿ���� ����
-����� ��µǴ� �÷����� ���� ������ �÷������� ���
-order by���� ���� �Ʒ��� �������� �ۼ��� �� ����.
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

--A���̺�� B���̺��� ������ ���
SELECT col1 FROM a
UNION ALL
SELECT col1 FROM b;

--068 : ���� �����ڷ� �����͸� ���Ʒ��� ���� (UNION)
--�μ� ��ȣ�� �μ���ȣ�� ��Ż ������ ���, �� �Ʒ� �࿡ ��Ż ������ ���
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION
SELECT null as deptno, SUM(sal)
FROM emp;

/*union �����ڰ� union all�� �ٸ� ��
-�ߺ��� �����͸� �ϳ��� ������ ������ ���
-ù ��° �÷��� �����͸� �������� ������������ �����Ͽ� ���
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

--069 : ���� �����ڷ� �������� ������ ��� (intersect)
--�μ� ��ȣ 10��, 20���� ������� ����ϴ� ������ ����� �μ���ȣ 20��, 30���� ����ϴ� ���� ����� �������� ���
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (10,20)
INTERSECT
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (20,30); --�������� 20�� ������ ���

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

--070 : ���� �����ڷ� �������� ���� ��� (MINUS)
--�μ� ��ȣ 10��, 20���� ����ϴ� �������� �μ� ��ȣ 20��, 30���� ����ϴ� ������ ��� ���� ���
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (10,20)
MINUS
SELECT ename, sal, job, deptno
FROM emp
WHERE deptno in (20,30);
--��� �����͸� �������� ����, �ߺ� ����

--071 : ���� ���� ��� (������ ��������)
--Jones���� �� ���� ������ �޴� ������� �̸��� ���� ���
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal
            FROM emp
            WHERE UPPER(ename)='JONES');

--Scott�� ������ ������ �޴� ������� �̸��� ���� ���(scott�� ����)
SELECT ename, sal
FROM emp
WHERE sal = (SELECT sal
            FROM emp
            WHERE ename='SCOTT')
AND ename != 'SCOTT';

--072 : ���� ���� ���(���� �� ��������)
--������ SALESMAN�� ������ ���� ������ �޴� ������� �̸��� ���� ���
SELECT ename, sal
FROM emp
WHERE sal in (SELECT sal
            FROM emp
            WHERE job = 'SALESMAN');

/*
>all : ����Ʈ���� ���� ū ������ ũ��
>any : ����Ʈ���� ���� ���� ������ ũ��
<all : ����Ʈ���� ���� ���� ������ �۴�
<any : ����Ʈ���� ���� ū ������ �۴�
*/

--074 : ���� ���� ��� (EXISTS, NOT EXISTS)
--�μ� ���̺� �ִ� �μ� ��ȣ �� ��� ���̺��� �����ϴ� �μ� ��ȣ�� �μ���ȣ, �μ���, �μ���ġ ���
SELECT *
FROM dept d
WHERE EXISTS (SELECT *
            FROM emp
            WHERE deptno = d.deptno);

--�μ� ���̺� �� emp ���̺� �������� �ʴ� ������ ��� 
SELECT *
FROM dept d
WHERE NOT EXISTS (SELECT *
                FROM emp e
                WHERE e.deptno = d.deptno);

--075 : �������� ��� (HAVING���� ���� ����)
--������ ������ ��Ż ���� ���, ������ SALESMAN�� ������� ��Ż ���޺��� �� ū ���鸸 ���
SELECT job, SUM(sal)
FROM emp
GROUP BY job
HAVING SUM(sal) > (SELECT SUM(sal)
                    FROM emp
                    WHERE job = 'SALESMAN'); --where�� ���� ���� �߻�

/*
SELECT : ��Į�� ���� ����
FROM : IN LINE VIEW
WHERE : ���� ����
GROUP BY : �������� �Ұ���
HAVING : ���� ����
ORDER BY : ��Į�� ���� ����
*/

--076 : ���� ���� ��� (FROM���� ���� ����)
--�̸��� ���ް� ������ ����ϴµ� ������ 1���� ����� ���
SELECT ename, sal, RANK() OVER(order by sal desc) ����
FROM emp
WHERE ���� = 1; --���� �߻�

SELECT ename, sal, ����
FROM (SELECT ename, sal, RANK() OVER(order by sal desc) ����
    FROM emp)
WHERE ���� = 1;

--077 : ���� ���� ��� (SELECT���� ���� ����)
--������ SALESMAN�� ������� �̸��� ���� ���, ������ SALESMAN�� ������� �ִ���ް� �ּҿ��޵� ���� ���
SELECT ename, sal, max(sal), min(sal)
FROm emp
WHERE job='SALESMAN'; --���� �߻� : ���� �׷��� �׷��Լ��� �ƴ�

SELECT ename, sal, (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN') �ִ����,
        (SELECT MIN(sal) FROM emp WHERE job = 'SALESMAN') �ּҿ���
FROM emp
WHERE job='SALESMAN';

--078 : ������ �Է� (INSERT)
--��� ���̺� �����͸� �Է��ϴµ� �����ȣ 2812, ����̸� JACK, ���� 3500, �Ի��� 2019�� 6�� 5��, ���� ANALYST
INSERT INTO emp (empno, ename, sal, hiredate, job)
VALUES (2812, 'JACK', 3500, TO_DATE('2019/06/05','RRRR/MM/DD'), 'ANALYST');

/* insert ino ������ ��ȣ�� �÷����� ������� ������, ��ü �÷��� ��� �����͸� �Է��ؾ���.

DML��
INSERT
UPDATE
DELETE
MERGE : ������ �Է�, ����, ������ �ѹ��� ����
*/

--079 : ������ ����(UPDATE)
--Scott�� ������ 3200���� ����
UPDATE emp
SET sal = 3200
WHERE ename='SCOTT';
--where���� ���� ������ ������� �ʴ� ��� ���̺��� ��� ������ 3200���� ���ŵ�.

UPDATE emp
SET sal = 3200, comm = 200
WHERE ename='SCOTT'; -- SET���� ������ �÷��� �޸��� �ۼ��Ͽ� ���ÿ� ���� ����

--scott�� ������ king�� �������� ����
UPDATE emp
SET sal = (SELECT sal FROM emp WHERE ename='KING')
WHERE ename='SCOTT';

/*
UPDATE : ���� ���� ����
SET : ���� ���� ����
WHERE : ���� ���� ����
*/

--080 : ������ ���� (DELETE, TRUNCATE, DROP)
--��� ���̺��� SCOTT�� �� ������ ����
DELETE FROM emp
WHERE ename='SCOTT';

/*
DELETE : ������ ����/������� ����/���屸�� ����/��� ����/�÷����� ����
TRUNCATE : ������ ����/������� ����/���屸�� ����/��� �Ұ���/�÷����� �Ұ���
DROP : ������ ����/������� ����/���屸�� ����/��� �Ұ���/�÷����� ����
*/

--���̺��� �����ϰ� ������ ���ܵδ� ��
TRUNCATE TABLE emp;

--���̺� ��ü�� ���� rollback�Ұ��������� �÷��������� ���� ����
DROP TABLE emp;

/* DDL�� (�Ͻ��� commit �߻�)
CREATE : ��ü ����
ALTER : ��ü ����
DROP : ��ü ����
TRUNCATE : ��ü ����
RENAME : ��ü �̸� ����
*/

--081 : ������ ���� �� ���(COMMIT, ROLLBACK)
INSERT INTO emp(empno, ename, sal, deptno)
VALUES(1122,'JACK',3000,20);

COMMIT;

UPDATE emp
SET sal = 4000
WHERE ename='SCOTT';

ROLLBACK;
/* TCL(Transaction Control Language)
COMMIT : ��� ���� ������ �����ͺ��̽��� �ݿ�
ROLLBACK : ��� ���� ������ ���
SAVEPOINT : Ư�� ���������� ������ ���
*/

--082 : ������ �Է�, ����, ���� �ѹ��� (MERGE)
/*��� ���̺� �μ� ��ġ �÷� �߰�, �μ� ���̺��� �̿��Ͽ� �ش� ����� �μ� ��ġ�� ���� ���ŵǵ��� ��.
���� �μ� ���̺��� �����ϴ� �μ��ε� ��� ���̺� ���� �μ� ��ȣ��� ���Ӱ� ��� ���̺� �Էµǵ��� ��.
*/
ALTER TABLE emp
ADD loc varchar2(10);

MERGE INTO emp e
USING dept d
ON (e.deptno = d.deptno)
WHEN MATCHED THEN --merge update ��
UPDATE set e.loc = d.loc
WHEN NOT MATCHED THEN --merge insert ��
INSERT (e.empno, e.deptno, e.loc) VALUES (1111,d.deptno,d.loc);

SELECT *
FROM emp;

--merge���� ������� ������
UPDATE emp e
SET loc = (SELECT loc
            FROM dept d
            WHERE e.deptno = d.deptno);

--083 : ��(LOCK) �����ϱ�
/*���� �����͸� ���ÿ� ������ �� ������ �ϴ� ��
UPDATE�� �����ϸ� ����̵Ǵ� ���� ����.
�͹̳� 1���� Ŀ���� �����ϸ� �͹̳� 2���� �ش� �÷����� ���� ������.
*/

--084 : SELECT FOR UPDATE�� ����
SELECT ename, sal, deptno
FROM emp
WHERE ename='JONES'
FOR UPDATE;
COMMIT;
/*�� ������ �˻��ϴ� �࿡ ���� �Ŵ� SQL��
commit���� �ٸ� �͹̳ο��� update�� �����ϸ� ���� �ɷ� ������ ���� �ʰ� waiting�ϰ� ��.
commit ���� �� lock�� �����Ǹ� �͹̳�2�� update���� �����.
*/

--085 : ���� ������ ����Ͽ� ������ �Է�
--emp���̺��� ������ ������ emp2���̺��� ����� �μ���ȣ�� 10���� ������� ���, �̸�, ����, �μ���ȣ�� �� ���� �Է�
CREATE TABLE emp2
as
SELECT *
FROM emp
WHERE 1=2;

INSERT INTO emp2(empno, ename, sal, deptno)
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 10;

--086 : ���� ������ ����Ͽ� ������ ����
--������ SALESMAN�� ������� ������ ALLEN�� �������� ����
UPDATE emp
SET sal = (SELECT sal
            FROM emp
            WHERE ename='ALLEN')
WHERE job='SALESMAN';

--���� ���� �÷����� ����Ͽ� �� ������ ���� ����
UPDATE emp
SET (sal,comm) = (SELECT sal, comm
                FROM emp
                WHERE ename='ALLEN')
WHERE ename='SCOTT';

--087 : ���� ������ ����Ͽ� ������ ����
--Scott���� �� ���� ������ �޴� ����� ����
DELETE FROM emp
WHERE sal > (SELECT sal
            FROM emp
            WHERE ename='SCOTT');

--������ �ش� ����� ���� �μ� ��ȣ�� ��� ���޺��� ũ�� �����ϴ� ���� ������ ����� DELETE��
DELETE FROM emp m
WHERE sal > (SELECT avg(sal)
            FROM emp s
            WHERE s.deptno = m.deptno);
            
--088 : ���������� ����Ͽ� ������ ��ġ��
--�μ� ���̺� ���������� sumsal �÷� �߰�, ��� ���̺��� �̿��Ͽ� sumsal�÷��� �����͸� �μ� ���̺��� �μ� ��ȣ�� ��Ż �������� ����
ALTER TABLE dept
ADD sumsal number(10);

MERGE INTO dept d
USING (SELECT deptno, SUM(sal) sumsal
        FROM emp
        GROUP BY deptno) v
ON (d.deptno = v.deptno)
WHEN MATCHED THEN --�μ���ȣ�� ��ġ�ϴ��� Ȯ���Ͽ� ��Ż�������� �� ����
UPDATE set d.sumsal = v.sumsal;

--update������ ������ ����
UPDATE dept d
SET sumsal = (SELECT SUM(sal)
            FROM emp e
            WHERE e.deptno = d.deptno);
            
--089 : ������ ���ǹ����� ������ �ְ� ������ ���
--������ ���ǹ��� �̿��Ͽ� ��� �̸�, ����, ������ ����ϰ� ����� ���� ����(LEVEL)�� ���� ���
SELECT rpad(' ',level*3) || ename as employee, level, sal, job
FROM emp
START WITH ename = 'KING' --��Ʈ ���(�ֻ��� ���)�� �����͸� ����. 
CONNECT BY prior empno = mgr; --�θ�� �ڽ� ���� ���� ���� ����. prior�� �ΰ� ����: �θ���, ������: �ڽĳ��

--090 : ������ ���ǹ����� ������ �ְ� ������ ���
--������ ���ǹ��� �̿��Ͽ� ��� �̸�, ����, ������ ����ϰ� ����� ���� ����(LEVEL)�� ���� ���(BLAKE�� BLAKE ���� ���ϵ��� ���X)
SELECT rpad(' ',level*3)||ename as employee, level, sal, job
FROM emp
START WITH ename='KING'
CONNECT BY prior empno = mgr
AND ename != 'BLAKE';

--091 : ������ ���ǹ����� ������ �ְ� ������ ���
--������ ���ǹ��� �̿��Ͽ� ��� �̸�, ����, ������ ������ ���� ���, ���� ������ �����ϸ鼭 ������ ���� ������� ���
SELECT rpad(' ',level*3)||ename as employee, level, sal, job
FROM emp
START WITH ename='KING'
CONNECT BY prior empno=mgr
ORDER SIBLINGS BY sal desc; 
--siblings�� ������� ���� ��� ������ ���� ������θ� ��µǸ� ���������� ����
SELECT rpad(' ',level*3)||ename as employee, level, sal, job
FROM emp
START WITH ename='KING'
CONNECT BY prior empno=mgr
ORDER BY sal desc;

--092 : ������ ���ǹ����� ������ �ְ� ������ ���
--������ ���ǹ��� SYS_CONNECT_BY �Լ��� �̿��Ͽ� ���� ������ ���η� ���
SELECT ename, SYS_CONNECT_BY_PATH(ename,'/') as path
FROM emp
START WITH ename='KING'
CONNECT BY prior empno = mgr;

SELECT ename, LTRIM(SYS_CONNECT_BY_PATH(ename,'/'),'/') as path --�տ� '/'�� �����ϰ� ���
FROM emp
START WITH ename='KING'
CONNECT BY prior empno = mgr;

--093 : �Ϲ� ���̺� ����(CREATE TABLE)
--��� ��ȣ, �̸�, ����, �Ի����� ������ �� �ִ� ���̺� ����
CREATE TABLE emp01
(empno number(10),
ename varchar2(10),
sal number(10,2),
hiredate date);

/* ���̺� ��� �÷� �� ���� �� ��Ģ
-�ݵ�� ���ڷ� ����
-�̸��� ���̴� 30�� ����
-�빮�� ���ĺ��� �ҹ��� ���ĺ��� ���ڸ� ����
-Ư�����ڴ� $,_,#�� ������ �� ���� */

--094 : �ӽ� ���̺� ���� (CREATE TEMPORARY TABLE)
--��� ��ȣ, �̸�, ������ ������ �� �ִ� ���̺��� �����ϴµ� COMMIT�� �������� �����͸� ������ �� �ֵ��� ����
CREATE GLOBAL TEMPORARY TABLE emp37
(EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10))
ON COMMIT DELETE ROWS;
/*ON COMMIT DELETE ROWS : �ӽ� ���̺� �����͸� �Է��ϰ� COMMIT�� �������� �����͸� ����
ON COMMIT PRESERVE ROWS : �ӽ� ���̺� �����͸� �Է��ϰ� ������ ����� ������ �����͸� ����
*/
INSERT INTO emp37 values(1111,'scott',3000);
INSERT INTO emp37 values(2222,'smith',4000);
SELECT * FROM emp37;
commit;
SELECT * FROM emp37; --��ȸ���� ����.

CREATE GLOBAL TEMPORARY TABLE emp38
(EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10))
ON COMMIT PRESERVE ROWS;

INSERT INTO emp38 VALUES(1111,'scott',3000);
INSERT INTO emp38 values(2222,'smith',4000);
SELECT * FROM emp38;
commit;
SELECT * FROM emp38; --��ȸ��.

--exit �� ����ȸ�ϸ� ��ȸ���� ����.

--095 : ������ ������ �ܼ��ϰ� �ϱ�(VIEW)
--������ SALESMAN�� ������� ��� ��ȣ, �̸�, ����, ����, �μ���ȣ�� ����ϴ� VIEW�� ����
CREATE VIEW EMP_VIEW
AS
SELECT empno, ename, sal, job, deptno
FROM emp
WHERE job='SALESMAN';

SELECT * FROM emp_view;
--emp �÷��� �Ϻ� �÷��鸸 �� �� ����. ���Ȼ� �����ϸ� �� �Ǵ� �����͵��� ���� �� ����.

UPDATE emp_view 
SET sal=0 
WHERE ename='MARTIN';

SELECT empno, ename, sal, job, deptno
FROM emp
WHERE job='SALESMAN'; --view�Ӹ� �ƴ϶� ���� �������� emp ���̺� �����.

--096 : ������ ������ �ܼ��ϰ� �ϱ� (VIEW)
--�μ� ��ȣ�� �μ� ��ȣ�� ��� ������ ����ϴ� VIEW�� ����
CREATE VIEW emp_view2
AS
SELECT deptno, round(avg(sal)) ��տ��� --�� ������ �Լ��� �׷� �Լ��� �ۼ��� ���� �ݵ�� �÷� ��Ī�� ����ؾ���.
FROM emp
GROUP BY deptno;

SELECT * FROM emp_view2;

--emp_view2�� ��� ������ �� 30�� �μ� ��ȣ�� ��� ������ 1567���� 3000���� ����
UPDATE emp_view2
SET ��տ���=3000
WHERE deptno=30; --���� �߻� : ���� ���̺��� �����Ͱ� ����Ǿ�� �ϴµ� �׷� �Լ��� �����ϴ� ���� ��� ������ ���� ����.

--���� �並 �̿��ϸ� ������ �ܼ��ϰ� �ۼ��� �� �ִٴ� ������ ����
SELECT e.ename, e.sal, e.deptno, v.��տ���
FROM emp e, (SELECT deptno, round(avg(sal)) ��տ���
            FROM emp
            GROUP BY deptno) v
WHERE e.deptno = v.deptno
AND e.sal > v.��տ���;
--�� ������ �Ʒ��� ���� �����ϰ� ��� ����
SELECT e.ename, e.sal, e.deptno, v.��տ���
FROM emp e, emp_view2 v
WHERE e.deptno = v.deptno
AND e.sal > v.��տ���;

--097 : ������ �˻� �ӵ� ���̱� (INDEX)
--������ ��ȸ�� �� �˻� �ӵ��� ���̱� ���� ���޿� �ε����� ����
CREATE INDEX emp_sal
ON emp(sal);

SELECT ename, sal
FROM emp
WHERE sal = 1600;
--emp_sal �̶�� �ε����� �÷����� ROWID�� ����. �÷����� sal �������� ������������ �����ϰ� �����Ƿ� ã�� �ӵ��� �� ����

--098 : ����� �ߺ����� �ʴ� ��ȣ ����� (SEQUENCE)
--���� 1������ 100������ ����ϴ� ������ ����
CREATE SEQUENCE seq1 --seq1 �̸��� ������ ����
START WITH 1 -- ù ���� ���� 1�� ����
INCREMENT BY 1 -- ����ġ�� 1�� ����
MAXVALUE 100 --���������� ��µ� �ִ� ���ڸ� 100���� ����
NOCYCLE; --�ִ� ���ڱ��� ��µ� ���Ŀ� �ٽ� ó�� 1������ ��ȣ�� �������� ����

--�������� �Ϸ� ��ȣ ������� ��ȣ�� ������� �����ϴ� �����ͺ��̽� ������Ʈ
CREATE TABLE EMP02
(EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10));

INSERT INTO EMP02 VALUES(SEQ1.NEXTVAL, 'JACK', 3500);
INSERT INTO EMP02 VALUES(SEQ1.NEXTVAL, 'JAMES', 4500);

SELECT * FROM EMP02;

--099 : �Ǽ��� ���� ������ ���� (FLASHBACK QUERY)
--��� ���̺��� 5�� �� KING ������ �˻�
SELECT *
FROM EMP
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE) --���� �ð����� 5���� �� �ð�
WHERE ENAME='KING';

SELECT ename, sal
FROM emp
WHERE ename = 'KING';

UPDATE emp
SET SAL = 0
WHERE ename='KING';

COMMIT;

SELECT ename, sal
FROM emp
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE)
WHERE ename='KING';

--���� �ð��� �Է��ؼ� ��ȸ�ϴ� �͵� ����
SELECT ename, sal
FROM emp
AS OF TIMESTAMP TO_TIMESTAMP('22/07/18 21:18:38','YY/mm/dd HH24:MI:SS')
WHERE ename='KING';

--���̺��� �÷����� �Ҽ� �ִ� ���Ÿ���� 15��
SELECT name, value
FROM V$PARAMETER
WHERE name='undo_retention'; --900�� = 15��

--100 : �Ǽ��� ���� ������ ���� (FLASHBACK TABLE)
--��� ���̺��� 5�� ������ �ǵ�����
ALTER TABLE emp ENABLE ROW MOVEMENT;

SELECT row_movement
FROM user_tables
WHERE table_name = 'EMP';--ENABLED

FLASHBACK TABLE emp TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE);

FLASHBACK TABLE emp TO TIMESTAMP
TO_TIMESTAMP('19/06/30 07:20:59', 'RR/MM/DD HH24:MI:SS');

--101 : �Ǽ��� ���� ������ ���� (FLASHBACK DROP)
--��� ���̺� DROP �� �����뿡 �����ϴ��� Ȯ���ϴ� ���
DROP TABLE emp;

SELECT ORIGINAL_NAME, DROPTIME
FROM USER_RECYCLEBIN;

--DROP �� ��� ���̺��� �����뿡�� ����
FLASHBACK TABLE emp TO BEFORE DROP;

--�����뿡�� ������ �� ���̺���� �ٸ� �̸����� ����
FLASHBACK TABLE emp TO BEFORE DROP RENAEM TO emp2;

--102 : �Ǽ��� ���� ������ ���� (FLASHBACK VERSION QUERY)
--��� ���̺��� �����Ͱ� ���� Ư�� �������� ���ݱ��� ��� ����Ǿ� �Դ��� �̷� ���� ���
SELECT ename, sal, versions_starttime, versions_endtime, versions_operation
FROM emp
VERSIONS BETWEEN TIMESTAMP
TO_TIMESTAMP('2022-07-18 21:54:00', 'RRRR-MM-DD HH24:MI:SS')
AND MAXVALUE
WHERE ename='KING'
ORDER BY versions_starttime;

SELECT systimestamp FROM dual; --22/07/18 21:57:22.047000000 +09:00

SELECT ename, sal, deptno
FROM emp
WHERE ename='KING';
--KING�� ���� 8000���� ����
UPDATE emp
SET sal = 8000
WHERE ename = 'KING';
COMMIT;
--KING�� �μ� ��ȣ 20���� ����
UPDATE emp
SET deptno = 20
WHERE ename='KING';
COMMIT;
--KING�� ������ ���� �̷� ���� Ȯ��
SELECT ename, sal, deptno, versions_starttime, versions_endtime, versions_operation
FROM emp
VERSIONS BETWEEN TIMESTAMP
TO_TIMESTAMP('22/07/18 21:57:22','RRRR-MM-DD HH24:MI:SS')
AND MAXVALUE
WHERE ename='KING'
ORDER BY versions_starttime;

FLASHBACK TABLE emp TO TIMESTAMP(SYSTIMESTAMP - INTERVAL '5' MINUTE);

--103 : �Ǽ��� ���� ������ ���� (FLASHBACK TRANSACTION QUERY)
--��� ���̺��� �����͸� 5�� ������ �ǵ����� ���� DML�� ���
SELECT undo_sql
FROM flashback_transaction_query
WHERE table_owner = 'SCOTT' AND table_name = 'EMP'
AND commit_scn between 5670632 AND 5677730
ORDER BY start_timestamp desc;

SELECT versions_startscn, versions_endscn, versions_operation, sal, deptno
FROM emp
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE ename = 'KING'; --king ������ ���� �̷� ���� Ȯ��

UPDATE EMP
SET sal = 0
WHERE ename='KING';
COMMIT;

--104 : ������ ǰ�� ���̱� (PRIMARY KEY)
CREATE TABLE DEPT2
(DEPTNO NUMBER(10) CONSTRAINT DPET2_DEPNO_PK PRIMARY KEY, --�ߺ��� �����Ϳ� NULL�� �Է� ����
DNAME VARCHAR2(14),
LOC VARCHAR2(10));

--���̺� ������ ���� Ȯ���ϴ� ���
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
WHERE a.TABLE_NAME = 'DEPT2'
AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

--���̺� ���� �� ���� �����ϴ� ���
CREATE TABLE DEPT2
(DEPTNO NUMBER(10),
DNAME VARCHAR2(13),
LOC VARCHAR2(10));

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY(DEPTNO);

--105 : ������ ǰ�� ���̱�(UNIQUE)
CREATE TABLE DEPT3
(DEPTNO NUMBER(10),
DNAME VARCHAR2(14) CONSTRAINT DEPT3_DNAME_UN UNIQUE, --�ߺ��� �����ʹ� ���ѵ����� NULL���� �Է� ����
LOC VARCHAR2(10));

--���̺� ������ ���� Ȯ���ϴ� ���
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
WHERE a.TABLE_NAME = 'DEPT3'
AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

--���̺� ���� �� ���� �����ϴ� ���
CREATE TABLE DEPT4
(DEPTNO NUMBER(10),
DNAME VARCHAR2(13),
LOC VARCHAR2(10));

ALTER TABLE DEPT4
ADD CONSTRAINT DEPT4_DNAME_UN UNIQUE(DNAME);

--106 : ������ ǰ�� ���̱� (NOT NULL)
CREATE TABLE DEPT5
(DEPTNO NUMBER(10),
DNAME VARCHAR2(14),
LOC VARCHAR2(10) CONSTRAINT DEPT5_LOC_NN NOT NULL);

--���̺� ���� �� ���� �����ϴ� ���. BUT, ���� ���̺� ������ �� NULL���� �������� �ʾƾ� ��.
CREATE TABLE DEPT6
(DEPTNO NUMBER(10),
DNAME VARCHAR2(13),
LOC VARCHAR2(10));

ALTER TABLE DEPT6
MODIFY LOC CONSTRAINT DEPT6_LOC_NN NOT NULL;

--107 : �������� ǰ�� ���̱� (CHECK)
--��� ���̺��� �����ϴµ�, ������ 0���� 6000������ �����͸� �Էµǰų� ������ �� �ֵ��� ����
CREATE TABLE EMP6
(EMPNO NUMBER(10),
ENAME VARCHAR2(20),
SAL NUMBER(10) CONSTRAINT EMP6_SAL_CK --Ư�� �÷��� Ư�� ������ �����͸� �Էµǰų� �����ǵ��� ������ �Ŵ� ����
CHECK (SAL BETWEEN 0 AND 6000));

UPDATE EMP6
SET SAL = 9000
WHERE ENAME='CLARK'; --üũ �������ǿ� �����.

INSERT INTO EMP6 VALUES (7566, 'ADAMS',9000); --���� �߻�

--������ 6000�̻����� �����ϰų� �Է��Ϸ��� üũ ���� �����ؾ� ����
--���� ��ɾ�
ALTER TABLE EMP6
DROP CONSTRAINT emp6_sal_ck;

INSERT INTO EMP6 VALUES (7566, 'ADAMS',9000); --���� �Է� ����

--108 : �������� ǰ�� ���̱� (FOREIGN KEY)
--��� ���̺��� �μ� ��ȣ�� �����͸� �Է��� �� �μ� ���̺� �����ϴ� �μ� ��ȣ�� �Էµ� �� �ֵ��� ���� ����
CREATE TABLE DEPT7
(DEPTNO NUMBER(10) CONSTRAINT DEPT7_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(10));

CREATE TABLE EMP7
(EMPNO NUMBER(10),
ENAME VARCHAR2(20),
SAL NUMBER(10),
DEPTNO NUMBER(10)
CONSTRAINT EMP7_DEPTNO_FK REFERENCES DEPT7(DEPTNO)); --DEPT7�� �θ� ���̺� EMP7�� �ڽ� ���̺�
--EMP7�� DEPTNO�� �����͸� �Է�, ���� �� ��, DEPT7 ���̺��� DEPTNO�� �����ϴ� �μ� ��ȣ�� ���ؼ��� ����.

ALTER TABLE DEPT7
DROP CONSTRAINT DEPT7_DEPTNO_PK; --DEPT7�� PK�� �������� ���� : �ڽ� ���̺��� EMP7���� �����ϰ� �ֱ� ������.

ALTER TABLE DEPT7
DROP CONSTRAINT DEPT7_DEPTNO_PK CASCADE; --CASCADE �ɼ��� ���̸� EMP7���̺��� FK���൵ �Բ� ���� 

--109 : WITH�� ����ϱ� (WITH ~ AS)
--with���� �̿��Ͽ� ������ ������ ��Ż ������ ����ϴµ� ������ ��Ż ���޵��� ��հ����� �� ū ���鸸 ���
WITH JOB_SUMSAL AS (SELECT job, SUM(sal) as ��Ż
                    FROM emp
                    GROUP BY job)
SELECT job, ��Ż
FROM job_sumsal
WHERE ��Ż > (SELECT avg(��Ż)
            FROM job_sumsal);
            
SELECT job, SUM(sal) as ��Ż
FROM emp
GROUP BY job
HAVING sum(sal) > (SELECT avg(sum(sal))
                    FROM emp
                    GROUP BY job);

--110 : WITH�� ����ϱ� (SUBQUERY FACTORING)
--�μ� ��ȣ�� �μ� ��ȣ�� ��Ż ������ ����ϴµ� job_sumsal�� ��Ż ���� ��հ��� 3000�� ���� ������ �� ū ��Ż ���� ���
WITH job_sumsal as (SELECT job, SUM(sal) ��Ż
                    FROM emp
                    GROUP BY job),
    deptno_sumsal as (SELECT deptno, SUM(sal) ��Ż
                        FROM emp
                        GROUP BY deptno
                        HAVING sum(sal) > (SELECT AVG(��Ż) + 3000
                                            FROM job_sumsal))
SELECT deptno, ��Ż
FROM deptno_sumsal;

--111 : SQL�� �˰��� ���� Ǯ��(������ 2�� ���)
--LOop���� sql�� ����
WITH loop_table as (SELECT level as num
                    FROM dual
                    CONNECT BY level <=9)
SELECT '2x'||num||'='||2*num as "2��"
FROM loop_table;

--112 : SQL�� �˰��� ���� Ǯ��(������ 1��~9�� ���)
SELECT num1 || 'x' || num2 || '=' || num1*num2 as "������"
FROM (SELECT level+1 num1
        FROM dual
        CONNECT BY level <= 8),
        (SELECT level num2
        FROM dual
        CONNECT BY level <= 9);
        
WITH loop_table AS (SELECT level+1 num1
            FROM dual
            CONNECT BY level <= 8),
    num_table AS (SELECT level num2
        FROM dual
        CONNECT BY level <= 9)
SELECT TO_CHAR(num1)||'x'||TO_CHAR(num2)||'='||num1*num2 as ������
FROM loop_table, num_table;

--113 : SQL�� �˰��� ���� Ǯ��(�����ﰢ�� ���)
--������ ���ǹ��� lpad�� �̿��Ͽ� sql�� �׸�� �����ﰢ�� �׸���
WITH loop_table as (SELECT level as num
                    FROM dual
                    CONNECT BY level <=8)
SELECT lpad('��',num,'��') as triangle
FROM loop_table;

SELECT lpad('��',10,'��') as triangle
FROM dual;

--114 :  SQL�� �˰��� ���� Ǯ��(�ﰢ�� ���)
WITH loop_table as (SELECT level as num
                    FROM DUAL
                    CONNECT BY level <= 8)
SELECT LPAD(' ',9-num,' ') || LPAD('��',num,'��') as triangle
FROM loop_table;

--ġȯ����(&)�� �Է¹��� ���ڸ�ŭ �ﰢ�� ��� ����
undefine ����1
undefine ����2

WITH loop_table as (SELECT level as num
                    FROM dual
                    CONNECT BY level <= &����1)
SELECT LPAD(' ',&����2-num,' ') || LPAD('��',num,'��') as triangle
FROM loop_table;

--115 : SQL�� �˰��� ���� Ǯ��(������ ���)
undefine p_num
ACCEPT p_num prompt '�����Է� : ';

SELECT LPAD(' ',(&p_num)-level,' ') || RPAD('��',level,'��')
FROM dual
CONNECT BY level <&p_num+1
UNION ALL
SELECT LPAD(' ',level,' ') || RPAD('��',(&p_num)-level,'��')
FROM dual
CONNECT BY level <&p_num;

--116 : SQL�� �˰��� ���� Ǯ��(�簢�� ���)
undefine p_n1
undefine p_n2
ACCEPT p_n1 prompt '���� ���ڸ� �Է��ϼ���~';
ACCEPT p_n2 prompt '���� ���ڸ� �Է��ϼ���~';

WITH loop_table AS (SELECT level as num
                    FROM dual
                    CONNECT BY level <= &p_n2)
SELECT LPAD('��',&p_n1,'��')
FROM loop_table;


--117 : SQL�� �˰��� ���� Ǯ�� (1���� 10���� ������ ��)
SELECT SUM(level) as �հ�
FROM dual
CONNECT BY level <= 10;

--118 : SQL�� �˰��� ���� Ǯ�� (1���� 10���� ������ ��)
SELECT ROUND(EXP(SUM(LN(level)))) ��
FROM dual
CONNECT BY level <= 10;

--119 : SQL�� �˰��� ���� Ǯ�� (1���� 10���� ¦���� ���)
SELECT level ¦��
FROM dual
WHERE MOD(level,2) = 0
CONNECT BY level <= 10;

--120 : SQL�� �˰��� ���� Ǯ�� (1���� 10���� �Ҽ��� ���)
undefine p_n
ACCEPT p_n prompt '���ڿ� ���� �� �Է�: ';

WITH loop_table AS (SELECT level as num
                    FROM dual
                    CONNECT BY level <= &p_n)
SELECT l1.num as �Ҽ�
FROM loop_table l1, loop_table l2
WHERE mod(l1.num,l2.num)=0
GROUP BY l1.num
HAVING count(l1.num) = 2;

--121 :SQL�� �˰��� ���� Ǯ��(�ִ� �����)
ACCEPT p_n1 prompt 'ù ��° ���ڸ� �Է��ϼ���.';
ACCEPT p_n2 prompt '�� ��° ���ڸ� �Է��ϼ���.';

WITH num_d as (SELECT &p_n1 as num1, &p_n2 as num2
                FROM dual)
SELECT max(level) AS �ִ�����
FROM num_d
WHERE mod(num1, level) = 0
AND mod(num2, level) = 0
CONNECT BY level <= num2;

--122 :SQL�� �˰��� ���� Ǯ��(�ּ� �����)
ACCEPT p_n1 prompt 'ù ��° ���ڸ� �Է��ϼ���.';
ACCEPT p_n2 prompt '�� ��° ���ڸ� �Է��ϼ���.';

WITH num_d as (SELECT &p_n1 as num1, &p_n2 as num2
                FROM dual)
SELECT num1, num2,
    (num1/max(level))*(num2/max(level))*max(level) AS �ּҰ����
FROM num_d
WHERE mod(num1, level) = 0
AND mod(num2, level) = 0
CONNECT BY level <= num2;

--123 :SQL�� �˰��� ���� Ǯ��(��Ÿ����� ����)
--�����ﰢ���� �غ�, ����, ������ ���̸� ���� �Է¹޾� ��Ÿ����� �����ﰢ�� ���Ŀ� �����Ͽ� ���� ���
ACCEPT num1 prompt '�غ��� ���̸� �Է��ϼ���.';
ACCEPT num2 prompt '���̸� �Է��ϼ���.';
ACCEPT num3 prompt '������ ���̸� �Է��ϼ���.';

SELECT CASE WHEN
    (POWER(&num1,2) + POWER(&num2,2)) = POWER(&num3,2)
    THEN '�����ﰢ���� �½��ϴ�.'
    ELSE '�����ﰢ���� �ƴմϴ�.'
    END as "��Ÿ��� ����"
FROM DUAL;



