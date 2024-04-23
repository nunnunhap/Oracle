/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   8��. ���̺�� ��
*/

------------------------------------
-- 8.1 ���̺�
------------------------------------

----------------- <�ǽ� 1> -------------------

CREATE USER tableDB IDENTIFIED BY 1234 -- ����� �̸�: tableDB, ��й�ȣ : 1234
   DEFAULT TABLESPACE USERS
   TEMPORARY TABLESPACE TEMP;

GRANT connect, resource, dba TO tableDB ;

CREATE TABLE test (idNum NUMBER(5));

----------------- </�ǽ� 1> -------------------

----------------- <�ǽ� 2> -------------------
DROP TABLE buyTBL;
DROP TABLE userTBL;
DROP SEQUENCE idSEQ;


CREATE TABLE userTBL -- ȸ�� ���̺�
( userID  	CHAR(8), -- ����� ���̵�(PK)
  userName  	NVARCHAR2(10), -- �̸�
  birthYear 	NUMBER(4),  -- ����⵵
  addr	  	NCHAR(2), -- ����(���,����,�泲 ������ 2���ڸ��Է�)
  mobile1	CHAR(3), -- �޴����� ����(010, 011, 016, 017, 018, 019 ��)
  mobile2	CHAR(8), -- �޴����� ������ ��ȭ��ȣ(����������)
  height    	NUMBER(3),  -- Ű
  mDate    	DATE  -- ȸ�� ������
);
CREATE TABLE buyTBL -- ȸ�� ���� ���̺�
(  idNum 	NUMBER(8), -- ����(PK)
   userID  	CHAR(8), -- ���̵�(FK)
   prodName 	NCHAR(6), --  ��ǰ��
   groupName 	NCHAR(4), -- �з�
   price     	NUMBER(8), -- �ܰ�
   amount    	NUMBER(3) -- ����
);

DROP TABLE buyTBL;
DROP TABLE userTBL;
CREATE TABLE userTBL 
( userID  	CHAR(8) NOT NULL,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL 
);
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL,
   userID  	CHAR(8)  NOT NULL, 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
);

DROP TABLE buyTBL;
DROP TABLE userTBL;
CREATE TABLE userTBL 
( userID  	CHAR(8) NOT NULL PRIMARY KEY,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL 
);
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL  PRIMARY KEY,
   userID  	CHAR(8)  NOT NULL, 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
);

DROP TABLE buyTBL;
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL  PRIMARY KEY,
   userID  	CHAR(8)  NOT NULL, 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
   , FOREIGN KEY(userID) REFERENCES userTBL(userID)
);

CREATE SEQUENCE idSEQ;

INSERT INTO userTBL VALUES('LSG', '�̽±�', 1987, '����', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '�����', 1979, '�泲', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '���ȣ', 1971, '����', '019', '3333333', 177, '2007-7-7');

INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '�ȭ', NULL, 30, 2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '�����', '����', 200, 1);

INSERT INTO userTBL VALUES('JYP', '������', 1950, '���', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '���ð�', 1979, '����', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '�����', 1963, '����', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '������', 1969, '�泲', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '������', 1972, '���', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '������', 1965, '���', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '00000000', 176, '2013-5-5');
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

----------------- </�ǽ� 2> -------------------

SELECT * FROM USER_CONSTRAINTS  -- Ű ������ ��ϵ� ���̺�
    WHERE OWNER='TABLEDB' AND 
          TABLE_NAME='USERTBL'  AND
          CONSTRAINT_TYPE='P';  -- P�� �⺻Ű, R�� �ܷ�Ű, C�� NOT NULL �Ǵ� CHECK

DROP TABLE userTBL CASCADE CONSTRAINTS; -- �ܷ�Ű ���������� �־ ����
CREATE TABLE userTBL 
( userID  	CHAR(8) NOT NULL CONSTRAINT PK_userTBL_userID PRIMARY KEY ,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL 
);


SELECT * FROM USER_CONSTRAINTS  -- Ű ������ ��ϵ� ���̺�
    WHERE OWNER='TABLEDB' AND 
          TABLE_NAME='USERTBL'  AND
          CONSTRAINT_TYPE='P';  -- P�� �⺻Ű, R�� �ܷ�Ű, C�� NOT NULL �Ǵ� CHECK

DROP TABLE userTBL CASCADE CONSTRAINTS; 
CREATE TABLE userTBL
( userID  	CHAR(8) NOT NULL , 
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL
  , CONSTRAINT PK_userTBL_userID PRIMARY KEY (userID)
);

