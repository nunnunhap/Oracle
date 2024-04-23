-- 계정생성과 권한부여작업이 진행되었을 경우 sqldb계정으로 작업
-- 학습용 데이터 준비작업

-- 1번째 실행
CREATE TABLE userTBL -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  userName  	NVARCHAR2(10) NOT NULL, -- 이름
  birthYear 	NUMBER(4) NOT NULL,  -- 출생년도
  addr	  	NCHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(010, 011, 016, 017, 018, 019 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	NUMBER(3),  -- 키
  mDate    	DATE  -- 회원 가입일
);

-- 2번째 실행
CREATE TABLE buyTBL -- 회원 구매 테이블
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	NCHAR(6) NOT NULL, --  물품명
   groupName 	NCHAR(4)  , -- 분류
   price     	NUMBER(8)  NOT NULL, -- 단가
   amount    	NUMBER(3)  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);

-- 3번째 실행
INSERT INTO userTBL VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

-- 4번째 실행
CREATE SEQUENCE idSEQ; -- 순차번호 입력을 위해서 시퀀스 생성

-- 5번째 실행
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '운동화', NULL   , 30,   2);

-- 6번째 실행
COMMIT;

-- 데이터 확인
-- SELECT문 : 테이블에 저장되어 있는 데이터 확인. 조회 명령어.
SELECT * FROM usertbl; -- 10개 데이터
SELECT * FROM buytbl; -- 12개 데이터

-- 특정한 조건의 데이터만 조회 : SELECT 컬럼명1, 컬럼명2 FROM 테이블명 WHERE 조건식;
-- 질의> 이름이 '김경호'인 데이터를 조회하라.
SELECT * FROM usertbl WHERE username = '김경호';
SELECT * FROM usertbl WHERE username = '은지원';

-- 질의> 생년월일이 1970년 이상(이후), 키가 182 이상 데이터 조회
SELECT * FROM usertbl WHERE birthyear >= 1970 AND height >= 182;

--> 질의> 생년월일이 1970년 이상이거나 키가 182 이상 데이터 조회
SELECT * FROM usertbl WHERE birthyear >= 1970 OR height >= 182;

-- 질의> 키가 180이상이면서 183이하인 데이터를 조회하라
SELECT * FROM usertbl WHERE height >= 180 AND height <= 183;
-- 동일한 구문
SELECT * FROM usertbl WHERE height BETWEEN 180 AND 183;

-- 질의> 주소가 경남이거나 전남 또는 경북 데이터 조회
SELECT * FROM usertbl WHERE addr = '경남' OR addr = '전남' OR addr = '경북';
-- 동일한 구문
SELECT * FROM usertbl WHERE addr IN ('경남', '전남', '경북');

-- 숫자데이터 컬럼의 경우 사칙연산 가능
SELECT * FROM buytbl;
-- 주문금액을 출력하시오.
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * AMOUNT AS TOT_PRICE FROM buytbl;
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * 1.3 AS TAX_INCLUDE FROM buytbl;

-- LIKE 패턴 매칭
-- 질의> 이름 중 성이 '김'인 데이터를 조회 %(와일드 카드 문자 : 길이가 0개 이상의 문자열)
SELECT * FROM usertbl WHERE username LIKE '김%';

-- 질의> 전체 이름이 3글자이면서, 종신으로 끝나는 데이터 조회 _(와일드카드 문자 : 길이가 1개를 의미)
SELECT * FROM usertbl WHERE username LIKE '_종신';



-- 더 북 오라클 오라클 SQL과 PL/SQL을 다루는 기술 https://thebook.io/006696/0063/


-- 질의> 사원 테이블에서 급여가 5000이 넘는 사원번호와 사원명을 조회
 SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id asc; --asc(오름차순)은 생략. order by는 항상 맨 마지막에 사용함.

 SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id desc; --desc(내림차순) 생략불가.

-- 급여가 5000 이상이고 job_id가 ‘IT_PROG’인 사원을 조회한다면, AND 연산자와 job_id를 검색하는 조건
SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'IT_PROG'
     ORDER  BY employee_id;

-- 데이터는 대소문자를 구분한다. IT_PROG -> 'it_prog'
-- 대소문자 구분 때문에 결과가 없다.
SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'it_prog'
     ORDER  BY employee_id;

-- usertbl테이블에서 생년월일을 오름차순으로 정렬하라.
SELECT * FROM usertbl ORDER BY birthyear ASC;

