/*
 * -������ ��ųʸ�
 * 
 * �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
 * ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
 * �۾��� �� �� ������ ���̽� ������ ���� �ڵ����� ���ŵǴ� ���̺�
 * 
 * 
 */


---------------------------------------------------------------------------------


--DQL(DATA QUERY LANGUAGE) : ������ ����(��ȸ) ���

--DML(DATA MANIPULATION LANGUAGE) : ������ ���� ���
--���̺� �����͸� ����, ����, �����ϴ� ���

--TCL(TRANSACTION CONTROL LANGUAGE) : Ʈ����� ���� ���, DML ���� ������ COMMIT, ROLLBACK�ϴ� ���

--DDL(DATA DEFINITION LANGUAGE) : ������ ���� ���
--��ü(OBJECT)�� �����(CREATE), ����(ALTER)�ϰ�, ����(DROP) �� 
--�������� ��ü ������ �����ϴ� ���� �ַ� DB������, �����ڰ� �����

--����Ŭ������ ��ü : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
--					  �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER)
--					  ���ν���(PROCEDURE), �Լ�(FUNCTION)
--					  ���Ǿ�(SYNOMYM), �����(USER)

-----------------------------------------------------------------------------------------

--CREATE
--���̺��̳� �ε���,�� �� �پ��� �����ͺ��̽� ��ü�� �����ϴ� ����
--���̺�� ������ ��ü�� DROP ������ ���� ������ �� �֤���

--1.���̺� �����ϱ�
--���̺��̶� ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽�
--�����ͺ��̽� ������ ��� �����ʹ� ���̺��� ���ؼ� ����ȴ�.

--[ǥ����]

/*
 * CREATE TABLE ���̺�� (
 * 		�÷��� �ڷ���(ũ��)
 * 		�÷��� �ڷ���(ũ��)
 * 			...
 * 			...
 * )
 */


/*
 * �ڷ���
 * NUMBER : ������(����,�Ǽ�)
 * CHAR(ũ��) : �������� ������(2000BYTE)
 * EX) CHAR(10) �÷��� 'ABC' 3BYTE ���ڿ��� �����ص� 10BYTE ��������� ��� ���.
 * VARCHAR2(ũ��) : �������� ������(4000BYTE)
 * EX) VARCHAR2(10) �÷��� ' ABC' 3BYTE ���ڿ��� �����ϸ� ������ 7BYTE�� ��ȯ��.
 * 
 *DATE : ��¥ Ÿ��
 *BLOB : ��뷮 ���� ������(4GB)
 *CLOB : ��뷮 ���� ������(4GB)
 * 
 */


CREATE TABLE MEMBER (
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_SSN CHAR(14),
	ENROLL_DATE DATE DEFAULT SYSDATE
	);
	
--SQL �ۼ��� : �빮�� �ۼ� ����, ����� �ܾ� ���̿��� "_"(�����) ���
--���� ���ڵ� UTF-8 : ����,���� 1BYTE, �ѱ�, Ư������ ���� 3BYTE ���

--���� ���̺� Ȯ��
SELECT * FROM "MEMBER";


--2. �÷��� �ּ� �ޱ�
--[ǥ����]
--COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD  IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME  IS 'ȸ�� �̸�';
COMMENT ON COLUMN MEMBER.MEMBER_SSN  IS 'ȸ�� �ֹι�ȣ';
COMMENT ON COLUMN MEMBER.ENROLL_DATE  IS 'ȸ�� ������';

-- USER_TABLES : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��
SELECT * FROM USER_TABLES;


-- MEMBER ���̺��� ���� ������ ����
-- INSERT INTO ���̺�� VALUES(��1,��2....);

INSERT INTO "MEMBER"  VALUES('MEM01','12345ABC','ȫ�浿','991213-1234567',DEFAULT);

--INSERT/UPDATE �� �÷������� DEFAULT�� �ۼ��ϸ�
--���̺� ���� �� �ش� �÷��� ������ DEFAULT ������ ������ �ȴ�.

SELECT * FROM "MEMBER";

