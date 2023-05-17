-- 巩力 1 --
-- 规过1
SELECT CONCAT(first_name, last_name), 
        REPLACE(SUBSTR(hire_date, 1, 8), '/')
FROM employees
ORDER BY first_name ASC;

--规过2
SELECT CONCAT(first_name, last_name),
        REPLACE(hire_date, '/', '') AS HIRE_DATE
FROM employees;

-- 巩力 2 --
SELECT '(02)' || SUBSTR(phone_number, INSTR(phone_number, '.'), LENGTH(phone_number))
FROM employees;

-- 巩力 3 --
SELECT RPAD(SUBSTR(first_name, 1, 3), LENGTH(first_name), '*') AS NAME,
        RPAD(salary, 10, '*') AS SALARY
FROM employees
WHERE LOWER(job_id) = 'it_prog';