-- usertbl테이블에서 키를 내림차순으로 이름을 오름차순으로 정렬
SELECT * FROM usertbl ORDER BY height DESC, username ASC; -- 키가 동일할 때는 2차 정렬을 따름.오름차순

-- 질의> usertbl에서 주소를 오름차순으로 정렬
SELECT * FROM usertbl ORDER BY addr ASC;
SELECT addr FROM usertbl ORDER BY addr ASC;

-- 중복된 데이터를 1개만 남기고 나머지는 제거 : DISTINCT
SELECT DISTINCT addr FROM usertbl ORDER BY addr ASC;

-- USERNAME 컬럼과 ADDR 컬럼에 동시에 만족되는 데이터가 존재 시 DISTINCT 효과가 나옴.
SELECT DISTINCT USERNAME, ADDR FROM USERTBL ORDER BY ADDR ASC;


-- 더 북 2장 DB를 구성하는 객체 살펴보기
-- 데이터베이스 객체란 데이터베이스 내에 존재하는 논리적인 저장구조라고 함. (뷰, 인덱스, 함수, 등등)
-- 데이터베이스 객체 중 실제 데이터를 저장하고 있는 것이 테이블이라고 함.
-- 01. 데이터베이스 객체의 개요 02. 테이블

-- 문자열 데이터타입 : CHAR, VARCHAR2, NCHAR, NVARCHAR2
CREATE TABLE ex2_1 (
    column1 char(10),
    column2 varchar2(10),
    column3 nvarchar2(10),
    column4 number
);

-- 데이터 삽입  : INSERT INTO 테이블명(컬럼명, 컬럼명) VALUES(값1, 값2);
INSERT INTO ex2_1(column1, column2) VALUES('ABC', 'abc');

-- LENGTH(COLUMN) : 컬럼의 기억장소의 길이 출력
-- 컬럼의 시제 기억장소의 크기를 확인 CHAR(10)와 VARCHAR2(10)의 차이점
SELECT COLUMN1, LENGTH(COLUMN1), COLUMN2, LENGTH(COLUMN2) FROM EX2_1;

CREATE TABLE ex2_2 (
    COLUMN1 VARCHAR2(3), -- 3BYTE 의미
    COLUMN2 VARCHAR2(3 BYTE),
    COLUMN3 VARCHAR2(3 CHAR) -- 3글자가 들어간다! 크기와 상관없이 한글 또는 영문이든 3글자를 입력 목적
);

-- 오라클 데이터베이스 시스템
/*
    영문자, 특수문자 : 1BYTE 관리
    한글 : 3BYTE. 오라클 설치환경설정에 따라 상대적이다. 2BYTE일 수도 있음.
        그래서 LENGTHB() 사용하여 확인이 필요함.
*/

-- 함수 : LENGTHB() : B는 BYTE의미. 그래서 매개변수에 제공되는 데이터의 BYTE길이를 구함.
SELECT LENGTHB ('A'), LENGTHB('1'), LENGTHB('*'), LENGTHB('김') FROM DUAL;
SELECT LENGTHB('손흥민') FROM DUAL; -- 9 BYTE

-- 데이터 삽입. 영문 문자열 데이터는 대소문자 구분. 'ABC'와 'abc'는 다른 데이터.
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3) VALUES('abc', 'abc', 'abc');

-- 데이터 조회
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM EX2_2;

-- 한글데이터 조회
-- ORA-12899: value too large for column "SQLDB"."EX2_2"."COLUMN1" (actual: 9, maximum: 3)
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3) VALUES ('홍길동', '홍길동', '홍길동');

-- 설명 : COLUMN3이 VARCHAR2(3 CHAR)이므로 한글 3개 문자를 데이터 삽입성공
INSERT INTO ex2_2(COLUMN3) VALUES('홍길동');

-- 데이터 조회
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM EX2_2;

-- 숫자 데이터 타입 : NUMBER[(P, [s])]
CREATE TABLE EX2_3 (
    COL_INT     INTEGER,
    COL_DEC     DECIMAL,
    COL_NUM     NUMBER
    ); -- 모두 내부적으로 NUMBER 데이터타입으로 변환되어 짐.
    
-- user_tab_cols 시스템 뷰 : 테이블의 컬럼정보를 확인할 때 
SELECT column_id, column_name, data_type, data_length
    FROM user_tab_cols
    WHERE table_name = 'EX2_3' -- 테이블명을 데이터로 사용할 경우 대문자로 입력
    ORDER BY column_id;

