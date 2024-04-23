-- ���������� ���Ѻο��۾��� ����Ǿ��� ��� sqldb�������� �۾�
-- �н��� ������ �غ��۾�

-- 1��° ����
CREATE TABLE userTBL -- ȸ�� ���̺�
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- ����� ���̵�(PK)
  userName  	NVARCHAR2(10) NOT NULL, -- �̸�
  birthYear 	NUMBER(4) NOT NULL,  -- ����⵵
  addr	  	NCHAR(2) NOT NULL, -- ����(���,����,�泲 ������ 2���ڸ��Է�)
  mobile1	CHAR(3), -- �޴����� ����(010, 011, 016, 017, 018, 019 ��)
  mobile2	CHAR(8), -- �޴����� ������ ��ȭ��ȣ(����������)
  height    	NUMBER(3),  -- Ű
  mDate    	DATE  -- ȸ�� ������
);

-- 2��° ����
CREATE TABLE buyTBL -- ȸ�� ���� ���̺�
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- ����(PK)
   userID  	CHAR(8) NOT NULL, -- ���̵�(FK)
   prodName 	NCHAR(6) NOT NULL, --  ��ǰ��
   groupName 	NCHAR(4)  , -- �з�
   price     	NUMBER(8)  NOT NULL, -- �ܰ�
   amount    	NUMBER(3)  NOT NULL, -- ����
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);

-- 3��° ����
INSERT INTO userTBL VALUES('LSG', '�̽±�', 1987, '����', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '�����', 1979, '�泲', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '���ȣ', 1971, '����', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '������', 1950, '���', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '���ð�', 1979, '����', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '�����', 1963, '����', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '������', 1969, '�泲', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '������', 1972, '���', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '������', 1965, '���', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '00000000', 176, '2013-5-5');

-- 4��° ����
CREATE SEQUENCE idSEQ; -- ������ȣ �Է��� ���ؼ� ������ ����

-- 5��° ����
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '�����', '����', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�����', '����', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', 'û����', '�Ƿ�', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�޸�', '����', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', 'å'    , '����', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'û����', '�Ƿ�', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);

-- 6��° ����
COMMIT;

-- ������ Ȯ��
-- SELECT�� : ���̺� ����Ǿ� �ִ� ������ Ȯ��. ��ȸ ��ɾ�.
SELECT * FROM usertbl; -- 10�� ������
SELECT * FROM buytbl; -- 12�� ������

-- Ư���� ������ �����͸� ��ȸ : SELECT �÷���1, �÷���2 FROM ���̺�� WHERE ���ǽ�;
-- ����> �̸��� '���ȣ'�� �����͸� ��ȸ�϶�.
SELECT * FROM usertbl WHERE username = '���ȣ';
SELECT * FROM usertbl WHERE username = '������';

-- ����> ��������� 1970�� �̻�(����), Ű�� 182 �̻� ������ ��ȸ
SELECT * FROM usertbl WHERE birthyear >= 1970 AND height >= 182;

--> ����> ��������� 1970�� �̻��̰ų� Ű�� 182 �̻� ������ ��ȸ
SELECT * FROM usertbl WHERE birthyear >= 1970 OR height >= 182;

-- ����> Ű�� 180�̻��̸鼭 183������ �����͸� ��ȸ�϶�
SELECT * FROM usertbl WHERE height >= 180 AND height <= 183;
-- ������ ����
SELECT * FROM usertbl WHERE height BETWEEN 180 AND 183;

-- ����> �ּҰ� �泲�̰ų� ���� �Ǵ� ��� ������ ��ȸ
SELECT * FROM usertbl WHERE addr = '�泲' OR addr = '����' OR addr = '���';
-- ������ ����
SELECT * FROM usertbl WHERE addr IN ('�泲', '����', '���');

-- ���ڵ����� �÷��� ��� ��Ģ���� ����
SELECT * FROM buytbl;
-- �ֹ��ݾ��� ����Ͻÿ�.
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * AMOUNT AS TOT_PRICE FROM buytbl;
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * 1.3 AS TAX_INCLUDE FROM buytbl;

-- LIKE ���� ��Ī
-- ����> �̸� �� ���� '��'�� �����͸� ��ȸ %(���ϵ� ī�� ���� : ���̰� 0�� �̻��� ���ڿ�)
SELECT * FROM usertbl WHERE username LIKE '��%';

