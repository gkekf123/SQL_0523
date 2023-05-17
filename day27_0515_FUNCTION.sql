-- 문자열 함수
-- LOWER(), INITCAP(), UPPER()
SELECT LOWER('HELLO'), INITCAP('HELLO'), UPPER('HELLO') FROM DUAL; // 가짜 테이블

SELECT LOWER(first_name), INITCAP(first_name), UPPER(first_name) FROM employees;

-- 함수는 WHERE절에도 적용
SELECT first_name FROM employees WHERE UPPER(first_name) = 'STEVEN';

-- LENTH() : 길이, INSTR() : 문자찾기
SELECT first_name, LENGTH(first_name), INSTR(first_name, 'e') FROM employees;

-- SUBSTR() : 문자열 자르기, CONCAT() : 문자열 합치기
SELECT first_name, SUBSTR(first_name, 1, 3) FROM employees; // 1번째에서 3글자를 자름
SELECT first_name, CONCAT(first_name, last_name)FROM employees; //first_name || last_name과 같은표현

-- LPAD() : 왼쪽 채우기, RPAD() : 오른쪽 채우기
SELECT LPAD('HELLO', 10, '*') FROM DUAL; // 10칸 잡고 왼쪽부터 채운다
SELECT LPAD(salary, 10, '*') FROM employees;
SELECT RPAD(salary, 10, '*') FROM employees;

-- LTRIM() : 왼쪽 제거, RTRIM() : 오른쪽 제거, RTIM() : 양쪽 제거
SELECT LTRIM('     HELLO') FROM DUAL;
SELECT LTRIM(first_name, 'A') FROM employees; // 왼쪽에 처음 발견되는 문자 A제거
SELECT RTRIM(first_name, 'n') FROM employees; // 오른쪽에서 입력 문자 제거
SELECT TRIM('    HELLO ') AS RESULT FROM DUAL;

-- REPLACE() : 문자열 변경
SELECT REPLACE('HELLO WORLD', 'HELLO', 'BYE') FROM DUAL;
SELECT REPLACE('HELLO WORLD ~!', ', ', '') AS RESULT FROM DUAL; -- 모든 공백 제거

-- 중첩
SELECT REPLACE('HELLO WORLD ~!', 'HELLO', 'BYE') FROM DUAL;
SELECT REPLACE(REPLACE('HELLO WORLD ~!', 'HELLO', 'BYE'), ' ', '') AS RESULT FROM DUAL;

-- 숫자 함수 --
-- ROUND() : 반올림
SELECT ROUND(45.523, 2), 
        ROUND(45.523), 
        ROUND(45.523, -1) 
FROM DUAL;

-- TRUNC() : 절삭
SELECT TRUNC(45.523, 2), 
        TRUNC(45.523), 
        TRUNC(45.523, -1) 
FROM DUAL;

-- CEIL() : 올림, FLOOR() : 내림
SELECT CEIL(3.14), 
        FLOOR(3.14)
FROM DUAL;

-- MOD() : 나머지
SELECT 5 / 3 AS 몫, 
        MOD(5, 3) AS 나머지 
FROM DUAL;

-- 날짜 함수 --
SELECT SYSDATE,
        SYSTIMESTAMP
FROM DUAL;

-- 날짜 연산 --
-- +10일
SELECT SYSDATE + 10
FROM DUAL;
-- -10일
SELECT SYSDATE - 10
FROM DUAL;
-- 일 수
SELECT SYSDATE - hire_date
FROM employees;
-- 주 
SELECT (SYSDATE - hire_date) / 7 AS "WEEKS"
FROM employees;
-- 달
SELECT TRUNC((SYSDATE - hire_date) / 365) * 12 AS "MONTH"
FROM employees;
-- 년
SELECT (SYSDATE - hire_date) / 365 AS "YEARS"
FROM employees;

-- 날짜의 반올림 --
SELECT ROUND(SYSDATE)
FROM DUAL;
-- 해당 주 의 일요일로
SELECT ROUND(SYSDATE, 'DAY')
FROM DUAL;
-- 월에 대한 반올림
SELECT ROUND(SYSDATE, 'MONTH')
FROM DUAL;
-- 년에 대한 반올림
SELECT ROUND(SYSDATE, 'YEAR')
FROM DUAL;

-- 날짜의 절삭 --
SELECT TRUNC(SYSDATE)
FROM DUAL;
-- 해당 주 의 일요일로 절삭
SELECT TRUNC(SYSDATE, 'DAY')
FROM DUAL;
-- 월에 대한 절삭
SELECT TRUNC(SYSDATE, 'MONTH')
FROM DUAL;
-- 년에 대한 절삭
SELECT TRUNC(SYSDATE, 'YEAR')
FROM DUAL;

SELECT first_name, TO_CHAR(hire_date, 'MM/YY') AS Month_hired
FROM employees
WHERE first_name = 'Steven';

----- 형변환 함수 -----

-- 자동 형변환
SELECT * 
FROM employees 
WHERE department_id = '30';

--
SELECT SYSDATE -5,
        SYSDATE - '5'
FROM employees;

-- 강제 형변환 --

-- TO_CHAR(날짜, 날짜 포맷)

-- 문자
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS')
FROM DUSL;

-- 문자
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS')
FROM DUAL;

-- 포맷문자가 아닌 경우는 ""로 묶어 준다
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일"') 
FROM DUAL;

SELECT TO_CHAR(hire_date, 'YYYY-MM-DD')
FROM employees;

-- TO_CHAR(숫자, 숫자 포맷) --

SELECT TO_CHAR(200000, '$999,999,999')
FROM DUAL;

-- 소수 점 자리 표현
SELECT TO_CHAR(200000, '999999.999')
FROM DUAL;

-- 지역 화폐
SELECT TO_CHAR(salary * 1300, 'L999,999,999')
FROM employees;

-- 자리수를 0으로 채움
SELECT TO_CHAR(salary * 1300, 'L0999,999,999')
FROM employees;

-- TO_NUMBER(문자, 숫자 포맷) --

-- 자동 형변환
SELECT '3.14' + 2000
FROM DUAL;

-- 명시적 형변환
SELECT TO_NUMBER('3.14') + 2000
FROM DUAL;

-- 명시적 형변환
-- ERROR
SELECT '$3,300' + 2000 
FROM DUAL;

-- CORRECT
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 
FROM DUAL;

-- TO_DATE(문자, 날짜 포맷) --

-- ERROR
SELECT SYSDATE - '2023-05-16'
FROM DUAL;

-- CORRECT
SELECT SYSDATE - TO_DATE('2023-05-16', 'YYYY-MM-DD')
FROM DUAL;

SELECT SYSDATE - TO_DATE('2023-05-16 11:31:23', 'YYYY-MM-DD HH:MI:SS')
FROM DUAL;

-- 아래 값을 YYYY년MM월DD일 형태로 출력
-- SELECT '20050105' FROM DUAL;
SELECT TO_CHAR(TO_DATE('20050105', 'YYYYMMDD'), 'YYYY"년"MM"월"DD"일"')
FROM DUAL;

-- 아래 값을 현재 날짜와 일수 차이르 구하시오
-- SELECT '2005년01월05일' FROM DUAL
SELECT SYSDATE - TO_DATE('2005년01월05일', 'YYYY"년"MM"월"DD"일"')
FROM  DUAL;

-- NULL값에 대한 반환 NVL(컬럼, NULL일 경우 처리) --

SELECT NVL(NULL, 0)
FROM DUAL;

--
SELECT first_name, 
        commission_pct
FROM employees;

-- NULL 연산 -> NULL
SELECT first_name, 
        commission_pct * 100
FROM employees;

--
SELECT first_name, 
        NVL(commission_pct, 0) * 100
FROM employees;

-- NVL2(컬럼, NULL이 아닌경우처리, NULL인 경우처리) --

SELECT NVL2(NULL, 'NULL이아니다', 'NULL이다')
FROM DUAL;