DROP TABLE userTBL CASCADE CONSTRAINTS; 
CREATE TABLE userTBL 
( userID  	CHAR(8) NOT NULL ,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL 
); 
ALTER TABLE userTBL
	ADD CONSTRAINT PK_userTBL_userID 
        PRIMARY KEY (userID);

CREATE TABLE prodTbl
( prodCode CHAR(3) NOT NULL,
  prodID   CHAR(4)  NOT NULL,
  prodDate DATE  NOT NULL,
  prodCur  CHAR(10) NULL
);
ALTER TABLE prodTbl
	ADD CONSTRAINT PK_prodTbl_proCode_prodID 
	PRIMARY KEY (prodCode, prodID) ;

DROP TABLE prodTbl;
CREATE TABLE prodTbl
( prodCode CHAR(3) NOT NULL,
  prodID   CHAR(4)  NOT NULL,
  prodDate DATE NOT NULL,
  prodCur  CHAR(10) NULL
  , CONSTRAINT PK_prodTbl_prodCode_prodID PRIMARY KEY (prodCode, prodID)
);

DROP TABLE buyTBL;
DROP TABLE userTBL;
CREATE TABLE userTBL 
(  userID  	CHAR(8) NOT NULL PRIMARY KEY ,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL 
);
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL  PRIMARY KEY,
   userID  	CHAR(8)  NOT NULL  REFERENCES userTBL(userID), 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
);

DROP TABLE buyTBL;
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL  PRIMARY KEY,
   userID  	CHAR(8)  NOT NULL 
        CONSTRAINT FK_userTBL_buyTBL  REFERENCES userTBL(userID), 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
);

DROP TABLE buyTBL;
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL  PRIMARY KEY,
   userID  	CHAR(8)  NOT NULL, 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
   , CONSTRAINT FK_userTBL_buyTBL FOREIGN KEY(userID) REFERENCES userTBL(userID)
);

DROP TABLE buyTBL;
CREATE TABLE buyTBL 
(  idNum 	NUMBER(8)  NOT NULL  PRIMARY KEY,
   userID  	CHAR(8)  NOT NULL, 
   prodName 	NCHAR(6)  NOT NULL,
   groupName 	NCHAR(4)  NULL, 
   price     	NUMBER(8) NULL,
   amount    	NUMBER(3)  NOT NULL
);
ALTER TABLE buyTbl
    ADD CONSTRAINT FK_userTbl_buyTbl 
    FOREIGN KEY (userID) 
    REFERENCES userTBL(userID) ;

ALTER TABLE buyTBL
	DROP CONSTRAINT FK_userTBL_buyTBL; -- �ܷ� Ű ����
ALTER TABLE buyTBL
	ADD CONSTRAINT FK_userTBL_buyTBL
	FOREIGN KEY (userID)
	REFERENCES userTBL (userID)
	ON DELETE CASCADE ;
    
DROP TABLE userTbl CASCADE CONSTRAINTS;
CREATE TABLE userTBL 
(  userID  	CHAR(8) NOT NULL ,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL,
  email     CHAR(30) NULL  UNIQUE
); 

DROP TABLE userTbl CASCADE CONSTRAINTS;
CREATE TABLE userTBL 
(  userID  	CHAR(8) NOT NULL ,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL,
  email     CHAR(30) NULL
  , CONSTRAINT AK_email UNIQUE (email)
);

DROP TABLE userTbl CASCADE CONSTRAINTS;
CREATE TABLE userTBL 
(  userID  	CHAR(8) NOT NULL ,
  userName  	NVARCHAR2(10) NOT NULL,
  birthYear 	NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height    NUMBER(3) NULL, 
  mDate    	DATE  NULL,
  email     CHAR(30) NULL
); 
ALTER TABLE USERTBL
    ADD CONSTRAINT AK_EMAIL UNIQUE (EMAIL);
   

-- Ű�� 0�̻��̾�� ��.
ALTER TABLE userTbl
	ADD CONSTRAINT CK_height
	CHECK   (height >= 0) ;

-- �޴��� ���� üũ
ALTER TABLE userTbl
	ADD CONSTRAINT CK_mobile1
	CHECK  (mobile1 IN ('010','011','016','017','018','019')) ;

-- �޴��� ���� üũ (���� ����)
ALTER TABLE userTbl
	ADD CONSTRAINT CK_mobile1_new
	CHECK  (mobile1 IN ('010','011','016','017','018','019')) 
	ENABLE NOVALIDATE ;

