-- PL/SQL
-- SQL : DCL, DDL, DML, TCL
-- DML : SELECT, INSERT, UPGRATE, DROP, MERGE 명령어 학습
-- SELELCT : 테이블의 데이터를 조회하는 명령어
/*
SELECT 컬럼명, 컬럼명, .... FROM 테이블명
*/

-- SQL명령어는 대소문자 구분안함.
SELECT * FROM employees; -- * : 테이블의 모든 컬럼명 의미.

-- 스키마 : 테이블과 같은 데이터베이스 개체들을 논리적인 단위로 묶어서 관리
SELECT * FROM HR.employees; -- 접속 또는 연결상태가 HR로 되어 있으면, 스키마 이름은 생략가능

-- 사원테이블에서 사원번호, 이름, 전자우편, 입사일, 급여을 조회하라. ||는 더하기를 의미
SELECT employee_id, first_name || last_name, email, hire_date, salary FROM employees;

-- 테이블의 컬럼을 선택하여 마우스로 드래그
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- 컬럼별칭 사용 AS
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME AS NAME,
EMAIL, HIRE_DATE, SALARY FROM employees;

-- AS 생략
SELECT employee_id ID, FIRST_NAME || ' ' || LAST_NAME AS NAME,
EMAIL EMAIL,HIRE_DATE HD, SALARY SAL FROM employees;

-- 부서 테이블에서 부서명을 조회하라.
SELECT department_name FROM departments;

-- 부서 테이블에서 부서코드, 부서명을 조회하라. "쿼리"를 작성하라 라고도 함.
SELECT department_id "부서 번호", department_name 부서명 FROM departments;











