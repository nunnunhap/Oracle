-- 계층형 쿼리HierarchicalQuery
-- 2차원 형태의 테이블에 저장된 데이터를 계층형 구조로 결과를 반환하는 쿼리를 말한다. 대학 학과, 정부부처 등

-- 계층형 형태의 출력목적으로 작성한 코드(예전에 사용)
    SELECT department_id,
           department_name,
           0 AS PARENT_ID,
           1 as levels,
           parent_id || department_id AS sort
      FROM departments
     WHERE parent_id IS NULL
     UNION ALL
    SELECT t2.department_id,
           LPAD(' ' , 3 * (2-1)) || t2.department_name AS department_name,
           t2.parent_id,
           2 AS levels,
           t2.parent_id || t2.department_id AS sort
      FROM departments t1,
           departments t2
     WHERE t1.parent_id is null
       AND t2.parent_id = t1.department_id
     UNION ALL
    SELECT t3.department_id,
           LPAD(' ' , 3 * (3-1)) || t3.department_name AS department_name,
           t3.parent_id,
           3 as levels,
           t2.parent_id || t3.parent_id || t3.department_id as sort
      FROM departments t1,
           departments t2,
           departments t3
     WHERE t1.parent_id IS NULL
       AND t2.parent_id = t1.department_id
       AND t3.parent_id = t2.department_id
     UNION ALL
    SELECT t4.department_id,
           LPAD(' ' , 3 * (4-1)) || t4.department_name as department_name,
           t4.parent_id,
           4 as levels,
           t2.parent_id || t3.parent_id || t4.parent_id || t4.department_id AS sort
      FROM departments t1,
           departments t2,
           departments t3,
           departments t4
     WHERE t1.parent_id IS NULL
       AND t2.parent_id = t1.department_id
       AND t3.parent_id = t2.department_id
       and t4.parent_id = t3.department_id
     ORDER BY sort;

-- 계층형 쿼리의 기본 문법
/*
SELECT expr1, expr2, ...
  FROM 테이블
 WHERE 조건
 START WITH[최상위 조건]
CONNECT BY [NOCYCLE][PRIOR 계층형 구조 조건];
*/

-- departments(부서) 테이블의 상하위 수직구조로 출력하라.
SELECT
    department_id,
    department_name
FROM
    departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id;
--PRIOR은 전체 코드를 가지고 있는데 단다.

-- 구매/생산부를 기준으로 하위부서 출력
SELECT
    department_id,
    department_name
FROM
    departments
START WITH department_id = 30
CONNECT BY PRIOR department_id = parent_id;
-- CONNECT BY 는 연결되어 있는 부분.

SELECT
    department_id,
    department_name
FROM
    departments
START WITH department_id = 30
CONNECT BY department_id = PRIOR parent_id;

-- ① 계층형 쿼리 정렬
-- 계층형 쿼리는 계층형 구조에 맞게 순서대로 출력되는데 ORDER BY 절로 그 순서를 변경할 수 있다.
-- 계층은 LEVEL 의사컬럼으로 확인할 수 있음.
SELECT LEVEL, department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name
  FROM departments
 START WITH parent_id IS NULL
 CONNECT BY PRIOR department_id  = parent_id
ORDER BY department_name;
-- 정렬 사용 시 부서명 출력 순서가 변경되어 상하위 연결 출력구조를 볼 수 없음.
-- ORDER SIBLINGS BY
SELECT LEVEL, department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name
  FROM departments
 START WITH parent_id IS NULL
 CONNECT BY PRIOR department_id  = parent_id
ORDER SIBLINGS BY department_name;

-- ② CONNECT_BY_ROOT
-- CONNECT_BY_ROOT는 계층형 쿼리에서 최상위 로우를 반환하는 연산자다. 연산자이므로 CONNECT_BY_ROOT 다음에는 표현식이 온다.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
       CONNECT_BY_ROOT department_name AS root_name
  FROM departments
 START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

-- ③ CONNECT_BY_ISLEAF
-- CONNECT_BY_ISLEAF는 CONNECT BY 조건에 정의된 관계에 따라 해당 로우가 최하위 자식 로우이면 1을, 그렇지 않으면 0을 반환하는 의사 컬럼이다.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL, CONNECT_BY_ISLEAF
  FROM departments
 START WITH parent_id IS NULL
 CONNECT BY PRIOR department_id  = parent_id;

-- ④ SYS_CONNECT_BY_PATH (colm, char)
-- SYS_CONNECT_BY_PATH는 계층형 쿼리에서만 사용할 수 있는 함수로, 루트 노드에서 시작해 자신의 행까지 연결된 경로 정보를 반환
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
       SYS_CONNECT_BY_PATH( department_name, '|')
  FROM departments
  START WITH parent_id IS NULL
  CONNECT BY PRIOR department_id  = parent_id;