-- 날짜 데이터타입 : DATE - 초 단위까지 관리. TIMESTAMP - 밀리세컨드 단위까지 관리
CREATE TABLE EX2_5 (
    COL_DATE        DATE,
    COL_TIMESTAMP   TIMESTAMP
);

-- 날짜형 데이터베이스 함수 : SYSDATE, SYSTIMESTAMP
-- 데이터삽입
INSERT INTO EX2_5(COL_DATE, COL_TIMESTAMP) VALUES(SYSDATE, SYSTIMESTAMP);
SELECT * FROM ex2_5;

-- 시나리오
/*
    테이블명 : USERINFO
    컬럼명 : 이름(U_NAME), 주소(U_ADDR), 연락처(U_TEL), 나이(U_AGE), 등록일(U_REG)
*/

CREATE TABLE USERINFO (
    U_NAME  VARCHAR2(50),
    U_ADDR  VARCHAR2(100),
    U_TEL   VARCHAR2(20),
    U_AGE   NUMBER,
    U_REG   DATE
);

INSERT INTO USERINFO(U_NAME, U_ADDR, U_TEL, U_AGE, U_REG)
    VALUES('유영', '서울시 노원구 노원역인근', '010-7446-2309', 28, SYSDATE);

SELECT * FROM USERINFO;

-- LOB 데이터타입
-- LOB는 'LARGE OBJECT'의 약자로 대용량 데이터를 저장할 수 있는 데이터 타입

-- 문자열 대용량 데이터는 CLOB나 NCLOB, 4000BYTE보다 큰 문자열데이터 저장
-- 그래픽 이미지 동영상 등의 데이터는 BLOB
-- BFILE은 실제 이진파일이 아닌 데이터베이스 외부에 있는 파일에 대한 로케이터(해당 파일을 가리키는 포인터)를 저장하며
-- 실제 파일을 수정할 수는 없고 읽기만 가능함.
CREATE TABLE SAMPLE_1 (
    COL1    VARCHAR2(50),
    COL2    CLOB
);

INSERT INTO sample_1(COL1, COL2) VALUES ('진달래', '작엽활엽 관목으로, 한반도에 주로 분포');
INSERT INTO sample_1(COL1, COL2) VALUES ('개나리', '물푸레나무과 식물로 봄철에 노란 꽃을 피우는 관목의 한 종류');
INSERT INTO sample_1(COL1, COL2) VALUES ('봉선화', '쌍떡잎식물 무환자무목 봉선화과의 한해살이풀');

-- 정렬 : ORDER BY COL1
SELECT * FROM sample_1 ORDER BY col1 ASC;

-- (에러) 정렬 : ORDER BY COL2. LOB는 정렬기능이 지원되지 않음.
SELECT * FROM sample_1 ORDER BY col2 ASC;

-- NULL : 값이 없음을 의미함. 디폴트 값이 NULL이며
-- 별도로 지정하지 않으면 해당 컬럼은 NULL을 허용함.
CREATE TABLE SAMPLE_2 (
    COL1 NUMBER NULL, -- NULL은 생략가능.
    COL2 VARCHAR2(50) NOT NULL -- 반드시 데이터를 삽입해야 함.
);

-- 데이터 입력. 오류 NOT NULL 이 무조건 있어야 함.
INSERT INTO SAMPLE_2(COL1) VALUES (1);

-- 데이터 입력. COL1 컬럼이 NULL허용이기 때문에 생략 가능.
INSERT INTO SAMPLE_2(COL2) VALUES ('테스트');

INSERT INTO SAMPLE_2(COL1, COL2) VALUES (1, '테스트2');

SELECT * FROM SAMPLE_2;

-- 주의? DBMS 종류에 따라 NULL 처리가 조금씩 다를 수 있어, 실무에서 데이터베이스에 따른 NULL 사용법을 확인할 것.

--  제약조건
-- NOT NULL : 반드시 값이 들어있어야 함.

CREATE TABLE EX2_6 (
    COL_NULL        VARCHAR2(10),
    COL_NOT_NULL    VARCHAR2(10) NOT NULL
    -- 오라클 서버가 자동으로 SYS_C007042 제약조건객체이름 NOT NULL로 설정.
);

-- 데이터 삽입 시 컬럼명을 생략 할 경우에는 모든 컬럼명을 입력한다는 의미
-- 아래 두 구문은 NULL문제로 에러 발생 ORA-01400: cannot insert NULL into ("SQLDB"."EX2_6"."COL_NOT_NULL")
INSERT INTO EX2_6 VALUES('AA', ''); -- ''는 NULL로 해석. 비추천.
INSERT INTO EX2_6 VALUES('AA', NULL); -- 위와 같음. ANSI-SQL표준문법.

