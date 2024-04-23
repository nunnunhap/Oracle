/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   10��. ���� ���ν����� �Լ�
*/

------------------------------------
-- 10.1 ���� ���ν���
------------------------------------
CREATE OR REPLACE PROCEDURE userProc AS
  v_bYear NUMBER; -- ���� ����
BEGIN
    SELECT birthYear INTO v_bYear FROM userTbl
         WHERE userID = 'SSK';  -- ���� ����� ������ ����
    v_byear := v_bYear + 1;  -- ������ 1 ����
    DBMS_OUTPUT.PUT_LINE (v_byear); -- ���� �� ���
END userProc ;

SET SERVEROUTPUT ON; 
EXECUTE userProc();

---------------- <�ǽ� 1> --------------------
CREATE OR REPLACE PROCEDURE userProc1 (
  pi_userID IN USERTBL.USERID%TYPE
) AS
  v_uName VARCHAR(10);
BEGIN
    SELECT userName INTO v_uName FROM userTbl 
         WHERE userID = pi_userID;
    DBMS_OUTPUT.PUT_LINE (v_uName);
END ;

SET SERVEROUTPUT ON; 
EXECUTE userProc1('JKW');

CREATE OR REPLACE PROCEDURE userProc2 (
  pi_bYear IN USERTBL.BIRTHYEAR%TYPE,
  pi_height IN USERTBL.HEIGHT%TYPE
) AS
  v_uName VARCHAR(10);
BEGIN
    SELECT userName INTO v_uName FROM userTbl 
         WHERE birthYear = pi_bYear AND height = pi_height;
    DBMS_OUTPUT.PUT_LINE (v_uName);
END ;

EXECUTE userProc2(1971, 177);

CREATE SEQUENCE userSEQ;
CREATE TABLE testTbl (userId INT, txt NCHAR(10)); 

CREATE OR REPLACE PROCEDURE userProc3 (
  pi_txtValue IN NCHAR,
  po_outValue OUT NUMBER
) AS
    v_count VARCHAR(10);
BEGIN
  INSERT INTO testTBL VALUES(userSEQ.NEXTVAL, pi_txtValue);
  SELECT MAX(userID) INTO po_outValue FROM testTBL; 
END ;

DECLARE
    outData NUMBER;
BEGIN
    userProc3('�׽�Ʈ�� 1', outData);
    DBMS_OUTPUT.PUT_LINE (outData);
END;

CREATE OR REPLACE PROCEDURE ifElseProc (
  pi_userName IN USERTBL.USERNAME%TYPE 
) AS
    v_bYear NUMBER; -- ����⵵�� ������ ����
BEGIN
    SELECT birthYear INTO v_bYear FROM userTbl
        WHERE userName = pi_userName;
    IF v_bYear >= 1980 THEN
        DBMS_OUTPUT.PUT_LINE ('���� ������..');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('���̰� �����Ͻó׿�..');
    END IF;
END ;    

EXECUTE ifelseProc ('������');

CREATE OR REPLACE PROCEDURE caseProc (
  pi_userName IN USERTBL.USERNAME%TYPE 
) AS
    v_bYear NUMBER; 
    v_mod NUMBER; -- ������ ��
    v_tti NCHAR(3);   -- ��
BEGIN
    SELECT birthYear INTO v_bYear FROM userTbl
        WHERE userName = pi_userName;
    v_mod := MOD(v_bYear, 12) ;
    CASE 
        WHEN (v_mod = 0) THEN    v_tti := '������';
        WHEN (v_mod = 1) THEN    v_tti := '��';
        WHEN (v_mod = 2) THEN    v_tti := '��';
        WHEN (v_mod = 3) THEN    v_tti := '����';
        WHEN (v_mod = 4) THEN    v_tti := '��';
        WHEN (v_mod = 5) THEN    v_tti := '��';
        WHEN (v_mod = 6) THEN    v_tti := 'ȣ����';
        WHEN (v_mod = 7) THEN    v_tti := '�䳢';
        WHEN (v_mod = 8) THEN    v_tti := '��';
        WHEN (v_mod = 9) THEN   v_tti := '��';
        WHEN (v_mod = 10) THEN   v_tti := '��';
        ELSE v_tti := '��';
    END CASE;
    DBMS_OUTPUT.PUT_LINE (pi_userName || '�� �� ==>' || v_tti);
END ;