-- ����> ��ü �̸��� 3�����̸鼭, �������� ������ ������ ��ȸ _(���ϵ�ī�� ���� : ���̰� 1���� �ǹ�)
SELECT * FROM usertbl WHERE username LIKE '_����';



-- �� �� ����Ŭ ����Ŭ SQL�� PL/SQL�� �ٷ�� ��� https://thebook.io/006696/0063/


-- ����> ��� ���̺��� �޿��� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ
 SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id asc; --asc(��������)�� ����. order by�� �׻� �� �������� �����.

 SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id desc; --desc(��������) �����Ұ�.

-- �޿��� 5000 �̻��̰� job_id�� ��IT_PROG���� ����� ��ȸ�Ѵٸ�, AND �����ڿ� job_id�� �˻��ϴ� ����
SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'IT_PROG'
     ORDER  BY employee_id;

-- �����ʹ� ��ҹ��ڸ� �����Ѵ�. IT_PROG -> 'it_prog'
-- ��ҹ��� ���� ������ ����� ����.
SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'it_prog'
     ORDER  BY employee_id;

-- usertbl���̺��� ��������� ������������ �����϶�.
SELECT * FROM usertbl ORDER BY birthyear ASC;

-- usertbl���̺��� Ű�� ������������ �̸��� ������������ ����
SELECT * FROM usertbl ORDER BY height DESC, username ASC; -- Ű�� ������ ���� 2�� ������ ����.��������

-- ����> usertbl���� �ּҸ� ������������ ����
SELECT * FROM usertbl ORDER BY addr ASC;
SELECT addr FROM usertbl ORDER BY addr ASC;

-- �ߺ��� �����͸� 1���� ����� �������� ���� : DISTINCT
SELECT DISTINCT addr FROM usertbl ORDER BY addr ASC;

-- USERNAME �÷��� ADDR �÷��� ���ÿ� �����Ǵ� �����Ͱ� ���� �� DISTINCT ȿ���� ����.
SELECT DISTINCT USERNAME, ADDR FROM USERTBL ORDER BY ADDR ASC;


-- �� �� 2�� DB�� �����ϴ� ��ü ���캸��
-- �����ͺ��̽� ��ü�� �����ͺ��̽� ���� �����ϴ� ������ ���屸����� ��. (��, �ε���, �Լ�, ���)
-- �����ͺ��̽� ��ü �� ���� �����͸� �����ϰ� �ִ� ���� ���̺��̶�� ��.
-- 01. �����ͺ��̽� ��ü�� ���� 02. ���̺�

-- ���ڿ� ������Ÿ�� : CHAR, VARCHAR2, NCHAR, NVARCHAR2
CREATE TABLE ex2_1 (
    column1 char(10),
    column2 varchar2(10),
    column3 nvarchar2(10),
    column4 number
);

-- ������ ����  : INSERT INTO ���̺��(�÷���, �÷���) VALUES(��1, ��2);
INSERT INTO ex2_1(column1, column2) VALUES('ABC', 'abc');

-- LENGTH(COLUMN) : �÷��� �������� ���� ���
-- �÷��� ���� �������� ũ�⸦ Ȯ�� CHAR(10)�� VARCHAR2(10)�� ������
SELECT COLUMN1, LENGTH(COLUMN1), COLUMN2, LENGTH(COLUMN2) FROM EX2_1;

CREATE TABLE ex2_2 (
    COLUMN1 VARCHAR2(3), -- 3BYTE �ǹ�
    COLUMN2 VARCHAR2(3 BYTE),
    COLUMN3 VARCHAR2(3 CHAR) -- 3���ڰ� ����! ũ��� ������� �ѱ� �Ǵ� �����̵� 3���ڸ� �Է� ����
);

-- ����Ŭ �����ͺ��̽� �ý���
/*
    ������, Ư������ : 1BYTE ����
    �ѱ� : 3BYTE. ����Ŭ ��ġȯ�漳���� ���� ������̴�. 2BYTE�� ���� ����.
        �׷��� LENGTHB() ����Ͽ� Ȯ���� �ʿ���.
*/