INSERT INTO EX2_6 VALUES('AA', 'BB'); -- (컬럼명1, 컬럼명1)가 생략되어 있음.
SELECT col_null, COL_NOT_NULL FROM EX2_6;

-- USER_CONSTRAINTS 시스템뷰 : 테이블 제약조건 정보를 확인하는 용도.
SELECT constraint_name, constraint_type, table_name, search_condition
    FROM user_constraints
    WHERE table_name = 'EX2_6';

-- UNIQUE
-- 해당 컬럼에 들어가는 값이 유일해야 함.(주민등록번호 등).
CREATE TABLE SAMPLE_3 (
    U_NAME      VARCHAR2(50)    NOT NULL,
    SSN         CHAR(14)    UNIQUE NOT NULL
    -- 오라클 서버가 SYS_C007045 제약조건 객체이름으로 SSN컬럼에 UNIQUE제약조건 설정
);

-- 데이터 입력
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('손흥민', '123456-1234567');
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('김민재', '123456-1234567');

SELECT * FROM SAMPLE_3;

-- 제약조건을 설정 시 문법적 1) 컬럼 수준제약 2) 테이블 수준 제약
CREATE TABLE EX2_7 ( -- 단일 컬럼 각각에 UNIQUE 제약조건이 적용. 테이블에 UNIQUE 제약조건이 3개 적용되어 있음.
    COL_UNIQUE_NULL     VARCHAR2(10)  UNIQUE, -- 컬럼수준 제약. NULL 허용
    COL_UNIQUE_NNULL    VARCHAR2(10)  UNIQUE NOT NULL, --오라클 서버가 UNIQUE제약조건 이름을 자동생성
    COL_UNIQUE          VARCHAR2(10),
    CONSTRAINT UNIQUE_NM1 UNIQUE(COL_UNIQUE) -- 테이블수준 제약
);
-- , 전에 컬럼에 대한 제약조건 명령어를 구사할 시 컬럼 수준제약
-- 전체적인 관점에서 바라보고 제약조건 명령어를 구사할 시 테이블 수준 제약

-- 데이터 입력
INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- 첫번째 실행
INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- 두 번째 실행
-- ORA-00001: unique constraint (SQLDB.SYS_C007047) violated

-- NULL도 중복성 검사에 해당되나? NULL은 중복성 검사에 안 걸림.
INSERT INTO EX2_7 VALUES('', 'BB', 'BB'); -- 세 번째 실행, ''는 NULL
SELECT * FROM EX2_7;

INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); -- 네 번째 실행
SELECT * FROM EX2_7;


INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); -- 다섯번째 실행
-- ORA-00001: unique constraint (SQLDB.SYS_C007048) violated

-- 테이블에 컬럼을 두 개 이상 묶어서 UNIQUE제약조건 적용하기.(복합 컬럼)
-- 테이블 수준 제약 문법을 사용해야 복합컬럼을 UNIQUE 제약조건을 적용할 수 있음.
CREATE TABLE SAMPLE_5 (
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10),
    CONSTRAINT UNI_FIRST UNIQUE(COL1, COL2)
    -- 이렇게 하면 4개 열을 한 번에 묶어서 적용시킬 수 있음.
);

INSERT INTO SAMPLE_5(COL1, COL2) VALUES(1, 'A'); -- 첫 번째 실행

INSERT INTO SAMPLE_5(COL1, COL2) VALUES(1, 'B'); -- 첫 번째 실행

INSERT INTO SAMPLE_5(COL1, COL2) VALUES(1, 'A'); -- 첫 번째 실행
-- 이렇게 한 번에 묶어서 할 경우엔, 제약조건에 의한 데이터가 동시에 만족하지 않으면 에러 발생.

-- PRIMARY KEY : 기본 키이며 UNIQUE와 NOT NULL 속성을 동시에 가지고 있음.

CREATE TABLE EX2_8 (
    COL1    VARCHAR2(10)    PRIMARY KEY, -- UNIQUE와 NOT NULL 특징
    COL2    VARCHAR2(10)
);

-- 데이터 입력

-- ORACLE INSERT문
INSERT INTO EX2_8 VALUES('', 'AA'); --ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")
-- ANSI-SQL INSERT문
INSERT INTO EX2_8 VALUES(NULL, 'AA');

INSERT INTO EX2_8 VALUES('AA', 'AA');

