/*
    VIEW : 하나 이상의 테이블이나 다른 뷰의 데이터를 볼 수 있게 하는 데이터베이스 객체
    데이터를 조회하는 개념이다보니 SELECT문을 사용함.
    
    CREATE OR REPLACE VIEW [스키마.]뷰명 AS
    SELECT 문장;
    
    용도 : SELECT문으로 시작하는 긴 문장을 저장하여 관리가 용이하게 함.
          보안적으로 중요한 컬럼을 가지고 있는 테이블 접근을 막고 뷰로 대체
*/

-- 설명 : VW_EMPLOYEES_DEPARTMENT_ID_50 뷰 이름으로 SELECT 구문의 코드를 저장하여 관리함.
CREATE OR REPLACE VIEW VW_EMPLOYEES_DEPARTMENT_ID_50
AS
SELECT emp_name, EMPLOYEE_ID, HIRE_DATE, SALARY, RETIRE_DATE, COMMISSION_PCT
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- 뷰 실행 : 뷰는 실제 데이터를 가지고 있는게 아니라 설렉트문이라는 코드를 가지고 있음.
SELECT * FROM VW_EMPLOYEES_DEPARTMENT_ID_50;

-- 뷰 삭제 : DROP VIEW [스키마.]뷰명;
DROP VIEW VW_EMPLOYEES_DEPARTMENT_ID_50;

-- SEQUENCE
CREATE SEQUENCE MY_SEQ1 --대개 이거 하나만 씀.
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE
NOCACHE;

CREATE SEQUENCE MY_SEQ2;

-- 시퀸스 명령어 NEXTVAL CURRVAL
SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- 최소값1
SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- 증가값이 작동 +1 
SELECT MY_SEQ2.CURRVAL FROM DUAL; -- 현재 시퀀스 값

CREATE SEQUENCE MY_SEQ3;
-- CURRVAL은 NEXTVAL을 쓴 후에만 사용 가능.
SELECT MY_SEQ2.CURRVAL FROM DAUL; -- 에러 발생

-- 시퀀스 사용
CREATE SEQUENCE MY_SEQ4;

CREATE TABLE SAMPLE_8 (
    IDX         NUMBER          PRIMARY KEY,
    NAME        VARCHAR2(20)    NOT NULL,
    REG_DATE    DATE            DEFAULT SYSDATE
);

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '손흥민');
INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '황희찬');
INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '김민재');
INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '이강인');

SELECT * FROM SAMPLE_8;

-- 시퀀스 생성
CREATE SEQUENCE MY_SEQ5
START WITH 1000 -- 초기값
INCREMENT BY 10; -- 증가값, 음수값도 가능

SELECT MY_SEQ5.NEXTVAL FROM DUAL;

-- 시퀀스 수정
ALTER SEQUENCE MY_SEQ5
INCREMENT BY 5;

DROP SEQUENCE MY_SEQ5;


-- 인덱스Index는 테이블에 있는 데이터를 빨리 찾기 위한 용도의 데이터베이스 객체
/*
? 인덱스 구성 컬럼 개수에 따른 분류: 단일 인덱스와 결합 인덱스
? 유일성 여부에 따른 분류: UNIQUE 인덱스, NON-UNIQUE 인덱스
? 인덱스 내부 구조에 따른 분류: B-tree 인덱스, 비트맵 인덱스, 함수 기반 인덱스
일반적으론 B-tree 인덱스가 가장 많이 사용됨.
*/
-- 테이블에 PRIMARY KEY 제약조건을 생성하면 자동으로 UNIQUE 인덱스가 생성됨.
-- 색인이 만들어지면 색인에 해당되는 데이터도 같이 만들어짐.

/*
    - 기본키
        1) 단일키 - 컬럼 1개 2) 복합키 - 컬럼을 복수로 하나의 단위로 묶어서 적용
  CREATE[UNIQUE] INDEX [스키마명.]인덱스명
    ON [스키마명.]테이블명(컬럼1, 컬럼2, ...);
*/

-- 컬럼 1개로 만든다고 하여 '단일 인덱스'
CREATE UNIQUE INDEX ex2_10_ix01
ON ex2_10 ( col11); 
--col1컬럼명에 중복된 데이터 불허, 컬럼의 데이터 검색 시 성능향상의 목적으로 인덱스 생성
SELECT * FROM ex2_10 WHERE col1 = 값;

-- 결합 인덱스, 중복방지 안됨
CREATE INDEX ex2_10_ix2
ON ex2_10(col11, col2);

CREATE TABLE 회원 (
회원 아이디, --PRIMARY KEY
이름,
주민등록번호
)
CREATE UNIQUE INDEX 회원_IDX
ON 회원(주민등록번호);

/*
    인덱스를 너무 많이 만들면 SELECT 외에 INSERT, DELETE, UPDATE 시 성능에 부하가 뒤따름.
    기본적으로 정렬상태로 만드는 것이기 때문임.
    
    인덱스를 생성할 때 고려해야 할 사항을 정리하면 다음과 같다.

? 일반적으로 테이블 전체 로우 수의 15%이하의 데이터를 조회할 때 인덱스를 생성한다
물론 15%는 정해진 것은 아니며 테이블 건수, 데이터 분포 정도에 따라 달라진다.

? 테이블 건수가 적다면(코드성 테이블) 굳이 인덱스를 만들 필요가 없다
데이터 추출을 위해 테이블이나 인덱스를 탐색하는 것을 스캔(scan)이라고 하는데, 테이블 건수가 적으면 인덱스를 경유하기보다
테이블 전체를 스캔하는 것이 빠르다.

? 데이터의 유일성 정도가 좋거나 범위가 넓은 값을 가진 컬럼을 인덱스로 만드는 것이 좋다

? NULL이 많이 포함된 컬럼은 인덱스 컬럼으로 만들기 적당치 않다

? 결합 인덱스를 만들 때는, 컬럼의 순서가 중요하다
보통, 자주 사용되는 컬럼을 순서상 앞에 두는 것이 좋다.

? 테이블에 만들 수 있는 인덱스 수의 제한은 없으나, 너무 많이 만들면 오히려 성능 부하가 발생한다
    
*/



COMMIT;