-- �Լ� : LENGTHB() : B�� BYTE�ǹ�. �׷��� �Ű������� �����Ǵ� �������� BYTE���̸� ����.
SELECT LENGTHB ('A'), LENGTHB('1'), LENGTHB('*'), LENGTHB('��') FROM DUAL;
SELECT LENGTHB('�����') FROM DUAL; -- 9 BYTE

-- ������ ����. ���� ���ڿ� �����ʹ� ��ҹ��� ����. 'ABC'�� 'abc'�� �ٸ� ������.
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3) VALUES('abc', 'abc', 'abc');

-- ������ ��ȸ
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM EX2_2;

-- �ѱ۵����� ��ȸ
-- ORA-12899: value too large for column "SQLDB"."EX2_2"."COLUMN1" (actual: 9, maximum: 3)
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3) VALUES ('ȫ�浿', 'ȫ�浿', 'ȫ�浿');

-- ���� : COLUMN3�� VARCHAR2(3 CHAR)�̹Ƿ� �ѱ� 3�� ���ڸ� ������ ���Լ���
INSERT INTO ex2_2(COLUMN3) VALUES('ȫ�浿');

-- ������ ��ȸ
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM EX2_2;

-- ���� ������ Ÿ�� : NUMBER[(P, [s])]
CREATE TABLE EX2_3 (
    COL_INT     INTEGER,
    COL_DEC     DECIMAL,
    COL_NUM     NUMBER
    ); -- ��� ���������� NUMBER ������Ÿ������ ��ȯ�Ǿ� ��.
    
-- user_tab_cols �ý��� �� : ���̺��� �÷������� Ȯ���� �� 
SELECT column_id, column_name, data_type, data_length
    FROM user_tab_cols
    WHERE table_name = 'EX2_3' -- ���̺���� �����ͷ� ����� ��� �빮�ڷ� �Է�
    ORDER BY column_id;

-- ��¥ ������Ÿ�� : DATE - �� �������� ����. TIMESTAMP - �и������� �������� ����
CREATE TABLE EX2_5 (
    COL_DATE        DATE,
    COL_TIMESTAMP   TIMESTAMP
);

-- ��¥�� �����ͺ��̽� �Լ� : SYSDATE, SYSTIMESTAMP
-- �����ͻ���
INSERT INTO EX2_5(COL_DATE, COL_TIMESTAMP) VALUES(SYSDATE, SYSTIMESTAMP);
SELECT * FROM ex2_5;

-- �ó�����
/*
    ���̺�� : USERINFO
    �÷��� : �̸�(U_NAME), �ּ�(U_ADDR), ����ó(U_TEL), ����(U_AGE), �����(U_REG)
*/

CREATE TABLE USERINFO (
    U_NAME  VARCHAR2(50),
    U_ADDR  VARCHAR2(100),
    U_TEL   VARCHAR2(20),
    U_AGE   NUMBER,
    U_REG   DATE
);

INSERT INTO USERINFO(U_NAME, U_ADDR, U_TEL, U_AGE, U_REG)
    VALUES('����', '����� ����� ������α�', '010-7446-2309', 28, SYSDATE);

SELECT * FROM USERINFO;

-- LOB ������Ÿ��
-- LOB�� 'LARGE OBJECT'�� ���ڷ� ��뷮 �����͸� ������ �� �ִ� ������ Ÿ��

-- ���ڿ� ��뷮 �����ʹ� CLOB�� NCLOB, 4000BYTE���� ū ���ڿ������� ����
-- �׷��� �̹��� ������ ���� �����ʹ� BLOB
-- BFILE�� ���� ���������� �ƴ� �����ͺ��̽� �ܺο� �ִ� ���Ͽ� ���� ��������(�ش� ������ ����Ű�� ������)�� �����ϸ�
-- ���� ������ ������ ���� ���� �б⸸ ������.
CREATE TABLE SAMPLE_1 (
    COL1    VARCHAR2(50),
    COL2    CLOB
);

INSERT INTO sample_1(COL1, COL2) VALUES ('���޷�', '�ۿ�Ȱ�� ��������, �ѹݵ��� �ַ� ����');
INSERT INTO sample_1(COL1, COL2) VALUES ('������', '��Ǫ�������� �Ĺ��� ��ö�� ��� ���� �ǿ�� ������ �� ����');
INSERT INTO sample_1(COL1, COL2) VALUES ('����ȭ', '�ֶ��ٽĹ� ��ȯ�ڹ��� ����ȭ���� ���ػ���Ǯ');

