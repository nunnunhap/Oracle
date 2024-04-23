/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   6��. PL/SQL �⺻
*/

------------------------------------
-- 6.1. SELECT ��  
------------------------------------

SELECT * FROM employees;	

SELECT * FROM HR.employees;

SELECT department_name FROM departments;

SELECT department_id, department_name FROM departments;

-- �� �� �ּ� ����
SELECT department_id, department_name -- �׷� ���̵�, �̸�
FROM departments;

/* ��� �ּ� ����
SELECT department_id, department_name -- �׷� ���̵�, �̸�
FROM departments;
*/

------------ <�ǽ�1> ------------
SELECT * FROM SYS.DBA_USERS;

SELECT * FROM SYS.DBA_TABLES WHERE OWNER = 'HR';

SELECT * FROM SYS.DBA_TAB_COLUMNS WHERE OWNER = 'HR' AND TABLE_NAME = 'DEPARTMENTS';

SELECT department_name FROM HR.departments; 

SELECT  department_id �μ���ȣ, department_name AS "�μ� �̸�" FROM HR.departments;

------------ </�ǽ�1> ------------

------------ <�ǽ�2> ------------

CREATE USER sqlDB IDENTIFIED BY 1234 -- ����� �̸�: sqlDB, ��й�ȣ : 1234
   DEFAULT TABLESPACE USERS
   TEMPORARY TABLESPACE TEMP;
   
GRANT connect, resource, dba TO sqlDB ;

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
CREATE TABLE buyTBL -- ȸ�� ���� ���̺�
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- ����(PK)
   userID  	CHAR(8) NOT NULL, -- ���̵�(FK)
   prodName 	NCHAR(6) NOT NULL, --  ��ǰ��
   groupName 	NCHAR(4)  , -- �з�
   price     	NUMBER(8)  NOT NULL, -- �ܰ�
   amount    	NUMBER(3)  NOT NULL, -- ����
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);

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

CREATE SEQUENCE idSEQ; -- ������ȣ �Է��� ���ؼ� ������ ����
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

COMMIT;
SELECT * FROM userTBL;
SELECT * FROM buyTBL;

------------ </�ǽ�2> ------------

SELECT * FROM userTBL;

SELECT * FROM userTBL WHERE userName = '���ȣ';

SELECT userID, userName FROM userTBL WHERE birthYear >= 1970 AND height >= 182;

SELECT userID, userName FROM userTBL WHERE birthYear >= 1970 OR height >= 182;

SELECT userName, height FROM userTBL WHERE height >= 180 AND height <= 183;

SELECT userName, height FROM userTBL WHERE height BETWEEN 180 AND 183;

SELECT userName, addr FROM userTBL WHERE addr='�泲' OR  addr='����' OR addr='���';

SELECT userName, addr FROM userTBL WHERE addr IN ('�泲','����','���');

SELECT userName, height FROM userTBL WHERE userName LIKE '��%';

SELECT userName, height FROM userTBL WHERE userName LIKE '_����';

SELECT userName, height FROM userTBL WHERE height  > 177;

SELECT userName, height FROM userTBL 
   WHERE height > (SELECT height FROM userTBL WHERE userName = '���ȣ');

SELECT userName, height FROM userTBL 
   WHERE height >= (SELECT height FROM userTBL WHERE addr = '�泲');

SELECT rownum, userName, height FROM userTBL 
   WHERE height >= ANY (SELECT height FROM userTBL WHERE addr = '�泲');

SELECT userName, height FROM userTBL 
   WHERE height = ANY (SELECT height FROM userTBL WHERE addr = '�泲');

SELECT userName, height FROM userTBL 
   WHERE height IN (SELECT height FROM userTBL WHERE addr = '�泲');

SELECT userName, mDate FROM userTBL ORDER BY mDate;

SELECT userName, mDate FROM userTBL ORDER BY mDate DESC;

SELECT userName, height FROM userTBL ORDER BY height DESC, userName ASC;

SELECT addr FROM userTBL;

SELECT addr FROM userTBL ORDER BY addr;

SELECT DISTINCT addr FROM userTBL;

SELECT employee_id, hire_date FROM employees 
   ORDER BY hire_date ASC;

SELECT * FROM 
   (SELECT employee_id, hire_date FROM employees  ORDER BY hire_date ASC)
   WHERE ROWNUM <= 5;
   
