-- 조인 : 2개의 테이블에서 컬럼끼리 비교하여, 동일한 데이터행을 수평적으로 결합한 기능
/*
표준 : 오라클 조인과 ANSI 조인
조인은 내부조인(INNER JOIN)과 외부조인(OUTER JOIN)으로 구분
- INNER JOIN : 일반적으로 조인을 얘기하면 INNER JOIN 이야기 함.
- OUTER JOIN :
    1. LEFT OUTER JOIN
    2. RIGHT OUTER JOIN
    3. FULL OUTER JOIN
*/

-- 질의? 사원번호, 이름, 부서명을 조회
-- 사원 테이블 : 사원번호, 이름
-- 부서 테이블 : 부서명

SELECT employee_id, emp_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- 시나리오 emp테이블과 dept테이블을 조인하여 데이터를 출력하라.
SELECT d_name, e_id, e_name
FROM dept, emp
WHERE dept.d_code = emp.d_code
AND emp.e_id = 1001;

-- ANSI JOIN(INNER JOIN)
SELECT employee_id, emp_name, department_name
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id;

SELECT d_name, e_id, e_name
FROM dept INNER JOIN emp
ON dept.d_code = emp.d_code
WHERE emp.e_id = 1001;

-- 테이블 별칭을 사용하여 INNER JOIN하는 구문
SELECT a.employee_id, a.emp_name, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;

SELECT e.employee_id, e.emp_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

-- 테이블 3개 조인 : 오라클 문법
SELECT *
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id
INNER JOIN job_history
ON departments.department_id = job_history.department_id;

--OUTER JOIN
-- 1. 일반 조인
-- 일치되는 데이터만 수평적인 결합으로 출력

-- 일치되는 데이터행과 일치되지 않는 데이터도 포함하여 출력.
-- 2. 외부 조인
-- departments 테이블 : 모든 부서정보, job_history 테이블 : 부서가 일한 프로젝트 정보가 존재. (+) 표시
-- LEFT OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
  FROM departments a,
       job_history b
 WHERE a.department_id = b.department_id (+) ;

-- RIGHT OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b,
     departments a
WHERE b.department_id (+) = a.department_id;
-- 위의 두 개는 동일한 값을 출력함.

-- 아래 두 개는 동일한 값 출력함.
-- LEFT OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b,
     departments a
WHERE b.department_id = a.department_id (+); -- 10건

-- INNER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b,
     departments a
WHERE b.department_id = a.department_id; -- 10건
-- 두개의 값이 동일한 이유는 : job_history테이블에 일치하지 않는 부서가 존재하지 않음.

-- FULL OUTER JOIN : 오라클 문법으론 지원되지 않음.
SELECT a.department_id, a.department_name, b.job_id, b.department_id
  FROM departments a,
       job_history b
 WHERE a.department_id (+) = b.department_id (+) ;

-- FULL OUTER JOIN : ANSI JOIN으로 사용해야 함.
-- LEFT OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM departments a LEFT OUTER JOIN job_history b
ON a.department_id = b.department_id;

-- RIGHT OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b RIGHT OUTER JOIN departments a
ON b.department_id = a.department_id;

-- FULL OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b FULL OUTER JOIN departments a
ON b.department_id = a.department_id;



CREATE TABLE HONG_A  (EMP_ID INT);

CREATE TABLE HONG_B  (EMP_ID INT);

INSERT INTO HONG_A VALUES ( 10);

INSERT INTO HONG_A VALUES ( 20);

INSERT INTO HONG_A VALUES ( 40);

INSERT INTO HONG_B VALUES ( 10);

INSERT INTO HONG_B VALUES ( 20);

INSERT INTO HONG_B VALUES ( 30);

COMMIT;

SELECT * FROM HONG_A;
SELECT * FROM HONG_B;


-- FULL OUTER JOIN
SELECT *
FROM HONG_A FULL OUTER JOIN HONG_B
ON hong_a.emp_id = hong_b.emp_id;

-- 셀프 조인
-- 서로 다른 두 테이블이 아닌 동일한 한 테이블을 사용해 조인하는 방법을 말한다.
-- 일반 개발에선 쓸 일은 별로 없음.
SELECT a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id
  FROM employees a,
       employees b
 WHERE a.employee_id < b.employee_id
   AND a.department_id = b.department_id
   AND a.department_id = 20;

-- 사원 테이블에서 부서코드가 20인 사원 출력
SELECT employee_id, emp_name, department_id
FROM employees
WHERE department_id = 20;

