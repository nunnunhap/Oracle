-- 질의? EMPLOYEES테이블에서 SALARY가 5000이 넘는 사원번호와 사원명을 조회
SELECT DEPARTMENT_ID, EMP_NAME FROM EMPLOYEES WHERE SALARY > 5000;

SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 5000 ORDER BY EMPLOYEE_ID ASC; -- 오름차순

SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 5000 ORDER BY EMPLOYEE_ID DESC; -- 내림차순

-- 질의? 급여가 5000이상이고 JOB_ID가 'IT_PROG'인 사원을 조회
-- AND 연산자와 JOB_ID를 검색하는 조건을 추가
SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 5000
AND JOB_ID = 'IT_PROG' ORDER BY EMPLOYEE_ID ASC; -- 문자열 데이터는 대소문자 구분하니 주의('IT_PROG')

-- 질의? 급여가 5000이상이거나 JOB_ID가 'IT_PROG'인 사원을 조회
SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES
WHERE SALARY > 5000 OR JOB_ID = 'IT_PROG' 
ORDER BY EMPLOYEE_ID ASC;

-- INSERT문
-- INSERT INTO 테이블명 (컬럼1, 컬럼2) VALUES (값1, 값2);
CREATE TABLE EX3_1 (
    COL1        VARCHAR2(10),
    COL2        NUMBER,
    COL3        DATE
);

-- 데이터 삽입
INSERT INTO EX3_1 (Col1, COL2, COL3) VALUES('ABC', 10, SYSDATE);

-- 데이터 조회
SELECT * FROM EX3_1;

-- 컬럼 순서를 바꾸더라도 VALUES절에 있는 값을 바뀐 순서와 맞추기만 하면 문제가 없음.
INSERT INTO EX3_1(COL3, COL1, COL2) VALUES(SYSDATE, 'DEF', 20);

-- 컬럼(필드, 열)이 NULL, DEFAULT일 경우는 생략가능함. 데이터 삽입 시 NULL로 처리
INSERT INTO EX3_1(COL1, COL2) VALUES ('GHI', 20);
SELECT * FROM EX3_1;

-- INSERT - SELECT 형태
-- 키워드(예약어)는 대문자로, 나머지는 소문자로 형식 패턴으로 작업하는 경향도 있음.

-- 이것이 1번
CREATE TABLE ex3_2 (
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

INSERT INTO ex3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees
WHERE salary > 5000;

-- 데이터 조회
SELECT * FROM ex3_2;

-- 이것이 2번
-- 테이블 백업, 테이블 복사
CREATE TABLE employees_bak
AS
SELECT employee_id, emp_name FROM employees
WHERE salary > 5000;

-- 데이터 조회
SELECT * FROM employees_bak;

-- ex3_1 테이블의 col2 값을 모두 50으로 변경해보자.
-- UPDATE문. 
UPDATE ex3_1
SET col2 = 50; -- WHERE 조건식이 생략되면 테이블의 모든 데이터를 변경하는 의미.

-- 데이터 조회
SELECT * FROM ex3_1;

-- 질의? COL1 컬럼에서 'ABC'인 데이터의 COL2컬럼의 값을 100으로 변경하라.
UPDATE ex3_1
SET col2 = 100
WHERE col1 = 'ABC';

SELECT * FROM ex3_1 WHERE col1 = 'ABC';

-- 데이터 조회
SELECT * FROM ex3_2 ORDER BY emp_id ASC;

-- 질의?
UPDATE ex3_2 SET emp_name = 'Peter Tucker Junior' WHERE emp_id = 150;

SELECT * FROM ex3_2 WHERE emp_id = 150;

-- 시나리오? employees 테이블에서 salary 컬럼에서 급여가 8000 이상인 데이터를 다음 컬럼으로
-- employee_id, emp_name, email, salary 구성되는 테이블(emp_salary_8000)을 생성
CREATE TABLE emp_salary_8000
AS
SELECT employee_id, emp_name, email, salary
FROM employees
WHERE salary > 8000;

SELECT * FROM emp_salary_8000 ORDER BY salary ASC;

-- 질의? 사원 번호가 100번인 데이터를 email컬럼은 'kings'로 변경하고 salary 컬럼은 20000 으로 변경하라.
UPDATE emp_salary_8000 SET email = 'KINGS', salary = 20000 WHERE employee_id = 100;

SELECT * FROM emp_salary_8000;


-- DELETE문 : 테이블에 있는 데이터를 삭제할 때 DELETE문 사용함.
SELECT * FROM emp_salary_8000 ORDER BY employee_id ASC;

-- 100번 데이터를 삭제하고자 함.
DELETE FROM emp_salary_8000 WHERE employee_id = 206;

-- 데이터 조회
SELECT * FROM emp_salary_8000 WHERE employee_id = 100;

-- 시나리오? 급여가 10000~13000 범위의 데이터를 삭제
DELETE emp_salary_8000 WHERE salary BETWEEN 10000 AND 13000;

SELECT * FROM emp_salary_8000 ORDER BY salary ASC;

-- 시나리오? 사번이 101 또는 145인 데이터를 삭제
DELETE emp_salary_8000 WHERE employee_id = 101 OR employee_id = 145;

SELECT * FROM emp_salary_8000 WHERE employee_id = 101 OR employee_id = 145 ORDER BY employee_id;

COMMIT;


-- TRUNCATE문
-- DELETE문은 COMMIT을 해야만 완전 삭제가 되며 ROLLBACK 시 복구 가능하나 이건 모든 테이블 데이터가 삭제됨.
CREATE TABLE ex3_4 (
    employee_id     NUMBER
);

INSERT INTO ex3_4 VALUES(100);

-- 데이터 조회
SELECT * FROM ex3_4;

ROLLBACK; -- 현재 입력한 데이터가 취소

INSERT INTO ex3_4 VALUES(100);

SELECT * FROM ex3_4;

COMMIT;

-- 데이터 조회
SELECT * FROM ex3_4;

-- 조건식 WHERE절 문법이 지원이 안됨. ROLLBACK 지원 안됨. 복구 불가.
TRUNCATE TABLE ex3_4; -- Table EX3_4이(가) 잘렸습니다.

ROLLBACK;

SELECT * FROM ex3_4;


-- 의사컬럼
-- 테이블의 컬럼처럼 동작하지만 실제로 테이블에 저장되지 않는 컬럼을 말함.

--1) ROWNUM : 쿼리에서 반환되는 각 로우들에 대한 순서 값을 나타내는 의사컬럼
SELECT ROWNUM, employee_id, emp_name FROM employees WHERE salary > 5000;

-- 화면에 출력되는 데이터를 제한
SELECT ROWNUM, employee_id, emp_name FROM employees
WHERE ROWNUM <= 5;

SELECT ROWNUM, employee_id, emp_name FROM employees
WHERE ROWNUM <= 15;
-- 중간값을 가져오는건 불가능함. 

--2) ROWID
SELECT ROWNUM, ROWID, employee_id, emp_name FROM employees WHERE ROWNUM <= 5;



-- 연산자 : 수식연산자 NUMBER데이터타입에 해당하는 컬럼 또는 숫자 데이터에 사용

-- 테이블 구조 정보
DESC employees;

SELECT employee_id, salary, commission_pct, salary * 12 + commission_pct
AS "연봉" FROM employees ORDER BY employee_id;

-- 위의 출력결과 중 NULL로 확인되는 것은 컬럼 데이터가 NULL이 존재하면, 결과가 NULL이 됨.

-- 연산 시 NULL이 존재하고 있으면 NULL이 존재하면 결과가 NULL이 됨.
-- NULL 관련 기능은 NULL 관련 함수를 할습해야 함.
SELECT 10 + 20 FROM DUAL; -- NULL

-- 논리 연산자: >, <, >=, <=, =, <>, !=, \^=

-- 표현식 : CASE문 : https://gent.tistory.com/311
-- CASE문 유형
SELECT employee_id, emp_name, department_id FROM employees ORDER BY department_id;
--1) IF문 유형 : 부서컬럼 데이터가 10이면 New York, 20번이면 Dallas, 기타 나머지는 Unknown
SELECT
    employee_id, emp_name, department_id,
    CASE
        WHEN department_id = 10 THEN 'NEW YORK'
        WHEN department_id = 20 THEN 'Dallas'
        ELSE 'Unknown'
    END AS department_city
FROM
    employees
ORDER BY department_id;

--2) SWITCH문 유형
SELECT employee_id, emp_name, department_id,
    CASE department_id
        WHEN 10 THEN 'NEW YORK'
        WHEN 20 THEN 'Dallas'
        ELSE 'Unknown'
    END AS department_city
FROM
    employees
ORDER BY department_id;

-- ELSE 생략하는 경우
SELECT
    employee_id, emp_name, department_id,
    CASE
        WHEN department_id = 10 THEN 'NEW YORK'
        WHEN department_id = 20 THEN 'Dallas'
--        ELSE 'Unknown'
    END AS department_city
FROM
    employees
ORDER BY department_id;

-- 시나리오 : salary(급여)가 15000이상이면 고액연봉. 10000이상이면 우수연봉 나머지는 일반연봉으로 출력하라
SELECT
    employee_id
    , emp_name
    , salary
    , CASE
        WHEN salary >= 15000 THEN '고액연봉'
        WHEN salary >= 10000 THEN '우수연봉'
        ELSE '일반연봉'
    END AS salary_gubun
FROM
    employees
ORDER BY
    salary DESC;

-- 중첩 CASE 추가연산작업 가능
SELECT
    employee_id, emp_name, department_id, salary,
    CASE
        WHEN department_id = 10 THEN
            CASE
                WHEN salary >= 15000 THEN '1등급'
                WHEN salary >= 10000 THEN '2등급'
                WHEN salary >= 3000  THEN '3등급'
            END
        WHEN department_id = 20 THEN
            CASE
                WHEN salary >= 18000 THEN '1등급'
                WHEN salary >= 15000 THEN '2등급'
                WHEN salary >= 5000  THEN '3등급'
            END
        WHEN department_id = 30 THEN
            CASE
                WHEN salary >= 8000 THEN '1등급'
                WHEN salary >= 5000 THEN '2등급'
                WHEN salary >= 2000 THEN '3등급'
            END
        ELSE ' '
    END AS salary_gubun
FROM
    employees
ORDER BY department_id ASC;


-- 비교 조건식 : ANY, SOME, ALL
-- salary가 2000 3000 4000 인 데이터를 조회 ANY는 OR와 같음.
--1) ANY 사용
SELECT employee_id, salary
FROM employees
WHERE salary = ANY (2000, 3000, 4000)
ORDER BY employee_id;
--2) OR 사용
SELECT employee_id, salary
FROM employees
WHERE salary = 2000
    OR salary = 3000
    OR salary = 4000
ORDER BY employee_id;
--3) ALL사용은 불가능. 2000,3000,4000을 동시에 만족할 수 없음.

-- 4000보다 salary가 큰 데이터 조회
SELECT employee_id, salary
FROM employees
WHERE salary > ALL (2000, 3000, 4000)
ORDER BY employee_id;

-- salary가 2000보다 큰 데이터 조회
SELECT employee_id, salary
FROM employees
WHERE salary > ANY (2000, 3000, 4000)
ORDER BY employee_id;

-- salary가 2000보다 큰 데이터 조회
SELECT employee_id, salary
FROM employees
WHERE salary > SOME (2000, 3000, 4000)
ORDER BY employee_id;
-- SOME과 ANY는 동일.

-- 논리 조건식 : AND OR NOT
SELECT employee_id, salary
FROM employees
WHERE NOT (salary >= 2500)
ORDER BY employee_id;
-- 성능 때문에 위를 사용하는 경우가 있음
SELECT employee_id, salary
FROM employees
WHERE salary < 2500
ORDER BY employee_id;


-- NULL 조건식
-- 조건식에서 사용되는 IS NULL, IS NOT NULL
SELECT employee_id, emp_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NULL;

SELECT employee_id, emp_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;


-- IN 조건식 : 조건절에 명시한 값이 포함된 건을 반환하는데 앞에서 배웠던 ANY와 비슷하다.

