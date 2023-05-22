----- 트랜잭션(논리적 작업단위) -----
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;
DELETE FROM depts WHERE department_id = 10;
SAVEPOINT delete10; -- 세이브포인트 기록
DELETE FROM depts WHERE department_id = 20;
SAVEPOINT delete20; -- 세이브포인트 기록
ROLLBACK TO delete20; -- 20번 세이브포인트로 롤백
ROLLBACK TO delete10; -- 20번 세이브포인트로 롤백
SELECT * FROM depts;
INSERT INTO depts VALUES(300, 'DEMO', NULL, 1000);
c