/* SELECT (DQL �Ǵ� DML) : ��ȸ
 * 
 * 
 * �����͸� ��ȸ�ϸ� ���ǿ� �´� ����� ��ȸ��.
 * �� ��, ��ȸ�� ����� ������ RESULT SET �̶�� �Ѵ�.
 * RESULT SET�� 0�� �̻��� ���� ������ �� �ִ�.
 * 0���� ������ ���ǿ� �´� ���� �������� �ֱ� �����̴�.
 *
 */
 
  -- �ۼ���
-- SELECT �÷��� FROM ���̺��;
-- � ���̺��� Ư�� �÷��� ��ȸ�ϰڴ�.
SELECT * FROM EMPLOYEE;
-- '*' : ���,ALL�̶� ��

--���,�����̸�,�޴���ȭ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

------------------------------------------------

--�÷� �� ��� ����
--�÷� �� : ���̺� �� �� ĭ(== �� ��)�� �ۼ��� ��(DATA)
--EMPLOYEE ���̺��� ��� ����� �纯,�̸�,�޿�,����(�޿�*12) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY*12 FROM EMPLOYEE;
SELECT EMP_NAME + 10 FROM EMPLOYEE;
--ORA-01722 : ��ġ�� �������մϴ�
-- ��������� ���ڸ� �����ϴ�

--��¥(DATE) Ÿ�� ��ȸ
--EMPLOYEE ���̺��� �̸�,�Ի���,���ó�¥ ��ȸ

SELECT EMP_NAME, HIRE_DATE, SYSDATE  FROM EMPLOYEE;
  
  --SYSDATE : �ý��ۻ��� ����ð��� ��Ÿ���� ���

-- ���� �ð��� ��ȸ�ϱ�
SELECT SYSDATE FROM DUAL;
--DUAL(DUmmy tAbLe) ���̺� : ��¥ ���̺�(�ӽ� ��ȸ�� ���̺�)
--��¥ + �������(+,-)
SELECT SYSDATE  -1,SYSDATE ,SYSDATE +1 FROM DUAL;
--SKFwkDP +/- ���� �� �� ������ ����� �����



-------------------------------------

--<�÷� ��Ī ����>
--SELECT ��ȸ ����� ������ RESULT SET�� ��µǴ� �÷����� �����Ѵ�
-- AS ��������
-- ���Ⱑ �ִ� ��Ī�� �ֵ���ǥ�� �����ֱ� + Ư�����ڵ�
SELECT SYSDATE  -1 "�Ϸ� ��",SYSDATE AS ����ð� ,SYSDATE +1 ����
FROM DUAL;

----------------------------------------------------
 --JAVA���� ���ͷ� = �� ��ü
 --DB���� ���ͷ� = ���Ƿ� ������ ���� ���� ���̺� �����ϴ� ��ó�� ����ϴ� ��
-- > DB�� ���ͷ� ǥ����� '' 
--> " " �ֵ���ǥ�� Ư������,��ҹ���,��ȣ ���� �����Ͽ� ��Ÿ�� �� ����ϴ� ǥ���
-- �ֵ���ǥ �ȿ� �ۼ��Ǵ� �͵��� �ϳ��� �ܾ��̴�.
SELECT EMP_NAME, SALARY, '�� �Դϴ�' FROM EMPLOYEE;


-----------------------------------------------------------------
--DISTINCT : ��ȸ �� Į���� ���Ե� �ߺ� ���� �� ���� ǥ��
--���ǻ��� 1) DISTINCT ������ SELECT ���� �� �ѹ����� �ۼ� ����
--���ǻ��� 2) DISTINCT ������ SELECT ���� �տ� �ۼ��Ǿ�� �Ѵ�.

SELECT DISTINCT DEPT_CODE, JOB_CODE  FROM EMPLOYEE;

-------------------------------------------------------------
--3. SELECT �� : SELECT  �÷���
--1. FROM  �� : FROM ���̺��
--2. WHERE ��(������) : WHERE �÷��� ������ ��;
--4. ORDER BY �÷��� | ��Ī | �÷����� [ASC(��������,�⺻��) | DESC(��������)] , [NULLS FIRST | LAST]

--EMPLOYEE ���̺��� �޿��� 300���� �ʰ��� �����ȸ

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;

--EMPLOYEE ���̺��� �μ��ڵ� D9�� ����� ���,�̸�,�μ��ڵ�,�����ڵ� ��ȸ
SELECT  EMP_NAME,EMP_ID ,DEPT_CODE ,JOB_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';  --�񱳿����� = , ���Կ����� :=

--�� ������  >, <. >=, <=, =, !=, <>(�����ʴ�)
--�� ������ (AND, OR)
-- EMPLOYEE ���̺��� �޿��� 300�̸� �Ǵ� 500�̻��� ����� ��� �̸� �޿� ��ȭ��ȣ ��ȸ

SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- EMPLOYEE ���̺��� �޿��� 300�̻�  500�̸��� ����� ��� �̸� �޿� ��ȭ��ȣ ��ȸ

SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY >= 3000000 AND SALARY < 5000000;

--BETWEEN A AND B : A�̻� B����

SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000;

--NOT ������
SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 6000000;

--��¥�� BETWEEN �̿��ϱ�
--EMPLOYEE ���̺��� �Ի����� 1990-01-01~ 1999-12-31 ������ ������ �̸� �Ի��� ��ȸ

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01' AND '1999-12-31';