-- 카타시안 조인(CATASIAN PRODUCT) : 연구목적으로 만들어서 실 개발에선 사용할 일 없음.
-- WHERE 절에 조인 조건이 없는 조인을 말한다. 즉 FROM 절에 테이블을 명시했으나, 두 테이블 간 조인 조건이 없는 조인이다.
-- WHERE절 : JOIN 조건식이 없음.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
  FROM employees a, -- 107
       departments b; -- 27
-- 전체 데이터 2889
-- ANSI문법으론 CROSS 조인이라고 함. CATASIAN JOIN은 오라클
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
  FROM employees a
 CROSS JOIN departments b;
 -- 전체 데이터 2889



-- 문법 시 헷갈려 하는 경우
-- <잘못된 경우>
-- 입력
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
      FROM employees a
     INNER JOIN departments b
     USING (department_id) --컬럼명이 같다면 ON 대신 사용 : ON a.department_id = b.department_id
     WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');
-- 결과
-- SQL 오류: ORA-25154: USING 절의 열 부분은 식별자를 가질 수 없음.

-- <잘 된 경우>
-- 입력
    SELECT a.employee_id, a.emp_name, department_id, b.department_name
      FROM employees a
     INNER JOIN departments b
     USING (department_id)
     WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
      FROM employees a
     INNER JOIN departments b
     ON a.department_id = b.department_id
     WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');


-- 서브 쿼리Sub-Query 란 한 SQL 문장 안에서 보조로 사용되는 또 다른 SELECT문을 의미한다. 최종 결과를 출력하는 쿼리를 메인 쿼리라고 한다면,
-- 이를 위한 중간 단계 혹은 보조 역할을 하는 SELECT문을 서브 쿼리라 한다. 조인 절에서 소개했던 SQL문 중 괄호 안에 
-- 들어있는 SELECT문이 바로 서브 쿼리에 속한다. 하나의 SQL문을 기준으로 메인 쿼리를 제외한 나머지 모든 SELECT문을 서브 쿼리로 보면 되며,
-- 따라서 서브 쿼리는 여러 개를 사용할 수 있다.
-- 서브 쿼리는 다양한 형태로 사용된다. 즉 SELECT, FROM, WHERE 절 모두에서 사용할 수 있을 뿐만 아니라,
-- INSERT, UPDATE, MERGE, DELETE 문에서도 사용할 수 있다. 서브 쿼리는 그 특성과 형태에 따라 다음과 같이 구분할 수 있다.

-- 연관성 없는 서브 쿼리1 : 메인쿼리의 영향을 받지 않고 서브쿼리 단독으로 실행해도 에러가 안남.
-- 서브쿼리가 단일 행 반환
-- 1) 사원의 평균 급여
SELECT AVG(salary) FROM employees; -- 6461.831775700934579439252336448598130841\
-- 2) 전 사원의 평균 급여 이상을 받는 사원 수를 조회하는 쿼리
SELECT COUNT(*) FROM employees
WHERE salary >= (SELECT AVG(salary) FROM employees);
-- 메인쿼리 : 앞의 SELECT, 서브쿼리 : 안의 SELECT

-- 연관성 없는 서브 쿼리2
-- 서브쿼리가 여러 행을 반환
-- 부서 테이블에서 parent_id가 NULL인 부서번호를 가진 사원의 총 건수를 반환하는 쿼리
SELECT count(*)
  FROM employees
 WHERE department_id IN ( SELECT department_id
                            FROM departments
                           WHERE parent_id IS NULL);
-- 서브쿼리의 결과가 여러개일 경우는 IN 키워드 사용
-- 서브쿼리의 결과가 하나일 경우만 등호, 부등호 연산자 사용이 가능함.
SELECT count(*)
  FROM employees
 WHERE department_id = ( SELECT department_id
                            FROM departments
                           WHERE parent_id IS NULL);

-- 연관성 없는 서브 쿼리3
--  job_history 테이블에 있는 employee_id, job_id 두 값과 같은 건을 사원 테이블에서 찾는 쿼리로 서브 쿼리는 메인 쿼리와 연관성이 없다.
SELECT employee_id, emp_name, job_id
  FROM employees
 WHERE (employee_id, job_id ) IN ( SELECT employee_id, job_id
                                    FROM job_history);


/* 연관성 있는 서브 쿼리
메인 쿼리와의 연관성이 있는 서브 쿼리, 즉 메인 테이블과 조인 조건이 걸린 서브 쿼리를 말한다.
서브 쿼리에서 사용하는 컬럼명이 메인 테이블의 컬럼명을 참조

입력
*/
-- WHERE절에서 연관성 있는 서브 쿼리 사용
SELECT a.department_id, a.department_name
  FROM departments a -- 27건
 WHERE EXISTS ( SELECT 1
                  FROM job_history b
                 WHERE a.department_id = b.department_id ); -- 중복된 department_id 컬럼의 데이터가 제거됨. 6개
--동작설명
-- 메인 쿼리 departments 테이블의 27건 데이터가 하나씩
-- 서브쿼리의 WHERE a.department_id = b.department_id가 일치되면 1이 데이터로 출력.
-- EXISTS함수는 TRUE가 되어, 일치되는 department_id가 메인 쿼리로 반환.
-- 만약 일치되지 않으면 1이 데이터로 출력되지 않고 EXISTS함수는 FALSE가 되어,
-- a.department_id 메인쿼리로 반환되지 못함.
-- 결과는 메인쿼리로 반환된 데이터 행의 컬럼명 a.department_id, a.department_name만 출력됨.

-- 연관성 있는 서브쿼리를 조인으로 변환해보자
SELECT DISTINCT a.department_id, a.department_name
  FROM departments a, job_history b
 WHERE a.department_id = b.department_id; -- 중복된 데이터 행이 제거 안됨. 10개


-- EXISTS() 함수 사용법
-- () 안의 결과가 존재하면 TRUE, 존재하지 않으면 FALSE 반환.
SELECT 1 FROM dual WHERE 1 = 0; -- 조건식이 FALSE일 경우 1이 데이터행으로 출력 안 됨.
SELECT 1 FROM dual WHERE 1 != 0; -- 조건식이 TRUE일 경우 1이 데이터행으로 출력

-- EXISTS함수는 서브쿼리에서 데이터가 존재하지 않아서 FALSE : 출력결과 없음.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 = 0);
-- EXISTS함수는 서브쿼리에서 데이터가 존재하지 않아서 TRUE : 출력결과 있음.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 != 0);


-- SELECT절에서 연관성 있는 서브쿼리 사용
SELECT a.employee_id,
       ( SELECT b.emp_name
           FROM employees b
          WHERE a.employee_id = b.employee_id) AS emp_name,
       a.department_id,
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id) AS dep_name
FROM job_history a;
-- 동작설명
/*
job_history테이블의 10건의 데이터가 하나씩 서브 쿼리의 조건식 WHERE a.employee_id = b.employee_id 비교되어
일치하면 반환되고, 일치하지 않으면 버린다. 일치되는 데이터만 메인 쿼리 SELECT a.employee_id, a.department_id 출력됨.
*/


/*
인라인 뷰
FROM 절에 사용하는 서브 쿼리를 인라인 뷰InlineView 라고 한다. 원래 FROM 절에는 테이블이나 뷰가 오는데,
서브 쿼리를 FROM 절에 사용해 하나의 테이블이나 뷰처럼 사용할 수 있다. 뷰를 해체하면 하나의 독립적인 SELECT문이므로
FROM 절에 사용하는 서브 쿼리도 하나의 뷰로 볼 수 있어서 인라인 뷰라는 이름이 붙은 것이다.

SELECT * FROM 테이블명 또는 뷰명;
SELECT * FROM (연관성 없는 서브쿼리) -- 인라인 뷰
*/
-- 아직 아래 두 유형의 문제풀이는 접근하지 말 것.
-- 유형1
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
  FROM employees a,
       departments b,
       ( SELECT AVG(c.salary) AS avg_salary
           FROM departments b,
                employees c
          WHERE b.parent_id = 90  -- 기획부
            AND b.department_id = c.department_id ) d
 WHERE a.department_id = b.department_id
   AND a.salary > d.avg_salary;
-- 메모리 상에 a, b, d 세 개의 테이블이 존재.

-- 유형2
SELECT a.*
  FROM ( SELECT a.sales_month, ROUND(AVG(a.amount_sold)) AS month_avg
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy' -- 이탈리아
          GROUP BY a.sales_month
       )  a,
       ( SELECT ROUND(AVG(a.amount_sold)) AS year_avg
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy' -- 이탈리아
       ) b
 WHERE a.month_avg > b.year_avg ;














COMMIT;