-- ���� : ORDER BY COL1
SELECT * FROM sample_1 ORDER BY col1 ASC;

-- (����) ���� : ORDER BY COL2. LOB�� ���ı���� �������� ����.
SELECT * FROM sample_1 ORDER BY col2 ASC;

-- NULL : ���� ������ �ǹ���. ����Ʈ ���� NULL�̸�
-- ������ �������� ������ �ش� �÷��� NULL�� �����.
CREATE TABLE SAMPLE_2 (
    COL1 NUMBER NULL, -- NULL�� ��������.
    COL2 VARCHAR2(50) NOT NULL -- �ݵ�� �����͸� �����ؾ� ��.
);

-- ������ �Է�. ���� NOT NULL �� ������ �־�� ��.
INSERT INTO SAMPLE_2(COL1) VALUES (1);

-- ������ �Է�. COL1 �÷��� NULL����̱� ������ ���� ����.
INSERT INTO SAMPLE_2(COL2) VALUES ('�׽�Ʈ');

INSERT INTO SAMPLE_2(COL1, COL2) VALUES (1, '�׽�Ʈ2');

SELECT * FROM SAMPLE_2;

-- ����? DBMS ������ ���� NULL ó���� ���ݾ� �ٸ� �� �־�, �ǹ����� �����ͺ��̽��� ���� NULL ������ Ȯ���� ��.

--  ��������
-- NOT NULL : �ݵ�� ���� ����־�� ��.

CREATE TABLE EX2_6 (
    COL_NULL        VARCHAR2(10),
    COL_NOT_NULL    VARCHAR2(10) NOT NULL
    -- ����Ŭ ������ �ڵ����� SYS_C007042 �������ǰ�ü�̸� NOT NULL�� ����.
);

-- ������ ���� �� �÷����� ���� �� ��쿡�� ��� �÷����� �Է��Ѵٴ� �ǹ�
-- �Ʒ� �� ������ NULL������ ���� �߻� ORA-01400: cannot insert NULL into ("SQLDB"."EX2_6"."COL_NOT_NULL")
INSERT INTO EX2_6 VALUES('AA', ''); -- ''�� NULL�� �ؼ�. ����õ.
INSERT INTO EX2_6 VALUES('AA', NULL); -- ���� ����. ANSI-SQLǥ�ع���.

INSERT INTO EX2_6 VALUES('AA', 'BB'); -- (�÷���1, �÷���1)�� �����Ǿ� ����.
SELECT col_null, COL_NOT_NULL FROM EX2_6;

-- USER_CONSTRAINTS �ý��ۺ� : ���̺� �������� ������ Ȯ���ϴ� �뵵.
SELECT constraint_name, constraint_type, table_name, search_condition
    FROM user_constraints
    WHERE table_name = 'EX2_6';

-- UNIQUE
-- �ش� �÷��� ���� ���� �����ؾ� ��.(�ֹε�Ϲ�ȣ ��).
CREATE TABLE SAMPLE_3 (
    U_NAME      VARCHAR2(50)    NOT NULL,
    SSN         CHAR(14)    UNIQUE NOT NULL
    -- ����Ŭ ������ SYS_C007045 �������� ��ü�̸����� SSN�÷��� UNIQUE�������� ����
);

-- ������ �Է�
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('�����', '123456-1234567');
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('�����', '123456-1234567');

SELECT * FROM SAMPLE_3;

-- ���������� ���� �� ������ 1) �÷� �������� 2) ���̺� ���� ����
CREATE TABLE EX2_7 ( -- ���� �÷� ������ UNIQUE ���������� ����. ���̺� UNIQUE ���������� 3�� ����Ǿ� ����.
    COL_UNIQUE_NULL     VARCHAR2(10)  UNIQUE, -- �÷����� ����. NULL ���
    COL_UNIQUE_NNULL    VARCHAR2(10)  UNIQUE NOT NULL, --����Ŭ ������ UNIQUE�������� �̸��� �ڵ�����
    COL_UNIQUE          VARCHAR2(10),
    CONSTRAINT UNIQUE_NM1 UNIQUE(COL_UNIQUE) -- ���̺���� ����
);
-- , ���� �÷��� ���� �������� ��ɾ ������ �� �÷� ��������
-- ��ü���� �������� �ٶ󺸰� �������� ��ɾ ������ �� ���̺� ���� ����

-- ������ �Է�
INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- ù��° ����
INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- �� ��° ����
-- ORA-00001: unique constraint (SQLDB.SYS_C007047) violated

-- NULL�� �ߺ��� �˻翡 �ش�ǳ�? NULL�� �ߺ��� �˻翡 �� �ɸ�.
INSERT INTO EX2_7 VALUES('', 'BB', 'BB'); -- �� ��° ����, ''�� NULL
SELECT * FROM EX2_7;

INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); -- �� ��° ����
SELECT * FROM EX2_7;


INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); -- �ټ���° ����
-- ORA-00001: unique constraint (SQLDB.SYS_C007048) violated

-- ���̺� �÷��� �� �� �̻� ��� UNIQUE�������� �����ϱ�.(���� �÷�)
-- ���̺� ���� ���� ������ ����ؾ� �����÷��� UNIQUE ���������� ������ �� ����.
CREATE TABLE SAMPLE_5 (
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10),
    CONSTRAINT UNI_FIRST UNIQUE(COL1, COL2)
    -- �̷��� �ϸ� 4�� ���� �� ���� ��� �����ų �� ����.
);

INSERT INTO SAMPLE_5(COL1, COL2) VALUES(1, 'A'); -- ù ��° ����

INSERT INTO SAMPLE_5(COL1, COL2) VALUES(1, 'B'); -- ù ��° ����

INSERT INTO SAMPLE_5(COL1, COL2) VALUES(1, 'A'); -- ù ��° ����
-- �̷��� �� ���� ��� �� ��쿣, �������ǿ� ���� �����Ͱ� ���ÿ� �������� ������ ���� �߻�.

-- PRIMARY KEY : �⺻ Ű�̸� UNIQUE�� NOT NULL �Ӽ��� ���ÿ� ������ ����.

CREATE TABLE EX2_8 (
    COL1    VARCHAR2(10)    PRIMARY KEY, -- UNIQUE�� NOT NULL Ư¡
    COL2    VARCHAR2(10)
);

-- ������ �Է�

-- ORACLE INSERT��
INSERT INTO EX2_8 VALUES('', 'AA'); --ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")
-- ANSI-SQL INSERT��
INSERT INTO EX2_8 VALUES(NULL, 'AA');

INSERT INTO EX2_8 VALUES('AA', 'AA');

INSERT INTO EX2_8 VALUES('AA', 'AA'); --ORA-00001: unique constraint (SQLDB.SYS_C007051) violated

-- ����Ű ���̺� ��.
-- ���� �߻� 02260. 00000 -  "table can have only one primary key"
CREATE TABLE SAMPLE_6 (
    COL1    NUMBER          PRIMARY KEY,
    COL2    VARCHAR2(10)    PRIMARY KEY, -- PRIMARY KEY�� ���̺� �� �ϳ��� ������.
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10),
    UNIQUE(COL1, COL2)
);
-- ���̺� ���� �������� �ؾ� ��.
-- PRIMARY KEY �������� ��ü�̸��� ����Ŭ ������ �ڵ����� ��������.
-- �׷��� �������� ��ü �̸��� ���������� ����¡��� ���� �� ����� �� ��쿡�� �������� ��ü �̸��� �������� �����ؾ� ��(�߿�)
CREATE TABLE SAMPLE_7 (
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10),
    CONSTRAINT PK_SAMPLE_7_COL1_COL2 PRIMARY KEY(COL1, COL2)
);
-- ���� ���̺� PRIMARY KEY(����Ű) �������� COL1, COL2 �÷��� ���ÿ� �����ϴ� �����ʹ� �ߺ��� �� ����.
-- �������� �÷��� �ϳ��� �⺻Ű�� ����� ��� �ִ� �÷������� 32������ ������.

INSERT INTO sample_7(COL1, COL2) VALUES(12, 'AA');
INSERT INTO sample_7(COL1, COL2) VALUES(12, 'BB');
INSERT INTO sample_7(COL1, COL2) VALUES(12, 'AA');
INSERT INTO sample_7(COL1, COL2) VALUES(12, 'BB');