EXECUTE caseProc ('�����');


CREATE TABLE guguTBL (txt VARCHAR(100)); -- ������ ����� ���̺�

CREATE OR REPLACE PROCEDURE whileProc AS
    v_str VARCHAR(100); -- ����⵵�� ������ ����
    v_i NUMBER; -- ������ ���ڸ�
    v_k NUMBER; -- ������ ���ڸ�
BEGIN
    v_i := 2;  -- 2�ܺ��� ó��
    WHILE (v_i < 10) LOOP  -- �ٱ� �ݺ���. 2��~9�ܱ���.
        v_str := ''; -- �� ���� ����� ������ ���ڿ� �ʱ�ȭ
        v_k := 1; -- ������ ���ڸ��� �׻� 1���� 9����.
        WHILE (v_k < 10) LOOP
            v_str := v_str || '  ' || v_i || 'x' || v_k || '=' || v_i*v_k; -- ���ڿ� �����
            v_k := v_k + 1; -- ���ڸ� ����
        END LOOP;
        v_i := v_i + 1; -- ���ڸ� ����
        INSERT INTO guguTBL VALUES(v_str); -- �� ���� ����� ���̺� �Է�.
    END LOOP;
END ;    

EXECUTE whileProc();
SELECT * FROM guguTBL;

CREATE OR REPLACE PROCEDURE returnProc (
  pi_userName IN USERTBL.USERNAME%TYPE,
  po_retValue OUT NVARCHAR2
) AS
    v_userID VARCHAR(10);
BEGIN
   SELECT userID INTO v_userID FROM userTbl 
          WHERE userName = pi_userName;
   IF v_userID = NULL THEN
      po_retValue := '�׷� ��� ����� �Ф�';  -- ������ ���
   ELSE
      po_retValue := 'ȸ�� �Դϴ�'; -- ������ ���
    END IF;
END ;

DECLARE
    retData NVARCHAR2(30);
BEGIN
    returnProc('������', retData);
    DBMS_OUTPUT.PUT_LINE (retData);
END;

DECLARE
    retData NVARCHAR2(30);
BEGIN
    returnProc('������', retData);
    DBMS_OUTPUT.PUT_LINE (retData);
END;

CREATE OR REPLACE PROCEDURE errorProc (
  pi_userName IN USERTBL.USERNAME%TYPE,
  po_retValue OUT NVARCHAR2
) AS
    v_userID VARCHAR(10);
BEGIN
   SELECT userID INTO v_userID FROM userTbl 
          WHERE userName = pi_userName;
   po_retValue := 'ȸ�� �Դϴ�'; -- ������ ���
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         po_retValue := '�׷� ��� ����� �Ф�' ;
END ;

DECLARE
    retData NVARCHAR2(30);
BEGIN
    errorProc('������', retData);
    DBMS_OUTPUT.PUT_LINE (retData);
END;

CREATE OR REPLACE PROCEDURE errorProc2 (
  pio_userName IN OUT NVARCHAR2
) AS
    v_userID VARCHAR(10);
BEGIN
   SELECT userID INTO v_userID FROM userTbl 
          WHERE userName = pio_userName;
   pio_userName := 'ȸ�� �Դϴ�'; -- ������ ���
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         pio_userName := '�׷� ��� ����� �Ф�' ;
END ;

DECLARE
    retData NVARCHAR2(30) := '������';
BEGIN
    errorProc2(retData);
    DBMS_OUTPUT.PUT_LINE (retData);
END;

SELECT * FROM USER_OBJECTS
    WHERE OBJECT_TYPE = 'PROCEDURE';

SELECT * FROM USER_SOURCE WHERE NAME='USERPROC1';

CREATE OR REPLACE PROCEDURE encryptProc (
    pi_userID IN USERTBL.USERID%TYPE) 
AS
    v_userName USERTBL.USERNAME%TYPE;
    v_birthYear USERTBL.BIRTHYEAR%TYPE;
BEGIN  
    SELECT SUBSTR(userName,1,1) || 'OO', birthYear 
            INTO v_userName, v_birthYear
       FROM  userTbl WHERE userID = pi_userID;
     DBMS_OUTPUT.put_line(pi_userID || '-->' || v_userName || '(' || v_birthYear || ')');  
END;

EXECUTE encryptProc('JYP');

DROP PROCEDURE encryptProc;
DECLARE
  v_source  VARCHAR2(32767);
BEGIN
  v_source := 
    'CREATE OR REPLACE PROCEDURE encryptProc (' ||
    '    pi_userID IN USERTBL.USERID%TYPE) ' ||    
    'AS' ||
    '    v_userName USERTBL.USERNAME%TYPE;' ||
    '    v_birthYear USERTBL.BIRTHYEAR%TYPE;' ||
    'BEGIN  ' ||
    '    SELECT SUBSTR(userName,1,1) || ''OO'', birthYear ' ||
    '            INTO v_userName, v_birthYear' ||
    '       FROM  userTbl WHERE userID = pi_userID;' ||
    '     DBMS_OUTPUT.put_line(pi_userID || ''-->'' || v_userName || ''('' || v_birthYear || '')'');' ||
    'END;'  ;
  EXECUTE IMMEDIATE DBMS_DDL.WRAP(DDL => v_source);
END;

EXECUTE encryptProc('BBK');


SELECT * FROM USER_SOURCE WHERE NAME='ENCRYPTPROC';

CREATE OR REPLACE PROCEDURE tableProc (
  pi_tableName IN VARCHAR2 )
AS
  v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM pi_tableName;
    DBMS_OUTPUT.PUT_LINE (v_count);
END ;

CREATE OR REPLACE PROCEDURE tableProc (
  pi_tableName IN VARCHAR2 )
AS
  v_count NUMBER;
  v_sql VARCHAR2(200);
BEGIN
    v_sql := 'SELECT COUNT(*) FROM ' || pi_tableName;
    EXECUTE IMMEDIATE v_sql INTO v_count;
    DBMS_OUTPUT.PUT_LINE (pi_tableName || ' �� ����--> ' || v_count);
END ;

EXEC tableProc('BUYTBL');


CREATE OR REPLACE PROCEDURE rowtypeProc (
  pi_userid IN USERTBL.USERID%TYPE
) AS
  v_constant CONSTANT NCHAR(3) := '-->';
  v_userData usertbl%ROWTYPE;
BEGIN
    SELECT userName, addr,  height 
        INTO  v_userData.userName, v_userData.addr, v_userData.height
    FROM userTBL WHERE userID = pi_userid;
    DBMS_OUTPUT.PUT_LINE (pi_userid || v_constant ||  v_userData.userName 
      || '  '  || v_userData.addr || '  ' || v_userData.height);
END ;

EXECUTE rowtypeProc('SSK');

CREATE OR REPLACE PROCEDURE recordProc (
  pi_userid IN USERTBL.USERID%TYPE
) AS
  v_constant CONSTANT NCHAR(3) := '-->';
  TYPE myRecordType IS RECORD (r_userName NVARCHAR2(20), r_addr NCHAR(2), r_height NUMBER(3));
  v_record myRecordType;
BEGIN
    SELECT userName, addr,  height 
        INTO  v_record.r_userName, v_record.r_addr, v_record.r_height
    FROM userTBL WHERE userID = pi_userid;
    DBMS_OUTPUT.PUT_LINE (pi_userid || v_constant ||  v_record.r_userName 
      || '  '  || v_record.r_addr || '  ' || v_record.r_height);
END ;

EXECUTE recordProc('LSG');

CREATE OR REPLACE PROCEDURE collectionProc AS
  TYPE myVarrayType IS VARRAY(3) OF NUMBER(10);
  TYPE myNestType IS TABLE OF NVARCHAR2(10);
  TYPE myAssocType IS TABLE OF NUMBER(5) INDEX BY STRING(10);
  v_varray myVarrayType;
  v_nest myNestType;
  v_assoc myAssocType;  
  v_idx VARCHAR2(10);
BEGIN
    v_varray := myVarrayType(10, 20, 30);
    v_nest := myNestType('�̰���', '����Ŭ', '�н� ��');
    v_assoc('¥��') := 4500;
    v_assoc('����') := 12000;
    v_assoc('ġŲ') := 19000;
    FOR i IN 1 .. 3 LOOP
        DBMS_OUTPUT.PUT_LINE (v_varray(i) || '  ' || v_nest(i));
    END LOOP;
    v_idx := v_assoc.FIRST;
    WHILE v_idx IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE (v_idx || '-->' || v_assoc(v_idx));
        v_idx := v_assoc.NEXT(v_idx);
    END LOOP;    
END ;

EXECUTE collectionProc();

