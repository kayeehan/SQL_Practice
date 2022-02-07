--22.01.21
--[문제] 110번 사원의 job_id와 동일한 사원들 중에 110번 사원의 급여보다 더 많이 받는 사원들의 정보를 추출하세요.
SELECT *
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id=110)
AND salary >= (SELECT salary
                FROM employees
                WHERE employee_id=110);
                
--[문제]자신의 부서 평균 급여 보다 더 많이 받는 사원들의 EMPLOYEE_ID, DEPARTMENT_ID, SALARY를 출력해주세요.
SELECT e.employee_id, e.department_id, e.salary
FROM (SELECT employee_id, department_id, salary, avg(salary) over(partition by department_id) avg_sal
        FROM employees) e
WHERE e.salary>e.avg_sal;

--[문제]PIVOT을 활용해서 입사연도별, 입사월별 인원수합을 구하세요. (합계x)
SELECT *
FROM(SELECT to_char(hire_date, 'yyyy') year, to_char(hire_date,'mm') month, employee_id
    FROM employees)
PIVOT (count(employee_id) for month in ('01','02','03','04','05','06','07','08','09','10','11','12'))
Order by 1;
/*행에 year, 열에 month*/                                        
SELECT *
FROM(SELECT to_char(hire_date, 'yyyy') year, to_char(hire_date,'mm') month, employee_id
    FROM employees)
PIVOT (count(employee_id) for year in ('2001','2002','2003','2004','2005','2006','2007','2008'))
Order by month;
/*행에 month, 열에 year*/

--[문제]PIVOT을 활용해서 입사연도별, 입사월별 인원수합을 구하세요. (연도별, 월별 총합도 표시)
SELECT *
FROM (SELECT nvl(year,'합계') year, nvl(month,'합계') month, nvl(cnt,0) cnt
FROM(SELECT to_char(hire_date,'yyyy') year, to_char(hire_date,'mm') month, count(employee_id) cnt
    FROM employees
    GROUP BY cube(to_char(hire_date,'yyyy'), to_char(hire_date,'mm'))))
PIVOT (max(cnt) for month in ('01','02','03','04','05','06','07','08','09','10','11','12','합계'))
Order by 1;
--값의 NULL값을 0으로 표시
SELECT year, nvl("01",0) "01월",nvl("02",0) "02월",nvl("03",0) "03월",nvl("04",0) "04월",nvl("05",0) "05월",nvl("06",0) "06월",
      nvl("07",0) "07월",nvl("08",0) "08월",nvl("09",0) "09월",nvl("10",0) "10월",nvl("11",0) "11월",nvl("12",0) "12월",nvl(total,0) "총합"
FROM(SELECT nvl(year,'총합') year, nvl(month,'total') month, nvl(cnt,0) cnt
    FROM(SELECT to_char(hire_date,'yyyy') year, to_char(hire_date,'mm') month, count(employee_id) cnt
    FROM employees
    GROUP BY cube(to_char(hire_date,'yyyy'),to_char(hire_date,'mm'))))
PIVOT (max(cnt) for month in ('01' "01",'02' "02",'03' "03",'04' "04",'05' "05",'06' "06",'07' "07",'08' "08",'09' "09",'10' "10",'11' "11",'12' "12",'total' total))
Order by 1;

--22.01.22
--[문제] locations 테이블에 있는 city컬럼에 Toronto도시에서 근무하는 모든 사원의 last_name, job_id, department_id, department_name를 출력하세요.
SELECT e.last_name, e.job_id, e.department_id, c.dept_name
FROM (SELECT d.department_id dept_id, d.department_name dept_name
        FROM departments d, locations l
        WHERE l.city='Toronto'
        AND l.location_id=d.location_id) c, employees e
WHERE e.department_id=c.dept_id;

--[문제]사원들의 급여의 등급 레이블의 빈도수를 출력해주세요.
SELECT j.grade_level, count(e.salary)
FROM employees e, job_grades j
WHERE e.salary between j.lowest_sal and j.highest_sal
GROUP BY j.grade_level
ORDER BY 1;

--[문제]사원들의 급여의 등급 레이블의 빈도수와 빈도수의 총합을 출력해주세요.
SELECT nvl(j.grade_level,'총 합계'), count(e.salary)
FROM employees e, job_grades j
WHERE e.salary between j.lowest_sal and j.highest_sal
GROUP BY cube(j.grade_level)
ORDER BY 1;

