--TCL(TRANSACTION CONTROL LANGUAGE) : Ʈ������ ���� ���
--COMMIT(Ʈ������ ���� �� ����), ROLLBACK(Ʈ������ ���), SAVEPOINT(�ӽ�����)

--DML(INSERT,UPDATE,DELETE)�� ���õǾ� �ִ�.

/* TRANSACTION�̶� ?
 * -�����ͺ��̽� ���� ���� ����
 * -�����ͺ��̽��� ���¸� ��ȭ ��Ű�� ���ؼ� �����ϴ� �۾� ����
 * -������ ���� ������ ���� �ϳ��� Ʈ����ǿ� ��� ó����.
 * -Ʈ������� ����� �Ǵ� ������ ���� ���� : INSERT,UPDATE,DELETE(DML)
 * -INSERT �����Ѵٰ� DB�� �ݿ����� ����
 * -INSERT �����ϸ� TRANSACTION�� �߰�, COMMIT�� �ؾ� DB�� �ݿ�
 * -EX) INSERT 10�� ���� -> 1�� Ʈ����ǿ� 10�� �߰� -> ROLLBACK --> DB�� �ݿ� X
 * 
 * 1)COMMIT : �޸� ����(Ʈ�����)�� �ӽ� ����� ������ ���� ������ DB�� �ݿ�
 * 2)ROLLBACK : �޸� ����(Ʈ�����)�� �ӽ� ����� ������ ���� ������ �����ϰ�
 * 				������ COMMIT ���� �������� ���ư�(DB�� ���� ���� �ݿ�X)
 *3)SAVEPOINT : �޸� ����(Ʈ�����)�� ���� ������ �����Ͽ�
 *				ROLLBACK���� �� ��ü �۾��� �����ϴ� ���� �ƴ�
 *				���� ���������� �Ϻ� ROLLBACK 
 *[SAVEPOINT]����
 *
 *SAVEPOINT ����Ʈ��1;
 *...
 *SAVEPOINT ����Ʈ��2;
 *...
 *ROLLBACK TO ����Ʈ��1; -- ����Ʈ1 �������� ������ ������� ����
 *
 */

SELECT * FROM DEPARTMENT2;

-- ���ο� ������ INSERT
INSERT INTO DEPARTMENT2 VALUES('T1','����1��','L2');
INSERT INTO DEPARTMENT2 VALUES('T2','����2��','L2');
INSERT INTO DEPARTMENT2 VALUES('T3','����3��','L2');
--> ���� DB�� �ݿ� X
--> SQL ���� �� Ʈ����ǿ� �ӽ� ����� ����
--(������ ���� DB �ݿ�X)

ROLLBACK;
SELECT * FROM DEPARTMENT2;

COMMIT;

ROLLBACK; --�ѹ� �ȵ�


-------------------------------------------------------------------------------------

--SAVEPOINT Ȯ��
INSERT INTO DEPARTMENT2 VALUES('T4','����4��','L2');
SAVEPOINT SP1; -- SAVEPOINT ����
INSERT INTO DEPARTMENT2 VALUES('T5','����5��','L2');
SAVEPOINT SP2;
INSERT INTO DEPARTMENT2 VALUES('T6','����6��','L2');
SAVEPOINT SP3;

ROLLBACK TO SP1;

-------UPPER �Լ��� ����
SELECT EMP_NO, UPPER(EMP_NAME)  
FROM EMPLOYEE;
--��ȸ�� �÷��� �������� ��� �빮�ڷ� �ٲ��ִ� �Լ�

