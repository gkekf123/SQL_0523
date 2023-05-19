--문제 1.
--DEPTS테이블의 다음을 추가하세요
--DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID
--280개발 null 1800
--290회계부 null 1800
--300재정 301 1800
--310인사 302 1800
--320영업 303 1700
SELECT * FROM depts;
INSERT INTO depts VALUES(280, '개발', null, 1800);
INSERT INTO depts VALUES(290, '회계부', null, 1800);
INSERT INTO depts VALUES(300, '재정', null, 1800);
INSERT INTO depts VALUES(310, '인사', null, 1800);
INSERT INTO depts VALUES(320, '영업', null, 1700);

COMMIT;

--문제 2.
--DEPTS테이블의 데이터를 수정합니다
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
UPDATE depts
SET department_name = 'IT bank'
WHERE department_name = 'IT Support';

commit;

--2. department_id가 290인 데이터의 manager_id를 301로 변경
SELECT * FROM depts;
UPDATE depts
SET manager_id = '301'
WHERE department_id = '290';

commit;

--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를 1800으로 변경하세요
UPDATE depts
SET department_name = 'IT Help',
    manager_id = '303',
    location_id = '1800'
WHERE department_name = 'IT Helpdesk';

SELECT * FROM depts;
commit;

--4. 재정, 인사, 영업의 매니저아이디를 301로 한번에 변경하세요.
SELECT * FROM depts;
UPDATE depts
SET manager_id = '301'
WHERE department_name IN('재정', '인사', '영업');

commit;

--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
select * FROM depts;
DELETE FROM depts
WHERE department_id = '320';

DELETE FORM depts
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = '영업');
--2. 부서명 NOC를 삭제하세요
DELETE FROM depts
WHERE department_id = '220';

DELETE FORM depts
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'NOC');

COMMIT;

--문제4
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
DELETE FROM depts WHERE department_id > 200;
SELECT * FROM depts;

COMMIT;
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
SELECT * FROM depts;
UPDATE depts
SET manager_id = '100'
WHERE manager_id IS NOT NULL
;

COMMIT;
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
--새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
SELECT * FROM DEPARTMENTS;
SELECT * FROM depts;

MERGE INTO depts d1
USING(SELECT * FROM departments)d2
ON(d1.department_id = d2.department_id)
WHEN MATCHED THEN
    UPDATE SET
        d1.department_name = d2.department_name,
        d1.manager_id = d2.manager_id,
        d1.location_id = d2.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES (d2.department_id,
                   d2.department_name,
                   d2.manager_id,
                   d2.location_id)
;

commit;
--문제 5
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
CREATE TABLE jobs_it AS(SELECT * FROM jobs WHERE MIN_SALARY > 6000);

commit;
--2. jobs_it 테이블에 다음 데이터를 추가하세요
--JOB_ID JOB_TITLE MIN_SALARY MAX_SALARY
--IT_DEV 아이티개발팀 6000 20000
--NET_DEV 네트워크개발팀 5000 20000
--SEC_DEV 보안개발팀 6000 19000
SELECT * FROM jobs_it;
INSERT INTO jobs_it VALUES('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO jobs_it VALUES('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO jobs_it VALUES('SEC_DEV', '보안개발팀', 6000, 19000);

COMMIT;
--3. jobs_it은 타겟 테이블 입니다
--4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요
SELECT * FROM jobs;
MERGE INTO jobs_it j1
USING(SELECT * FROM jobs WHERE MIN_SALARY > 0) j2
ON(j1.job_id = j2.job_id)
WHEN MATCHED THEN
    UPDATE SET
        j1.min_salary = j2.min_salary,
        j1.max_salary = j2.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES(j2.job_id,
                  j2.job_title,
                  j2.min_salary,
                  j2.max_salary)
;
SELECT * FROM jobs_it;
COMMIT;