-- 각 로우별로 어떤 계층 경로를 타고 있는지 알 수 있다.
-- 두 번째 매개변수인 구분자로 해당 컬럼 값에 포함된 문자는 사용할 수 없다는 점을 주의해야 한다.
-- 위 쿼리에서 구매/생산부는 ‘/’문자가 속해 있는데, 구분자로 ‘/’를 사용하면 다음과 같은 오류가 발생한다.

-- ⑤ CONNECT_BY_ISCYCLE
-- 눈치챘는지는 모르겠지만 오라클의 계층형 쿼리는 루프(반복) 알고리즘을 사용한다.
-- 계층형 구조나 레벨은 테이블에 있는 데이터에 따라 동적으로 변경되므로, 내부적으로는 루프를 돌며 자식 노드를 찾아간다.
-- 루프 알고리즘에서 주의할 점은 조건을 잘못 주면 무한루프를 타게 된다는 점인데,
-- 계층형 쿼리에서도 부모-자식 간의 관계를 정의하는 값이 잘못 입력되면 무한루프를 타고 오류가 발생한다. 아래 내용
UPDATE departments
   SET parent_id = 170
 WHERE department_id = 30;

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
       parent_id
  FROM departments
  START WITH department_id = 30
CONNECT BY PRIOR department_id  = parent_id;

-- 부서의 상위부서 값이 잘못 입력되어 루프 발생 시 해결하기 위한 쿼리
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name AS depname, LEVEL,
       CONNECT_BY_ISCYCLE IsLoop,
       parent_id
  FROM departments
  START WITH department_id = 30
CONNECT BY NOCYCLE PRIOR department_id  = parent_id;

ROLLBACK; -- UPDATE 구문 취소


/* 분석 함수와 window 함수
분석 함수AnalyticFunction 란 테이블에 있는 로우에 대해 특정 그룹별로 집계 값을 산출할 때 사용된다.
집계 값을 구할 때 보통은 그룹 쿼리를 사용하는데, 이때 GROUP BY 절에 의해 최종 쿼리 결과는 그룹별로 로우 수가 줄어든다.
이에 반해, 집계 함수를 사용하면 로우의 손실 없이도 그룹별 집계 값을 산출해 낼 수 있다.
분석 함수에서 사용하는 로우별 그룹을 윈도우(window)라고 부르는데, 이는 집계 값 계산을 위한 로우의 범위를 결정하는 역할을 한다.

    분석 함수(매개변수) OVER
       　　　(PARTITION BY expr1, expr2,...
                  ORDER BY expr3, expr4...
                window 절)
*/

-- ROW_NUMBER( ) ROWNUM 의사 컬럼과 비슷한 기능을 하는데, 파티션으로 분할된 그룹별로 각 로우에 대한 순번을 반환하는 함수
-- ROWNUM
SELECT ROWNUM,
    emp_name,
    email
FROM
    employees
WHERE
    ROWNUM <= 5;

-- GROUP BY 문법 사용
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id ORDER BY department_id;

-- ROWNUMBER()
-- PARTITION BY : department_id가 같은 데이터별로 분류
SELECT department_id, emp_name,
       ROW_NUMBER() OVER (PARTITION BY department_id
                          ORDER BY emp_name ) dep_rows
  FROM employees;

/*
② RANK( ), DENSE_RANK( )
RANK 함수는 파티션별 순위를 반환한다. 부서별로 급여 순위를 매겨 보자.

입력

    SELECT department_id, emp_name,
           salary,
           RANK() OVER (PARTITION BY department_id
                        ORDER BY salary ) dep_rank
      FROM employees;
*/

-- 공동순위 시 한 순위 건너뜀.
    SELECT department_id, emp_name,
           salary,
           RANK() OVER (PARTITION BY department_id
                        ORDER BY salary DESC) dep_rank
      FROM employees;

-- 공동순위 시 한 순위 건너뛰지 않음.
    SELECT department_id, emp_name,
           salary,
           DENSE_RANK() OVER (PARTITION BY department_id
                              ORDER BY salary DESC ) dep_rank
      FROM employees;

-- 응용 : 특정 조건에 맞는 상위 혹은 하위 n개의 데이터만 추출하는 TOP n 쿼리도 쉽게 작성
SELECT *
FROM ( SELECT department_id, emp_name,
              salary,
              DENSE_RANK() OVER (PARTITION BY department_id
                                 ORDER BY salary desc) dep_rank
         FROM employees
     )
