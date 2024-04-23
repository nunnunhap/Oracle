/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   9��. �ε���
*/

------------------------------------
-- 9.2 �ε����� ������ �ڵ� ���� 
------------------------------------

----------------- <�ǽ� 1> -------------------
CREATE TABLE  tbl1
	(	a NUMBER(4) PRIMARY KEY,
		b NUMBER(4),
		c NUMBER(4)
	);

SELECT I.INDEX_NAME, I.INDEX_TYPE, I.UNIQUENESS, C.COLUMN_NAME, C.DESCEND
    FROM USER_INDEXES I
        INNER JOIN USER_IND_COLUMNS C
        ON I.INDEX_NAME = C.INDEX_NAME
    WHERE I.TABLE_NAME='TBL1' ;
    
CREATE TABLE  tbl2
	(	a NUMBER(4) PRIMARY KEY,
		b NUMBER(4) UNIQUE,
		c NUMBER(4) UNIQUE,
		d NUMBER(4)
	);

SELECT I.INDEX_NAME, I.INDEX_TYPE, I.UNIQUENESS, C.COLUMN_NAME, C.DESCEND
    FROM USER_INDEXES I
        INNER JOIN USER_IND_COLUMNS C
        ON I.INDEX_NAME = C.INDEX_NAME
    WHERE I.TABLE_NAME='TBL2' ;

----------------- </�ǽ� 1> -------------------    


------------------------------------
-- 9.3 �ε����� ���� �۵�
------------------------------------

CREATE TABLE btreeTBL
( userID  CHAR(8) ,
  userName    NVARCHAR2(10) 
);
INSERT INTO btreeTBL VALUES('LSG', '�̽±�');
INSERT INTO btreeTBL VALUES('KBS', '�����');
INSERT INTO btreeTBL VALUES('KKH', '���ȣ');
INSERT INTO btreeTBL VALUES('JYP', '������');
INSERT INTO btreeTBL VALUES('SSK', '���ð�');
INSERT INTO btreeTBL VALUES('LJB', '�����');
INSERT INTO btreeTBL VALUES('YJS', '������');
INSERT INTO btreeTBL VALUES('EJW', '������');
INSERT INTO btreeTBL VALUES('JKW', '������');
INSERT INTO btreeTBL VALUES('BBK', '�ٺ�Ŵ');

SELECT rowid, userID, userName FROM btreeTBL;

ALTER TABLE btreeTBL
	ADD CONSTRAINT PK_btreeTBL_userID
		PRIMARY KEY (userID);

INSERT INTO btreeTBL VALUES('FNT', 'Ǫ��Ÿ');
INSERT INTO btreeTBL VALUES('KAI', 'ī����');


------------------------------------
-- 9.4 �ε��� ����/����/���� 
------------------------------------

----------------- <�ǽ� 2> -------------------    


ALTER TABLE userTBL -- PK ����
    DROP PRIMARY KEY CASCADE;
ALTER TABLE userTBL -- PK ����
    ADD CONSTRAINT PK_userTBL_userID PRIMARY KEY(userID);
ALTER TABLE buyTbl -- FK ����
    ADD CONSTRAINT FK_userTbl_buyTbl 
    FOREIGN KEY (userID) 
    REFERENCES userTBL(userID) ;

SELECT * FROM userTbl;

SELECT I.INDEX_NAME, I.INDEX_TYPE, I.UNIQUENESS, C.COLUMN_NAME, C.DESCEND
    FROM USER_INDEXES I
        INNER JOIN USER_IND_COLUMNS C
        ON I.INDEX_NAME = C.INDEX_NAME
    WHERE I.TABLE_NAME='USERTBL' ;

SELECT INDEX_NAME, LEAF_BLOCKS, DISTINCT_KEYS, NUM_ROWS FROM  USER_INDEXES 
    WHERE TABLE_NAME='USERTBL' ;

SELECT * FROM userTBL WHERE userID='BBK';

SELECT * FROM userTBL WHERE userName='�ٺ�Ŵ';

CREATE INDEX idx_userTbl_addr 
   ON userTbl (addr);

SELECT I.INDEX_NAME, I.INDEX_TYPE, I.UNIQUENESS, C.COLUMN_NAME, C.DESCEND
    FROM USER_INDEXES I
        INNER JOIN USER_IND_COLUMNS C
        ON I.INDEX_NAME = C.INDEX_NAME
    WHERE I.TABLE_NAME='USERTBL' ;

SELECT INDEX_NAME, LEAF_BLOCKS, DISTINCT_KEYS, NUM_ROWS FROM  USER_INDEXES 
    WHERE TABLE_NAME='USERTBL' ;

CREATE UNIQUE INDEX idx_userTbl_birtyYear
	ON userTbl (birthYear);

CREATE UNIQUE INDEX idx_userTbl_userName
	ON userTbl (userName);

