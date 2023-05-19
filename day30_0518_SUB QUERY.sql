----- 서브 쿼리 -----
-- SELECT문이 SELECT 구문으로 들어가는 형태 :  스칼라 서브쿼리
-- SELECT문이 FROM 구문으로 들어가는 형태 : 인라인뷰
-- SELECT문이 WHERE 구문으로 들어가면 : 서브쿼리
-- 서브쿼리는 반드시 () 안에 적는디
------------------------------------------------------------
-- 단일행 서브쿼리 : 리턴이 되는 행이 1개인 서브쿼리
SELECT first_name,
       salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE first_name = 'Nancy');
                
-- employee_id가 103번인 사람과 동일한 직군
SELECT job_id FROM employees WHERE employee_id = 103;

SELECT * 
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 103);

-- 주의할 점 -> 단일행 이어야 한다, 컬럼값도 1개여야 한다.
-- ERROR
SELECT * 
FROM employees
WHERE job_id = (SELECT * 
                FROM employees
                WHERE employee_id = 103);
--------------------------------------------------------------------
-- 다중 행 서브쿼리 : 행이 여러개라면 IN, ANY, ALL로 비교해야 한다
SELECT salary FROm employees WHERE first_name = 'David';

-- IN : 동일한 값을 찾음 : 4800, 9500, 6800
SELECT * 
FROM employees
WHERE salary IN (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
                    
-- ANY : 최소값 보다 큼, 최대값 보다 작음 -- 급여가 4800보다 큰 사람들
-- > ANY : 4800보다 큰 사람들
-- < ANY : 9500보다 작은 사람들
SELECT * 
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
                    
-- ALL : 최대값 보다 큼, 최소값 보다 작음--
-- > ALL : 9500 보다 큰 사람
-- < ALL : 4800 보다 작은 사람
SELECT * 
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
                    
-- 연습문제
-- 직업이 IT_PROG인 사람들의 최소값 보다 큰 급여를 받는 사람들
SELECT * FROM employees WHERE job_id = 'IT_PROG';

SELECT *
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
--------------------------------------------------------------------
-- 스칼라 서브쿼리
-- JOIN시 특정 테이블의 1컬럼을 가지고 올 때 유리하다
SELECT first_name,
       email,
       (SELECT department_name 
        FROM departments d 
        WHERE d.department_id = e.department_id)
FROM employees e
ORDER BY first_name;

-- LEFT JOIN : 위 / 아래 결과 같다
SELECT first_name,
       email,
       department_name
FROM employees e
LEFT JOIN departments d 
ON d.department_id = e.department_id
ORDER BY first_name;

-- 각 부서의 매니저 이름을 출력
-- 스칼라
SELECT D.*,
       (SELECT first_name
        FROM employees e
        WHERE e.employee_id = d.manager_id)
FROM departments d;

-- JOIN
SELECT d.*,
       e.first_name
FROM departments d
LEFT JOIN employees e
ON d.manager_id = e.employee_id;

-- 스칼라 쿼리는 여러 번 가능
SELECT * FROM jobs;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT e.first_name,
       e.job_id,
       (SELECT job_title
        FROM jobs j
        WHERE j.job_id = e.job_id) AS job_title,
       (SELECT department_name
        FROM departments d
        WHERE d.department_id = e.department_id) AS department_name
FROM employees e;

-- 각 부서의 사원 수, 부서정보 출력
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;

SELECT d.*,
       NVL((SELECT COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id), 0) AS 사원수
FROM departments d;
--------------------------------------------------------------------
-- Inline View : 맨 안쪽의 구문부터 만든다
-- 가짜의 테이블 형태
SELECT * 
FROM (SELECT *
      FROM (SELECT *
            FROM employees)
);

-- ROWNUM은 조회 된 순서이기 때문에, ORDER와 같이 사용되면 ROWNUM 섞이는 문제
SELECT first_name,
       salary,
       ROWNUM
        FROM (SELECT *
              FROM employees
              ORDER BY salary DESC);

-- 문법 2
SELECT ROWNUM,
       A.*
FROM (SELECT first_name,
             salary
      FROM employees
      ORDER BY salary DESC) A;

-- ROWNUM는 무조건 1번째부터 조회 가능하기 때문 1 AND 10은 가능
SELECT first_name,
       salary,
       ROWNUM
        FROM (SELECT *
              FROM employees
              ORDER BY salary DESC)
        WHERE ROWNUM BETWEEN 11 AND 20;

-- 해결방법 : 인라인뷰에서 RONUM을 rn으로 컬럼화
SELECT *
FROM (SELECT first_name,
             salary,
             ROWNUM AS rn
      FROM (SELECT *
            FROM employees
            ORDER BY salary DESC))
WHERE rn >= 51 AND rn <= 60;

-- 인라인 뷰의 예시
SELECT TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE ,
       NAME
FROM (SELECT '홍길동' AS NAME, 
             SYSDATE AS REGDATE 
      FROM DUAL
      UNION ALL
      SELECT '이순신', 
             SYSDATE 
      FROM DUAL);
      
-- 인라인 뷰의 응용
-- 부서별 사원수
SELECT * 
FROM departments d
LEFT JOIN(SELECT department_id,
                 COUNT(*)
          FROM employees
          GROUP BY department_id) E 
ON d.department_id = e.department_id;
      
-- 인라인 뷰의 응용2 : 
-- 부서별 사원수
SELECT d.*,
       e.total
FROM departments d
LEFT JOIN(SELECT department_id,
                 COUNT(*) AS total
          FROM employees
          GROUP BY department_id) E 
ON d.department_id = e.department_id;

-- 단일행(대소비교) || 다중행(IN, ANY, ALL)
-- 스칼라 쿼리 : LEFT JOIN과 같은 역할, 1개의 컬럼을 가져올 때
-- 인라인뷰 : FROM 들어가는 가짜 테이블