-- FOREIGN KEY : �ܷ�Ű, ���̺� ���� ���� ������ ���Ἲ�� ���� ��������

-- �μ� ���̺�
CREATE TABLE DEPT (
    D_CODE  NUMBER          PRIMARY KEY,
    D_NAME  VARCHAR2(20)    NOT NULL
);

-- ��� ���̺�
CREATE TABLE EMP (
    E_ID    NUMBER  PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER REFERENCES DEPT(D_CODE) -- �÷����� ����
);

CREATE TABLE EMP (
    E_ID    NUMBER  PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER,
    FOREIGN KEY(D_CODE) REFERENCES DEPT(D_CODE) -- ���̺� ���� ����
);

-- ���̺� ���� : �����޴� ���̺��� ���߿� �����ϰ� �����ϴ� ���̺��� ���� ����
DROP TABLE EMP;
DROP TABLE DEPT;

-- ���̺� ����Ű ������ ����� ���� Ȯ���ϱ�.
-- ���� - DATA MODELER - ������
-- ������ ������������ ������ �� [] ���� - ��Ŭ�� '�� ������ ��'

-- ������ �Է�(�μ� ���̺�)
INSERT INTO DEPT VALUES(1, '�ѹ���');
INSERT INTO DEPT VALUES(2, '���ߺ�');
INSERT INTO DEPT VALUES(3, '������');
INSERT INTO DEPT VALUES(4, 'ȫ����');

-- ������ �Է�(��� ���̺�)
INSERT INTO EMP VALUES(1001, '�����', 1);
INSERT INTO EMP VALUES(1002, '�����', 4);
INSERT INTO EMP VALUES(1003, 'Ȳ����', 3);
INSERT INTO EMP VALUES(1004, '�̰���', 2);

-- ���� ORA-02291: integrity constraint (SQLDB.SYS_C007076) violated - parent key not found
INSERT INTO EMP VALUES(1005, 'Ȳ��ȫ', 7);

-- CHECK ��������
CREATE TABLE EX2_9 (
    NUM1    NUMBER
        CONSTRAINT CHECK1 CHECK(NUM1 BETWEEN 1 AND 9), -- NUM1�÷��� ���� ������ 1~9 ������ �Է°���
    GENDER  VARCHAR2(10)
        CONSTRAINT CHECK2 CHECK(GENDER IN ('MALE', 'FEMALE')) -- GENDER�÷��� ���ڵ����� 'MALE', 'FEMALE' ���ڵ����͸� �Է°���
);

DROP TABLE EX2_9;

-- ������ �Է�
INSERT INTO EX2_9 VALUES(10, 'MAN'); --ORA-02290: check constraint (SQLDB.CHECK2) violated

INSERT INTO EX2_9 VALUES(5, 'FEMALE');

SELECT * FROM EX2_9;

COMMIT;
-- Ŀ���� ���� ������ ������ �Է��� ���� ���� �ӽû��¿� ����. �׷��� �Է��� �����͸� ������ �ݿ��ϰ��� �Ѵٸ� Ŀ���� �ؾ� ��.

-- DEFAULT(�⺻��) : ���������� �ƴ����� �÷� �Ӽ� ��ɾ�
CREATE TABLE EX2_10 (
    COL1    VARCHAR2(10)    NOT NULL,
    COL2    VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

-- ������ �Է�
-- CREATE_DATE �÷� �Է� �� �����ϰ� �Ǹ� ������ ���� �� DEFAULT SYSDATE �۵�.
-- ��ǻ���� ��¥�� �ð��� �о�ͼ� ���Ե�.
INSERT INTO EX2_10(COL1, COL2) VALUES('AA', 'BB');

-- CREATE_DATE �÷��� ������ �Է�
INSERT INTO EX2_10 VALUES('AA', 'BB', '2024-04-04'); -- ��¥�� ���ڿ��� ������ �˾Ƽ� ����ȯ�� �ȴٰ� �����ϱ�.

-- ������ ��ȸ
SELECT * FROM EX2_10;


-- �ǽ�
-- DEPT_CONST TABLE
CREATE TABLE DEPT_CONST (
    DEPTNO  NUMBER(2)       CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14)    CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
    LOC     VARCHAR2(13)    CONSTRAINT DEPTCONST_LOC_NN NOT NULL
);