DROP TABLE userTbl CASCADE CONSTRAINTS;
CREATE TABLE userTBL 
( userID  	CHAR(8) NOT NULL PRIMARY KEY ,
  userName  	NVARCHAR2(10) NOT NULL ,
  birthYear 	NUMBER(4) DEFAULT -1 NOT NULL ,  
  addr	  	NCHAR(2) DEFAULT '����' NOT NULL ,
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height	NUMBER(3) DEFAULT 170 NULL,
  mDate    	DATE  NULL 
);

DROP TABLE userTbl CASCADE CONSTRAINTS;
CREATE TABLE userTBL 
( userID  	CHAR(8) NOT NULL PRIMARY KEY ,
  userName  	NVARCHAR2(10) NOT NULL ,
  birthYear 	NUMBER(4) NOT NULL ,  
  addr	  	NCHAR(2) NOT NULL ,
  mobile1	CHAR(3) NULL,
  mobile2	CHAR(8) NULL,
  height	NUMBER(3) NULL,
  mDate    	DATE  NULL 
);
ALTER TABLE userTBL
	MODIFY birthYear DEFAULT -1;
ALTER TABLE userTBL
	MODIFY addr DEFAULT '����';
ALTER TABLE userTBL
	MODIFY height DEFAULT 170;

-- default ���� DEFAULT�� ������ ���� �ڵ� �Է��Ѵ�.
INSERT INTO userTBL VALUES ('LHL', '������', DEFAULT, DEFAULT, '011', '1234567', DEFAULT, '2019.12.12');
-- ���̸��� ��õ��� ������ DEFAULT�� ������ ���� �ڵ� �Է��Ѵ�
INSERT INTO userTBL(userID, userName) VALUES('KAY', '��ƿ�');
-- ���� ���� ���Ǹ� DEFAULT�� ������ ���� ���õȴ�.
INSERT INTO userTBL VALUES ('WB', '����', 1982, '����', '019', '9876543', 176, '2020.5.5');
SELECT * FROM userTBL;

INSERT INTO userTBL(userID, userName, mobile1) VALUES('MGG', '��¡��', NULL);
INSERT INTO userTBL(userID, userName, mobile1) VALUES('MKD', '��ĭ��', '');
INSERT INTO userTBL(userID, userName, mobile1) VALUES('JJK', '¯��', ' ');

----------------- <�ǽ� 3> -------------------

-- (��ũ��Ʈ 1)
CREATE GLOBAL TEMPORARY TABLE tempTBL (id CHAR(8), uName NCHAR(10));

SELECT TABLE_NAME, TEMPORARY FROM USER_TABLES; 

INSERT INTO tempTBL VALUES('Thomas', '�丶��');
INSERT INTO tempTBL VALUES('James', '���ӽ�');
SELECT * FROM tempTBL;

COMMIT;
SELECT * FROM tempTBL;

-- (��ũ��Ʈ 2)
CREATE GLOBAL TEMPORARY TABLE tempTBL2 (id CHAR(8), uName NCHAR(10))
     ON COMMIT PRESERVE ROWS;
INSERT INTO tempTBL2 VALUES('Arthur', '�Ƽ�');
INSERT INTO tempTBL2 VALUES('Murdoch', '�ӵ�');

COMMIT;
SELECT * FROM tempTBL2;

SELECT * FROM tempTBL2;

DROP TABLE tempTBL;
DROP TABLE tempTBL2;
----------------- </�ǽ� 3> -------------------

ALTER TABLE userTBL
	ADD homepage VARCHAR(30)  -- �� �߰�
		DEFAULT 'http://www.hanbit.co.kr' -- ����Ʈ��
		NULL; -- Null �����

ALTER TABLE userTBL
	ADD (homeAddr  NVARCHAR2(20), postNum VARCHAR(5) );

ALTER TABLE userTBL
	DROP COLUMN homeAddr;

ALTER TABLE userTBL
	DROP (homepage, postNum);

ALTER TABLE userTBL
	RENAME COLUMN userName TO uName;
    
ALTER TABLE userTBL
	MODIFY (addr NVARCHAR2(10) NULL);

ALTER TABLE userTBL
	DROP PRIMARY KEY;

ALTER TABLE buyTBL
	DROP CONSTRAINT SYS_C007801;

----------------- <�ǽ� 4> -------------------

DROP TABLE buyTbl;
DROP TABLE userTbl;
CREATE TABLE userTBL 
( userID  	CHAR(8),
  userName  	NVARCHAR2(10),
  birthYear 	NUMBER(4),
  addr	  	NCHAR(2),
  mobile1	CHAR(3),
  mobile2	CHAR(8),
  height    	NUMBER(3),
  mDate    	DATE
);
CREATE TABLE buyTBL
(  idNum 	NUMBER(8) PRIMARY KEY,
   userID  	CHAR(8),
   prodName 	NCHAR(6),
   groupName 	NCHAR(4),
   price     	NUMBER(8),
   amount    	NUMBER(3)
);
DROP SEQUENCE idSEQ;
CREATE SEQUENCE idSEQ;

INSERT INTO userTBL VALUES('LSG', '�̽±�', 1987, '����', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '�����', NULL, '�泲', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '���ȣ', 1871, '����', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '������', 1950, '���', '011', '4444444', 166, '2009-4-4');
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL,'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL,'JYP', '�����', '����', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL,'BBK', '�����', '����', 200,  5);

ALTER TABLE userTBL
	ADD CONSTRAINT PK_userTBL_userID
	PRIMARY KEY (userID);

SELECT * FROM USER_CONSTRAINTS 
    WHERE OWNER='TABLEDB' AND TABLE_NAME='USERTBL' AND CONSTRAINT_TYPE='P';
DESCRIBE userTBL;

ALTER TABLE buyTBL
	ADD CONSTRAINT FK_userTBL_buyTBL
	FOREIGN KEY (userID)
	REFERENCES userTBL (userID);
    
DELETE FROM buyTBL WHERE userID = 'BBK';
ALTER TABLE buyTBL
	ADD CONSTRAINT FK_userTBL_buyTBL
	FOREIGN KEY (userID)
	REFERENCES userTBL (userID);
    
ALTER TABLE buyTBL
    DISABLE CONSTRAINT FK_userTBL_buyTBL;
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�����', '����', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', 'û����', '�Ƿ�', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�޸�', '����', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', 'å'    , '����', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'û����', '�Ƿ�', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);
ALTER TABLE buyTBL
    ENABLE NOVALIDATE CONSTRAINT FK_userTBL_buyTBL;

ALTER TABLE userTBL
	ADD CONSTRAINT CK_birthYear
	CHECK  (birthYear >= 1900 AND birthYear <= 2017)
	ENABLE;

ALTER TABLE userTBL
	ADD CONSTRAINT CK_birthYear
	CHECK  (birthYear >= 1900 AND birthYear <= 2017)
	ENABLE NOVALIDATE ;
    
INSERT INTO userTBL VALUES('SSK', '���ð�', 1979, '����', NULL  , NULL , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '�����', 1963, '����', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '������', 1969, '�泲', NULL  , NULL , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '������', 1972, '���', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '������', 1965, '���', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '0000000', 176, '2013-5-5');
    
DELETE FROM userTBL WHERE userID = 'BBK';

ALTER TABLE buyTBL
	DROP CONSTRAINT FK_userTBL_buyTBL;
ALTER TABLE buyTBL 
	ADD CONSTRAINT FK_userTBL_buyTBL
		FOREIGN KEY (userID)
		REFERENCES userTBL (userID)
		ON DELETE CASCADE;

DELETE FROM userTBL WHERE userID = 'BBK';
SELECT * FROM buyTBL;

ALTER TABLE userTBL
	DROP COLUMN birthYear ;

----------------- </�ǽ� 4> -------------------

------------------------------------
-- 8.2 �� (View)
------------------------------------

CREATE VIEW v_userTBL
AS
	SELECT userID, userName, addr FROM userTBL;

SELECT * FROM v_userTBL;  -- �並 ���̺��̶�� �����ص� ����

SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2 AS "����ó"
FROM userTBL U
  INNER JOIN buyTBL B
     ON U.userID = B.userID ;

CREATE OR REPLACE VIEW v_userbuyTBL
AS
  SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2 AS "����ó"
  FROM userTBL U
    INNER JOIN buyTBL B
       ON U.userID = B.userID ;

SELECT * FROM v_userbuyTBL WHERE userName = '�����';


----------------- <�ǽ� 5> -------------------

CREATE OR REPLACE VIEW v_userbuyTBL
AS
   SELECT U.userID AS "USER ID", U.userName AS "USER NAME", B.prodName AS "PRODUCT NAME", 
		U.addr, CONCAT(U.mobile1, U.mobile2) AS "MOBILE PHONE"
      FROM userTBL U
	INNER JOIN buyTBL B
	 ON U.userID = B.userID;

SELECT "USER ID", "USER NAME" FROM v_userbuyTBL;

CREATE OR REPLACE VIEW v_userbuyTBL
AS
   SELECT U.userID AS "����� ���̵�", U.userName AS "�̸�", B.prodName AS "��ǰ �̸�", 
		U.addr, CONCAT(U.mobile1, U.mobile2)  AS "��ȭ ��ȣ"
      FROM userTBL U
          INNER JOIN buyTBL B
             ON U.userID = B.userID ;
             
SELECT "�̸�","��ȭ ��ȣ" FROM v_userbuyTBL;

DROP VIEW v_userbuyTBL;

CREATE OR REPLACE VIEW v_userTBL
AS
	SELECT userID, userName, addr FROM userTBL;

SELECT * FROM USER_VIEWS;

UPDATE v_userTBL SET addr = '�λ�' WHERE userID='JKW';

INSERT INTO v_userTBL(userID, userName, addr) VALUES('KBM','�躴��','���');

CREATE OR REPLACE VIEW v_userTBL
AS
	SELECT userID, userName, addr FROM userTBL
	WITH READ ONLY;

UPDATE v_userTBL SET addr = '�±�' WHERE userID='SSK';

CREATE OR REPLACE VIEW v_sum
AS
	SELECT userID , SUM(price*amount) AS "Total"  
	   FROM buyTBL GROUP BY userID;

SELECT * FROM v_sum;

INSERT INTO v_sum VALUES('BAD', 1000);

CREATE OR REPLACE VIEW v_height177
AS
	SELECT * FROM userTBL WHERE height >= 177 ;

SELECT * FROM v_height177 ;

DELETE FROM v_height177 WHERE height < 177 ;

INSERT INTO v_height177 VALUES('KBM', '�躴��', 1977, '���', '010', '5555555', 158, '2019-01-01') ;

CREATE OR REPLACE VIEW v_height177
AS
	SELECT * FROM userTBL WHERE height >= 177 
	WITH CHECK OPTION ;

INSERT INTO v_height177 VALUES('WDT', '������', 2006 , '����', '010', '3333333', 155, '2019-3-3') ;

CREATE OR REPLACE VIEW v_userbuyTBL
AS
  SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2 AS mobile
   FROM userTBL U
      INNER JOIN buyTBL B
         ON U.userID = B.userID ;

INSERT INTO v_userbuyTBL VALUES('PKL','�ڰ渮','�ȭ','���','00000000000');

DROP TABLE userTbl CASCADE CONSTRAINTS;

SELECT * FROM v_userbuyTBL;
----------------- </�ǽ� 5> -------------------

----------------- <�ǽ� 6> -------------------

CREATE TABLE bigEmployees (
    emp_no  NUMBER(10) PRIMARY KEY,
    birth_date  DATE NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    gender  CHAR(1) NOT NULL,
    hire_date  DATE NOT NULL
);

SELECT COUNT(*) FROM bigEmployees; -- �� 30������ ������ ��
SELECT * FROM bigEmployees WHERE ROWNUM <= 10;

CREATE TABLE bigTBL AS SELECT * FROM HR.bigEmployees;
CREATE TABLE smallTBL AS SELECT * FROM HR.Employees;

SELECT ROUND(AVG(EXTRACT(YEAR FROM B.birth_date)), 0) AS "��� ����⵵"
    FROM bigTBL B
        CROSS JOIN smallTBL S; -- �Ϻη� �ð��� �ɸ����� �߰��� ����

CREATE MATERIALIZED VIEW mv_AvgYear
AS
    SELECT ROUND(AVG(EXTRACT(YEAR FROM B.birth_date)), 0) AS "��� ����⵵"
    FROM bigTBL B
        CROSS JOIN smallTBL S;

SELECT * FROM mv_AvgYear;

DROP MATERIALIZED VIEW mv_AvgYear;
CREATE MATERIALIZED VIEW mv_AvgYear 
    BUILD DEFERRED  
AS
    SELECT ROUND(AVG(EXTRACT(YEAR FROM B.birth_date)), 0) AS "��� ����⵵"
    FROM bigTBL B
        CROSS JOIN smallTBL S;

SELECT * FROM mv_AvgYear;

EXECUTE DBMS_MVIEW.REFRESH(LIST =>'mv_AvgYear');
SELECT * FROM mv_AvgYear;

ALTER TABLE buyTBL
    ADD sales GENERATED ALWAYS AS (price * amount) ;
SELECT * FROM buyTBL;

CREATE MATERIALIZED VIEW mv_SumSales 
    BUILD IMMEDIATE
    REFRESH COMPLETE   -- ��ü �䰡 �����
    ON COMMIT         -- ���� ���̺��� COMMIT �Ǵ� ��� �����.
AS
    SELECT SUM(sales) 
    FROM buyTBL;

SELECT * FROM mv_SumSales;

UPDATE buyTBL SET price = price*2;
COMMIT;
SELECT * FROM mv_SumSales;

----------------- </�ǽ� 6> -------------------