INSERT INTO "MEMBER"  VALUES('MEM02','22345ABC','����','201213-1234567',SYSDATE);
INSERT INTO "MEMBER"  VALUES('MEM03','32345ABC','����','211213-1234567',DEFAULT);

COMMIT;


--INSERT�� ���ۼ� �ϴ� ���(������) DEFAULT ���� �ݿ���
INSERT INTO "MEMBER"(MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES('MEM04','3456ABC','������');

-- ** JDBC���� ��¥�� �Է¹޾��� �� �����ϴ� ��� **
-- '2023-01-13 10:33:27'
INSERT INTO "MEMBER" VALUES('MEM05','PASS05','���ؼ�','121212-1234567',
			TO_DATE('2023-01-13 10:33:27','YYYY-MM-DD HH24:MI:SS')
);

--MEMBER2 ���̺�(���̵�, ��й�ȣ, �̸�, ��ȭ��ȣ)

CREATE TABLE MEMBER2(
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_TEL NUMBER
);

INSERT INTO MEMBER2 VALUES('MEM01','PASS01','������', 7712341234);
INSERT INTO MEMBER2 VALUES('MEM02','PASS02','������', 01012341234);
-- NUMBERŸ�� �÷��� ������ ���Խ�
--���� �տ� 0�� ������ �ڵ����� ������
-->��ȭ��ȣ,�ֹε�Ϲ�ȣó�� ���ڷθ� �Ǿ��մ� ����������
--0���� ������ ���ɼ��� ������ CHAR,VARCHAR2���� ������ ���


SELECT *FROM MEMBER2;

--------------------------------------------------------------------------------------

--��������(CONSTRAINTS)
/*
 * ����ڰ� ���ϴ� ������ �����͸� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
 * ������ ���Ἲ ������ �������� ��.
 * -->�ߺ�������X
 * 
 * +�Է� �����Ϳ� ������ ������ �ڵ����� �˻��ϴ� ����
 *
 *  +�������� ����/���� ���� ���� �˻���� �������� ��
 * -->���������� �����ϴ� DML������ ������ �� ����
 * �������� ����
 * PRIMARY KEY, UNIQUE , NOT NULL, CHECK, FOREIGN KEY
 *
 */

--USER_CONSTRAINTS : ����ڰ� ���ۼ��� ���������� Ȯ���ϴ� ��ųʸ� ��
SELECT *FROM USER_CONSTRAINTS;

--1.NOT NULL
--�ش� �÷��� �ݵ�� ���� ��ϵǾ�� �ϴ� ��쿡 ���
--����/���� �� NULL���� ������� �ʵ��� �÷��������� ����

--�÷����� : ���̺� ���� �� �÷��� �����ϴ� �κп� �ۼ��ϴ� ��

CREATE TABLE USER_USED_NN(
	USER_NO NUMBER NOT NULL, --����� ��ȣ(��� ����ڴ� ����� ��ȣ�� �־���Ѵ�)
							 -->�÷� ���� ���� ���� ����
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR(50)
);

INSERT INTO USER_USED_NN
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONG123@kh.or.kr');

INSERT INTO USER_USED_NN
VALUES(NULL,NULL,NULL,'ȫ�浿','��','010-1234-1234','HONG123@kh.or.kr');
--ORA-01400: NULL�� ("KH"."USER_USED_NN"."USER_NO") �ȿ� ������ �� �����ϴ�
--> NOT NULL �������ǿ� ����Ǿ� ���� �߻�
SELECT * FROM USER_USED_NN;

------------------------------------------------------------------------------------------------------

-- 2. UNIQUE ���� ����
-- �÷��� �Է°��� ���ؼ� �ߺ��� �����ϴ� ��������
-- �÷��������� ���� ����, ���̺� �������� ���� ����
-- ��,UNIQUE ���������� ������ �÷��� NULL ���� �ߺ����� ���� ����

--* ���̺� ���� : ���̺� ������ �÷� ���ǰ� ���� �� �������� �ۼ�

--* �������� ���� ���
--1) �÷� ���� : [CONSTRAINT �������Ǹ�] ��������
--2) ���̺� ���� : [CONSTRAINT �������Ǹ�] ��������(�÷���)

