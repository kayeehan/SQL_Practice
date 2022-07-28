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

/*leetcode 182. Duplicate Emails
Write an SQL query to report all the duplicate emails.
Return the result table in any order.*/
SELECT email "Email"
FROM (SELECT email, count(*) cnt
     FROM Person
     GROUP BY email
     HAVING count(*)>=2);
--Runtime: 545 ms, faster than 92.39% of Oracle online submissions for Duplicate Emails.

/*leetcode 183. Customers Who Never Order
Write an SQL query to report all customers who never order anything.
Return the result table in any order.
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+*/
SELECT C.name "Customers"
FROM customers C
WHERE not exists (SELECT 'x'
                 FROM orders
                 WHERE C.id=customerid);
--Runtime: 697 ms, faster than 89.90% of Oracle online submissions for Customers Who Never Order.

/*leetcode 184. Department Highest Salary
Write an SQL query to find employees who have the highest salary in each of the departments.
Return the result table in any order.
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
*/
SELECT D.name "Department", E.name "Employee", E.max_sal "Salary"
FROM (SELECT name, departmentid, salary, max(salary) over(partition by departmentid) max_sal
    FROM employee) E, department D
WHERE E.departmentid=D.id
AND E.salary=E.max_sal;
--Runtime: 1800 ms, faster than 11.56% of Oracle online submissions for Department Highest Salary.

/*leetcode 185. Department Top Three Salaries
A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
Write an SQL query to find the employees who are high earners in each of the departments.
Return the result table in any order.
The query result format is in the following example.
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation: 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary
In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees
*/
SELECT  M.dept_name "Department", M.emp_name "Employee", M.sal "Salary"
FROM (SELECT D.name dept_name, E.name emp_name, E.salary sal, dense_rank() over(partition by E.departmentid order by E.salary desc) rank
     FROM department D, employee E
     WHERE E.departmentid=D.id) M
WHERE M.rank<=3
ORDER BY 1,3;
--Runtime: 1586 ms, faster than 27.42% of Oracle online submissions for Department Top Three Salaries.

/*leetcode 262. Trips and Users
The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.
Return the result table in any order.
The query result format is in the following example.
Output: 
+------------+-------------------+
| Day        | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |
| 2013-10-03 | 0.50              |
+------------+-------------------+
Explanation: 
On 2013-10-01:
  - There were 4 requests in total, 2 of which were canceled.
  - However, the request with Id=2 was made by a banned client (User_Id=2), so it is ignored in the calculation.
  - Hence there are 3 unbanned requests in total, 1 of which was canceled.
  - The Cancellation Rate is (1 / 3) = 0.33
On 2013-10-02:
  - There were 3 requests in total, 0 of which were canceled.
  - The request with Id=6 was made by a banned client, so it is ignored.
  - Hence there are 2 unbanned requests in total, 0 of which were canceled.
  - The Cancellation Rate is (0 / 2) = 0.00
On 2013-10-03:
  - There were 3 requests in total, 1 of which was canceled.
  - The request with Id=8 was made by a banned client, so it is ignored.
  - Hence there are 2 unbanned request in total, 1 of which were canceled.
  - The Cancellation Rate is (1 / 2) = 0.50*/
SELECT request_at "Day", round(sum(case when status like 'cancelled_by_%' then 1 else 0 end)/count(*),2) "Cancellation Rate"
FROM trips
WHERE request_at between '2013-10-01' and '2013-10-03'
AND client_id NOT IN (SELECT users_id
                     FROM users
                     WHERE banned = 'Yes')
AND driver_id NOT IN (SELECT users_id
                     FROM users
                     WHERE banned = 'Yes')
GROUP BY request_at
ORDER BY 1;
--Runtime: 838 ms, faster than 74.69% of Oracle online submissions for Trips and Users.

