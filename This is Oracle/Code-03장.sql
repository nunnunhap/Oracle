/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   3��. Oracle ��ü � �ǽ� 
*/

------------------------------------
-- 3.2. Oracle�� �̿��� ��Ű�� ���� ����
------------------------------------

SELECT * FROM memberTBL;

SELECT memberName, memberAddress FROM memberTBL;

SELECT * FROM memberTBL WHERE memberName = '������' ;

CREATE TABLE "my testTBL" (id NUMBER(3));

DROP TABLE "MY TESTTBL";

DROP TABLE "my testTBL";

------------------------------------
-- 3.3 ���̺� ���� �����ͺ��̽� ��ü�� Ȱ��
------------------------------------

CREATE TABLE Shop.indexTBL 
AS
    SELECT first_name, last_name, hire_date 
    FROM HR.employees;

SELECT * FROM Shop.indexTBL;

SELECT * FROM indexTBL WHERE first_name = 'Jack';

CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);

SELECT * FROM indexTBL WHERE first_name = 'Jack';

CREATE VIEW Shop.memberTBL_view AS
    SELECT memberName, memberAddress FROM Shop.memberTBL ;

SELECT * FROM memberTBL_view ;

SELECT COUNT(*) FROM memberTBL;
SELECT COUNT(*) FROM productTBL ;


CREATE PROCEDURE Shop.myProc AS
 var1 INT;
 var2 INT;
BEGIN
    SELECT COUNT(*) INTO var1 FROM Shop.memberTBL;
    SELECT COUNT(*) INTO var2 FROM Shop.productTBL;
    DBMS_OUTPUT.PUT_LINE(var1+var2);
END ;

-- ����� ��µǱ� ���� ����
SET SERVEROUTPUT ON; 
-- ���� ���ν��� ȣ��
EXECUTE myProc;

DROP PROCEDURE Shop.myProc;

INSERT INTO memberTBL VALUES ('Figure', '����', '��⵵ ������ ������');

SELECT * FROM memberTBL ;

UPDATE memberTBL SET memberAddress = '���� ������ ���ﵿ' WHERE memberName = '����';

SELECT * FROM memberTBL ;

DELETE FROM memberTBL WHERE memberName = '����';

SELECT * FROM memberTBL ;

CREATE TABLE deletedMemberTBL (  
	memberID char(8) ,
	memberName nchar(5) ,
	memberAddress nvarchar2(20),
	deletedDate date  -- ������ ��¥
);

CREATE TRIGGER trg_deletedMemberTBL  -- Ʈ���� �̸�
    AFTER DELETE -- ���� �Ŀ� �۵��ϰ� ����
    ON memberTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW -- �� �ึ�� �����
BEGIN 
	-- :old ���̺��� ������ ������̺� ����
	INSERT INTO deletedMemberTBL 
		VALUES (:old.memberID, :old.memberName, :old.memberAddress, SYSDATE() ); 
END ;

SELECT * FROM memberTBL;

DELETE FROM memberTBL WHERE memberName = '������';

SELECT * FROM memberTBL;

SELECT * FROM deletedMemberTBL;

------------------------------------
-- 3.4 �������� ��� �� ����
------------------------------------

SELECT * FROM productTBL;

/* ��� ������Ʈ���� ����
exp  userid=SYSTEM/1234@xe  OWNER=Shop  FILE=C:\DB���\Shop01.dmp
*/

DROP TABLE productTBL;

SELECT * FROM productTBL;

/* ��� ������Ʈ���� ����
imp  userid=SYSTEM/1234@xe  FROMUSER=Shop TOUSER=Shop  FILE=C:\DB���\Shop01.dmp TABLES=(productTBL)
*/

SELECT * FROM productTBL;














