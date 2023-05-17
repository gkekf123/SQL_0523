SELECT * 
FROM EMPLOYEES;

SELECT first_name, 
       email, 
       hire_date
FROM employees;

SELECT job_id, 
        salary, 
        department_id 
FROM employees;

SELECT * 
FROM departments;

-- 연산
-- 컬럼을 조회하는 위치에서 * / + -
SELECT first_name, 
        salary, 
        salary + salary * 0.1 
FROM employees;

-- NULL
SELECT first_name, 
        commission_pct 
FROM employees;

-- AS
SELECT first_name AS 이름, 
        last_name AS 성, 
        salary 급여, 
        salary + salary * 0.1 총급여 
FROM employees;

-- || 문자열 연결
-- 오라클은 문자를''로 표현
-- 문자열 안에서' 사용하려면 '' -> ''' = '''s salary is $'
SElECT first_name || ' ' || last_name || '''s salary is $' || salary AS "Employees Details"
FROM employees;

-- DISTINCT 중복 제거
SELECT DISTINCT first_name, 
                department_id
FROM employees
ORDER BY department_id ASC; 

-- ROWID /
SELECT ROWID, 
        ROWNUM, 
        employee_id, 
        first_name
FROM employees;

-- WHERE 조건 (띄어쓰기, 언더바, 대소문자 구분)
SELECT first_name, 
        job_id,
        department_id
FROM employees
WHERE JOB_ID='IT_PROG';

SELECT *
FROM employees
WHERE salary = 4800;

-- 비교 연산자
SELECT first_name,
        salary, 
        hire_date
FROM employees
WHERE salary >= 15000
order by hire_date ASC;

-- 범위 - BETWEEN A AND B
SELECT first_name,
        salary
FROM employees
WHERE salary BETWEEN 10000 AND 12000;

SELECT *
FROM employees
WHERE hire_date BETWEEN '08/01/01' AND '08/12/31';

SELECT * 
FROM employees
WHERE NOT salary >= 6000
ORDER BY salary ASC;

SELECT * 
FROM employees
where job_id = 'IT_PROG' AND salary >= 6000;

SELECT * 
FROM employees
where job_id = 'IT_PROG' OR salary >= 6000;

-- 값은 나오지만 조건이 맞지않음
SELECT * 
FROM employees
where job_id = 'IT_PROG' OR job_id = 'FI_MGR' AND salary >= 6000; //FI중 6000이상인 사람 OR IT_PROG

-- 값과 조건이 맞음
SELECT * 
FROM employees
where (job_id = 'IT_PROG' OR job_id = 'FI_MGR') AND salary >= 6000; 

-- IN
SELECT employee_id,
        first_name,
        manager_id
FROM employees
WHERE manager_id IN(101, 102, 103 );

-- LIKE %, _
SELECT first_name,
        last_name,
        job_id,
        department_id
FROM employees
WHERE job_id LIKE 'IT%';

SELECT *
FROM employees
WHERE hire_date LIKE '%12%'
order by department_id asc;

SELECT *
FROM employees
WHERE hire_date LIKE '___05%';

SELECT *
FROM employees
WHERE email LIKE '_A%';

-- IS NULL / IS NOT NULL
SELECT * 
FROM employees
WHERE commission_pct IS NULL;

SELECT * 
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY commission_pct ASC;