SELECT I.INDEX_NAME, I.INDEX_TYPE, I.UNIQUENESS, C.COLUMN_NAME, C.DESCEND
    FROM USER_INDEXES I
        INNER JOIN USER_IND_COLUMNS C
        ON I.INDEX_NAME = C.INDEX_NAME
    WHERE I.TABLE_NAME='USERTBL' ;

SELECT INDEX_NAME, LEAF_BLOCKS, DISTINCT_KEYS, NUM_ROWS FROM  USER_INDEXES 
    WHERE TABLE_NAME='USERTBL' ;    
    
INSERT INTO userTbl VALUES('GPS', '�����', 1983, '�̱�', NULL  , NULL  , 162, NULL);

CREATE INDEX idx_userTbl_userName_birthYear
	ON userTbl (userName,birthYear);
DROP INDEX idx_userTbl_userName;

SELECT I.INDEX_NAME, I.INDEX_TYPE, I.UNIQUENESS, C.COLUMN_NAME, C.DESCEND
    FROM USER_INDEXES I
        INNER JOIN USER_IND_COLUMNS C
        ON I.INDEX_NAME = C.INDEX_NAME
    WHERE I.TABLE_NAME='USERTBL' ;

SELECT * FROM userTbl WHERE userName = '������' and birthYear = '1969';

SELECT * FROM userTbl WHERE userName = '������';

CREATE INDEX idx_userTbl_mobile1
	ON userTbl (mobile1);

SELECT * FROM userTbl WHERE mobile1 = '011';

SELECT INDEX_NAME FROM  USER_INDEXES 
    WHERE TABLE_NAME='USERTBL';

DROP INDEX idx_userTbl_addr;
DROP INDEX idx_userTbl_userName_birthYear;
DROP INDEX idx_userTbl_mobile1;

DROP INDEX PK_userTBL_userID;

ALTER TABLE userTBL
	DROP PRIMARY KEY;

SELECT * FROM USER_CONSTRAINTS 
    WHERE OWNER='SQLDB' AND TABLE_NAME='BUYTBL' AND CONSTRAINT_TYPE='R';

ALTER TABLE userTBL
	DROP PRIMARY KEY CASCADE;
    
----------------- </�ǽ� 2> -------------------    



------------------------------------
-- 9.5 �ε����� ���� ��
------------------------------------

----------------- <�ǽ� 3> -------------------    

SELECT COUNT(*) FROM HR.bigEmployees;

CREATE TABLE Emp AS 
    SELECT * FROM HR.bigEmployees ORDER BY DBMS_RANDOM.VALUE;
CREATE TABLE Emp_idx AS 
    SELECT * FROM HR.bigEmployees ORDER BY DBMS_RANDOM.VALUE;

SELECT * FROM Emp WHERE ROWNUM <= 5;
SELECT * FROM Emp_idx WHERE ROWNUM <= 5;

SELECT * FROM  USER_INDEXES
    WHERE TABLE_NAME='EMP';

CREATE INDEX idx_empIdx_emoNo ON Emp_idx(emp_no);

SELECT INDEX_NAME, INDEX_TYPE, BLEVEL, LEAF_BLOCKS, DISTINCT_KEYS, NUM_ROWS FROM  USER_INDEXES 
    WHERE TABLE_NAME='EMP_IDX' ;

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

SELECT * FROM Emp WHERE emp_no = 20000; -- �����ȣ 20000�� ��� 1���� ��ȸ

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

SELECT * FROM Emp_idx WHERE emp_no = 20000;

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

SELECT * FROM Emp WHERE emp_no < 10100;  -- �� 99���� ��ȸ��

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

SELECT * FROM Emp_idx WHERE emp_no < 10100;  

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

SELECT * FROM Emp_idx WHERE emp_no < 11000; -- �� 999���� ��ȸ��

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

SELECT /*+ INDEX(Emp_idx IDX_EMPIDX_EMONO) */ 
    * FROM Emp_idx WHERE emp_no < 11000;
    

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;    

SELECT * FROM Emp_idx WHERE emp_no < 10500; -- �� 499���� ��ȸ��

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;    

SELECT * FROM Emp_idx WHERE emp_no < 10400; -- �� 399���� ��ȸ��

SELECT * FROM Emp_idx WHERE emp_no = 20000;

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;  

SELECT * FROM Emp_idx WHERE emp_no*1 = 20000;

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;  

SELECT * FROM Emp_idx WHERE emp_no = 20000/1;

SELECT * FROM Emp;

CREATE INDEX idx_Emp_gender ON Emp (gender); 
SELECT INDEX_NAME, LEAF_BLOCKS, DISTINCT_KEYS, NUM_ROWS FROM  USER_INDEXES 
    WHERE TABLE_NAME='EMP' ;

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;  

SELECT * FROM Emp WHERE gender = 'M';

ALTER INDEX idx_Emp_gender REBUILD;
----------------- </�ǽ� 3> -------------------    

------------------------------------
-- 9.6 ���: �ε����� �����ؾ� �ϴ� ���� �׷��� ���� ���
------------------------------------

SELECT name, birthYear, addr FROM userTbl WHERE userID = 'KKH';