WHERE dep_rank <= 3;

SELECT department_id, emp_name, salary,
              DENSE_RANK() OVER (PARTITION BY department_id
                                 ORDER BY salary desc) dep_rank
         FROM employees;


-- 다중 테이블 INSERT
/*
다중 테이블 INSERT 구문은 단 하나의 INSERT 문장으로 여러 개의 INSERT 문을 수행하는 효과를 낼 수 있을 뿐만 아니라
특정 조건에 맞는 데이터만 특정 테이블에 입력되게 할 수 있는 문장이다. 먼저 다중 테이블 INSERT 문의 구문을 살펴 보자.

    INSERT ALL| FIRST
    WHEN 조건1 THEN
    　INTO [스키마.]테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
    WHEN 조건2 THEN
    　INTO [스키마.]테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
        ...
     ELSE
    　 INTO [스키마.]테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
    SELECT 문;
    
    ? ALL: 디폴트 값으로 이후 WHEN 조건절을 명시했을 때 각 조건이 맞으면 INSERT를 모두 수행하라는 의미다.

? FIRST: 이후 WHEN 절 조건식에 따른 INSERT문을 수행할 때, 서브 쿼리로 반환된 로우에 대해 조건이 참인 WHEN 절을 만나면 해당 INSERT문을 수행하고 나머지에 대해서는 조건 평가를 하지 않고 끝낸다.

? WHEN 조건 THEN … ELSE: 특정 조건에 따라 INSERT를 수행할 때 해당 조건을 명시.

? SELECT 문: 다중 테이블 INSERT 구문에서는 반드시 서브 쿼리가 동반되어야 하며, 서브 쿼리의 결과를 조건에 따라 평가해 데이터를 INSERT 한다.
*/

    CREATE TABLE ex7_3 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

    CREATE TABLE ex7_4 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

    INSERT INTO ex7_3 VALUES (101, '홍길동');
    INSERT INTO ex7_3 VALUES (102, '김유신');
-- 위의 문장을 아래로 한꺼번에 가능함.
    INSERT ALL
      INTO ex7_3 VALUES (103, '강감찬')
      INTO ex7_3 VALUES (104, '연개소문')
    SELECT * -- INSERT ALL 에선 무조건 이런 서브 쿼리가 들어가야만 함.
      FROM DUAL;

ROLLBACK;

    INSERT ALL
      INTO ex7_3 VALUES (105, '가가가')
      INTO ex7_4 VALUES (105, '나나나')
    SELECT *
      FROM DUAL;


SELECT * FROM ex7_3;
SELECT * FROM ex7_4;

TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;

-- 조건에 따른 다중 INSERT (신규 작업에선 잘 사용 안 하는데 유지보수 때 많이 나옴)
INSERT ALL
      WHEN department_id = 30 THEN
      INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN department_id = 90 THEN
      INTO ex7_4 VALUES (employee_id, emp_name)
      -- SELETE문으로 실행된 결과를 삽입데이터로 사용
      SELECT department_id,
           employee_id, emp_name
      FROM  employees;
-- depatment_id 데이터가 30이면 ex7_3 테이블에 데이터 삽입
-- depatment_id 데이터가 90이면 ex7_4 테이블에 데이터 삽입
SELECT * FROM ex7_3;
SELECT * FROM ex7_4;


    CREATE TABLE ex7_5 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

    INSERT ALL
      WHEN department_id = 30 THEN
        INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN department_id = 90 THEN
        INTO ex7_4 VALUES (employee_id, emp_name)
      ELSE
        INTO ex7_5 VALUES (employee_id, emp_name)
    SELECT department_id,
           employee_id, emp_name
     FROM  employees;

TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;


-- INSERT FIRST
/* ALL과 FIRST의 차이점은 입력되는 대상 로우를 기준으로 WHEN 조건에 맞으면 처리하는 방식에 있다.
만약 FIRST를 명시했다면 첫 번째로 조건 값이 TRUE가 될 때 해당 로우가 입력되고 끝난다.
만약 그 다음 WHEN 조건 결과가 TRUE가 되더라도 이미 이전 단계에서 입력이 됐으므로 그 로우는 추가로 입력되지 않는다. */
    INSERT ALL
      WHEN employee_id < 116 THEN
        INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN salary < 5000 THEN
        INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name,  salary
      FROM employees
     WHERE department_id = 30;

    INSERT FIRST
      WHEN employee_id < 116 THEN
        INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN  salary < 5000 THEN
        INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name,  salary
      FROM employees
     WHERE department_id = 30;

SELECT * FROM ex7_3;
SELECT * FROM ex7_4;


COMMIT;