INSERT INTO EX2_8 VALUES('AA', 'AA'); --ORA-00001: unique constraint (SQLDB.SYS_C007051) violated

-- 복합키 테이블 예.
-- 에러 발생 02260. 00000 -  "table can have only one primary key"
CREATE TABLE SAMPLE_6 (
    COL1    NUMBER          PRIMARY KEY,
    COL2    VARCHAR2(10)    PRIMARY KEY, -- PRIMARY KEY는 테이블 당 하나만 가능함.
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10),
    UNIQUE(COL1, COL2)
);
-- 테이블 수준 제약으로 해야 함.
-- PRIMARY KEY 제약조건 개체이름이 오라클 서버가 자동으로 생성해줌.
-- 그래서 제약조건 객체 이름이 스프링에서 페이징기능 구현 시 사용이 될 경우에는 제약조건 객체 이름을 수동으로 생성해야 함(중요)
CREATE TABLE SAMPLE_7 (
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10),
    CONSTRAINT PK_SAMPLE_7_COL1_COL2 PRIMARY KEY(COL1, COL2)
);
-- 위의 테이블에 PRIMARY KEY(복합키) 설정으로 COL1, COL2 컬럼에 동시에 만족하는 데이터는 중복될 수 없음.
-- 여러개의 컬럼을 하나의 기본키로 만드는 경우 최대 컬럼개수는 32개까지 가능함.

INSERT INTO sample_7(COL1, COL2) VALUES(12, 'AA');
INSERT INTO sample_7(COL1, COL2) VALUES(12, 'BB');
INSERT INTO sample_7(COL1, COL2) VALUES(12, 'AA');
INSERT INTO sample_7(COL1, COL2) VALUES(12, 'BB');

-- FOREIGN KEY : 외래키, 테이블 간의 참조 데이터 무결성을 위한 제약조건

-- 부서 테이블
CREATE TABLE DEPT (
    D_CODE  NUMBER          PRIMARY KEY,
    D_NAME  VARCHAR2(20)    NOT NULL
);

-- 사원 테이블
CREATE TABLE EMP (
    E_ID    NUMBER  PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER REFERENCES DEPT(D_CODE) -- 컬럼수준 제약
);

CREATE TABLE EMP (
    E_ID    NUMBER  PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER,
    FOREIGN KEY(D_CODE) REFERENCES DEPT(D_CODE) -- 테이블 수준 제약
);

-- 테이블 삭제 : 참조받는 테이블은 나중에 삭제하고 참조하는 테이블을 먼저 삭제
DROP TABLE EMP;
DROP TABLE DEPT;

-- 테이블 참조키 설정된 모습을 툴로 확인하기.
-- 보기 - DATA MODELER - 브라우저
-- 브라우저 도구모음에서 관계형 모델 [] 선택 - 우클릭 '새 관계형 모델'

-- 데이터 입력(부서 테이블)
INSERT INTO DEPT VALUES(1, '총무부');
INSERT INTO DEPT VALUES(2, '개발부');
INSERT INTO DEPT VALUES(3, '영업부');
INSERT INTO DEPT VALUES(4, '홍보부');

-- 데이터 입력(사원 테이블)
INSERT INTO EMP VALUES(1001, '손흥민', 1);
INSERT INTO EMP VALUES(1002, '김민재', 4);
INSERT INTO EMP VALUES(1003, '황희찬', 3);
INSERT INTO EMP VALUES(1004, '이강인', 2);

-- 에러 ORA-02291: integrity constraint (SQLDB.SYS_C007076) violated - parent key not found
INSERT INTO EMP VALUES(1005, '황선홍', 7);

-- CHECK 제약조건
CREATE TABLE EX2_9 (
    NUM1    NUMBER
        CONSTRAINT CHECK1 CHECK(NUM1 BETWEEN 1 AND 9), -- NUM1컬럼에 숫자 데이터 1~9 범위로 입력가능
    GENDER  VARCHAR2(10)
        CONSTRAINT CHECK2 CHECK(GENDER IN ('MALE', 'FEMALE')) -- GENDER컬럼에 문자데이터 'MALE', 'FEMALE' 문자데이터만 입력가능
);

DROP TABLE EX2_9;

-- 데이터 입력
INSERT INTO EX2_9 VALUES(10, 'MAN'); --ORA-02290: check constraint (SQLDB.CHECK2) violated

INSERT INTO EX2_9 VALUES(5, 'FEMALE');

SELECT * FROM EX2_9;