CREATE TABLE USER_USED_UK(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20) UNIQUE, --�÷�����
	--USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR(50)
	--���̺� ����
	--CONSTRAINT USER_ID_U UNIQUE(USER_ID) --���̺� �������� �������� ����
	);
--ORA-02261: ���� Ű �Ǵ� �⺻ Ű�� �̹� �����ϰ� �ֽ��ϴ�

SELECT *FROM USER_USED_UK;

INSERT INTO USER_USED_UK
VALUES(1,NULL,'PASS01','ȫ�浿','��','010-1234-1234','HONG123@kh.or.kr');
-->���̵� NULL�� ���� ����


---------------------------------------------------------------------------------------------------------

-- UNIQUE ����Ű
-- �ΰ� �̻��� �÷��� ��� �ϳ��� UNIQUE ���� ������ ������

--*����Ű ������ ���̺� ���������� �����ϴ�
--*����Ű�� ������ ��� �÷��� ���� ���� �� ������


CREATE TABLE USER_USED_UK2(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR(50),
	--���̺� ���� UNIQUE ����Ű ����
	CONSTRAINT USER_ID_NAME_U UNIQUE(USER_ID, USER_NAME)
	);

INSERT INTO USER_USED_UK2
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONG123@kh.or.kr');

INSERT INTO USER_USED_UK2 
VALUES(1,'USER02','PASS01','ȫ�浿','��','010-1234-1234','HONG123@kh.or.kr');

INSERT INTO USER_USED_UK2 
VALUES(1,'USER03','PASS01','��浿','��','010-1234-1234','HONG123@kh.or.kr');

--�Ȱ��� �̸�,���̵� ������
--ORA-00001: ���Ἲ ���� ����(KH.USER_ID_NAME_U)�� ����˴ϴ�

SELECT *FROM USER_USED_UK2;

------------------------------------------------------------------------------------------------------------------------

--3. PRIMARY KEY(�⺻Ű) ��������

--���̺��� �� ���� ������ ã������ ����� �÷��� �ǹ�
--���̺� ���� �ĺ���(�й�, ȸ����ȣ ��) ������ ��

-- NOT NULL + UNIQUE ���������� �ǹ� --> �ߺ����� �ʴ� ���� �ʼ��� ����
-- �� ���̺�� �� ���� ������ �� ����.
-- �÷�����,���̺��� �� �� ��������

CREATE TABLE USER_USED_PK(
	USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY, --�÷�����
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR(50)
	--���̺� ����
	--CONSTRAINT USER_NO_PK PRIMARY KEY(USER_NO)
	);

INSERT INTO USER_USED_PK
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONG123@kh.or.kr');

INSERT INTO USER_USED_PK
VALUES(2,'USER02','PASS02','����','��','010-1534-1234','TEST123@kh.or.kr');
--ORA-00001: ���Ἲ ���� ����(KH.USER_ID_NAME_U)�� ����˴ϴ�

INSERT INTO USER_USED_PK
VALUES(NULL,'USER02','PASS02','����','��','010-1534-1234','TEST123@kh.or.kr');
--�⺻Ű�� NULL�̹Ƿ� ����
--ORA-01400: NULL�� ("KH"."USER_USED_PK"."USER_NO") �ȿ� ������ �� �����ϴ�

SELECT *FROM USER_USED_PK;

----------------------------------------------------------------------------------------------------------

--4.FOREING KEY(�ܺ�Ű/�ܷ�Ű) ��������
--������ �ٸ� ���̺��� �÷��� �����ϴ� ���� ����� �� ����
--FOREIGN KEY �������ǿ� ���ؼ� ���̺��� ���谡 ������.
--�����Ǵ� �� �ܿ��� NULL ����� �� ����

--�÷������ϰ��
--�÷��� �ڷ���(ũ��) [CONSTRAINT �̸�] REFERENCES ������ ���̺�� [(�������÷�)] [������]

--���̺��� ���
--[CONSTRAINT �̸�] FOREIGN KEY (������ �÷���) REFERENCES ������ ���̺�� [(�������÷�)] [������]
 

