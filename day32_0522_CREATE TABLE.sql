----- DDL문 CREATE, ALTER, DROP
-- 오라클 대표 데이터 타입(VARCHAR2 - 가변문자, CHAR - 고정문자, NUMBER - 숫자, DATE - 날짜)
-- CREATE
CREATE TABLE DEPT2(
    DEPT_NO NUMBER(2), --  자리수
    DEPT_NAME VARCHAR(20), -- 최대 20바이트, 가변문자
    DEPT_YN CHAR(1), -- 1Byte 고정문자형
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10, 3) -- 10자리, 수수부 3
);
  
SELECT * FROM dept2;

INSERT INTO dept2 VALUES(99, 'SALES', 'Y', SYSDATE, 3.14);
-- INSERT INTO dept2 VALUES(98, 'SALES', '홍', SYSDATE, 3.14); -- 사이즈가 맞지않아 오류

COMMIT;

---------------------------------------------------------------------------------------------

-- ALTER
-- 열 추가
ALTER TABLE dept2 ADD(DEPT_COUNT NUMBER(3));

-- 열 이름 변경
ALTER TABLE dept2 RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

-- 열 수정(타입변경)
ALTER TABLE dept2 MODIFY(EMP_COUNT NUMBER(10));

-- 열 삭제
ALTER TABLE dept2 DROP COLUMN emp_count;

SELECT * FROM dept2;

---------------------------------------------------------------------------------------------

-- DROP
DROP TABLE dept2;
-- 제약조건 FK도 삭제, 테이블도 삭제
DROP TABLE dept2 CASCASE 제약조건명;

---------------------------------------------------------------------------------------------

-- TRUNCATE
TRUNCATE TABLE dept2;