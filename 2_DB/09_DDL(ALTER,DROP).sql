-- DDL (Data Definition Language)
-- ��ü�� �����(CREATE),�ٲٰ�(ALTER),����(DROP)�ϴ� ������ ���� ���
-- 
-- ALTER(�ٲٴ�,�����ϴ�)

-- ���̺��� ������ �� �ִ� ��
-- 1)���� ����(�߰�/����)
-- 2)�÷�(�߰�/����/����)
-- 3)�̸� ����(���̺��, �������Ǹ�, �÷���)


-------------------------------------------------------

--1.���� ����(�߰�/����)

--[�ۼ���]
--1) �߰� : ALTER TABLE ���̺��
-- 			ADD [CONSTRAINT �������Ǹ�] ��������(������ �÷���)
--			[REFERENCES ���̺��(�÷���)]; --< FK�� ��� �߰�


--2) ���� : ALTER TABLE ���̺��
--			DROP CONSTRAINT �������Ǹ�;

-->������ ���� �������� �ʱ� ������ ���� �� �߰��� �̿��ؼ� ����


--DEPARTMENT ���̺� ����(�÷���, ������Ÿ��, NOT NULL�� ����)

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;


SELECT * FROM DEPT_COPY;

-- DEPT_COPY�� DEPT_TITLE �÷��� UNIQUE �߰�

ALTER  TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_U UNIQUE(DEPT_TITLE);

--DEPT_COPY�� DEPT_TITLE�÷��� UNIQUE ����

ALTER TABLE DEPT_COPY
DROP CONSTRAINT DEPT_COPY_TITLE_U;


-- DEPT_COPY�� DEPT_TITLE �÷��� NOT NULL �������� �߰�/����

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_N NOT NULL(DEPT_TTILE);
--�������� �ĺ���

-->NOT NULL ���� ������ ���ο� ������ �߰��ϴ� ���� �ƴ�
-- �÷� ��ü�� NULL ���/������� �����ϴ� ���� ������ ���·� �νĵ�

--MODIFY(�����ϴ�) ������ ����ؼ� NULL ����

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE NOT NULL; --DEPT_TITLE �÷��� NOT NULL �������� �������� ����

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE NULL; --DEPT_TITLE �÷��� NOT NULL �������� ����


--------------------------------------------------------------------------

--2.�÷�(�߰�/����/����)


--�÷� �߰�
--ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ�� [DEFAULT '��'])

--�÷� ����
--ALTER TABLE ���̺�� MODIFY �÷��� ������Ÿ��; -> ������ Ÿ�� ����
--ALTER TABLE ���̺�� MODIFY �÷��� DEFAULT'��';-> DEFAULT �� ����
--ALTER TABLE ���̺�� MODIFY �÷��� NULL / NOT NULL -> NULL ���� ����

-- �÷� ����
-- ALTER TABLE ���̺�� DROP(������ �÷���);
-- ALTER TABLE ���̺�� DROP COLUMN ������ �÷���;
-- �ǹ̴� ������ ǥ����� �ٸ�


-->�÷� ���� �� ���ǻ���
-- ���̺��̶� ? ��� ���� �̷���� DB���� ���� �⺻���� ��ü��
-- 				���̺� �����Ͱ� �����.

-- ���̺��� �ּ� 1�� �̻��� �÷��� �����ؾ� �Ǳ� ������
-- ��� �÷��� �� ������ �� ����.


SELECT * FROM DEPT_COPY;

--CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD(CNAME VARCHAR2(30));

--LNAME �÷� �߰�,�⺻�� �ѱ�
ALTER TABLE DEPT_COPY ADD(LNAME VARCHAR2(30) DEFAULT'�ѱ�');
--�÷��� �����Ǹ鼭 DEFAULT ���� �ڵ� ���Ե�




-- D10 ���� 1�� �߰�
INSERT INTO DEPT_COPY
VALUES('D10','����1��','L1',DEFAULT,DEFAULT);
-- DEPT_IDũ�Ⱑ2�ε� D10�� 3�̶� ũ�Ⱑ �ȸ���
-- DEPT_ID �÷� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);

--LNAME�� �⺻���� 'KOREA'�� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
--�⺻���� �����ߴٰ� �ؼ� ���� �����Ͱ� �������� ����

--LNAME '�ѱ�' -> 'KOREA'�� ����
UPDATE  DEPT_COPY 
SET LNAME = DEFAULT
WHERE LNAME = '�ѱ�';

COMMIT;

--��� �÷� ����

ALTER TABLE DEPT_COPY DROP(LNAME);
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP(LOCATION_ID);
ALTER TABLE DEPT_COPY DROP(DEPT_TITLE);
ALTER TABLE DEPT_COPY DROP(DEPT_ID);
SELECT * FROM DEPT_COPY;
-- ���̺� ��� ������ ������ �� ����

--���̺� ����
DROP TABLE DEPT_COPY;


-------------------------------------------------
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
-->�÷���, ������Ÿ��, NOT NULL ���θ� ����ȴ�.

--DEPT_COPY ���̺� PK �߰�(�÷� : DEPT_ID, �������Ǹ� : D_COPY_PK)

ALTER TABLE DEPT_COPY
ADD CONSTRAINT D_COPY_PK PRIMARY KEY(DEPT_ID);

--3.�̸�����(���̺��, �÷���, �������Ǹ�)

--1) �÷��� ����(DEPT_TITLE -> DEPT_NAME)

ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;

--2) �������Ǹ� ����(D_COPY_PK -> DEPT_COPY_PK)

ALTER TABLE DEPT_COPY RENAME CONSTRAINT D_COPY_PK TO DEPT_COPY_PK;

--3) ���̺�� ����(DEPT_COPY -> DCOPY)
ALTER TABLE DEPT_COPY RENAME TO DCOPY;

SELECT * FROM DCOPY;


-------------------------------------------------------------------

--4. ���̺� ����

--DROP TABLE ���̺��[CASCADE CONSTRAINTS];

--1)���谡 �������� ���� ���̺�(DCOPY) ����
DROP TABLE DCOPY;

--2)���谡 ������ ���̺� ����
CREATE TABLE TB1(
	TB1_PK NUMBER PRIMARY KEY,
	TB1_COL NUMBER 
);

CREATE TABLE TB2(
	TB2_PK NUMBER PRIMARY KEY,
	TB2_COL NUMBER REFERENCES TB1 -- FK�������� �߰�
);

--TB1�� ���� ������ ����
INSERT INTO TB1 VALUES(1,100);
INSERT INTO TB1 VALUES(2,200);
INSERT INTO TB1 VALUES(3,300);

COMMIT;

--TB2�� ���� ������ ����
INSERT INTO TB2 VALUES(11,1);
INSERT INTO TB2 VALUES(22,2);
INSERT INTO TB2 VALUES(33,3);

SELECT * FROM TB1;
SELECT * FROM TB2;

--TB1 ����
DROP TABLE TB1;
--ORA-02449: �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�

--> �ذ���
--1) �ڽ�,�θ� ���̺� ������ ����
--2) ALTER�� �̿��ؼ� FK �������� ���� �� TB1 ����
--3) DROP TABLE �����ɼ� CASCADE CONSTRAINTS ���
--> CASCADE CONSTRAINTS : �����Ϸ��� ���̺�� ����� FK ���������� ��� ����

DROP TABLE TB1 CASCADE CONSTRAINTS;

------------------------------------------------------------------------------------

--DDL ���ǻ���
--1)DDL�� COMMIT/ROLLBACK�� ���� �ʴ´�.
--> ALTER,DROP�� �����ϰ� �ؾ���

--2)DDL�� DML������ ��� �����ϸ� �ȵȴ�
-->DDL�� ���� �� �����ϰ��ִ� Ʈ������� ��� DB�� ���� COMMIT��Ŵ
-->DDL�� ����� �� DML ������ ������ �� �ֵ��� ����

SELECT * FROM TB2;
COMMIT;

INSERT INTO TB2 VALUES(14,4);
INSERT INTO TB2 VALUES(15,5);

--�÷��� ���� DDL
ALTER TABLE TB2 RENAME COLUMN TB2_COL TO TB2_COLCOL;

ROLLBACK;
--ALTER��� DDL�� ����ؼ� ������ COMMIT �Ǿ� ������ ROLLBACK �ص� �ǵ��ư�������
