/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   11��. Ʈ����
*/

------------------------------------
-- 11.1 Ʈ������ ����
------------------------------------


------------------ <�ǽ� 1> ------------------
SET SERVEROUTPUT ON; 
CREATE TABLE testTBL (id NUMBER, txt NVARCHAR2(5));
INSERT INTO testTBL VALUES(1, '�����ɽ�');
INSERT INTO testTBL VALUES(2, '����ũ');
INSERT INTO testTBL VALUES(3, '������');

CREATE OR REPLACE TRIGGER testTrg  -- Ʈ���� �̸�
    AFTER DELETE  OR UPDATE -- ���� �� ���� �Ŀ� �۵��ϰ� ����
    ON  testTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW -- �� �ึ�� �����
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ʈ���Ű� �۵��߽��ϴ�') ; -- Ʈ���� ����� �۵��Ǵ� �ڵ��
END;

BEGIN
   INSERT INTO testTBL VALUES(4, '���ι�����');
   UPDATE testTBL SET txt = '������ũ' WHERE id = 3;
   DELETE testTBL WHERE id = 4;
END;

------------------ </�ǽ� 1> ------------------



------------------------------------
-- 11.2 Ʈ������ ����
------------------------------------


------------------ <�ǽ� 2> ------------------
DROP TABLE buyTBL; -- �������̺��� �ǽ��� �ʿ�����Ƿ� ����.
CREATE TABLE backup_userTBL
( userID  	CHAR(8) NOT NULL PRIMARY KEY, 
  userName  NVARCHAR2(10) NOT NULL,
  birthYear NUMBER(4) NOT NULL,  
  addr	  	NCHAR(2) NOT NULL, 
  mobile1  CHAR(3), 
  mobile2  CHAR(8), 
  height   NUMBER(3), 
  mDate    DATE,
  modType  NCHAR(2), -- ����� Ÿ��. '����' �Ǵ� '����'
  modDate  DATE, -- ����� ��¥
  modUser  NVARCHAR2(256) -- ������ �����
);

CREATE OR REPLACE TRIGGER trg_BackupUserTBL  -- Ʈ���� �̸�
   AFTER  UPDATE OR DELETE  -- ����,���� �Ŀ� �۵��ϵ��� ����
   ON userTBL -- Ʈ���Ÿ� ������ ���̺�
   FOR EACH ROW -- �� �ึ�� �����
DECLARE 
   v_modType NCHAR(2); -- ���� Ÿ��
BEGIN
   IF UPDATING THEN  -- ������Ʈ �Ǿ��ٸ�
      v_modType := '����';
   ELSIF DELETING  THEN -- �����Ǿ��ٸ�,
      v_modType := '����';
    END IF;
   -- :OLD ���̺��� ����(�������� ����)�� ������̺� ����
    INSERT INTO backup_userTBL VALUES( :OLD.userID, :OLD.userName, :OLD.birthYear, 
        :OLD.addr, :OLD.mobile1, :OLD.mobile2, :OLD.height, :OLD.mDate, 
        v_modType, SYSDATE(), USER() );
END trg_BackupUserTBL;

UPDATE userTBL SET addr = '����' WHERE userID = 'JKW';
DELETE userTBL WHERE height >= 177;

SELECT * FROM backup_userTBL;

TRUNCATE TABLE userTBL;

SELECT * FROM backup_userTBL;


DROP TRIGGER trg_BackupUserTBL;

SET SERVEROUTPUT ON; 
CREATE OR REPLACE TRIGGER trg_insertUserTBL
   AFTER INSERT  -- ���� �Ŀ� �۵��ϵ��� ����
   ON userTBL 
   FOR EACH ROW 
BEGIN
    DBMS_OUTPUT.PUT_LINE('�������� �Է��� �õ��߽��ϴ�.');
    DBMS_OUTPUT.PUT_LINE('������ ������ ������ ��ϵǾ����ϴ�.');
    DBMS_OUTPUT.PUT_LINE('�׸���, �Է��� �����ʹ� ������� �ʾҽ��ϴ�.');
    RAISE_APPLICATION_ERROR(-20999,'�Է� �õ� �߰� !!!');
END;

BEGIN
    INSERT INTO userTBL VALUES('ABC', '����', 1977, '����', '011', '1111111', 181, '2019-12-25');
END;

DROP TRIGGER trg_insertUserTBL;
------------------ </�ǽ� 2> ------------------

------------------ <�ǽ� 3> ------------------
CREATE OR REPLACE TRIGGER trg_changeUserTBL
   BEFORE INSERT  -- ���� ���� �۵��ϵ��� ����
   ON userTBL 
   FOR EACH ROW 
BEGIN
    :NEW.userName := SUBSTR(:NEW.userName, 1, 1) || 'OO';
    :NEW.birthYear := :NEW.birthYear + 2333;
END;

INSERT INTO userTBL VALUES('ABC', '����', 1977, '����', '011', '1111111', 181, '2019-12-25');
SELECT * FROM  USERTBL;

CREATE OR REPLACE TRIGGER trg_columnChange
   AFTER UPDATE OF userName -- �̸� ���� ������Ʈ�� �۵��Ǹ�
   ON userTBL 
   FOR EACH ROW 
BEGIN
    RAISE_APPLICATION_ERROR(-20888,'�̸��� ������ �ȵ˴ϴ�. !!!');
END;

UPDATE userTBL SET addr='����' WHERE userID = 'ABC';
UPDATE userTBL SET userName='����' WHERE userID = 'ABC';

------------------ </�ǽ� 3> ------------------

------------------ <�ǽ� 4> ------------------
CREATE VIEW v_deliver -- ��������� ���� ��
AS
	SELECT b.userid, u.userName, b.prodName, b.price, b.amount, u.addr
	FROM buyTBL b
		INNER JOIN userTBL u
		ON b.userid = u.userid;

SELECT * FROM v_deliver;

INSERT INTO v_deliver VALUES ('SDY', '�ŵ���', '����', 50, 1, '��õ');


CREATE OR REPLACE TRIGGER trg_viewInsert
   INSTEAD OF INSERT  -- �����۾� ��ſ� �۵� �۵��ϵ��� ����
   ON v_deliver  -- �信 ����
   FOR EACH ROW 
BEGIN
   INSERT INTO userTBL(userID, userName,birthYear, addr, mDate)
     VALUES (:NEW.userid, :NEW.userName, 0, :NEW.addr, SYSDATE);
   INSERT INTO buyTBL(idNum, userID, prodName, price, amount)
     VALUES (idSEQ.NEXTVAL, :NEW.userID, :NEW.prodName, :NEW.price, :NEW.amount);
END;

INSERT INTO v_deliver VALUES ('SDY', '�ŵ���', '����', 50, 1, '��õ');

SELECT * FROM userTBL WHERE userid = 'SDY';
SELECT * FROM buyTBL WHERE userid = 'SDY';

SELECT * FROM USER_TRIGGERS;

SELECT * FROM USER_SOURCE WHERE NAME = UPPER('trg_viewInsert');

DROP VIEW v_deliver;

------------------ </�ǽ� 4> ------------------


------------------------------------
-- 11.3 ��Ÿ Ʈ���ſ� ���� ����
------------------------------------

------------------ <�ǽ� 5> ------------------
CREATE SEQUENCE orderSEQ; -- ���� �Ϸù�ȣ��
CREATE SEQUENCE deliverSEQ; -- ��� �Ϸù�ȣ��
CREATE TABLE orderTBL -- ���� ���̺�
	(orderNo NUMBER, -- ���� �Ϸù�ȣ
          userID NVARCHAR2(5), -- ������ ȸ�����̵�
	 prodName NVARCHAR2(5), -- ������ ����
	 orderAmount NUMBER );  -- ������ ����
CREATE TABLE prodTBL -- ��ǰ ���̺�
	( prodName NVARCHAR2(5), -- ���� �̸�
	  account NUMBER ); -- ���� ���Ǽ���
CREATE TABLE deliverTBL -- ��� ���̺�
	( deliverNo NUMBER, -- ��� �Ϸù�ȣ
	  prodName NVARCHAR2(5), -- ����� ����		  
	  amount NUMBER ); -- ����� ���ǰ���

INSERT INTO prodTBL VALUES('���', 100);
INSERT INTO prodTBL VALUES('��', 100);
INSERT INTO prodTBL VALUES('��', 100);

-- ��ǰ ���̺��� ���� ���ҽ�Ű�� Ʈ����
CREATE OR REPLACE TRIGGER trg_order 
   AFTER INSERT 
   ON orderTbl
   FOR EACH ROW 
DECLARE
   v_orderAmount NUMBER;
   v_prodName NVARCHAR2(5);
BEGIN
   DBMS_OUTPUT.PUT_LINE('1. trg_order�� �����մϴ�.');
   SELECT :NEW.orderAmount INTO v_orderAmount FROM DUAL;
   SELECT :NEW.prodName INTO v_prodName FROM DUAL;
   UPDATE prodTbl SET account = account - v_orderAmount 
       WHERE prodName = v_prodName ;
END;

-- ������̺� �� ��� ���� �Է��ϴ� Ʈ����
CREATE OR REPLACE TRIGGER trg_prod 
   AFTER UPDATE 
   ON prodTbl
   FOR EACH ROW 
DECLARE
   v_amount NUMBER;
   v_prodName NVARCHAR2(5);
BEGIN
   DBMS_OUTPUT.PUT_LINE('2. trg_prod�� �����մϴ�.');
   SELECT :NEW.prodName INTO v_prodName FROM DUAL;
   -- (���� ���� ���� - ���� ���� ����) = �ֹ� ����
  SELECT :OLD.account - :NEW.account INTO v_amount FROM DUAL;

  INSERT INTO deliverTbl(deliverNo, prodName, amount)
        VALUES(deliverSEQ.NEXTVAL, v_prodName, v_amount);
END;

SET SERVEROUTPUT ON; 
BEGIN
    INSERT INTO orderTbl VALUES (orderSEQ.NEXTVAL, 'JOHN', '��',5);
END;

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;

ALTER TABLE deliverTBL 
    RENAME COLUMN prodName TO productName;

BEGIN
    INSERT INTO orderTbl VALUES (orderSEQ.NEXTVAL, 'DANG', '���', 9);
END;

ALTER TABLE deliverTBL 
    RENAME COLUMN productName TO prodName;
BEGIN
    INSERT INTO orderTbl VALUES (orderSEQ.NEXTVAL,'DANG', '���', 9);   
END;

------------------ </�ǽ� 5> ------------------

------------------ <�ǽ� 6> ------------------
CREATE SEQUENCE aSEQ; -- ���� ��Ϳ� ������
CREATE SEQUENCE bSEQ; -- ���� ��Ϳ� ������
CREATE TABLE recuA  (id NUMBER, txt NVARCHAR2(10)); -- ���� ��� Ʈ���ſ� ���̺�A
CREATE TABLE recuB  (id NUMBER, txt NVARCHAR2(10)); -- ���� ��� Ʈ���ſ� ���̺�B

CREATE TABLE countTBL (cnt NUMBER); -- Ʈ������ �ܰ� ���ڰ� ����� ���̺�
INSERT INTO countTBL VALUES (0); -- 0���� �� ���� Ʈ���ſ��� UPDATE ��Ŵ.

CREATE OR REPLACE TRIGGER trg_recuA 
   AFTER  INSERT 
   ON recuA 
DECLARE
   v_count NUMBER; -- �ݺ� Ƚ����
BEGIN
   SELECT cnt INTO v_count FROM countTBL;

   v_count := v_count + 1;
   DBMS_OUTPUT.PUT_LINE( v_count || ' --> trg_recuA �� �����մϴ�.');
   UPDATE countTBL SET cnt = v_count;    
   INSERT INTO recuB VALUES (bSEQ.NEXTVAL, '���� ��� Ʈ����');
END;

CREATE OR REPLACE TRIGGER trg_recuB 
   AFTER  INSERT 
   ON recuB
DECLARE
   v_count NUMBER; -- �ݺ� Ƚ����
BEGIN
    SELECT cnt INTO v_count FROM countTBL;

    v_count := v_count + 1;
   DBMS_OUTPUT.PUT_LINE( v_count || ' --> trg_recuB�� �����մϴ�.');
    UPDATE countTBL SET cnt = v_count;    
   INSERT INTO recuA VALUES (aSEQ.NEXTVAL, '���� ��� Ʈ����');
END;

BEGIN
    INSERT INTO recuA VALUES (aSEQ.NEXTVAL, 'ó���Է°�');
END;

SELECT * FROM recuA;
SELECT * FROM recuB;


CREATE OR REPLACE TRIGGER trg_recuA 
   AFTER  INSERT 
   ON recuA 
DECLARE
   v_count NUMBER; -- �ݺ� Ƚ����
BEGIN
   SELECT cnt INTO v_count FROM countTBL;
   IF v_count >= 49 THEN
            RETURN;
   END IF;
   v_count := v_count + 1;
   DBMS_OUTPUT.PUT_LINE( v_count || ' --> trg_recuA �� �����մϴ�.');
   UPDATE countTBL SET cnt = v_count;    
   INSERT INTO recuB VALUES (bSEQ.NEXTVAL, '���� ��� Ʈ����');
END;

CREATE OR REPLACE TRIGGER trg_recuB 
   AFTER  INSERT 
   ON recuB
DECLARE
   v_count NUMBER; -- �ݺ� Ƚ����
BEGIN
    SELECT cnt INTO v_count FROM countTBL;
   IF v_count >= 49 THEN
            RETURN;
   END IF;
    v_count := v_count + 1;
   DBMS_OUTPUT.PUT_LINE( v_count || ' --> trg_recuB�� �����մϴ�.');
    UPDATE countTBL SET cnt = v_count;    
   INSERT INTO recuA VALUES (aSEQ.NEXTVAL, '���� ��� Ʈ����');
END;

-- ������ �ʱ�ȭ
DROP SEQUENCE aSEQ;
CREATE SEQUENCE aSEQ;
DROP SEQUENCE bSEQ;
CREATE SEQUENCE bSEQ;
UPDATE countTBL SET cnt = 0;  -- ī��Ʈ ���̺� �ʱ�ȭ
BEGIN      
    INSERT INTO recuA VALUES (aSEQ.NEXTVAL, 'ó���Է°�');
END;

SELECT * FROM recuA;
SELECT * FROM recuB;

------------------ </�ǽ� 6> ------------------

------------------ <�ǽ� 7> ------------------

CREATE TABLE autoTable (
    seqNum NUMBER NOT NULL PRIMARY KEY, 
    TXT NVARCHAR2(20));

CREATE SEQUENCE autoSEQ
    START WITH 10000   -- ���۰�
    INCREMENT BY 1 ;  -- ������

CREATE OR REPLACE TRIGGER trg_autoSEQ 
  BEFORE INSERT 
  ON autoTable 
  FOR EACH ROW 
BEGIN
  IF INSERTING AND :NEW.seqNum IS NULL THEN
    SELECT autoSEQ.NEXTVAL INTO :NEW.seqNum FROM DUAL;
  END IF;
END;

INSERT INTO autoTable VALUES(NULL, '�̰���');
INSERT INTO autoTable VALUES(NULL, '����Ŭ');
INSERT INTO autoTable VALUES(NULL, '�̴�');
SELECT * FROM autoTable;


------------------ </�ǽ� 7> ------------------