-- 총 월급은 얼마인가?
SELECT  first_name,
        salary,
        commission_pct,
        NVL2(commission_pct, salary + (salary * commission_pct), 
        salary) AS 급여
FROM employees;

-- DECODE() : ELSE IF문을 대체하는 함수 --

SELECT DECODE('D', 'A', 'A입니다', 
                   'B', 'B입니다', 
                   'C', 'C입니다',
                   'ABC가 아닙니다')
FROM DUAL;

--
SELECT job_id, 
    DECODE(job_id, 'IP_PROG', salary * 0.3,
                   'FI_MGR', salary * 0.2,
                   salary)
FROM employees;

-- CASE WHEN THEN ELSE --

-- 방법 1
SELECT job_id, 
       salary,
       CASE job_id WHEN 'IT_PROG' THEN salary * 1.10
                   WHEN 'FI_MGE' THEN salary * 1.15
                   WHEN 'FI_ACCOUNT' THEN salary * 1.20
                   ELSE salary
                   END AS REVISED_SALARY
FROM employees;

-- 방법 2
SELECT job_id, 
       salary,
       CASE WHEN job_id = 'IT_PROG' THEN salary * 1.10
            WHEN job_id = 'FI_MGE' THEN salary * 1.15
            WHEN job_id = 'FI_ACCOUNT' THEN salary * 1.20
            ELSE salary
            END AS REVISED_SALARY
FROM employees;

-- COALESCE(A, B) -- NVL이랑 유사(NULL일 경우에 0으로 치환) --

SELECT COALESCE(commission_pct, 0)
FROM employees;

-- 연습문제
SELECT * FROM employees;

-- 문제 1
SELECT employee_id AS 사원번호,
       first_name || ' ' || last_name AS 사원명,
       hire_date AS 입사일자,
       TRUNC((SYSDATE - hire_date) / 365) AS 근속년수 
FROM employees
WHERE TRUNC((SYSDATE - hire_date) / 365) >= 10
ORDER BY 근속년수 DESC;

-- 문제 2
SELECT first_name || ' ' || last_name AS NAME,
       manager_id,
       CASE manager_id WHEN 100 THEN '사원'
                       WHEN 120 THEN '주임'
                       WHEN 121 THEN '대리'
                       WHEN 122 THEN '과장'
                       ELSE '임원'
                       END AS 직급
FROM employees
WHERE department_id = 50
ORDER BY manager_id ASC;

-- UNION : 합집합 --
SELECT first_name,
       hire_date
FROM employees
WHERE hire_date LIKE '04%'
UNION
SELECT first_name,
       hire_date
FROM employees
WHERE department_id = 20;

-- UNION ALL : 합집합 --
SELECT first_name,
       hire_date
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT first_name,
       hire_date
FROM employees
WHERE department_id = 20;

-- INTERSECT : 교집합 --
SELECT first_name,
       hire_date
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT first_name,
       hire_date
FROM employees
WHERE department_id = 20;

-- MINUS : 차집합 --
SELECT first_name,
       hire_date
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT first_name,
       hire_date
FROM employees
WHERE department_id = 20;

SELECT '홍길동', TO_CHAR(SYSDATE) FROM DUAL
UNION ALL
SELECT '이순신', '05/01/01' FROM DUAL
UNION ALL
SELECT '홍길자', '06/06/06' FROM DUAL
UNION ALL
SELECT last_name, TO_CHAR(hire_date) FROM employees;

-- 분석 함수 행에 대한 결과를 출력하느 기능, OVER()와 함께 사용된다 --
-- window구문 SQLD 단골 문제
SELECT salary, 
       RANK() OVER(ORDER BY salary DESC) AS 중복순서,
       DENSE_RANK() OVER(ORDER BY salary DESC) AS 중복순서X,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS 데이터번호,
       COUNT(*)OVER(), -- 전체 데이터 개수
       ROWNUM AS 조회순서 -- 조회가 일어난 순서
FROM employees;