---------------- </�ǽ� 1> --------------------


------------------------------------
-- 10.2 �Լ�
------------------------------------

CREATE OR REPLACE FUNCTION userFunc(value1 INT, value2 INT)
    RETURN NUMBER
AS    
BEGIN
    RETURN value1 + value2;
END;

SELECT userFunc(100, 200) FROM DUAL;

VAR retValue NUMBER;
EXECUTE :retValue := userFunc(100, 200);
PRINT retValue;

---------------- <�ǽ� 2> --------------------

CREATE OR REPLACE FUNCTION getAgeFunc(bYear NUMBER)
    RETURN NUMBER
AS    
    v_age NUMBER;
BEGIN
    v_age := EXTRACT(YEAR FROM SYSDATE) - bYear;
    RETURN  v_age;
END getAgeFunc;

SELECT getAgeFunc(1979) FROM DUAL;

VAR retValue NUMBER;
EXECUTE :retValue := getAgeFunc(1979);
PRINT retValue;

SELECT userID, userName, getAgeFunc(birthYear) AS "�� ����" FROM userTbl;

CREATE OR REPLACE FUNCTION blindFunc(uString NCHAR)
    RETURN NCHAR
AS    
    v_string NCHAR(20) := '';
BEGIN
    IF uString = '-' THEN -- '-'�� ��ȭ��ȣ�� ���� �����.
        RETURN  v_string;
    END IF;
    
    IF SUBSTR(uString, 1, 1) = '0' THEN  -- ���� ���� 0�̸� ��ȭ��ȣ
        v_string := CONCAT( SUBSTR(uString, 1, 8), '-xxxx');
    ELSE    
        v_string := CONCAT( SUBSTR(uString, 1, 1), 'OO');
    END IF;
    RETURN  v_string;
END blindFunc;

SELECT blindFunc(userName) AS "ȸ��", 
    blindFunc(mobile1 || '-' || mobile2) AS "����ó" FROM userTBL;

---------------- </�ǽ� 2> --------------------


---------------- <�ǽ� 3> --------------------

CREATE OR REPLACE TYPE tableRowType AS OBJECT
( uName NCHAR(5), bYear NUMBER);


CREATE OR REPLACE TYPE tableType AS TABLE OF tableRowType;

CREATE OR REPLACE FUNCTION tableReturnFunc(nameString NVARCHAR2, birthString NVARCHAR2)
    RETURN tableType
    PIPELINED
AS    
    v_nameString NVARCHAR2(500) := nameString;
    v_birthString NVARCHAR2(500) := birthString;
    v_rowType tableRowType; -- 1�� �� (�̸�, ����)
    v_nameIdx NUMBER;  -- �̸� ���ڿ����� ������ �̸��� ���� ��ġ
    v_birthIndex NUMBER; -- ���� ���ڿ����� ������ ������ ���� ��ġ
    v_name NCHAR(5); -- ������ 1���� �̸� ���ڿ�
    v_birth NUMBER;  -- ������ 1���� ���� ����
BEGIN
    LOOP
        v_nameIdx := INSTR(v_nameString, ',');
        v_birthIndex := INSTR(v_birthString, ',');
        IF v_nameIdx > 0 AND v_birthIndex > 0 THEN
            v_name := SUBSTR(v_nameString, 1, v_nameIdx-1);
            v_birth := TO_NUMBER(SUBSTR(v_birthString, 1, v_birthIndex-1));
            v_rowType := tableRowType(v_name, v_birth);
            PIPE ROW(v_rowType);
            v_nameString := SUBSTR(v_nameString, v_nameIdx+1);
            v_birthString := SUBSTR(v_birthString, v_birthIndex+1);
        ELSE
            v_rowType := tableRowType(v_nameString, v_birthString); -- ������ �� ����
            PIPE ROW(v_rowType);
            EXIT;
        END IF;
    END LOOP;
    RETURN;
END tableReturnFunc;

SELECT * FROM TABLE(tableReturnFunc('�丶��,���ӽ�,���,���и�','1990, 1995, 1993,1999'));

---------------- </�ǽ� 3> --------------------

------------------------------------
-- 10.3 Ŀ��
------------------------------------

---------------- <�ǽ� 4> --------------------

