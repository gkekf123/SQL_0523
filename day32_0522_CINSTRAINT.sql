-- 제약 조건
SELECT * FROM user_constraints;

-- 열 레벨 제약조건(테이블생성 시 열 옆에 적는다)
-- 제약조건 이름이 자동 생상 됨
CREATE TABLE DEPTS2(
    DEPT_NO NUMBER(2) PRIMARY KEY, 
    DEPT_NAME VARCHAR(20) NOT NULL,
    DEPT_DATE DATE DEFAULT SYSDATE, -- 제약조건은 아니다(기본값)
    DEPT_PHONE VARCHAR(20) UNIQUE,
    DEPT_BONUS NUMBER(10) CHECK(DEPT_BONUS > 0),
    LOCA NUMBER(4) REFERENCES  LOCATIONS(location_id)-- FK 참조테이블(참조컬럼)
    );
    
-- 제약 조건 이름을 지정
CREATE TABLE DEPTS2(
    DEPT_NO NUMBER(2) CONSTRAINT DEPT2_PK PRIMARY KEY, 
    DEPT_NAME VARCHAR(20) CONSTRAINT DEPT2_NAME_NN NOT NULL,
    DEPT_DATE DATE DEFAULT SYSDATE, -- 제약조건은 아니다(기본값)
    DEPT_PHONE VARCHAR(20) CONSTRAINT DEPT2_PHONE_UK UNIQUE,
    DEPT_BONUS NUMBER(10) CONSTRAINT DEPT2_BONUS_CK CHECK(DEPT_BONUS > 0),
    LOCA NUMBER(4) CONSTRAINT DEPT2_LOCA_FK REFERENCES LOCATIONS(location_id)-- FK 참조테이블(참조컬럼)
    );
    
 -- 테이블 레벨 제약조건(슈퍼키나, 다중 FK등 선언이 가능)
 CREATE TABLE DEPTS2(
    DEPT_NO NUMBER(2) , 
    DEPT_NAME VARCHAR(20) NOT NULL,
    DEPT_DATE DATE DEFAULT SYSDATE, -- 제약조건은 아니다(기본값)
    DEPT_PHONE VARCHAR(20) ,
    DEPT_BONUS NUMBER(10) ,
    LOCA NUMBER(4),
    CONSTRAINT DEPT_PK PRIMARY KEY(DEPT_NO /*, DEPT_NAME*/), --(DEPT_NO, DEPT_NAME)-> 슈퍼키로 지정
    CONSTRAINT DEPT_PHONE_UK UNIQUE(DEPT_PHONE),
    CONSTRAINT DEPT_BONUS_CK CHECK(DEPT_BONUS > 0),
    CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(location_id)
    );
 
DROP TABLE DEPTS2;
-- pk는 null값이 들어가지 않는다 -> 제약조건을 지키지 않았다
INSERT INTO depts2 VALUES(NULL, 'HONG', SYSDATE, '010...', 10000, 1000);
-- pk는 중복되지 않는다 -> 개체무결성(중복X)
INSERT INTO depts2 VALUES(10, 'HONG', SYSDATE, '010...', 10000, 1000);
INSERT INTO depts2 VALUES(10, 'HONG', SYSDATE, '010...', 10000, 1000);

-- 참조 무결성(참조테이블의 FK가 아닌 값이 FK에 들어갈 수 없음)
-- 500은 LOCATIONS에 PK가 아님
INSERT INTO depts2 VALUES(20, 'HONG', SYSDATE, '010...', 10000, 500);

-- 도메인 무결성(값은 컬럼에 정의 된 값이어야 한다)
INSERT INTO depts2 VALUES(30, 'HONG', SYSDATE, '01022222222', -1000, 1000);

------------------------------------------------------------------------------------

-- 제약 조건을 추가 OR 삭제
DROP TABLE DEPTS2;
 CREATE TABLE DEPTS2(
    DEPT_NO NUMBER(2) , 
    DEPT_NAME VARCHAR(20) NOT NULL,
    DEPT_DATE DATE DEFAULT SYSDATE, -- 제약조건은 아니다(기본값)
    DEPT_PHONE VARCHAR(20) ,
    DEPT_BONUS NUMBER(10) ,
    LOCA NUMBER(4)
--    CONSTRAINT DEPT_PK PRIMARY KEY(DEPT_NO /*, DEPT_NAME*/), --(DEPT_NO, DEPT_NAME)-> 슈퍼키로 지정
--    CONSTRAINT DEPT_PHONE_UK UNIQUE(DEPT_PHONE),
--    CONSTRAINT DEPT_BONUS_CK CHECK(DEPT_BONUS > 0),
--    CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(location_id)
    );
    
-- 제약조건은 수정이 없다
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_PK PRIMARY KEY(DEPT_NO);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_PHONE_UK UNIQUE(DEPT_PHONE);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_BONUS_CK CHECK(DEPT_BONUS > 0);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(location_id);

-- NOT NULL은 NODIFY문장으로 수정을 한다
ALTER TABLE DEPTS2 MODIFY DEPT_NAME VARCHAR2(20) NOT NULL;

-- 제약조건 삭제
ALTER TABLE DEPTS2 DROP CONSTRAINT DEPT_LOCA_FK;

---------------------------------------------------------------------
-- 문제
DROP TABLE members;

CREATE TABLE MEMBERS(
    M_NAME VARCHAR(20) NOT NULL,
    M_NUM NUMBER(5),
    REG_DATE DATE DEFAULT SYSDATE,
    GENDER CHAR(1),
    LOCA NUMBER(10),
    CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY(M_NUM),
    CONSTRAINT MEM_REGDATE UNIQUE(REG_DATE),
    CONSTRAINT MEM_GENDER_CK CHECK(GENDER IN('M', 'F')),
    CONSTRAINT MEM_LOCA_LOC_LOCID_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(location_id)
    );
    
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'members';

INSERT INTO members VALUES('AAA', 1, '18/07/01', 'M', 1800);
INSERT INTO members VALUES('BBB', 2, '18/07/02', 'F', 1900);
INSERT INTO members VALUES('CCC', 3, '18/07/03', 'M', 2000);
INSERT INTO members VALUES('DDD', 4, SYSDATE, 'M', 2000);

SELECT m_name,
       m_num,
       street_address,
       location_id
FROM members m
JOIN locations l
ON m.loca = l.location_id
ORDER BY M_NUM;

commit;