CREATE TABLE USER_GRADE(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10,'�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20,'���ȸ��');
INSERT INTO USER_GRADE VALUES(30,'Ư��ȸ��');

SELECT *FROM USER_GRADE;

CREATE TABLE USER_USED_FK(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRACE_CODE_FK REFERENCES USER_GRADE 
	--�÷��� ���ۼ��� USER_GRADE ���̺��� PK�� �ڵ� ����
);



SELECT *FROM USER_USED_FK;

COMMIT;

INSERT INTO USER_USED_FK
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONH@tes.com', 10);

INSERT INTO USER_USED_FK
VALUES(2,'USER02','PASS02','��浿','��','010-3234-1234','EDH@tes.com', 20);

INSERT INTO USER_USED_FK
VALUES(3,'USER03','PASS03','�쵿','��','010-5534-1254','WOO@tes.com', 30);

INSERT INTO USER_USED_FK
VALUES(4,'USER04','PASS04','����','��','010-1774-6634','NU@tes.com', NULL);

INSERT INTO USER_USED_FK
VALUES(5,'USER05','PASS05','����','��','010-4774-4634','NA@tes.com', 40);
--ORA-02291: ���Ἲ ��������(KH.GRACE_CODE_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
--40�̶�� ���� USER_GRADE���̺��� GRADE_CODE �÷����� �����ϴ� ���� �ƴϹǷ�
--�ܷ�Ű �������ǿ� ����Ǿ� ���� �߻�

COMMIT;

-----------------------------------------------------------------------------------------------------------------

--FOREING KEY �����ɼ�
--�θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����͸� 
--������� ó�������� ���� ������ ������ �� �ִ�

SELECT *FROM USER_GRADE;
SELECT *FROM USER_USED_FK;

--1) ON DELETE  RESTPICTED(���� ����)�� �⺻ �����Ǿ� ����
--FOREIGN KEY�� ������ �÷����� ���ǰ� �ִ� ���� ���
--�����ϴ� �÷��� ���� �������� ����

DELETE FROM USER_GRADE WHERE GRADE_CODE = 30;
--ORA-02292: ���Ἲ ��������(KH.GRACE_CODE_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�

UPDATE USER_USED_FK SET GRADE_CODE =30
WHERE GRADE_CODE = 20;

--GRADE_CODE �� 20�� �ܷ�Ű�� �����ǰ� ���� �����Ƿ� ���� ������
DELETE FROM USER_GRADE WHERE GRADE_CODE =20;

ROLLBACK;

--2) ON DELETE SET NULL : �θ�Ű ���� �� �ڽ�Ű�� NULL�� �����ϴ� �ɼ�

CREATE TABLE USER_GRADE2(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR(30) NOT NULL
);
INSERT INTO USER_GRADE2 VALUES(10,'�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20,'���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30,'Ư��ȸ��');

SELECT *FROM USER_GRADE2 ;

CREATE TABLE USER_USED_FK2(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRACE_CODE_FK2 REFERENCES USER_GRADE2 ON DELETE SET NULL
);


INSERT INTO USER_USED_FK2
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONH@tes.com', 10);

INSERT INTO USER_USED_FK2
VALUES(2,'USER02','PASS02','��浿','��','010-3234-1234','EDH@tes.com', 10);

INSERT INTO USER_USED_FK2
VALUES(3,'USER03','PASS03','�쵿','��','010-5534-1254','WOO@tes.com', 30);

INSERT INTO USER_USED_FK2
VALUES(4,'USER04','PASS04','����','��','010-1774-6634','NU@tes.com', NULL);

SELECT *FROM USER_USED_FK2;

COMMIT;

--�θ����̺��� USER_GRADE2���� GRADE_CODE = 10 ����

DELETE FROM USER_GRADE2  
WHERE GRADE_CODE = 10;


-------------------------------------------------------------------------------------------------------------------

--3) ON DELETE CASCADE : �θ�Ű ������ �ڽ�Ű�� �Բ� ������


CREATE TABLE USER_GRADE3(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR(30) NOT NULL
);
INSERT INTO USER_GRADE3 VALUES(10,'�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20,'���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30,'Ư��ȸ��');

SELECT *FROM USER_GRADE3 ;

