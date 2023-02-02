--DML ������ ���� ���

--���̺� ���� �����ϰų� �����ϰų�  �����ϴ� ����

--���� : ȥ�ڼ� COMIT, ROLLBACK���� ����

--�׽�Ʈ�� ���̺� ����
CREATE TABLE EMPLOYEE2
AS SELECT * FROM EMPLOYEE;

CREATE TABLE DEPARTMENT2
AS SELECT * FROM DEPARTMENT;

----------------------------------------------------------------------------------

-- 1.INSERT
-- ���̺� ���ο� ���� �߰��ϴ� ����

--1) INSERT INTO ���̺�� VALUES(������,������,������)
--���̺� '���' �÷��� ���� ���� INSERT�� �� ���

INSERT INTO EMPLOYEE2  
VALUES(900,'��ü��','901234-2345678','jacn_ch@kh.or.kr',
			'01055569512', 'D1', 'J8', 'S3', 
           4300000,0.2,'200',SYSDATE,NULL,'N');
          
SELECT * FROM EMPLOYEE2
WHERE EMP_ID = 900;

ROLLBACK;      
          
DELETE  FROM EMPLOYEE2
WHERE EMP_ID = 900;

COMMIT;


-----------------------------------------------------------------------------------

-- 2) INSERT INTO ���̺��(�÷���,�÷���,�÷���..) VALUES(������,������,������...)
--���̺� ���� ������ �÷��� ���� ���� INSERT �� �� ���
--���� �ȵ� �÷��� ���� NULL�� ��(DEFAULT ���� �� DEFAULT ������ ���Ե�)

INSERT INTO EMPLOYEE2 (EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE,SAL_LEVEL,SALARY)
VALUES(900,'��ü��','901234-2345678','jacn_ch@kh.or.kr',
			'01055569512', 'D1', 'J8', 'S3', 
           4300000);
           
SELECT * FROM EMPLOYEE2
WHERE EMP_ID = 900;

--(�����) INSERT �� VAULUES ��ſ� �������� ��� ����

CREATE TABLE EMP_01(
EMP_ID NUMBER,
EMP_NAME VARCHAR2(30),
DEPT_TITLE VARCHAR2(20)
);


--���������� SELECT����
--�� SELECT ������ �׷��� INSERT ������ ���ؼ�
--EMP_01 �̶�� ���̺� ���� �� �ִ�

/*SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE2
LEFT JOIN DEPARTMENT2 ON(DEPT_CODE = DEPT_ID);*/

--��������(SELECT) ����� EMP_01 ���̺� INSERT
-->SELECT ���� ����� ������ Ÿ��,�÷�������
--INSERT�Ϸ��� ���̺��� �÷��� ��ġ�ؾ���

INSERT INTO EMP_01
(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE2
LEFT JOIN DEPARTMENT2 ON(DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;


------------------------------------------------------------------------------------------------

--2. UPDATE (������ �ٲٴ��� �߰��ؼ� �ֽ�ȭ��)

--���̺� ��ϵ� �÷��� ���� �����ϴ� ���

--[�ۼ���]
--UPDATE ���̺�� SET �÷��� = �ٲܰ�
--[WHERE �÷��� �񱳿����� �񱳰�] 
-->WHERE ���� �߿�
--UPDATE �� �÷��� ������ WHERE ������ ���ϱ� ������

--DEPARTMET2 ���̺��� DEPT_ID 'D9' �� �μ� ���� ��ȸ

SELECT * FROM DEPARTMENT2
WHERE DEPT_ID = 'D9'; -- D9 �ѹ���

--DEPARTMET2 ���̺��� DEPT_ID�� D9�� ���� DEPT_TITLE�� '������ȹ��'���� ����

UPDATE DEPARTMENT2 
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

-- EMPLOYEE2 ���̺��� ���ʸ� ���� �ʴ� ������� ���ʽ��� 0.1�� ����

UPDATE EMPLOYEE2
SET BONUS = '0.1'
WHERE BONUS IS NULL;

SELECT EMP_NAME, BONUS
FROM EMPLOYEE2;

--------------------------------------------------------------------

-- �������� �������� �ʰ� UPDATE ���� ���� �� ��� ���� �÷����� ����

SELECT * FROM DEPARTMENT2;

UPDATE DEPARTMENT2 SET DEPT_TITLE = '���������';

ROLLBACK;
--------------------------------------------------

--���� �÷��� �ѹ��� ������ �� �޸�(,)�� �÷��� �����ϸ� ��

UPDATE DEPARTMENT2 SET DEPT_ID ='D0', DEPT_TITLE ='������ȹ2��'
WHERE DEPT_ID = 'D9'
AND DEPT_TITLE  = '������ȹ��';

SELECT * FROM DEPARTMENT2;
-------------------------------------------------------------------

--UPDATE �ÿ��� �������� ��� ����

--[�ۼ���]
--UPDATE ���̺��
--SET �÷��� = (��������)

--EMPLOYEE2���̺���
--���� ����� ����� �η����ϴ� ���� �����
--�޿��� ���ʽ����� ����� ����� �����ϰ� ������ �ֱ�� �ߴ�.
--�̸� �ݿ��ϴ� UPDATE���� �ۼ��Ͻÿ�

SELECT SALARY FROM EMPLOYEE2 WHERE EMP_NAME = '�����';

SELECT BONUS FROM EMPLOYEE2 WHERE EMP_NAME = '�����';

SELECT SALARY FROM EMPLOYEE2 WHERE EMP_NAME = '����';

SELECT BONUS FROM EMPLOYEE2 WHERE EMP_NAME = '����';


UPDATE EMPLOYEE2
SET SALARY = (SELECT SALARY FROM EMPLOYEE2 WHERE EMP_NAME = '�����'),
BONUS = (SELECT BONUS FROM EMPLOYEE2 WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE2
WHERE EMP_NAME IN('�����','����');

----------------------------------------------------------------------------------

-- 3. MERGE(����) (���� �ϼ���!)
-- ������ ���� �� ���� ���̺��� �ϳ��� ��ġ�� ���.
-- ���̺��� �����ϴ� ������ ���� �����ϸ� UPDATE
-- ������ ���� ������ INSERT��


CREATE TABLE EMP_M01
AS SELECT * FROM EMPLOYEE; -- EMPLOYEE�� ���� ����
CREATE TABLE EMP_M02
AS SELECT * FROM EMPLOYEE -- EMPLOYEE�� ���� ��������� JOB_CODE �� J4�ξָ� ���� ����
WHERE JOB_CODE = 'J4';
SELECT * FROM EMP_M01;
SELECT * FROM EMP_M02;
INSERT INTO EMP_M02
VALUES (999, '���ο�', '561016-1234567', 'kwack_dw@kh.or.kr',
'01011112222', 'D9', 'J4', 'S1', 9000000, 0.5, NULL,
SYSDATE, NULL, DEFAULT);
SELECT * FROM EMP_M01; -- 23��
SELECT * FROM EMP_M02; -- 5��(����4�� + �ű� 1��)
						-- (������, �ӽ�ȯ, ���߼�, ������) + ���ο�
UPDATE EMP_M02 SET SALARY = 0;
SELECT * FROM EMP_M02;
ROLLBACK;
MERGE INTO EMP_M01 USING EMP_M02 ON(EMP_M01.EMP_ID = EMP_M02.EMP_ID)
WHEN MATCHED THEN
UPDATE SET
EMP_M01.EMP_NAME = EMP_M02.EMP_NAME,
EMP_M01.EMP_NO = EMP_M02.EMP_NO,
EMP_M01.EMAIL = EMP_M02.EMAIL,
EMP_M01.PHONE = EMP_M02.PHONE,
EMP_M01.DEPT_CODE = EMP_M02.DEPT_CODE,
EMP_M01.JOB_CODE = EMP_M02.JOB_CODE,
EMP_M01.SAL_LEVEL = EMP_M02.SAL_LEVEL,
EMP_M01.SALARY = EMP_M02.SALARY,
EMP_M01.BONUS = EMP_M02.BONUS,
EMP_M01.MANAGER_ID = EMP_M02.MANAGER_ID,
EMP_M01.HIRE_DATE = EMP_M02.HIRE_DATE,
EMP_M01.ENT_DATE = EMP_M02.ENT_DATE,
EMP_M01.ENT_YN = EMP_M02.ENT_YN
WHEN NOT MATCHED THEN
INSERT VALUES (EMP_M02.EMP_ID, EMP_M02.EMP_NAME, EMP_M02.EMP_NO,
EMP_M02.EMAIL, EMP_M02.PHONE, EMP_M02.DEPT_CODE,
EMP_M02.JOB_CODE, EMP_M02.SAL_LEVEL, EMP_M02.SALARY,
EMP_M02.BONUS, EMP_M02.MANAGER_ID, EMP_M02.HIRE_DATE,
EMP_M02.ENT_DATE, EMP_M02.ENT_YN);
SELECT * FROM EMP_M01; -- EMP_M02���̺��� SALARY�� 0�� �� ���¿��� �� ������ ������ ���
-- ������, �ӽ�ȯ, ���߼�, ������ �� SALARY �� 0���� ��ȸ��

----------------------------------------------------------------------------------------------------------------

--DELETE 
--���̺��� '��'�� �����ϴ� ����
--���̺� ������ DROP���� ��

--[�ۼ���]
--DELETE FROM ���̺�� WHERE ���Ǽ���
--���࿡ WHERE ������ �������� ������ ��� ���� ������

--EMPLOYEE2 ���̺��� ��ä��
COMMIT;

SELECT * FROM EMPLOYEE2 
WHERE EMP_NAME = '��ü��';

DELETE FROM EMPLOYEE2  WHERE EMP_NAME = '��ü��';

ROLLBACK;

SELECT * FROM EMPLOYEE2 e ; --���ǹ� �ۼ� ���ϸ� ��ü �� ����

DELETE FROM EMPLOYEE2;

------------------------------------------------------------------

--5. TRUNCATE(DDL �Դϴ�. DML �ƴ�)
-- ���̺��� ��ü �� �����ϴ� DDL
-- DELETE ���� ����ӵ��� �� ������
-- ROLLBACK�� ���ؼ� ������ �� ����.

--TRUNCATE �׽�Ʈ�� ���̺� ����

CREATE TABLE EMPLOYEE3
AS SELECT * FROM EMPLOYEE2;

SELECT * FROM EMPLOYEE3;

--DELETE �� ��� ������ ����(��������)
DELETE FROM EMPLOYEE3;
ROLLBACK;

--DTRUNCATE�� ��� ������ ����(�����Ұ���)
TRUNCATE TABLE EMPLOYEE3;
ROLLBACK;