--[문제] 상위 20%의 월급을 받는 사원들의 last_name, department_name, salary를 출력해주세요.
SELECT e.last_name, d.department_name, e.salary
FROM employees e, departments d
WHERE d.department_id=e.department_id
ORDER BY 3 desc 
FETCH FIRST 20 PERCENT ROWS ONLY;

--[문제] last_name이 Chen인 사원과 같은 달에 입사한 사원의 정보를 출력해주세요. (Chen의 정보는 제외)
SELECT *
FROM employees
WHERE to_char(hire_date,'yyyy/mm')= (SELECT to_char(hire_date,'yyyy/mm')
                                FROM employees
                                WHERE last_name='Chen')
AND last_name != 'Chen';          

--22.01.24
--[문제]employees중 manager가 아닌 사원들의 부서별 SALARY 평균을 출력해주세요. distinct함수 사용 금지
SELECT department_id, avg_sal
FROM(SELECT department_id, avg(salary) over(partition by department_id) avg_sal
      FROM employees e
      WHERE not exists (SELECT 1
                        FROM employees
                        WHERE e.employee_id = manager_id)
        union
        SELECT department_id, NULL
        FROM departments)
WHERE avg_sal is not null
AND department_id is not null;
--[문제] 부서별 최고 급여자들의 정보를 모두 출력해주세요.
SELECT *
FROM employees
WHERE employee_id in (SELECT employee_id
                FROM(SELECT EMPLOYEE_ID, rank() over(partition by DEPARTMENT_ID order by SALARY desc) ord_sal
                 FROM employees)
                 WHERE ord_sal=1);

--동물 보호소에 들어온 모든 동물의 정보를 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. 
SELECT *
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

--동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 ANIMAL_ID 역순으로 보여주세요. 
SELECT NAME, DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID desc;

--동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = 'Sick'
ORDER BY 1;

--동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION NOT IN ('Aged')
ORDER BY 1;

--동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
ORDER BY 1;

--동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
SELECT ANIMAL_ID,NAME, DATETIME
FROM ANIMAL_INS
ORDER BY NAME, DATETIME DESC;

--동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
SELECT NAME
FROM ANIMAL_INS
WHERE DATETIME= (SELECT MIN(DATETIME)
                FROM ANIMAL_INS)

--가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT MAX(DATETIME)
FROM ANIMAL_INS;

--동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT MIN(DATETIME)
FROM ANIMAL_INS;

--동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT COUNT(*)
FROM ANIMAL_INS;

--동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
SELECT COUNT(DISTINCT NAME)
FROM ANIMAL_INS;

--동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
SELECT ANIMAL_TYPE, count(*)
FROM ANIMAL_INS
WHERE ANIMAL_TYPE IN ('Cat','Dog')
GROUP BY ANIMAL_TYPE
ORDER BY 1;

--동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
SELECT NAME, count(*)
FROM ANIMAL_INS
GROUP BY NAME
HAVING NAME IS NOT NULL
AND COUNT(*) >= 2
ORDER BY 1;

--보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
SELECT hour(DATETIME) HOUR, count(*) COUNT
FROM ANIMAL_OUTS
WHERE hour(DATETIME) between 9 and 19
GROUP BY hour(DATETIME)
ORDER BY 1;

--보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
SELECT D.HOUR, nvl(A.COUNT,0)
FROM (SELECT to_char(DATETIME,'hh24') HOUR, COUNT(*) COUNT
        FROM ANIMAL_OUTS
        GROUP BY to_char(DATETIME,'hh24')) A,
    (SELECT level-1 HOUR
        FROM dual
        CONNECT BY level <= 24) D
WHERE D.HOUR = A.HOUR(+)
ORDER BY 1;

--동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME is null
ORDER BY 1;

--동물 보호소에 들어온 동물 중, 이름이 있는 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
ORDER BY 1;

--입양 게시판에 동물 정보를 게시하려 합니다. 동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 프로그래밍을 모르는 사람들은 NULL이라는 기호를 모르기 때문에, 이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
SELECT ANIMAL_TYPE, nvl(NAME,'No name'), SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

--천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS O
WHERE NOT EXISTS (SELECT 'X'
             FROM ANIMAL_INS
                 WHERE ANIMAL_ID=O.ANIMAL_ID )
ORDER BY 1;

--관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
SELECT I.ANIMAL_ID, I.NAME
FROM ANIMAL_INS I
WHERE I.ANIMAL_ID = (SELECT ANIMAL_ID
                     FROM ANIMAL_OUTS
                     WHERE ANIMAL_ID=I.ANIMAL_ID
                     AND DATETIME<=I.DATETIME)
ORDER BY I.DATETIME;      

--아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.
SELECT ANI.NAME, ANI.DATETIME
FROM(SELECT ANIMAL_ID, NAME, DATETIME, RANK() OVER(ORDER BY DATETIME) RANK
    FROM ANIMAL_INS I
    WHERE NOT EXISTS (SELECT 'X'
                 FROM ANIMAL_OUTS
                 WHERE ANIMAL_ID=I.ANIMAL_ID)) ANI
WHERE ANI.RANK BETWEEN 1 AND 3
ORDER BY ANI.DATETIME;

--보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
SELECT O.ANIMAL_ID, O.ANIMAL_TYPE, O.NAME
FROM ANIMAL_OUTS O
WHERE O.SEX_UPON_OUTCOME in ('Neutered Male', 'Spayed Female')
AND EXISTS (SELECT 'X'
                 FROM ANIMAL_INS
                 WHERE SEX_UPON_INTAKE in ('Intact Male','Intact Female')
                 AND O.ANIMAL_ID=ANIMAL_ID)
ORDER BY 1;

--동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요. 
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy','Ella','Pickle','Rogan','Sabrina','Mitty')
ORDER BY 1;

--보호소에 돌아가신 할머니가 기르던 개를 찾는 사람이 찾아왔습니다. 이 사람이 말하길 할머니가 기르던 개는 이름에 'el'이 들어간다고 합니다. 동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.
SELECT animal_id, name
FROM ANIMAL_INS
WHERE animal_type = 'Dog'
AND lower(name) like '%el%'
ORDER BY 2;

--보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.
SELECT animal_id, name,
        (CASE
         when regexp_like(sex_upon_intake,'Neutered.*|Spayed') then 'O'
         else 'X' end) as 중성화
FROM ANIMAL_INS
ORDER BY 1;

--입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.
SELECT animal_id, name
FROM (SELECT O.animal_id, O.name, O.datetime-I.datetime
        FROM ANIMAL_OUTS O, ANIMAL_INS I
        WHERE I.animal_id = O.animal_id
        ORDER BY 3 desc)
WHERE rownum <= 2;

--ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요. 이때 결과는 아이디 순으로 조회해야 합니다.
SELECT animal_id, name, to_char(datetime,'YYYY-MM-DD') 날짜
FROM ANIMAL_INS
ORDER BY 1;

/*leetcode 175. Combine Two Tables
Write an SQL query to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.
Return the result table in any order.*/
SELECT P.firstName, P.lastName, A.city, A.state
FROM Address A, Person P
WHERE A.personId(+) = P.personId;

/*leetcode 176. Second Highest Salary
Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.*/
SELECT nvl(max(salary),NULL) "SecondHighestSalary"
FROM Employee
WHERE salary != (SELECT max(salary)
                FROM Employee);

/*leetcode 177.  Second Highest Salary
Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.*/
CREATE FUNCTION getNthHighestSalary(N IN NUMBER) 
RETURN NUMBER IS
result NUMBER;
BEGIN
    SELECT nvl(salary,NULL) INTO result
    FROM (SELECT distinct salary, dense_rank() over(order by salary desc) ranking
            FROM Employee)
    WHERE ranking = N;
    
    RETURN result;
END;

/*leetcode 178. Rank Scores
Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

-The scores should be ranked from the highest to the lowest.
-If there is a tie between two scores, both should have the same ranking.
-After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.*/
SELECT score, dense_rank() over(order by score desc) rank
FROM scores
ORDER BY score desc;

--Runtime: 855 ms, faster than 24.81% of Oracle online submissions for Rank Scores.
/*leetcode 180. Consecutive Numbers
Write an SQL query to find all numbers that appear at least three times consecutively.
Return the result table in any order.*/
SELECT distinct t1.num as "ConsecutiveNums"
FROM logs t1, logs t2, logs t3
WHERE t1.id = t2.id+1
AND t2.id = t3.id+1
AND t1.num = t2.num
AND t2.num = t3.num;
--Runtime: 869 ms, faster than 58.13% of Oracle online submissions for Consecutive Numbers.

/*leetcode 181. Employees Earning More Than Their Managers
Write an SQL query to find the employees who earn more than their managers.
Return the result table in any order.*/
SELECT e1.name "Employee"
FROM employee e1, employee e2
WHERE e1.managerid = e2.id
AND e1.salary > e2.salary;
--Runtime: 618 ms, faster than 77.09% of Oracle online submissions for Employees Earning More Than Their Managers.
