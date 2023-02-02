--TCL(TRANSACTION CONTROL LANGUAGE) : 트랜젝션 제어 언어
--COMMIT(트랜젝션 종료 후 저장), ROLLBACK(트랜젝션 취소), SAVEPOINT(임시저장)

--DML(INSERT,UPDATE,DELETE)과 관련되어 있다.

/* TRANSACTION이란 ?
 * -데이터베이스 논리적 연산 단위
 * -데이터베이스의 상태를 변화 시키기 위해서 수행하는 작업 단위
 * -데이터 변경 사항을 묶어 하나의 트랜잭션에 담아 처리함.
 * -트랜잭션의 대상이 되는 데이터 변경 사항 : INSERT,UPDATE,DELETE(DML)
 * -INSERT 수행한다고 DB에 반영되지 않음
 * -INSERT 수행하면 TRANSACTION에 추가, COMMIT을 해야 DB에 반영
 * -EX) INSERT 10번 수행 -> 1개 트랜잭션에 10개 추가 -> ROLLBACK --> DB에 반영 X
 * 
 * 1)COMMIT : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영
 * 2)ROLLBACK : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제하고
 * 				마지막 COMMIT 상태 시점으로 돌아감(DB에 변경 내용 반영X)
 *3)SAVEPOINT : 메모리 버퍼(트랜잭션)에 저장 지점을 정의하여
 *				ROLLBACK수행 시 전체 작업을 삭제하는 것이 아닌
 *				저장 지점까지만 일부 ROLLBACK 
 *[SAVEPOINT]사용법
 *
 *SAVEPOINT 포인트명1;
 *...
 *SAVEPOINT 포인트명2;
 *...
 *ROLLBACK TO 포인트명1; -- 포인트1 지점까지 데이터 변경사항 삭제
 *
 */

SELECT * FROM DEPARTMENT2;

-- 새로운 데이터 INSERT
INSERT INTO DEPARTMENT2 VALUES('T1','개발1팀','L2');
INSERT INTO DEPARTMENT2 VALUES('T2','개발2팀','L2');
INSERT INTO DEPARTMENT2 VALUES('T3','개발3팀','L2');
--> 아직 DB에 반영 X
--> SQL 수행 시 트랜잭션에 임시 저장된 상태
--(실제로 아직 DB 반영X)

ROLLBACK;
SELECT * FROM DEPARTMENT2;

COMMIT;

ROLLBACK; --롤백 안됨


-------------------------------------------------------------------------------------

--SAVEPOINT 확인
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀','L2');
SAVEPOINT SP1; -- SAVEPOINT 지정
INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀','L2');
SAVEPOINT SP2;
INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀','L2');
SAVEPOINT SP3;

ROLLBACK TO SP1;

-------UPPER 함수의 역할
SELECT EMP_NO, UPPER(EMP_NAME)  
FROM EMPLOYEE;
--조회한 컬럼이 영문자일 경우 대문자로 바꿔주는 함수