--ON DELETE CASCASE ���� �ɼ��� ����� ���̺� ����
CREATE TABLE USER_USED_FK3(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER,
	CONSTRAINT GRADE_CODE_FK3 FOREIGN KEY(GRADE_CODE)
	REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);


INSERT INTO USER_USED_FK3
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONH@tes.com', 10);

INSERT INTO USER_USED_FK3
VALUES(2,'USER02','PASS02','��浿','��','010-3234-1234','EDH@tes.com', 10);

INSERT INTO USER_USED_FK3
VALUES(3,'USER03','PASS03','�쵿','��','010-5534-1254','WOO@tes.com', 30);

INSERT INTO USER_USED_FK3
VALUES(4,'USER04','PASS04','����','��','010-1774-6634','NU@tes.com', NULL);

COMMIT;

SELECT *FROM USER_USED_FK3;
SELECT *FROM USER_GRADE3;

--�θ� ���̺� USER_GRADE3���� GRADE_CODE = 10 ����

DELETE FROM USER_GRADE3 
WHERE GRADE_CODE =10;


--------------------------------------------------------------------------------

--5. CHECK ���� ���� : �÷��� ��ϵǴ� ���� ������ ���� �� �� ����
--CHECK(�÷��� �񱳿����� �񱳰�)
--���� : �񱳰��� ���ͷ��� ����� �� ����, ���ϴ� �� or �Լ� ��� ����


CREATE TABLE USER_USED_CHECK(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10)CONSTRAINT GENDER_CHECK CHECK(GENDER IN ('��','��')),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
);

INSERT INTO USER_USED_CHECK
VALUES(1,'USER01','PASS01','ȫ�浿','��','010-1234-1234','HONG@TEST.COM');

SELECT * FROM USER_USED_CHECK;

INSERT INTO USER_USED_CHECK
VALUES(1,'USER01','PASS01','ȫ�浿','����','010-1234-1234','HONG@TEST.COM');
--���� �ƴ� ���ڶ�� �ؼ� ���� �߻�

CREATE TABLE USER_TEST (
	USER_NO NUMBER CONSTRAINT PK_USER_TEST PRIMARY KEY,
	USER_ID VARCHAR(20) CONSTRAINT UK_USER_ID UNIQUE,
	USER_PWD VARCHAR(30) CONSTRAINT NN_USER_PWD NOT NULL,
	PNO VARCHAR2(14) CONSTRAINT  UK_PNO UNIQUE,
	GENDER VARCHAR2(10)CONSTRAINT CK_GENDER CHECK(GENDER IN('��','��')),
	PHONE VARCHAR2(30),
	ADDRESS VARCHAR2(30),
	STATUS VARCHAR2(10) DEFAULT 'N' CONSTRAINT 
	CONSTRAINT CK_STATUS CHECK(STATUS IN('Y','N')
	
);












---------------------------------------------------------------------------------------------
--6.SUBQUERY�� �̿��� ���̺� ������
--�÷���,������Ÿ��,���� ����ǰ�,���������� NOT NULL�� �����

--1)���̺� ��ü ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT*FROM EMPLOYEE;
--���������� ��ȸ����� ����� ���̺��� ������

--2)JOIN �� ���ϴ� �÷��� ���̺�� ����
CREATE TABLE EMPLOYEE_COPY2
AS 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-->���������� ���̺� ���� �� 
--���̺��� ����(�÷���,������Ÿ��) + NOT NULL �������Ǹ� ����
-- ��������,�ڸ�Ʈ�� ������� �ʱ� ������ ���� �߰� �۾��� �ʿ��ϴ�

-------------------------------------------------------------------------------

--ALTER 

SELECT *
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'EMPLOYEE_COPY';



ALTER TABLE EMPLOYEE_COPY ADD CONSTRAINT PK_EMP_COPY PRIMARY KEY(EMP_ID);

ALTER TABLE EMPLOYEE_COPY ADD CONSTRAINT EMP_DEPT_CODE FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT ON DELETE SET NULL;

ALTER TABLE EMPLOYEE_COPY ADD CONSTRAINT EMP_JOB_CODE FOREIGN KEY(JOB_CODE) REFERENCES JOB ON DELETE SET NULL;




