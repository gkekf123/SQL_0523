----- ���� ���� ��� 1 -----
-- 1. USER ����
-- ���̵� USER01, ��й�ȣ USER01
CREATE USER USER01 IDENTIFIED BY USER01;

-- 2. USER ���� �ο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO USER01;
-- ���� ȸ��
--REVOKE CREATE SESSION FROM USER01;

-- 3. �����Ͱ� ���� �Ǵ� �������� ����(���̺� �����̽� ����)
-- ALTER USER ������ DEFAULT TABLESPACE ���̺����̽��� QUOTA UNLIMITED ON ���̺����̽���
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- 4. ���� ���� -> ���� ���� -> ���̺���� -> ������ ���� -> ����
DROP USER USER01 CASCADE;

-----------------------------------------------------------------------------------------------

----- ROLE -----

CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT/*, DBA */ TO USER01;

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ��й�ȣ ���� --
ALTER USER USER01 IDENTIFIED BY 1234;

-------------------------------------------------------------------------

-- ���콺�� �����ϱ� --
-- 1. ���̺� �����̽� ���� > ���� > DBA
-- 1. DBA���� ������ > �ٸ� ����� > ����� ����
