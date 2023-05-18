SELECT * FROM info;
SELECT * FROM auth;

----- INNER JOIN -----

-- 붙을 수 있는 데이터가 없으면 안나온다
SELECT * 
FROM info INFO INNER JOIN auth ON info.auth_id = auth.auth_id;

-- 원하는 컬럼들만, auth_id는 둘다 있기 때문에 한쪽 테이블을 찍어줘야 된다
SELECT id,
       title,
       auth.auth_id, --info.auth_id
       name
FROM info INFO INNER JOIN auth ON info.auth_id = auth.auth_id;

-- 테이블 엘리어스
SELECT i.id,
       i.title,
       i.auth_id,
       a.name
FROM info I 
INNER JOIN auth A
ON I.auth_id = a.auth_id;

-- WHERE
SELECT *
FROM info I 
INNER JOIN auth A
ON i.auth_id = a.auth_id
WHERE id IN(1,2,3)
ORDER BY id DESC;

-- INNER JOIN USING
SELECT * 
FROM info
INNER JOIN auth
USING (auth_id);

----- OUTER JOIN -----

-- LEFT OUTER JOIN
SELECT *
FROM info I
LEFT OUTER JOIN auth A
ON i.auth_id = a.auth_id;
 
 -- RIGHT OUTER JOIN
 SELECT *
FROM info I
RIGHT OUTER JOIN auth A
ON i.auth_id = a.auth_id;
-- LEFT JOIN 사용해도 순서만 바꾸면 위 쿼리와 동일
SELECT *
FROM auth A
LEFT OUTER JOIN info I
ON a.auth_id = i.auth_id;

-- FULL OUTER JOIN
SELECT * 
FROM info I
FULL OUTER JOIN auth A
ON i.auth_id = a.auth_id;

-- CROSS JOIN : 잘못 된 조인의 형태
SELECT *
FROM info I
CROSS JOIN auth A;
----------------------------------------------------------
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM LOCATIONS;

SELECT *
FROM employees E
JOIN departments D
ON e.department_id = d.department_id;

SELECT *
FROM employees E
LEFT JOIN departments D
ON e.department_id = d.department_id;

-- 조인은 여러번 들어갈 수 있다.
SELECT *
FROM employees E 
LEFT JOIN departments D ON e.department_id = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id; 

-- SELF JOIN
SELECT * 
FROM employees e1
LEFT JOIN employees e2
ON e1.employee_id = e2.manager_id;

-- 깔끔하게
SELECT e1.*,
       e2.first_name
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id;

----------------------------------------------------------------------
-- 오라클 조인 구문
-- FROM절 아래에 테이블을 나열, WHERE에 JOIN의 조건을 쓴다

-- INNER JOIN
SELECT * 
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- LEFT JOIN
SELECT * 
FROM employees e, departments d
WHERE e.department_id = d.department_id(+); -- 붙일 테이블에 (+)

-- RIGHT JOIN
SELECT * 
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id; -- 붙일 테이블에 (+)

-- FULL JOIN은 없다
-- 조건이 있다면 AND로 연결해서 사용
 