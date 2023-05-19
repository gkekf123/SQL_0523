
----- INSERT, UPDATE, DELETE -> COMMIT : 실제 반영 처리 -----

-- INSERT --
DESC departments;

-- 전체행 삽입
INSERT INTO departments VALUES(300, 'DEV', NULL, 1700);

-- 선택행 삽입, 나머지는 기본값
INSERT INTO departments(department_id, department_name) VALUES(310, 'SYSTEM');
SELECT * FROM departments;

-- 되돌리기
ROLLBACK;

-- 사본 테이블
CREATE TABLE EMPS AS ( SELECT * FROm employees WHERE 1 = 2);
SELECT * FROM emps;

-- employees 테이블에서 해당 항목 복사 / 전체 컬럼을 맞춤
INSERT INTO emps (SELECT * FROM employees WHERE job_id = 'IT_PROG');

-- 서브쿼리 인서트
INSERT INTO emps (employee_id, last_name, email, hire_date, job_id)
    VALUES(200, 
           (SELECT last_name FROM employees WHERE employee_id = '200'),
           (SELECT email FROM employees WHERE employee_id = '200'),
        SYSDATE,
        'TEST'
           );
           
----------------------------------------------------------------------------

-- UPDATE --
SELECT  * FROM emps;

-- EX 1 : 기본 UPDATE
UPDATE emps
SET hire_date = SYSDATE, 
    last_name = 'HONG',
    salary = salary + 1000
WHERE employee_id = 103;

-- EX 2 : 응용
UPDATE emps
SET commission_pct = 0.1
WHERE job_id IN ('IT_PROG', 'SA_MAN');

-- EX 3 : 연습 문제
-- employee_id = 200인 급여를 103번과 동일하게 변경
UPDATE emps
SET salary = (SELECT salary
               FROM employees
               WHERE employee_id = 103)
WHERE employee_id = 200;

-- EX 4 : 3개의 컬럼을 변경
UPDATE emps
SET(job_id, salary, commission_pct) = (SELECT job_id, 
                                              salary, 
                                              commission_pct 
                                       FROM emps 
                                       WHERE employee_id = 103)
WHERE employee_id = 200;

COMMIT;

----------------------------------------------------------------------------

-- DELETE --
-- 테이블 복사 + 데이터 복사
CREATE TABLE depts AS (SELECT * 
                       FROM departments
                       WHERE 1 = 1)
;
-- EX 1 : 삭제할 때는 꼭 PK를 이용
DELETE FROM emps
WHERE employee_id = 200;

DELETE FROM emps
WHERE salary >= 4000;

ROLLBACK;

SELECT * FROM emps;

-- EX 2 : 
DELETE FROM emps
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'IT')
;
SELECT * FROM emps;

-- employees가 60번 부서를 사용하고 있기 때문에 삭제 불가
DELETE FROM departments WHERE department_id = 60;

----------------------------------------------------------------------------

-- MERGE : 두 테이블을 비교해서 데이터가 있으면 UPDATE, 없다면 INSERT
SELECT * FROM emps;

MERGE INTO emps e1
USING(SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'SA_MAN')) e2
ON(e1.employee_id = e2.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        e1.salary = e2.salary,
        e1.hire_date = e2.hire_date,
        e1.commission_pct = e2.commission_pct
WHEN NOT MATCHED THEN
    INSERT VALUES
    (e2.employee_id,
     e2.first_name,
     e2.last_name,
     e2.email,
     e2.phone_number,
     e2.hire_date,
     e2.job_id,
     e2.salary,
     e2.commission_pct,
     e2.manager_id,
     e2.department_id
    )
;

-- MERGE 3
SELECT * FROM emps;

MERGE INTO emps e
USING DUAL
ON(e.employee_id = 103)
WHEN MATCHED THEN
    UPDATE SET e.last_name = 'DEMO'
WHEN NOT MATCHED THEN
    INSERT(e.employee_id,
           e.last_name,
           e.email,
           e.hire_date,
           e.job_id)
    VALUES('1000', 'DEMO', 'DEMO', SYSDATE, 'DEMO')
;
DELETE FROM emps
WHERE employee_id = 103;
SELECT * FROM emps;

