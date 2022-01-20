select *
from employees
where employee_id in (select employee_id
            from (select rank() over(partition by department_id order by salary desc) "부서별순위", 
            employee_id, salary
            from employees)
            where "부서별순위" in 1)
order by 1;