--ex) 1 = '1'
SELECT '����'
FROM DUAL
WHERE 1 = '1';
------------------------------
--LIKE : ~ó��,~����
--���Ϸ��� ���� Ư���� ������ ������Ű�� ��ȸ�ϴ� ������
--[�ۼ���]
--WHERE �÷��� LIKE '������ ����� ��'

--LIKE�� ������ ��Ÿ���� ����(���ϵ� ī��)
--> '%' : ����
--> '_' : ���� ��
--'%' ����
--'A%' : A�� �����ϴ� ���ڿ�
--'%A' : A�� ������ ���ڿ�
--'%A%' : A�����ϴ� ���ڿ�

--'_'����
--'A_' : A�� �����ϴ� �α��� ���ڿ�
--'___A' : A�� ������ �ױ��� ���ڿ�
--'__A__' : �� ���� ���ڰ� A�� �ټ����� ���ڿ�
--'_____' : �ټ����� ���ڿ�

--EMPLOYEE���̺��� ����'��'���� ����� ��� �̸� ��ȸ
SELECT EMP_NAME,EMP_ID
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��__';   --��% �� ����(�̸��� 2~4������ ����� ��ȸ�����ϱ� ������ �̰� �� ����)

--EMPLOYEE ���̺��� ��ȭ��ȣ�� 010���� �������� �ʴ� ����� ��� �̸� ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_ID, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '%010%';

--sun_di@or.kr
--EMPLOYEE ���̺��� �̸����� _�տ� ���ڰ� �������� ��� ��ȸ
--#,^ �� ���� ��.(ESCAPE ����)
-- ESCAPE ���� �ڿ� �ۼ��� _�� �Ϲ� ���ڷ� Ż�� �Ѵٴ� ��
SELECT EMP_NAME,EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--EMPLOYEE���̺��� �̸��� '_' ���� �ױ��� �̸鼭 �μ��ڵ尡 'D9' �Ǵ� 'D6' �̰� �Ի����� 1990-01-01 ~2000-12-31 �����̰� �޿��� 270�̻���
--����� ��� �̸� �̸��� �μ��ڵ� �Ի��� �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL,DEPT_CODE ,HIRE_DATE,SALARY
FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%' ESCAPE '#' 
AND (DEPT_CODE ='D9'OR DEPT_CODE ='D6') 
AND HIRE_DATE BETWEEN '1990-01-01' AND '2000-12-31' 
AND SALARY > 2700000;

--������ �켱����

/*
 * 1. ��� ������ (+ - * /)
 * 2. ���� ������ ( || )
 * 3. �� ������ ( > < >= <= = != <> )
 * 4. IS NULL / IS NOT NULL , LIKE, IN / LOT IN
 * 5. BETWEEN AND / NOT BETWEEN AND
 * 6.NOT(�� ������)
 * 7.AND(�� ������)
 * 8.OR(�� ������)
 *  
 */
 
--------------------------------------------------------------

/* IN ������
 * 
 * ���Ϸ��� ���� ��Ͽ� �ۼ��� �� ��
 * ��ġ�ϴ� ���� ������ ��ȸ�ϴ� ������
 * 
 * �ۼ���
 * WHERE �÷��� IN(��1,��2,��3....)
 * 
 */

--EMPLOYEE ���̺���
--�μ��ڵ尡 D1,D6,D9�� ����� ��� �̸� �ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1','D6','D9');

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1','D6','D9')
OR DEPT_CODE IS NULL;
-- NULL���� �ֵ��� ���ԾȵǹǷ� OR�� NULL�ξֵ� ���� ���Խ����ֱ�

--IS NULL , IS NOT NULL

---------------------------------------------------------------------

--NULL ó�� ������

--JAVA���� NULL : �����ϴ� ��ü�� ������ �ǹ��ϴ� ��
--DB���� NULL : �÷��� ���� ������ �ǹ��ϴ� ��

--1)IS NULL : NULL�� ��� ��ȸ
--2)IS NOT NULL : NULL�� �ƴ� ��� ��ȸ

--EMPOYEE ���̺��� ���ʽ��� �ִ� ����� �̸�,���ʽ� ��ȸ

SELECT EMP_NAME,BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

---------------------------------------------------------------

--ORDER BY ��
--EMPLOYEE ���̺꿡�� �޿� ������������ 

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
ORDER BY SALARY; -- ASC�� �⺻���̹Ƿ� ���� �Ƚ��൵��

--�޿� 200�� �̻��� ����� ��� �̸� �޿� ��ȸ
--�� �޿� ���������� ��ȸ

SELECT EMP_NAME,EMP_ID,SALARY
FROM EMPLOYEE
WHERE SALARY >= 2000000
ORDER BY SALARY  DESC; -- SALARY ��� 3 ���� SELECT���� SALARY�� 3��° �����Ƿ� (�÷������� �� ��)

--�Ի��� ������� �Ի��� ��ȸ(��Ī���)

SELECT EMP_NAME �̸� ,HIRE_DATE �Ի��� --��Ī�� �����༭
FROM EMPLOYEE
ORDER BY �Ի���;                      -- ��Ī�� �̿��� ��

--�μ��� �������� , �޿��� ��������

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC; -- ���� ��ø ',' ���� , ��з� ���� �� �Һз� ����


-------------------------------------------------