-- 급여가 2000, 3000, 4000에 포함되는 사원을 추출한 결과
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN (2000, 3000, 4000); -- OR, ANY로 변환 가능

SELECT employee_id, emp_name, salary FROM employees
WHERE salary NOT IN (2000, 3000, 4000);


-- LIKE 조건식 : 문자열의 패턴을 검색할 때 사용하는 조건식
-- 사원 테이블에서 사원이름이 ‘A’로 시작되는 사원을 조회하는 쿼리
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'Al%'
ORDER BY emp_name;
-- 이렇게 와일드 카드 문자는 무조건 LIKE 붙여주어야 함.
SELECT emp_name
FROM employees
WHERE emp_name = 'A%' -- 에러
ORDER BY emp_name;

-- %
CREATE TABLE ex3_5 (
    name    VARCHAR2(30)
);

INSERT INTO ex3_5 VALUES('홍길동');
INSERT INTO ex3_5 VALUES('홍길용');
INSERT INTO ex3_5 VALUES('홍길상');
INSERT INTO ex3_5 VALUES('홍길상동');
INSERT INTO ex3_5 VALUES('홍길');

SELECT * FROM ex3_5;

SELECT * FROM ex3_5
WHERE name LIKE '홍길%';

SELECT * FROM ex3_5
WHERE name LIKE '홍길_';

-- MERGE
/*
MERGE문은 조건을 비교해서 테이블에 해당 조건에 맞는 데이터가 없으면 INSERT, 있으면 UPDATE를 수행하는 문장이다.
특정 조건에 따라 어떤 때는 INSERT를, 또 다른 경우에는 UPDATE문을 수행해야 할 때, 과거에는 해당 조건을 처리하는 로직을 별도로 작성해야 했지만,
MERGE문이 나온 덕분에 이제 한 문장으로 처리할 수 있게 되었다.

    MERGE INTO [스키마.]테이블명
        USING (update나 insert될 데이터 원천)
             ON (update될 조건)
    WHEN MATCHED THEN
           SET 컬럼1 = 값1, 컬럼2 = 값2, ...
    WHERE update 조건
           DELETE WHERE update_delete 조건
    WHEN NOT MATCHED THEN
           INSERT (컬럼1, 컬럼2, ...) VALUES (값1, 값2,...)
           WHERE insert 조건;
*/

-- HR계정 접속사용, SCOTT 계정 접속 사용
-- 1) 단일 테이블 사용(DUAL)
-- 시나리오? 사원테이블의 사원번호 7738이 존재하면 업데이트
-- 존재하지 않으면 INSERT작업을 하자.
SELECT * FROM EMP WHERE empno = 7738; --데이터 없음.

MERGE
    INTO emp a
    USING DUAL
        ON (a.empno = 7738)
    WHEN MATCHED THEN -- 위의 조건이 참이면
        -- UPDATE emp a SET a.deptno = 20 WHERE a.empno = 7738
        UPDATE
            SET a.deptno = 20
    WHEN NOT MATCHED THEN
        -- INSERT emp a (a.empno, a.ename, a.deptno) VALUES(7788, 'SCOTT', 20);
        INSERT (a.empno, a.ename, a.deptno)
        VALUES(7738, 'SCOTT', 20);

ROLLBACK;

-- 2) JOIN 사용 : scott계정 접속에서 job_history테이블이 존재 안함.
SELECT *
FROM job_history a, emp b
WHERE a.empno = b.empno
AND a.empno = 7738;

MERGE
    INTO job_history a
    USING emp b
    ON (a.empno = 7738 AND a.empno)
    WHEN MATCHED THEN
        UPDATE
            SET a.job = b.job, a.deptno = b.deptno
    WHEN NOT MATCHED THEN
        INSERT (a.empno, a.job, a.deptno) VALUES(b.empno, b.job, b.deptno);
        
-- DELETE절 사용
MERGE
    INTO emp a
    USING dual
        ON (a.empno = 7738)
    WHEN MATCHED THEN
        UPDATE
            SET a.deptno = 20 WHERE a.job = 'ANALYST'
        DELETE
            WHERE a.job <> 'ANALYST';


COMMIT;
