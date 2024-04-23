/*
   [�̰��� Oracle�̴�] �ҽ� �ڵ�
   7��. PL/SQL ���
*/

------------------------------------
-- 7.1 Oracle�� ������ ����  
------------------------------------

SELECT CAST(1234567.89 AS NUMBER(9,1)) FROM DUAL;

SELECT SYSDATE FROM DUAL ; -- ���� ��¥
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MM:SS') "���� ��¥" FROM DUAL; 
SELECT TO_DATE('20201231235959', 'YYYYMMDDHH24MISS') "��¥ ����" FROM DUAL; 

SELECT ROWID, userName FROM userTBL;

CREATE TABLE person (       -- ����� ���̺�
   userId  NUMBER(5),         -- ����� ID
   korName  NVARCHAR2(10),  -- �ѱ� �̸� (�ѱ� ���)
   engName  VARCHAR2(20),   -- ���� �̸� (��� ���)
   email      VARCHAR2(30)   -- �̸��� �ּ� (���� �� ��ȣ�� ���)
);

--------------- <�ǽ� 1> ---------------------

DROP USER sqlDB CASCADE; -- ���� ����� ����
CREATE USER sqlDB IDENTIFIED BY 1234 -- ����� �̸�: sqlDB, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO sqlDB; -- ���� �ο�

SET SERVEROUTPUT ON;

DECLARE
   myVar1 NUMBER(3) ; 
   myVar2 NUMBER(5,2) := 3.14 ; 
   myVar3 NVARCHAR2(20) := '�̽±� Ű -->' ; 
BEGIN
   myVar1 := 5;
   DBMS_OUTPUT.PUT_LINE(myVar1);
   DBMS_OUTPUT.PUT_LINE(myVar1 + myVar2);
   SELECT height INTO myVar1 FROM userTbl WHERE userName = '�̽±�' ;
   DBMS_OUTPUT.PUT_LINE(myVar3 || TO_CHAR(myVar1));
END ;

--------------- </�ǽ� 1> ---------------------

SELECT AVG(amount) AS "��� ���� ����" FROM buyTBL ;

SELECT CAST(AVG(amount) AS NUMBER(3)) AS "��� ���� ����" FROM buyTBL ;

SELECT CAST('2020$12$12' AS DATE) FROM DUAL;
SELECT CAST('2020/12/12' AS DATE) FROM DUAL;
SELECT CAST('2020%12%12' AS DATE) FROM DUAL;
SELECT CAST('2020@12@12' AS DATE) FROM DUAL;

SELECT CAST(price AS CHAR(5)) || 'X' || CAST(amount AS CHAR(4)) || '=' AS "�ܰ�X����",	price*amount AS "���ž�" 
  FROM buyTbl ;

SELECT TO_CHAR(12345, '$999,999') FROM DUAL;
SELECT TO_CHAR(12345, '$000,999') FROM DUAL;
SELECT TO_CHAR(12345, 'L999,999') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MM:SS') FROM DUAL;

SELECT TO_CHAR(10, 'X'), TO_CHAR(255, 'XX') FROM DUAL;

SELECT TO_NUMBER('A', 'X'), TO_NUMBER('FF', 'XX') FROM DUAL;

SELECT TO_NUMBER('0123'), TO_NUMBER('1234.456') FROM DUAL;

SELECT '100' + '200' FROM DUAL; -- ���ڿ� ���ڸ� ���� (������ ��ȯ�Ǽ� �����)
SELECT CONCAT('100', '200') FROM DUAL; -- ���ڿ� ���ڸ� ���� (���ڷ� ó��)
SELECT 100 || '200' FROM DUAL; -- ������ ���ڸ� ���� (������ ���ڷ� ��ȯ�Ǽ� ó��)
SELECT price  FROM buyTBL WHERE price >= '500'; -- ���� 500���� ��ȯ


SELECT ASCII('A'), CHR(65), ASCIISTR('��'), UNISTR('\D55C') FROM DUAL;

SELECT LENGTH('�ѱ�'), LENGTH('AB'), LENGTHB('�ѱ�'), LENGTHB('AB') FROM DUAL;

SELECT CONCAT('�̰���',' Oracle�̴�'), '�̰���' || ' ' || 'Oracle�̴�'  FROM DUAL;

SELECT INSTR('�̰��� Oracle�̴�. �̰͵� ����Ŭ�̴�', '�̰�') FROM DUAL;
SELECT INSTR('�̰��� Oracle�̴�. �̰͵� ����Ŭ�̴�', '�̰�', 2) FROM DUAL;
SELECT INSTRB('�̰��� Oracle�̴�. �̰͵� ����Ŭ�̴�', '�̰�', 2) FROM DUAL;

SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH'), INITCAP('this is oracle') FROM DUAL;

SELECT REPLACE ('�̰��� Oracle�̴�', '�̰���' , 'This is') FROM DUAL;

SELECT TRANSLATE('�̰��� Oracle�̴�', '�̰�' , 'AB') FROM DUAL;

SELECT SUBSTR('���ѹα�����', 3, 2) FROM DUAL;

SELECT REVERSE('Oracle') FROM DUAL;

SELECT LPAD('�̰���', 10, '##'), RPAD('�̰���', 10, '##') FROM DUAL;

SELECT LTRIM('   �̰���'), RTRIM('�̰���$$$', '$') FROM DUAL;

SELECT TRIM('   �̰���   '), TRIM(BOTH '��' FROM '��������վ��.������') FROM DUAL;

SELECT REGEXP_COUNT('�̰��� ����Ŭ�̴�.', '��') FROM DUAL;

SELECT ABS(-100) FROM DUAL;

SELECT CEIL(4.7), FLOOR(4.7), ROUND(4.7) FROM DUAL;

SELECT MOD(157, 10) FROM DUAL;

SELECT POWER(2,3), SQRT(9) FROM DUAL;

SELECT SIGN(100), SIGN(0), SIGN(-100.123) FROM DUAL;

SELECT TRUNC(12345.12345, 2), TRUNC(12345.12345, -2) FROM DUAL;

SELECT ADD_MONTHS('2020-01-01', 5), ADD_MONTHS(SYSDATE, -5)  FROM DUAL;
SELECT TO_DATE('2020-01-01') + 5,  SYSDATE - 5  FROM DUAL;

SELECT CURRENT_DATE, SYSDATE, CURRENT_TIMESTAMP FROM DUAL;

SELECT EXTRACT(YEAR FROM DATE '2020-12-25'), EXTRACT(DAY FROM SYSDATE) FROM DUAL;

SELECT LAST_DAY('2020-02-01') FROM DUAL;

SELECT NEXT_DAY('2020-02-01', '������'), NEXT_DAY(SYSDATE, '�Ͽ���')  FROM DUAL;

SELECT MONTHS_BETWEEN (SYSDATE, '1988-09-17') FROM DUAL;

SELECT BIN_TO_NUM(1,0), BIN_TO_NUM(1,1,1,1)  FROM DUAL;

SELECT NUMTODSINTERVAL(48, 'HOUR'), NUMTODSINTERVAL(360000, 'SECOND') FROM DUAL;

SELECT NUMTOYMINTERVAL(37, 'MONTH'), NUMTOYMINTERVAL(1.5, 'YEAR') FROM DUAL;

--------------- <�ǽ� 2> ---------------------

SELECT ROW_NUMBER( ) OVER(ORDER BY height DESC) "Űū����", userName, addr, height
   FROM userTBL ;

SELECT ROW_NUMBER( ) OVER(ORDER BY height DESC, userName ASC) "Űū����", userName, addr, height
   FROM userTbl ;

SELECT addr, ROW_NUMBER( ) OVER(PARTITION BY addr ORDER BY height DESC, userName ASC) "������Űū����", userName, height
   FROM userTbl ;

SELECT DENSE_RANK( ) OVER(ORDER BY height DESC)"Űū����", userName, addr, height
   FROM userTbl ;

SELECT RANK( ) OVER(ORDER BY height DESC)"Űū����", userName, addr, height
   FROM userTbl ;

SELECT NTILE(2) OVER(ORDER BY height DESC) "�ݹ�ȣ", userName, addr, height
   FROM userTbl;

SELECT NTILE(4) OVER(ORDER BY height DESC) "�ݹ�ȣ", userName, addr, height
   FROM userTbl;

--------------- </�ǽ� 2> ---------------------

--------------- <�ǽ� 3> ---------------------
SELECT  userName, addr, height AS "Ű",
       height - (LEAD(height, 1, 0) OVER (ORDER BY height DESC)) AS "���� ����� Ű ����"
   FROM userTbl ;

SELECT addr, userName, height AS "Ű",
       height - ( FIRST_VALUE(height) OVER (PARTITION BY addr ORDER BY height DESC) ) 
             AS "������ �ִ�Ű�� ����"
   FROM userTbl ;

SELECT  addr, userName, height AS "Ű",
      (CUME_DIST() OVER (PARTITION BY addr ORDER BY height DESC)) * 100 AS "�����ο� �����%"
   FROM userTbl ;

SELECT  DISTINCT addr,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY height) OVER (PARTITION BY addr) 
               AS "������ Ű�� �߾Ӱ�"
   FROM userTbl ;

--------------- </�ǽ� 3> ---------------------

--------------- <�ǽ� 4> ---------------------
CREATE TABLE pivotTest
   (  uName NCHAR(3),
      season NCHAR(2),
      amount NUMBER(3));

INSERT  INTO  pivotTest VALUES ('�����' , '�ܿ�',  10) ;
INSERT  INTO  pivotTest VALUES ('������' , '����',  15) ;
INSERT  INTO  pivotTest VALUES ('�����' , '����',  25) ;
INSERT  INTO  pivotTest VALUES ('�����' , '��',    3) ;
INSERT  INTO  pivotTest VALUES ('�����' , '��',    37) ;
INSERT  INTO  pivotTest VALUES ('������' , '�ܿ�',  40) ;
INSERT  INTO  pivotTest VALUES ('�����' , '����',  14) ;
INSERT  INTO  pivotTest VALUES ('�����' , '�ܿ�',  22) ;
INSERT  INTO  pivotTest VALUES ('������' , '����',  64) ;
SELECT * FROM pivotTest;

SELECT * FROM pivotTest
   PIVOT ( SUM(amount) 
           FOR season 
           IN ('��','����','����','�ܿ�') )   ;

--------------- </�ǽ� 4> ---------------------

--------------- <�ǽ� 5> ---------------------
CREATE TABLE movieTBL 
  (movie_id        NUMBER(4),
   movie_title     NVARCHAR2(30),
   movie_director  NVARCHAR2(20),
   movie_star      NVARCHAR2(20),
   movie_script    CLOB,
   movie_film      BLOB
);

/* C:\SQL\Movies\movieRecords.txt 
0001,���鷯����Ʈ,���ʹ���,���� �Ͻ�,0001.txt,0001.mp4
0002,���ũŻ��,����ũ�ٶ�Ʈ,�� �κ�,0002.txt,0002.mp4
0003,��Ʈ����ĭ,����Ŭ ��,�ٴϿ� ���� ���̽�,0003.txt,0003.mp4
*/

/* C:\SQL\Movies\movieLoader.txt 
LOAD DATA
INFILE 'movieRecords.txt'
  INTO TABLE movieTBL
  FIELDS TERMINATED BY ','
  (  movie_id        CHAR(4),
     movie_title      CHAR(30),
     movie_director CHAR(20),
     movie_star      CHAR(20),
     scriptFname    FILLER CHAR(80),
     filmFname      FILLER CHAR(80),
     movie_script   LOBFILE(scriptFname) TERMINATED BY EOF,
     movie_film     LOBFILE(filmFname) TERMINATED BY EOF
)
*/

/* ��� ������Ʈ���� ���� 
CD C:\SQL\Movies 
SQLLDR  sqlDB/1234@XE  control=movieLoader.txt
*/

SELECT * FROM movieTBL;

--------------- </�ǽ� 5> ---------------------

------------------------------------
-- 7.2. ����(Join)  
------------------------------------

SELECT * 
   FROM buyTbl
     INNER JOIN userTbl
        ON buyTbl.userID = userTbl.userID
   WHERE buyTbl.userID = 'JYP';

SELECT * 
   FROM buyTbl
     INNER JOIN userTbl
        ON buyTbl.userID = userTbl.userID;

SELECT userID, userName, prodName, addr, mobile1 || mobile2 AS "����ó"
   FROM buyTbl
     INNER JOIN userTbl
        ON buyTbl.userID = userTbl.userID ;

SELECT buyTbl.userID, userName, prodName, addr, mobile1 || mobile2 AS "����ó"
   FROM buyTbl
     INNER JOIN userTbl
        ON buyTbl.userID = userTbl.userID ;

SELECT buyTbl.userID, userName, prodName, addr, mobile1 || mobile2 
   FROM buyTbl, userTbl
   WHERE buyTbl.userID = userTbl.userID ;

SELECT buyTbl.userID, userTbl.userName, buyTbl.prodName, userTbl.addr, 
         userTbl.mobile1 || userTbl.mobile2  AS "����ó"
   FROM buyTbl
     INNER JOIN userTbl
        ON buyTbl.userID = userTbl.userID;

SELECT B.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2  AS "����ó"
   FROM buyTbl B
     INNER JOIN userTbl U
        ON B.userID = U.userID;
        
SELECT B.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2  AS "����ó"
   FROM buyTbl B
     INNER JOIN userTbl U
        ON B.userID = U.userID
   WHERE B.userID = 'JYP';

SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2  AS "����ó"
   FROM userTbl U
     INNER JOIN buyTbl B
        ON U.userID = B.userID 
   WHERE B.userID = 'JYP';

SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2  AS "����ó"
   FROM userTbl U
     INNER JOIN buyTbl B
        ON U.userID = B.userID 
   ORDER BY U.userID;

SELECT DISTINCT U.userID, U.userName,  U.addr
   FROM userTbl U
     INNER JOIN buyTbl B
        ON U.userID = B.userID 
   ORDER BY U.userID ;

SELECT U.userID, U.userName,  U.addr
   FROM userTbl U
   WHERE EXISTS (
      SELECT * 
      FROM buyTbl B
      WHERE U.userID = B.userID );

--------------- <�ǽ� 6> ---------------------

CREATE TABLE stdTBL 
( stdName   NCHAR(5) NOT NULL PRIMARY KEY,
  addr	    NCHAR(2) NOT NULL
);
CREATE TABLE clubTBL 
( clubName    NCHAR(5) NOT NULL PRIMARY KEY,
  roomNo      NCHAR(4) NOT NULL
);
CREATE SEQUENCE stdclubSEQ;
CREATE TABLE stdclubTBL
(  idNum    NUMBER(5) NOT NULL PRIMARY KEY, 
   stdName  NCHAR(5) NOT NULL,
   clubName NCHAR(5) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdTBL(stdName),
FOREIGN KEY(clubName) REFERENCES clubTBL(clubName)
);
INSERT INTO stdTBL VALUES('�����','�泲');
INSERT INTO stdTBL VALUES('���ð�','����');
INSERT INTO stdTBL VALUES('������','���');
INSERT INTO stdTBL VALUES('������','���');
INSERT INTO stdTBL VALUES('�ٺ�Ŵ','����');
INSERT INTO clubTBL VALUES('����','101ȣ');
INSERT INTO clubTBL VALUES('�ٵ�','102ȣ');
INSERT INTO clubTBL VALUES('�౸','103ȣ');
INSERT INTO clubTBL VALUES('����','104ȣ');
INSERT INTO stdclubTBL VALUES(stdclubSEQ.NEXTVAL, '�����','�ٵ�');
INSERT INTO stdclubTBL VALUES(stdclubSEQ.NEXTVAL,'�����','�౸');
INSERT INTO stdclubTBL VALUES(stdclubSEQ.NEXTVAL,'������','�౸');
INSERT INTO stdclubTBL VALUES(stdclubSEQ.NEXTVAL,'������','�౸');
INSERT INTO stdclubTBL VALUES(stdclubSEQ.NEXTVAL,'������','����');
INSERT INTO stdclubTBL VALUES(stdclubSEQ.NEXTVAL,'�ٺ�Ŵ','����');

SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdTBL S 
      INNER JOIN stdclubTBL SC
           ON S.stdName = SC.stdName
      INNER JOIN clubTBL C
	  ON SC.clubName = C.clubName 
   ORDER BY S.stdName;

SELECT C.clubName, C.roomNo, S.stdName, S.addr
   FROM  stdTBL S
      INNER JOIN stdclubTBL SC
           ON SC.stdName = S.stdName
      INNER JOIN clubTBL C
	 ON SC.clubName = C.clubName
    ORDER BY C.clubName;

--------------- </�ǽ� 6> ---------------------

SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2 AS "����ó"
   FROM userTbl U
      LEFT OUTER JOIN buyTbl B
         ON U.userID = B.userID 
   ORDER BY U.userID;

SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2 AS "����ó"
   FROM buyTbl B 
      RIGHT OUTER JOIN userTbl U
         ON U.userID = B.userID 
   ORDER BY U.userID;

SELECT U.userID, U.userName, B.prodName, U.addr, U.mobile1 || U.mobile2 AS "����ó"
   FROM userTbl U
      LEFT  JOIN buyTbl B
         ON U.userID = B.userID 
   WHERE B.prodName IS NULL
   ORDER BY U.userID;

--------------- <�ǽ� 7> ---------------------
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdTBL S 
      LEFT OUTER JOIN stdclubTBL SC
          ON S.stdName = SC.stdName
      LEFT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName
   ORDER BY S.stdName;

SELECT C.clubName, C.roomNo, S.stdName, S.addr
   FROM  stdTBL S
      LEFT OUTER JOIN stdclubTBL SC
          ON SC.stdName = S.stdName
      RIGHT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName
   ORDER BY C.clubName;

SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdTBL S 
      LEFT OUTER JOIN stdclubTBL SC
          ON S.stdName = SC.stdName
      LEFT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName
UNION 
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM  stdTBL S
      LEFT OUTER JOIN stdclubTBL SC
          ON SC.stdName = S.stdName
      RIGHT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName;

--------------- </�ǽ� 7> ---------------------

SELECT * 
   FROM buyTbl 
     CROSS JOIN userTbl;

SELECT * 
   FROM buyTbl , userTbl ;

SELECT  COUNT(*) AS "������ ����"
   FROM HR.employees 
     CROSS JOIN HR.countries;

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

SELECT A.emp AS "��������" , B.emp AS "���ӻ��", B.department AS "���ӻ���μ�"
   FROM empTbl A
      INNER JOIN empTbl B
         ON A.manager = B.emp
   WHERE A.emp = '��븮';

SELECT stdName, addr FROM stdTBL
   UNION ALL
SELECT clubName, roomNo FROM clubTBL;

SELECT userName, CONCAT(mobile1, mobile2) AS "��ȭ��ȣ" FROM userTbl
   WHERE userName NOT IN ( SELECT userName FROM userTbl WHERE mobile1 IS NULL);

SELECT userName, CONCAT(mobile1, mobile2) AS "��ȭ��ȣ" FROM userTbl
   WHERE userName IN ( SELECT userName FROM userTbl WHERE mobile1 IS NULL);
   
------------------------------------
-- 7.3. PL/SQL ���α׷���
------------------------------------

SET SERVEROUTPUT ON; 

DECLARE
    var1 NUMBER(5) ; -- ���� ����
BEGIN
    var1 := 100; -- ������ �� ����
    IF  var1 = 100 THEN  -- ���� var1�� 100�̶��
        DBMS_OUTPUT.PUT_LINE('100�Դϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('100�� �ƴմϴ�');
    END IF;
END ;

DECLARE
    hireDate DATE ; -- �Ի���
    curDate DATE ; -- ����
    wDays   NUMBER(5) ; -- �ٹ��� �ϼ�
BEGIN
    SELECT hire_date INTO hireDate -- hire_date ���� ����� hireDATE�� ����
       FROM HR.employees
       WHERE employee_id = 200;
    curDate := CURRENT_DATE(); -- ���� ��¥
    wDays :=  curDate - hireDate; -- ��¥�� ����(�� ����)
    IF (wDays/365) >= 5 THEN -- 5���� �����ٸ�
        DBMS_OUTPUT.PUT_LINE('�Ի����� ' || wdays || 
                    '���̳� �������ϴ�. �����մϴ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�Ի����� ' || wdays || 
                    '�Ϲۿ� �ȵǾ��׿�. ������ ���ϼ���.');
    END IF;
END ;

DECLARE
    pNumber NUMBER(3) ; -- ����
    credit CHAR(1) ; -- ����
BEGIN
    pNumber := 77;
    IF pNumber >= 90 THEN
		credit := 'A';
    ELSIF pNumber >= 80 THEN
		credit := 'B';
    ELSIF pNumber >= 70 THEN
		credit := 'C';
    ELSIF pNumber >= 60 THEN
		credit := 'D';
    ELSE
		credit := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('�������==>' || pNumber || ', ����==>' || credit);
END ;

DECLARE
    pNumber NUMBER(3) ; -- ����
    credit CHAR(1) ; -- ����
BEGIN
    pNumber := 77;
    CASE 
		WHEN pNumber >= 90 THEN
			credit := 'A';
		WHEN pNumber >= 80 THEN
			credit := 'B';
		WHEN pNumber >= 70 THEN
			credit := 'C';
		WHEN pNumber >= 60 THEN
			credit := 'D';
		ELSE
			pNumber := 'F';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('�������==>' || pNumber || ', ����==>' || credit);
END ;


--------------- <�ǽ� 8> ---------------------
SELECT userID, SUM(price*amount) AS "�ѱ��ž�"
   FROM buyTbl
   GROUP BY userID
   ORDER BY SUM(price*amount) DESC;

SELECT B.userID, U.userName, SUM(price*amount) AS "�ѱ��ž�"
   FROM buyTbl B
      INNER JOIN userTbl U
         ON B.userID = U.userID
   GROUP BY B.userID, U.userName
   ORDER BY SUM(price*amount) DESC;

SELECT B.userID, U.userName, SUM(price*amount) AS "�ѱ��ž�"
   FROM buyTbl B
      RIGHT OUTER JOIN userTbl U
         ON B.userID = U.userID
   GROUP BY B.userID, U.userName
   ORDER BY SUM(price*amount) DESC NULLS LAST;

SELECT U.userID, U.userName, SUM(price*amount) AS "�ѱ��ž�"
   FROM buyTbl B
      RIGHT OUTER JOIN userTbl U
         ON B.userID = U.userID
   GROUP BY U.userID, U.userName
   ORDER BY SUM(price*amount) DESC NULLS LAST;

SELECT U.userID, U.userName, SUM(price*amount) AS "�ѱ��ž�",
       CASE  
            WHEN (SUM(price*amount)  >= 1500) THEN  '�ֿ����'
            WHEN (SUM(price*amount)  >= 1000) THEN  '�����'
            WHEN (SUM(price*amount) >= 1 ) THEN '�Ϲݰ�'
            ELSE '���ɰ�'
       END AS "�����"
   FROM buyTbl B
      RIGHT OUTER JOIN userTbl U
         ON B.userID = U.userID
   GROUP BY U.userID, U.userName
   ORDER BY SUM(price*amount) DESC NULLS LAST;

--------------- </�ǽ� 8> ---------------------

SET SERVEROUTPUT ON; 
DECLARE
    iNum NUMBER(3) ; -- 1���� 100���� ������ ����
    hap NUMBER(5) ; -- ���� ���� ������ ����
BEGIN
    iNum := 1;
    hap := 0;
    WHILE iNum <= 100 
    LOOP
        hap := hap + iNum; -- hap�� iNum�� ������Ŵ
        iNum := iNum + 1; -- iNum�� 1 ������Ŵ
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(hap);
END ;

DECLARE
    iNum NUMBER(3) ; -- 1���� 100���� ������ ����
    hap NUMBER(5) ; -- ���� ���� ������ ����
BEGIN
    hap := 0;
    FOR iNum IN 1 .. 100 
    LOOP
        hap := hap + iNum; -- hap�� iNum�� ������Ŵ
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(hap);
END ;

DECLARE
    iNum NUMBER(3) ; -- 1���� 100���� ������ ����
    hap NUMBER(5) ; -- ���� ���� ������ ����
BEGIN
    iNum := 1;
    hap := 0;
    WHILE iNum <= 100 
    LOOP
        IF MOD(iNum, 7) = 0 THEN
            iNum := iNum + 1;
            CONTINUE;
        END IF;
        hap := hap + iNum; -- hap�� iNum�� ������Ŵ
        IF hap > 1000 THEN
            EXIT;
        END IF;
        iNum := iNum + 1; -- iNum�� 1 ������Ŵ
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(hap);
END ;


DECLARE
    iNum NUMBER(3) ; -- 1���� 100���� ������ ����
    hap NUMBER(5) ; -- ���� ���� ������ ����
BEGIN
    iNum := 1;
    hap := 0;
    WHILE iNum <= 100 
    LOOP
        IF MOD(iNum, 7) = 0 THEN
            iNum := iNum + 1;
            CONTINUE;
        END IF;
        hap := hap + iNum; -- hap�� iNum�� ������Ŵ
        IF hap > 1000 THEN
            GOTO  my_goto_location;
        END IF;
        iNum := iNum + 1; -- iNum�� 1 ������Ŵ
    END LOOP;
    << my_goto_location >>
    DBMS_OUTPUT.PUT_LINE(hap);
END ;

BEGIN
    DBMS_LOCK.SLEEP(5); 
    DBMS_OUTPUT.PUT_LINE('5�ʰ� ������ ����Ǿ���');
END ;

DECLARE
    -- ���̺� ���� ������ Ÿ�԰� �����ϰ� ���� Ÿ���� ����
    v_userName userTBL.userName%TYPE; 
BEGIN
    SELECT userName INTO v_userName FROM userTBL 
            WHERE userName LIKE ('��%'); -- �����, ���ȣ 2��
    DBMS_OUTPUT.PUT_LINE ('�达 �� �̸��� ' ||v_userName|| '�Դϴ�.') ;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE ('�达 ���� �����ϴ�.') ;
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE ('�达 ���� �ʹ� ���׿�.') ;            
END ;

DECLARE
    v_userName userTBL.userName%TYPE; 
    userException EXCEPTION;
    PRAGMA EXCEPTION_INIT(userException, -1422);
BEGIN
    SELECT userName INTO v_userName FROM userTBL 
            WHERE userName LIKE ('��%'); -- �����, ���ȣ 2��
    DBMS_OUTPUT.PUT_LINE ('�达 �� �̸��� ' ||v_userName|| '�Դϴ�.') ;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE ('�达 ���� �����ϴ�.') ;
        WHEN userException THEN
            DBMS_OUTPUT.PUT_LINE ('�达 ���� �ʹ� ���׿�.') ;            
END ;

DECLARE
    v_userName userTBL.userName%TYPE; 
    zeroDelete EXCEPTION;
BEGIN
    v_userName := '����';
    DELETE FROM userTBL WHERE userName=v_userName; 
    IF SQL%NOTFOUND THEN
        RAISE zeroDelete;
    END IF;
    EXCEPTION
        WHEN zeroDelete THEN
            DBMS_OUTPUT.PUT_LINE (v_userName || ' ������ ����. Ȯ�� �ٷ���^^') ;            
END ;

DECLARE
    v_userName userTBL.userName%TYPE; 
BEGIN
    v_userName := '����';
    DELETE FROM userTBL WHERE userName=v_userName; 
    IF  SQL%NOTFOUND  THEN
        RAISE_APPLICATION_ERROR(-20001, '������ ���� ���� �߻�!!');
    END IF;
END ;

DECLARE
    v_sql VARCHAR2(100); -- SQL ������ ������ ����
    v_height userTBL.height%TYPE;  -- ��ȯ�� Ű�� ������ ����
BEGIN
    v_sql := 'SELECT height FROM userTBL WHERE userid = ''EJW'' ' ; 
    EXECUTE IMMEDIATE v_sql INTO v_height;
    DBMS_OUTPUT.PUT_LINE (v_height) ;
END ;

DECLARE
    v_year CHAR(4);
    v_month CHAR(2);
    v_day  CHAR(2);
    v_sql VARCHAR2(100);
    v_height userTBL.height%TYPE;
BEGIN
     v_year := EXTRACT(YEAR FROM SYSDATE);
     v_month := EXTRACT(MONTH FROM SYSDATE);
     v_day := EXTRACT(DAY FROM SYSDATE);
     v_sql := 'CREATE TABLE myTBL' || v_year || '_' || v_month || '_' || 
            v_day || ' (idNum  NUMBER(5), userName NVARCHAR2(10))';
    EXECUTE IMMEDIATE v_sql;
    DBMS_OUTPUT.PUT_LINE ('���̺� ������');
END;