SELECT employee_id, hire_date FROM employees 
   WHERE ROWNUM <= 5;

SELECT employee_id, hire_date FROM EMPLOYEES SAMPLE(5);

CREATE TABLE buyTBL2 AS (SELECT * FROM buyTBL);
SELECT * FROM buyTBL2;

CREATE TABLE buyTBL3 AS (SELECT userID, prodName FROM buyTBL);
SELECT * FROM buyTBL3;

SELECT userID, amount FROM buyTBL ORDER BY userID;

SELECT userID, SUM(amount) FROM buyTBL GROUP BY userID;

SELECT userID AS "����� ���̵�", SUM(amount) AS "�� ���� ����"
   FROM buyTBL GROUP BY userID;

SELECT userID AS "����� ���̵�", SUM(price*amount) AS "�� ���ž�"
   FROM buyTBL GROUP BY userID;

SELECT AVG(amount) AS "��� ���� ����" FROM buyTBL;

SELECT CAST(AVG(amount) AS NUMBER(5,3)) AS "��� ���� ����" FROM buyTBL;

SELECT userID, CAST(AVG(amount) AS NUMBER(5,3)) AS "��� ���� ����" FROM buyTBL  GROUP BY userID;

SELECT userName, MAX(height), MIN(height) FROM userTBL;

SELECT userName, MAX(height), MIN(height) FROM userTBL GROUP BY userName;

SELECT userName, height
   FROM userTBL 
   WHERE height = (SELECT MAX(height)FROM userTBL) 
       OR height = (SELECT MIN(height)FROM userTBL);

SELECT COUNT(*) FROM userTBL;

SELECT COUNT(mobile1) AS "�޴����� �ִ� �����" FROM userTBL;

SELECT userID AS "�����", SUM(price*amount) AS "�� ���ž�"  
   FROM buyTBL 
   GROUP BY userID;

SELECT userID AS "�����", SUM(price*amount) AS "�� ���ž�"  
   FROM buyTBL 
   WHERE SUM(price*amount) > 1000 
   GROUP BY userID;

SELECT userID AS "�����", SUM(price*amount) AS "�� ���ž�"  
   FROM buyTBL 
   GROUP BY userID
   HAVING SUM(price*amount) > 1000;

SELECT userID AS "�����", SUM(price*amount) AS "�� ���ž�"  
   FROM buyTBL 
   GROUP BY userID
   HAVING SUM(price*amount) > 1000
   ORDER BY SUM(price*amount);

SELECT idNum,  groupName, SUM(price * amount) AS "���" 
   FROM buyTbl
   GROUP BY ROLLUP (groupName, idNum);

SELECT groupName, SUM(price * amount) AS "���" 
   FROM buyTbl
   GROUP BY ROLLUP (groupName);

SELECT groupName, SUM(price * amount) AS "���" 
         , GROUPING_ID(groupName) AS "�߰��� ����"
   FROM buyTbl
   GROUP BY ROLLUP(groupName) ;

CREATE TABLE cubeTbl(prodName NCHAR(3), color NCHAR(2), amount INT);
INSERT INTO cubeTbl VALUES('��ǻ��', '����', 11);
INSERT INTO cubeTbl VALUES('��ǻ��', '�Ķ�', 22);
INSERT INTO cubeTbl VALUES('�����', '����', 33);
INSERT INTO cubeTbl VALUES('�����', '�Ķ�', 44);
SELECT prodName, color, SUM(amount) AS "�����հ�"
   FROM cubeTbl
   GROUP BY CUBE (color, prodName)
   ORDER BY prodName, color;

SELECT userID AS "�����", SUM(price*amount) AS "�ѱ��ž�"  
   FROM buyTbl  GROUP BY userID;

WITH abc(userID, total)
AS
(  SELECT userID, SUM(price*amount)  
      FROM buyTbl  GROUP BY userID  )
SELECT * FROM abc ORDER BY total DESC ;

WITH abc(userID, total)
AS
(  SELECT userID, SUM(price*amount)  
      FROM buyTbl  GROUP BY userID  )
SELECT userID AS "�����", total AS "�� ���ž�" FROM abc ORDER BY total DESC ;

WITH cte_userTbl(addr, maxHeight)
AS
( SELECT addr, MAX(height) FROM userTbl GROUP BY addr)
SELECT AVG(maxHeight) AS "�� ������ �ְ�Ű ���" FROM cte_userTbl;

WITH 
AAA(userID, total)
   AS
     (SELECT userID, SUM(price*amount) FROM buyTbl GROUP BY userID ),
BBB(sumtotal)
   AS
      (SELECT SUM(total) FROM AAA ),
CCC(sumavg)
   AS
      (SELECT  sumtotal / (SELECT count(*) FROM buyTbl) FROM BBB)
SELECT * FROM CCC;

------------ <�ǽ�3> ------------
CREATE TABLE empTbl (emp NCHAR(3), manager NCHAR(3), department NCHAR(3));

INSERT INTO empTbl VALUES('������','����','����');
INSERT INTO empTbl VALUES('���繫','������','�繫��');
INSERT INTO empTbl VALUES('�����','���繫','�繫��');
INSERT INTO empTbl VALUES('�̺���','���繫','�繫��');
INSERT INTO empTbl VALUES('��븮','�̺���','�繫��');
INSERT INTO empTbl VALUES('�����','�̺���','�繫��');
INSERT INTO empTbl VALUES('�̿���','������','������');
INSERT INTO empTbl VALUES('�Ѱ���','�̿���','������');
INSERT INTO empTbl VALUES('������','������','������');
INSERT INTO empTbl VALUES('������','������','������');
INSERT INTO empTbl VALUES('������','������','������');

WITH empCTE(empName, mgrName, dept, empLevel)
AS
(
 ( SELECT emp, manager, department , 0  
       FROM empTbl 
       WHERE manager = '����' ) -- ����� ���� ����� �ٷ� ����
  UNION ALL
  (SELECT empTbl.emp, empTbl.manager, empTbl.department, empCTE.empLevel+1
   FROM empTbl INNER JOIN empCTE 
        ON empTbl.manager = empCTE.empName)
)
SELECT * FROM empCTE ORDER BY dept, empLevel;

WITH empCTE(empName, mgrName, dept, empLevel)
AS
(
 ( SELECT emp, manager, department , 0  
       FROM empTbl 
       WHERE manager = '����' ) -- ����� ���� ����� �ٷ� ����
  UNION ALL
  (SELECT empTbl.emp, empTbl.manager, empTbl.department, empCTE.empLevel+1
   FROM empTbl INNER JOIN empCTE 
        ON empTbl.manager = empCTE.empName)
)
SELECT CONCAT(RPAD(' ��', empLevel*2 + 1, '��'),  empName) AS "�����̸�", dept AS "�����μ�"
   FROM empCTE  ORDER BY dept, empLevel;

WITH empCTE(empName, mgrName, dept, empLevel)
AS
(
 ( SELECT emp, manager, department , 0  
       FROM empTbl 
       WHERE manager = '����' ) -- ����� ���� ����� �ٷ� ����
  UNION ALL
  (SELECT empTbl.emp, empTbl.manager, empTbl.department, empCTE.empLevel+1
   FROM empTbl INNER JOIN empCTE 
        ON empTbl.manager = empCTE.empName
   WHERE empLevel < 2)
)
SELECT CONCAT(RPAD(' ��', empLevel*2 + 1, '��'),  empName) AS "�����̸�", dept AS "�����μ�"
   FROM empCTE  ORDER BY dept, empLevel;

------------ </�ǽ�3> ------------


------------------------------------
-- 6.2. �������� ������ ���� SQL�� 
------------------------------------

CREATE TABLE testTBL1 (id  NUMBER(4), userName NCHAR(3), age NUMBER(2));
INSERT INTO testTBL1 VALUES (1, 'ȫ�浿', 25);

INSERT INTO testTBL1(id, userName) VALUES (2, '����');

INSERT INTO testTBL1(userName, age, id) VALUES ('����', 26,  3);

CREATE TABLE testTBL2 
   (id NUMBER(4), 
    userName NCHAR(3), 
    age NUMBER(2),
    nation NCHAR(4) DEFAULT '���ѹα�');


CREATE SEQUENCE idSEQ
    START WITH 1   -- ���۰�
    INCREMENT BY 1 ;  -- ������

DROP SEQUENCE idSEQ;

INSERT INTO testTBL2 VALUES (idSEQ.NEXTVAL, '����' ,25 , DEFAULT);
INSERT INTO testTBL2 VALUES (idSEQ.NEXTVAL, '����' ,24 , '����');
SELECT * FROM testTBL2;