/*leetcode 595. Big Countries
A country is big if:
it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write an SQL query to report the name, population, and area of the big countries.
Return the result table in any order.
The query result format is in the following example.
Output: 
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+*/
SELECT name "name", population "population", area "area"
FROM world
WHERE area >= 3000000
OR population >= 25000000;
--Runtime: 551 ms, faster than 47.47% of Oracle online submissions for Big Countries.
/*leetcode 620. Not Boring Movies
Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order.
The query result format is in the following example.
Output: 
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
Explanation: 
We have three movies with odd-numbered IDs: 1, 3, and 5. The movie with ID = 3 is boring so we do not include it in the answer.
*/
SELECT id, movie, description, rating
FROM cinema
WHERE description != 'boring'
AND mod(id,2) = 1
ORDER BY rating desc;
--Runtime: 714 ms, faster than 27.72% of Oracle online submissions for Not Boring Movies.

/*leetcode 596. Classes More Than 5 Students
Write an SQL query to report all the classes that have at least five students.
Return the result table in any order.
The query result format is in the following example.
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation: 
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.
*/
 SELECT class
FROM (SELECT distinct class, count(*) over(partition by class) cnt
     FROM courses)
WHERE cnt >=5;
--Runtime: 476 ms, faster than 88.37% of Oracle online submissions for Classes More Than 5 Students.

/*leetcode 197. Rising Temperature
Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.
The query result format is in the following example.
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).*/
SELECT W1.id
FROM weather W1
WHERE W1.temperature > (SELECT temperature
                    FROM weather
                    WHERE recordDate = W1.recordDate-1);
--Runtime: 1244 ms, faster than 19.47% of Oracle online submissions for Rising Temperature.

/*leetcode 601. Human Traffic of Stadium
Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.
Return the result table ordered by visit_date in ascending order.
The query result format is in the following example.
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Explanation: 
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.*/
WITH M AS (
    SELECT 
        id, 
        to_char(visit_date,'YYYY-MM-DD') visit_date, 
        people,
        LAG(id,2) OVER(ORDER BY visit_date) bef2,
        LAG(id,1) OVER(ORDER BY visit_date) bef,
        LEAD(id,1) OVER(ORDER BY visit_date) aft,
        LEAD(id,2) OVER(ORDER BY visit_date) aft2    
    FROM Stadium
    WHERE people >= 100
    ORDER BY id
    )
SELECT M.id, M.visit_date, M.people
FROM M
WHERE 
    (M.id+1=M.aft AND M.id+2=M.aft2) OR
    (M.id-1=M.bef AND M.id+1=M.aft) OR
    (M.id-2=M.bef2 AND M.id-1=M.bef);
--Runtime: 786 ms, faster than 55.04% of Oracle online submissions for Human Traffic of Stadium.

/* 196. Delete Duplicate Emails
Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.
After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.
The query result format is in the following example.
Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
*/
/*
 Please write a DELETE statement and DO NOT write a SELECT statement.
 Write your PL/SQL query statement below
 */
DELETE FROM Person
WHERE id in
(SELECT p1.id
FROM Person p1, Person p2
WHERE p1.email = p2.email
AND p1.id > p2.id);

/*511. Game Play Analysis I
Write an SQL query to report the first login date for each player.
Return the result table in any order.
The query result format is in the following example.
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/
SELECT player_id "player_id", to_char(event_date,'yyyy-mm-dd') "first_login"
FROM (SELECT player_id , event_date, 
     dense_rank() over(partition by player_id order by event_date) as min_day
    FROM Activity)
WHERE min_day = 1;

/*584. Find Customer Referee
Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.
The query result format is in the following example.
Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/
SELECT name
FROM Customer
WHERE referee_id not in 2
OR referee_id is null;


/*586. Customer Placing the Largest Number of Orders
Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.
The test cases are generated so that exactly one customer will have placed more orders than any other customer.
The query result format is in the following example.
Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.*/
SELECT customer_number
FROM (SELECT customer_number,
     count(order_number) num
     FROM Orders
     GROUP BY customer_number)
WHERE num in (SELECT max(count(order_number))
              FROM Orders
             GROUP BY customer_number);
             
             
