----- SEQUENCE ���������� �����ϴ� ��, PK�� ���� ��� ��-----
SELECT * FROM user_sequences;
 
 CREATE SEQUENCE DEPTS_SEQ
 START WITH 1
 INCREMENT BY 1
 MAXVALUE 10
 MINVALUE 1
 NOCYCLE
 NOCACHE;
 
 -- ������ ����(��, ���ǰ� �ִ� ��������� ����) --
 DROP SEQUENCE depts_seq;
 
 DROP TABLE depts;
 CREATE TABLE depts AS(SELECT * FROM departments where 1 = 2);
 ALTER TABLE depts ADD CONSTRAINT depts_pk PRIMARY KEY(department_id); -- PK
 SELECT * FROM depts;
 
 -- ������ ��� --
 -- �������� ���� ��(���� �ȴ� - �ٸ������� ����ϸ� �����ϰ� ��)
 SELECT depts_seq.nextval FROM DUAL; 
 
 -- �������� ���� ��
 SELECT depts_seq.CURRVAL FROM DUAL; 
 
 -- X10 -> ���� -> (�������� �ִ밪�� �����ϸ� ����� �� ����)
 INSERT INTO depts VALUES(depts_seq.nextval, 'TEST', 100, 1000); 
 
 -- �������� ���� --
 ALTER SEQUENCE depts_seq MAXVALUE 99999;
 ALTER SEQUENCE depts_seq INCREMENT BY 10;
 
 SELECT * FROM depts;
 
 -- ������ ���� ���� (�ɼǾ����� �⺻��) --
 DROP SEQUENCE depts2_seq;
 CREATE SEQUENCE depts2_seq NOCACHE;
 SELECT * FROM user_sequences;
 
 -- ������ �ʱ�ȭ (�������� ���̺��� ���ǰ� �ִ� ���, DROP SEQUENCE �ϸ� �ȵȴ�) -- 
 -- 1. ���� ������
 SELECT depts_seq.CURRVAL FROM DUAL;
 -- 2. �������� ������ ����
 ALTER SEQUENCE depts_seq INCREMENT BY -119; -- ��������� -1 ����
 -- 3. ������ ����
 SELECT depts_seq.NEXTVAL FROM DUAL;
 -- 4. ������ �������� �ٽ� 1�� ����
 ALTER SEQUENCE depts_seq INCREMENT BY 1;
 -- 5. ���� ���� �������� 2���� ����
 
 -- ������ VS �� ������ VS ���� ���ڿ� -> PK���� --
 --20220523-00001 - ��ǰ��ȣ
 CREATE TABLE depts3(
    dept_no VARCHAR2(30) PRIMARY KEY,
    dept_name VARCHAR2(30)
 );
 
 CREATE SEQUENCE depts3_seq NOCACHE;
 -- TO_CHAR(SYSDATE, 'YYYYMMDD'), LPAD(�ڸ���, 'ä�ﰪ')
 SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(depts_seq.NEXTVAL, 5, '0') || '-' || '��ǰ��ȣ', 'TEST' FROM DUAL;
 INSERT INTO depts3 VALUES
 (TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(depts_seq.NEXTVAL, 5, '0') || '-' || '��ǰ��ȣ', 'TEST'
 );
 SELECT * FROM depts3;
 
 ----------------------------------------------------------------------------------
 
 -- INDEX --
 -- �ε����� PK, UK���� �ڵ����� �Ǵ� UNIQUE�ε����� �ִ�
 -- �ε����� ������ ��ȸ�� ������ ���ִ� HINT������ �Ѵ�
 -- ���� ������� �ʴ� �Ϲ� �÷��� �ε����� ������ �� �ִ�
 
 CREATE TABLE emps_it AS(SELECT * FROM employees where 1 = 1);
 -- �ε����� ���� �� ��ȸ VS �ε��� ���� �� ��ȸ
 SELECT * FROM emps_it WHERE first_name = 'Allan';
 -- �ε��� ����(�ε����� ��ȸ�� ������ �ϱ� ������, ������ �ϰ� ���� �����ϸ� ������ ������ ��������)
 CREATE INDEX emps_it_idx ON emps_it(first_name);
 CREATE UNIQUE INDEX emps_it_idx ON emps_it(first_name); -- ����ũ�ε���(�÷����� ����ũ�ؾ� �Ѵ�)
 -- �ε��� ����
 DROP INDEX emps_it_idx;
 -- �ε�����(�����ε���) ���� �ø��� ������ �� �ִ�
 CREATE INDEX emps_it_idx ON emps_it(first_name, last_name);
 SELECT * FROM emps_it WHERE first_name = 'Allan'; -- �ε��� ����
 SELECT * FROM emps_it WHERE first_name = 'Allan' AND last_name = 'McEwen'; -- �ε��� ����
 
 -- first_name �������� ����
 -- �ε����� �������� ��Ʈ�� �ִ� ���
 SELECT * 
 FROM(SELECT /* + INDEX_DESC(e emps_it_idx) */
        ROWNUM rn,
        e.*
      FROM emps_it e
      ORDER BY first_name DESC)
 WHERE rn > 10 AND rn <= 20
 ;