INSERT INTO testTBL2 VALUES (11, '����' , 18, '�븸'); 
ALTER SEQUENCE idSEQ  
   INCREMENT BY  10; 
INSERT INTO testTBL2 VALUES (idSEQ.NEXTVAL, '�̳�' , 21, '�Ϻ�'); 
ALTER SEQUENCE idSEQ  
   INCREMENT BY  1; 
SELECT * FROM testTBL2;

SELECT idSEQ.CURRVAL FROM DUAL;

SELECT 100*100 FROM DUAL;

CREATE TABLE testTBL3 (id  NUMBER(3));
CREATE  SEQUENCE cycleSEQ
  START WITH 100
  INCREMENT BY 100
  MINVALUE 100   -- �ּҰ�
  MAXVALUE 300   -- �ִ밪
  CYCLE           -- �ݺ�����
  NOCACHE ;       -- ĳ�� ��� ����
INSERT INTO testTBL3 VALUES  (cycleSEQ.NEXTVAL);
INSERT INTO testTBL3 VALUES  (cycleSEQ.NEXTVAL);
INSERT INTO testTBL3 VALUES  (cycleSEQ.NEXTVAL);
INSERT INTO testTBL3 VALUES  (cycleSEQ.NEXTVAL);
SELECT * FROM testTBL3;


CREATE TABLE testTBL4 (empID NUMBER(6), FirstName VARCHAR2(20), 
    LastName VARCHAR2(25), Phone VARCHAR2(20));
INSERT INTO testTBL4 
  SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER
    FROM HR.employees ;

CREATE TABLE testTBL5 AS
   (SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER
       FROM HR.employees) ;

COMMIT;

UPDATE testTBL4
    SET Phone = '����'
    WHERE FirstName = 'David';
    
UPDATE buyTBL SET price = price * 1.5 ;

DELETE FROM testTBL4 WHERE FirstName = 'Peter';

ROLLBACK; -- �տ��� ���� 'Peter'�� �ǵ���
DELETE FROM testTBL4 WHERE FirstName = 'Peter' AND ROWNUM <= 2;

------------ <�ǽ�4> ------------

CREATE TABLE bigTBL1 AS
    SELECT  level AS bigID,
        ROUND(DBMS_RANDOM.VALUE(1, 500000),0) AS  numData
    FROM DUAL
    CONNECT BY level <= 500000;

CREATE TABLE bigTBL2 AS
    SELECT  level AS bigID,
        ROUND(DBMS_RANDOM.VALUE(1, 500000),0) AS  numData
    FROM DUAL
    CONNECT BY level <= 500000;
    
CREATE TABLE bigTBL3 AS
    SELECT  level AS bigID,
        ROUND(DBMS_RANDOM.VALUE(1, 500000),0) AS  numData
    FROM DUAL
    CONNECT BY level <= 500000;

DELETE FROM bigTbl1;
COMMIT;

DROP TABLE bigTbl2;

TRUNCATE TABLE bigTbl3;

------------ </�ǽ�4> ------------

------------ <�ǽ�5> ------------

CREATE TABLE memberTBL AS
   (SELECT userID, userName, addr FROM userTbl ) ;
SELECT * FROM memberTBL;

CREATE TABLE changeTBL
( userID CHAR(8) , 
  userName NVARCHAR2(10), 
  addr NCHAR(2),
  changeType NCHAR(4) -- ���� ����
  );
INSERT INTO changeTBL VALUES('TKV', '�±Ǻ���', '�ѱ�', '�ű԰���');
INSERT INTO changeTBL VALUES('LSG', null, '����', '�ּҺ���');
INSERT INTO changeTBL VALUES('LJB', null, '����', '�ּҺ���');
INSERT INTO changeTBL VALUES('BBK', null, 'Ż��', 'ȸ��Ż��');
INSERT INTO changeTBL VALUES('SSK', null, 'Ż��', 'ȸ��Ż��');

MERGE INTO memberTBL M  
  USING (SELECT changeType, userID, userName, addr FROM changeTBL)  C  
  ON (M.userID = C.userID)  
  WHEN MATCHED  THEN
      UPDATE SET M.addr = C.addr
      DELETE WHERE C.changeType = 'ȸ��Ż��'
  WHEN NOT MATCHED  THEN
     INSERT (userID, userName,  addr)  VALUES(C.userID, C.userName,  C.addr) ;

SELECT * FROM memberTBL;
------------ </�ǽ�5> ------------