/*607. Sales Person
Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
Return the result table in any order.
The query result format is in the following example.
Input: 
SalesPerson table:
+----------+------+--------+-----------------+------------+
| sales_id | name | salary | commission_rate | hire_date  |
+----------+------+--------+-----------------+------------+
| 1        | John | 100000 | 6               | 4/1/2006   |
| 2        | Amy  | 12000  | 5               | 5/1/2010   |
| 3        | Mark | 65000  | 12              | 12/25/2008 |
| 4        | Pam  | 25000  | 25              | 1/1/2005   |
| 5        | Alex | 5000   | 10              | 2/3/2007   |
+----------+------+--------+-----------------+------------+
Company table:
+--------+--------+----------+
| com_id | name   | city     |
+--------+--------+----------+
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |
+--------+--------+----------+
Orders table:
+----------+------------+--------+----------+--------+
| order_id | order_date | com_id | sales_id | amount |
+----------+------------+--------+----------+--------+
| 1        | 1/1/2014   | 3      | 4        | 10000  |
| 2        | 2/1/2014   | 4      | 5        | 5000   |
| 3        | 3/1/2014   | 1      | 1        | 50000  |
| 4        | 4/1/2014   | 1      | 4        | 25000  |
+----------+------------+--------+----------+--------+
Output: 
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
Explanation: 
According to orders 3 and 4 in the Orders table, it is easy to tell that only salesperson John and Pam have sales to company RED, so we report all the other names in the table salesperson.
*/
SELECT name
FROM SalesPerson
WHERE name not in (SELECT s_name 
                    FROM (SELECT s.name s_name, c.name c_name, o.*
                    FROM SalesPerson s LEFT OUTER JOIN Orders o
                    ON s.sales_id = o.sales_id
                    LEFT OUTER JOIN Company c
                    ON c.com_id = o.com_id)
                    WHERE c_name in 'RED');


/*608. Tree Node
Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.
Return the result table ordered by id in ascending order.
The query result format is in the following example.

Input: 
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
Explanation: 
Node 1 is the root node because its parent node is null and it has child nodes 2 and 3.
Node 2 is an inner node because it has parent node 1 and child node 4 and 5.
Nodes 3, 4, and 5 are leaf nodes because they have parent nodes and they do not have child nodes.

Input: 
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
+----+-------+
Explanation: If there is only one node on the tree, you only need to output its root attributes.
*/
SELECT id,
CASE when p_id is null then 'Root'
    when id in (SELECT p_id FROM tree) then 'Inner'
    else 'Leaf'
    End as "type"
FROM Tree;

/*1050. Actors and Directors Who Cooperated At Least Three Times
Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
Return the result table in any order.
The query result format is in the following example.

Input: 
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
Output: 
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
Explanation: The only pair is (1, 1) where they cooperated exactly 3 times.
*/
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING count(timestamp) >= 3;

/*626. Exchange Seats
Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
Return the result table ordered by id in ascending order.
The query result format is in the following example.

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.
*/
SELECT id-1 "id", student
FROM seat s1
WHERE mod(s1.id,2) = 0
UNION
SELECT id+1 "id", student
FROM seat s2
WHERE mod(s2.id,2) = 1
AND s2.id != (SELECT max(id) FROM seat)
UNION
SELECT id, student 
FROM seat s3
WHERE s3.id = (SELECT max(id)
           FROM seat)
AND mod(s3.id,2) = 1;

/*627. Swap Salary
Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.
Note that you must write a single update statement, do not write any select statement for this problem.
The query result format is in the following example.
Input: 
Salary table:
+----+------+-----+--------+
| id | name | sex | salary |
+----+------+-----+--------+
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
+----+------+-----+--------+
Output: 
+----+------+-----+--------+
| id | name | sex | salary |
+----+------+-----+--------+
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |
+----+------+-----+--------+
Explanation: 
(1, A) and (3, C) were changed from 'm' to 'f'.
(2, B) and (4, D) were changed from 'f' to 'm'.
*/
UPDATE salary
SET sex = (CASE WHEN sex = 'm'
          THEN 'f'
          ELSE 'm'
          END)
          
/*1084. Sales Analysis III
Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
Return the result table in any order.
The query result format is in the following example.
*/
SELECT product_id "product_id", product_name "product_name"
FROM product
WHERE product_id not in (SELECT product_id
                        FROM sales
                        WHERE sale_date Not Between '2019/01/01'
                        AND '2019/03/31')
AND product_id in (SELECT product_id
                  FROM sales);