CREATE OR REPLACE PROCEDURE cursorProc AS
  v_height NUMBER; -- ȸ���� Ű
  v_cnt  NUMBER := 0 ; -- ȸ���� �ο��� (= ���� ���� ��)
  v_total NUMBER := 0 ; -- ȸ�� Ű�� �հ�
  -- (1) Ŀ�� ����
  CURSOR userCursor IS  
        SELECT height FROM userTbl;
BEGIN
    -- (2) Ŀ�� ����
    OPEN userCursor;
    -- (3) Ŀ������ ������ �������� �� (4) ������ ó��
    LOOP 
        FETCH  userCursor INTO v_height;
        EXIT WHEN userCursor%NOTFOUND; -- �����Ͱ� ������ LOOP ����
        v_total := v_total + v_height;
        v_cnt := v_cnt + 1;    
    END LOOP;
    -- (5) Ŀ�� �ݱ�
    CLOSE userCursor;
    DBMS_OUTPUT.PUT_LINE('ȸ�� Ű�� ��� ==>' || (v_total/v_cnt));
END ;

SET SERVEROUTPUT ON;
EXECUTE cursorProc();

ALTER TABLE userTbl ADD grade NVARCHAR2(5);  -- ȸ�� ��� �� �߰�

CREATE OR REPLACE PROCEDURE gradeProc AS
  v_id CHAR(8); -- ȸ�� ���̵�
  v_total NUMBER(5) := 0 ; -- �� ���ž�
  v_grade NVARCHAR2(5); -- ȸ�� ���
  -- (1) Ŀ�� ����
  CURSOR userCursor IS  
    SELECT U.userid, SUM(price*amount)
        FROM buyTbl B
            RIGHT OUTER JOIN userTbl U
            ON B.userid = U.userid
        GROUP BY U.userid, U.userName ;
BEGIN
    -- (2) Ŀ�� ����
    OPEN userCursor;
    -- (3) Ŀ������ ������ �������� �� (4) ������ ó��
    LOOP 
        FETCH  userCursor INTO v_id, v_total;
        EXIT WHEN userCursor%NOTFOUND; -- �����Ͱ� ������ LOOP ����
        CASE  
            WHEN (v_total >= 1500) THEN  v_grade := '�ֿ��ȸ��';
            WHEN (v_total  >= 1000) THEN v_grade :='���ȸ��';
            WHEN (v_total >= 1) THEN  v_grade :='�Ϲ�ȸ��';
            ELSE  v_grade :='����ȸ��';
         END CASE;
         UPDATE userTbl SET grade = v_grade WHERE userID = v_id;
    END LOOP;
    -- (5) Ŀ�� �ݱ�
    CLOSE userCursor;
END ;


EXEC gradeProc();
SELECT userId, userName, grade FROM userTBL;

---------------- </�ǽ� 4> --------------------


------------------------------------
-- 10.4 ��Ű��
------------------------------------

SELECT * FROM ALL_OBJECTS  WHERE  OBJECT_TYPE ='PACKAGE';

SELECT * FROM ALL_PROCEDURES  WHERE OBJECT_NAME = 'DBMS_OUTPUT';

SELECT TEXT FROM ALL_SOURCE WHERE NAME = 'DBMS_OUTPUT';

---------------- <�ǽ� 5> --------------------

CREATE OR REPLACE PACKAGE totalPackage AS
    v_age NUMBER;
    v_bYear NUMBER;
    PROCEDURE sampleProc(pi_userName IN NCHAR);
    FUNCTION sampleFunc(bYear NCHAR) RETURN NUMBER;
END totalPackage;


CREATE OR REPLACE PACKAGE BODY totalPackage AS
    PROCEDURE sampleProc(pi_userName IN NCHAR) AS
    BEGIN
        SELECT birthYear INTO v_bYear FROM userTbl 
            WHERE userName = pi_userName;
        DBMS_OUTPUT.PUT_LINE ('���� --> ' || sampleFunc(v_bYear));
    END sampleProc;
    
    FUNCTION sampleFunc(bYear NCHAR) 
        RETURN NUMBER    AS    
    BEGIN
        v_age := EXTRACT(YEAR FROM SYSDATE) - bYear;
        RETURN  v_age;
    END sampleFunc;
END totalPackage;

EXECUTE totalPackage.sampleProc('�̽±�');
SELECT totalPackage.sampleFunc(birthYear) FROM userTBL 
    WHERE userName = '�̽±�';

---------------- </�ǽ� 5> --------------------