COMMIT;
-- 커밋을 하지 않으면 데이터 입력한 것이 현재 임시상태에 있음. 그래서 입력한 데이터를 완전히 반영하고자 한다면 커밋을 해야 함.

-- DEFAULT(기본값) : 제약조건은 아니지만 컬럼 속성 명령어
CREATE TABLE EX2_10 (
    COL1    VARCHAR2(10)    NOT NULL,
    COL2    VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

-- 데이터 입력
-- CREATE_DATE 컬럼 입력 시 생략하게 되면 데이터 삽입 시 DEFAULT SYSDATE 작동.
-- 컴퓨터의 날짜와 시간을 읽어와서 삽입됨.
INSERT INTO EX2_10(COL1, COL2) VALUES('AA', 'BB');

-- CREATE_DATE 컬럼에 데이터 입력
INSERT INTO EX2_10 VALUES('AA', 'BB', '2024-04-04'); -- 날짜를 문자열로 넣으면 알아서 형변환이 된다고 생각하기.

-- 데이터 조회
SELECT * FROM EX2_10;


-- 실습
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


-- 테이블 삭제 (순서가 아주아주 중요)
DROP TABLE DEPT_CONST;
DROP TABLE EMP_CONST;

-- [CASCADE CONSTRAINTS] 사용
DROP TABLE DEPT_CONST CASCADE CONSTRAINTS; -- EMP_CONST테이블의 참조키 제약조건을 자동삭제

DROP TABLE EX2_10;

-- 테이블 변경
-- 기존에 생성했던 컬럼의 데이터 타입을 수정하거나 삭제. 새로운 컬럼을 추가하는 경우가 발생
CREATE TABLE EX2_10 (
    COL1        VARCHAR2(10)    NOT NULL,
    COL2        VARCHAR2(10)    NULL,
    CREATE_DATE DATE            DEFAULT SYSDATE
);

-- COL1을 COL11로 변경 : ALTER TABLE [스키마.]테이블명 RENAME COLUMN 변경전컬럼명 TO 변경후컬럼명;
ALTER TABLE EX2_10 RENAME COLUMN COL1 TO COL11;

-- 컬럼변경 확인
DESC EX2_10; --테이블의 컬럼구성 확인

-- 컬럼타입변경 : ALTER TABLE [스키마.]테이블명 MODIFY 컬럼명 데이터타입;
ALTER TABLE EX2_10 MODIFY COL2 VARCHAR2(30);

-- 컬럼 확인
DESC EX2_10;

-- 컬럼 추가
ALTER TABLE EX2_10 ADD COL3 NUMBER;
DESC EX2_10;

-- 컬럼 삭제
ALTER TABLE EX2_10 DROP COLUMN COL3;
DESC EX2_10;

-- 제약조건 추가
ALTER TABLE EX2_10 ADD CONSTRAINT PK_EX2_10 PRIMARY KEY(COL11);

-- 제약조건 삭제
ALTER TABLE EX2_10 DROP CONSTRAINT PK_EX2_10;

SELECT * FROM EX2_9;

-- 테이블 복사
CREATE TABLE EX2_9_1 AS SELECT * FROM EX2_9;

SELECT * FROM EX2_9_1;

-- 시나리오 : 사원 테이블 중 부서코드가 50번인 데이터를 보관하는 테이블을 생성.
CREATE TABLE EMP_DEPARTMENT_ID_50 
AS
SELECT employee_id, EMP_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

-- 확인
SELECT * FROM EMP_DEPARTMENT_ID_50;

-- 시나리오 : 사원테이블에서 급여가 5000 이상인 데이터를 EMP_SALARY_5000 테이블명으로 생성하라.
-- 컬럼명은 사원번호, 사원이름, 급여, 커미션, 부서코드 사용
CREATE TABLE EMP_SALARY_5000
AS
SELECT employee_id, EMP_NAME, SALARY, COMMISSION_PCT, DEPARTMENT_ID
FROM EMPLOYEES WHERE SALARY >= 5000;

SELECT * FROM EMP_SALARY_5000;

-- 데이터 입력
-- 201번 사원번호가 이미 존재함. 근데도 아래의 문장은 입력이 됨.
-- 왜냐면 PRIMARY KEY가 복사가 안 되어서 사원번호가 중복저장이 가능하게 된 것임.
INSERT INTO EMP_SALARY_5000 VALUES(201, 'YY', 20000, NULL, 20);






COMMIT; -- 항상 하루 작업 끝나면 COMMIT 추가를 무조건 해야 함. 안하면 데이터가 날라감.