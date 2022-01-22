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
SELECT year, nvl("01",0) "01월",nvl("02",0) "02월",nvl("03",0) "03월",nvl("04",0) "04월",nvl("05",0) "05월",nvl("06",0) "06월",nvl("07",0) "07월",nvl("08",0) "08월",nvl("09",0) "09월",nvl("10",0) "10월",nvl("11",0) "11월",nvl("12",0) "12월",nvl(total,0) "총합"
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