-- EMP_CONST TABLE
CREATE TABLE EMP_CONST (
    EMPNO       NUMBER(4)    CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY,
    ENAME       VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL,
    JOB         VARCHAR2(9),
    TEL         VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE,
    HIREDATE    DATE,
    SAL         NUMBER(7, 2) CONSTRAINT EMPCONST_SAL_CHK CHECK(SAL BETWEEN 1000 AND 9999),
    COMM        NUMBER(7, 2),
    DEPTNO      NUMBER(2)    CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST(DEPTNO)    
);

DROP TABLE EMP_CONST;


-- ���̺� ���� (������ ���־��� �߿�)
DROP TABLE DEPT_CONST;
DROP TABLE EMP_CONST;

-- [CASCADE CONSTRAINTS] ���
DROP TABLE DEPT_CONST CASCADE CONSTRAINTS; -- EMP_CONST���̺��� ����Ű ���������� �ڵ�����

DROP TABLE EX2_10;

-- ���̺� ����
-- ������ �����ߴ� �÷��� ������ Ÿ���� �����ϰų� ����. ���ο� �÷��� �߰��ϴ� ��찡 �߻�
CREATE TABLE EX2_10 (
    COL1        VARCHAR2(10)    NOT NULL,
    COL2        VARCHAR2(10)    NULL,
    CREATE_DATE DATE            DEFAULT SYSDATE
);

-- COL1�� COL11�� ���� : ALTER TABLE [��Ű��.]���̺�� RENAME COLUMN �������÷��� TO �������÷���;
ALTER TABLE EX2_10 RENAME COLUMN COL1 TO COL11;

-- �÷����� Ȯ��
DESC EX2_10; --���̺��� �÷����� Ȯ��

-- �÷�Ÿ�Ժ��� : ALTER TABLE [��Ű��.]���̺�� MODIFY �÷��� ������Ÿ��;
ALTER TABLE EX2_10 MODIFY COL2 VARCHAR2(30);

-- �÷� Ȯ��
DESC EX2_10;

-- �÷� �߰�
ALTER TABLE EX2_10 ADD COL3 NUMBER;
DESC EX2_10;

-- �÷� ����
ALTER TABLE EX2_10 DROP COLUMN COL3;
DESC EX2_10;

-- �������� �߰�
ALTER TABLE EX2_10 ADD CONSTRAINT PK_EX2_10 PRIMARY KEY(COL11);

-- �������� ����
ALTER TABLE EX2_10 DROP CONSTRAINT PK_EX2_10;

SELECT * FROM EX2_9;

-- ���̺� ����
CREATE TABLE EX2_9_1 AS SELECT * FROM EX2_9;

SELECT * FROM EX2_9_1;

-- �ó����� : ��� ���̺� �� �μ��ڵ尡 50���� �����͸� �����ϴ� ���̺��� ����.
CREATE TABLE EMP_DEPARTMENT_ID_50 
AS
SELECT employee_id, EMP_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

-- Ȯ��
SELECT * FROM EMP_DEPARTMENT_ID_50;

-- �ó����� : ������̺��� �޿��� 5000 �̻��� �����͸� EMP_SALARY_5000 ���̺������ �����϶�.
-- �÷����� �����ȣ, ����̸�, �޿�, Ŀ�̼�, �μ��ڵ� ���
CREATE TABLE EMP_SALARY_5000
AS
SELECT employee_id, EMP_NAME, SALARY, COMMISSION_PCT, DEPARTMENT_ID
FROM EMPLOYEES WHERE SALARY >= 5000;

SELECT * FROM EMP_SALARY_5000;

-- ������ �Է�
-- 201�� �����ȣ�� �̹� ������. �ٵ��� �Ʒ��� ������ �Է��� ��.
-- �ֳĸ� PRIMARY KEY�� ���簡 �� �Ǿ �����ȣ�� �ߺ������� �����ϰ� �� ����.
INSERT INTO EMP_SALARY_5000 VALUES(201, 'YY', 20000, NULL, 20);






COMMIT; -- �׻� �Ϸ� �۾� ������ COMMIT �߰��� ������ �ؾ� ��. ���ϸ� �����Ͱ� ����.