----- SEQUENCE 순차적으로 증가하는 값, PK에 많이 사용 됨-----
SELECT * FROM user_sequences;
 
 CREATE SEQUENCE DEPTS_SEQ
 START WITH 1
 INCREMENT BY 1
 MAXVALUE 10
 MINVALUE 1
 NOCYCLE
 NOCACHE;
 
 -- 시퀀스 삭제(단, 사용되고 있는 시퀀스라면 주의) --
 DROP SEQUENCE depts_seq;
 
 DROP TABLE depts;
 CREATE TABLE depts AS(SELECT * FROM departments where 1 = 2);
 ALTER TABLE depts ADD CONSTRAINT depts_pk PRIMARY KEY(department_id); -- PK
 SELECT * FROM depts;
 
 -- 시퀀스 사용 --
 -- 시퀀스의 다음 값(공유 된다 - 다른곳에서 사용하면 증가하게 됨)
 SELECT depts_seq.nextval FROM DUAL; 
 
 -- 시퀀스의 현재 값
 SELECT depts_seq.CURRVAL FROM DUAL; 
 
 -- X10 -> 에러 -> (시퀀스의 최대값에 도달하면 사용할 수 없다)
 INSERT INTO depts VALUES(depts_seq.nextval, 'TEST', 100, 1000); 
 
 -- 시퀀스의 수정 --
 ALTER SEQUENCE depts_seq MAXVALUE 99999;
 ALTER SEQUENCE depts_seq INCREMENT BY 10;
 
 SELECT * FROM depts;
 
 -- 시퀀스 빠른 생성 (옵션없으면 기본값) --
 DROP SEQUENCE depts2_seq;
 CREATE SEQUENCE depts2_seq NOCACHE;
 SELECT * FROM user_sequences;
 
 -- 시퀀스 초기화 (시퀀스가 테이블에서 사용되고 있는 경우, DROP SEQUENCE 하면 안된다) -- 
 -- 1. 현재 시퀀스
 SELECT depts_seq.CURRVAL FROM DUAL;
 -- 2. 증가값을 음수로 변경
 ALTER SEQUENCE depts_seq INCREMENT BY -119; -- 현재시퀀스 -1 감소
 -- 3. 시퀀스 실행
 SELECT depts_seq.NEXTVAL FROM DUAL;
 -- 4. 시퀀스 증가값을 다시 1로 변경
 ALTER SEQUENCE depts_seq INCREMENT BY 1;
 -- 5. 이후 부터 시퀀스는 2부터 시작
 
 -- 시퀀스 VS 년 시퀀스 VS 랜덤 문자열 -> PK지정 --
 --20220523-00001 - 상품번호
 CREATE TABLE depts3(
    dept_no VARCHAR2(30) PRIMARY KEY,
    dept_name VARCHAR2(30)
 );
 
 CREATE SEQUENCE depts3_seq NOCACHE;
 -- TO_CHAR(SYSDATE, 'YYYYMMDD'), LPAD(자리수, '채울값')
 SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(depts_seq.NEXTVAL, 5, '0') || '-' || '상품번호', 'TEST' FROM DUAL;
 INSERT INTO depts3 VALUES
 (TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(depts_seq.NEXTVAL, 5, '0') || '-' || '상품번호', 'TEST'
 );
 SELECT * FROM depts3;
 
 ----------------------------------------------------------------------------------
 
 -- INDEX --
 -- 인덱스는 PK, UK에서 자동생성 되는 UNIQUE인덱스가 있다
 -- 인덱스의 역할은 조회를 빠르게 해주는 HINT역할을 한다
 -- 많이 변경되지 않는 일반 컬럼에 인덱스를 적용할 수 있다
 
 CREATE TABLE emps_it AS(SELECT * FROM employees where 1 = 1);
 -- 인덱스가 없을 때 조회 VS 인덱스 생성 후 조회
 SELECT * FROM emps_it WHERE first_name = 'Allan';
 -- 인덱스 생성(인덱스는 조회를 빠르게 하긴 하지만, 무작위 하게 많이 생성하면 오히려 성능이 떨어진다)
 CREATE INDEX emps_it_idx ON emps_it(first_name);
 CREATE UNIQUE INDEX emps_it_idx ON emps_it(first_name); -- 유니크인덱스(컬럼값이 유니크해야 한다)
 -- 인덱스 삭제
 DROP INDEX emps_it_idx;
 -- 인덱스는(결합인덱스) 여러 컬름을 지정할 수 있다
 CREATE INDEX emps_it_idx ON emps_it(first_name, last_name);
 SELECT * FROM emps_it WHERE first_name = 'Allan'; -- 인덱스 적용
 SELECT * FROM emps_it WHERE first_name = 'Allan' AND last_name = 'McEwen'; -- 인덱스 적용
 
 -- first_name 기준으로 순서
 -- 인덱스를 기준으로 힌트를 주는 방법
 SELECT * 
 FROM(SELECT /* + INDEX_DESC(e emps_it_idx) */
        ROWNUM rn,
        e.*
      FROM emps_it e
      ORDER BY first_name DESC)
 WHERE rn > 10 AND rn <= 20
 ;