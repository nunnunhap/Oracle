/*
PL/SQL은 집합적 언어와 절차적 언어의 특징을 모두 가지고 있다고 앞서 설명했다.
전자는 SQL을 사용할 수 있기 때문이고, 후자는 일반 프로그래밍 언어처럼 변수에 값을 할당하고 예외처리도 할 수 있으며
특정 기능을 처리하는 함수나 프로시저를 만들 수 있는 기능을 제공하기 때문이다.
PL/SQL이 일반 프로그래밍 언어와 다른 점은 모든 코드가 DB 내부에서 만들어져 처리됨으로써 수행 속도와 성능 측면에서 큰 장점이 있다는 점이다.

‘DB 프로그래밍’이라 하면 SQL을 사용한 DML문을 사용하는 것을 지칭할 수도 있지만,
실제 복잡한 비즈니스 로직을 만드는 것은 PL/SQL을 사용해 구현하는 것이 보통이다
*/

SET SERVEROUTPUT ON;
-- 아래 dbms_output.put_line(vi.num); 출력 결과를 화면에서 보기 위하여 사용

-- 익명 블록
DECLARE
    vi_num NUMBER; -- 변수 선언
BEGIN
    vi_num := 100; -- 선언한 변수 사용
    dbms_output.put_line(vi_num); --System.out.println() 느낌임.
END;

/*
PL/SQL 블록의 구성요소
1. 변수 :변수는 다른 프로그래밍 언어에서 사용하는 변수와 개념이 같으며 선언부에서 변수 선언을 하고 실행부에서 사용
    변수명 데이터타입 := 초깃값;
변수 선언과 동시에 초깃값을 할당할 수 있는데, 초깃값을 할당하지 않으면 데이터 타입에 상관없이 그 변수의 초깃값은 NULL이 된다.
변수로 선언할 수 있는 데이터 타입은 크게 두 가지로 구분할 수 있는데, 하나는 SQL 데이터 타입이고 다른 하나는 PL/SQL 데이터 타입
중요 : PL/SQL 데이터 타입에는 SQL 데이터 타입이 포함되어 있음.

2. 상수 : 상수는 변수와는 달리 한 번 값을 할당하면 변하지 않는다. 상수 선언도 변수 선언과 비슷하다.
    상수명 CONSTANT 데이터타입 := 상수값;
상수를 선언할 때는 반드시 CONSTANT란 키워드를 붙여 변수와 구분하며, 선언할 때 반드시 초기화해야 하고 
실행부에서 상수를 다른 값으로 변경할 수 없다. 왜냐하면 말 그대로 상수는 상수니까!
*/

DECLARE -- 변수나 상수 선언 위치(선언부)
    a INTEGER := 2**2*3**2;
BEGIN -- 실행부
    DBMS_OUTPUT.PUT_LINE('a = ' || a);
END;

/*
PL/SQL 블록 상에서 사용하는 변수, 상수, 연산자는 사실 부차적인 용도로 사용될 뿐이다.
실제로 PL/SQL 블록을 작성하는 원래의 목적은 테이블 상에 있는 데이터를 이리저리 가공해서 특정 로직에 따라 무언가를 처리하는 것이며,
따라서 주로 사용되는 것은 SQL문이다. SQL문 중 DDL은 PL/SQL 상에서 직접 쓸 수 없고(물론 전혀 방법이 없는 것은 아니다) DML문만 사용한다.
*/
-- 시나리오? 사원 테이블에서 특정 사원의 이름과 부서명을 가져와 출력하는 코드를 작성
-- 1) 일반적인 SQL구문
SELECT e.emp_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.employee_id = 100;

-- 2) PL/SQL 구문
DECLARE
    vs_emp_name     VARCHAR2(80); -- 사원명 변수
    vs_dep_name     VARCHAR2(80); -- 부서명 변수
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;
    
    -- 변수값 출력
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;

/*
다음과 같이 %TYPE 키워드를 쓰면 해당 변수에 컬럼 타입을 자동으로 가져온다.
해당 테이블의 컬럼 데이터타입이 수정되었을 때 아래와 같이 하면 자동으로 변경된 데이터타입으로 가져옴.
    변수명 테이블명.컬럼명%TYPE;
*/
DECLARE
  vs_emp_name employees.emp_name%TYPE;
  vs_dep_name departments.department_name%TYPE;
BEGIN
  SELECT a.emp_name, b.department_name
    INTO vs_emp_name, vs_dep_name
    FROM employees a,
         departments b
   WHERE a.department_id = b.department_id
     AND a.employee_id = 100;

  DBMS_OUTPUT.PUT_LINE( vs_emp_name || ' - ' || vs_dep_name);
END;

/*
SQL과 PL/SQL 데이터 타입별 길이
SQL : VARCHAR2(4000)이 최대치
PL/SQL : VARCHAR2(12006)이 최대치
*/
CREATE TABLE ch08_varchar2 (
    var1    VARCHAR2(5000)); -- 에러 발생

-- 타입 수정
CREATE TABLE ch08_varchar2 (
       VAR1 VARCHAR2(4000)); -- 4000으로 수정
    
INSERT INTO ch08_varchar2 VALUES('4000바이트 크기 데이터');

SELECT * FROM ch08_varchar2;

COMMIT;

DECLARE
    vs_sql_varchar2     VARCHAR2(4000);
    vs_plsql_varchar2   VARCHAR2(32767);
BEGIN
    SELECT var1 INTO vs_sql_varchar2 FROM ch08_varchar2;
        
    vs_plsql_varchar2 := vs_plsql_varchar2 || ' - ' || vs_plsql_varchar2 || ' - ' || vs_plsql_varchar2;
    
    -- 각 변수의 크기를 출력함.
    DBMS_OUTPUT.PUT_LINE('SQL VARCHAR2 길이  : ' || LENGHTB(vs_sql_varchar2));
    DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR2 길이  : ' || LENGHTB(vs_plsql_varchar2));
END;


-- PL/SQL 제어문과 함수, 프로시저 알아 보기
/*
익명 블록과 달리 함수와 프로시저는 데이터베이스 내에 저장되고 컴파일되므로 언제든지 재사용이 가능한 프로그램으로 
함수나 프로시저를 만드는 것이 곧 DB 프로그래밍의 시작이라고 할 수 있다.
*/
--PL/SQL 제어문
DECLARE
    vn_num1 NUMBER := 1;
    vn_num2 NUMBER := 2;
BEGIN
    IF vn_num1 >= vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num1 || ' 이 큰 수');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vn_num2 || ' 이 큰 수');
    END IF;
END;

SELECT ROUND(DBMS_RANDOM.VALUE (10, 120), -1) FROM DUAL;

    DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
    BEGIN
    -- 부서코드를 랜덤으로 반환
    -- 10~120 사이의 실수를 랜덤으로 출력하고 그 중 정수의 첫번째 자리에서 반올림하기.
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

       SELECT salary
         INTO vn_salary
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1; -- 동일한 부서의 사원이 여러명인 경우 앞에 데이터 1개만 참조

      DBMS_OUTPUT.PUT_LINE(vn_salary);

      IF vn_salary BETWEEN 1 AND 3000 THEN
         DBMS_OUTPUT.PUT_LINE('낮음');
      ELSIF vn_salary BETWEEN 3001 AND 6000 THEN
         DBMS_OUTPUT.PUT_LINE('중간');
      ELSIF vn_salary BETWEEN 6001 AND 10000 THEN
         DBMS_OUTPUT.PUT_LINE('높음');
      ELSE
         DBMS_OUTPUT.PUT_LINE('최상위');
      END IF;
    END;




SET SERVEROUTPUT ON;
    DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
      vn_commission NUMBER := 0;
    BEGIN
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

       SELECT salary, commission_pct
         INTO vn_salary, vn_commission
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1;

      DBMS_OUTPUT.PUT_LINE(vn_salary);

      IF vn_commission > 0 THEN
        IF vn_commission > 0.15 THEN
           DBMS_OUTPUT.PUT_LINE(vn_salary * vn_commission );
        END IF;
      ELSE
         DBMS_OUTPUT.PUT_LINE(vn_salary);
      END IF;
    END;

/*
CASE문
CASE문은 3장에서 배웠던 CASE 표현식과 비슷하다. SELECT 절에서 CASE 표현식을 사용했듯이 PL/SQL 프로그램 내에서도 CASE문을 사용할 수 있는데, 그 구문은 다음과 같다.

    <유형 1>
    CASE 표현식
        WHEN 결과1 THEN
             처리문1;
        WHEN 결과2 THEN
             처리문2;
        ...
        ELSE
             기타 처리문;
    END CASE;
     
    <유형 2>
    CASE WHEN 표현식1 THEN
             처리문1;
        WHEN 표현식2 THEN
             처리문2;
        ...
        ELSE
             기타 처리문;
    END CASE;
*/

SET SERVEROUTPUT ON;

DECLARE -- 초기값을 안 주면 내부적으로 NULL로 사용함.
    vn_salary NUMBER := 0;
    vn_department_id NUMBER := 0;
BEGIN
    vn_department_id := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
    
    SELECT salary
    INTO vn_salary
    FROM employees
    WHERE department_id = vn_department_id
    AND ROWNUM = 1;
    
    DBMS_OUPUT.PUT_LINE(vn_salary);
    
    CASE WHEN vn_salary BETWEEN 1 AND 3000 THEN
            DBMS_OUPUT.PUT_LINE('낮음');
        WHEN vn_salary BETWEEN 3001 AND 6000 THEN
            DBMS_OUTPUT.PUT_LINE('중간');
        WHEN vn_salary BETWEEN 6001 AND 10000 THEN
            DBMS_OUPUT.PUT_LINE('높음');
        ELSE
            DBMS_OUPUT.PUT_LINE('최상위');
    END CASE;
END;


    DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
    BEGIN
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

       SELECT salary
         INTO vn_salary
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE(vn_salary);

    CASE WHEN vn_salary BETWEEN 1 AND 3000 THEN
              DBMS_OUTPUT.PUT_LINE('낮음');
         WHEN vn_salary BETWEEN 3001 AND 6000 THEN
              DBMS_OUTPUT.PUT_LINE('중간');
         WHEN vn_salary BETWEEN 6001 AND 10000 THEN
              DBMS_OUTPUT.PUT_LINE('높음');
         ELSE
              DBMS_OUTPUT.PUT_LINE('최상위');
      END CASE;

    END;

/*
LOOP문은 루프를 돌며 반복해서 로직을 처리하는 반복문이다. 이러한 반복문에는 LOOP문 외에도 WHILE문, FOR문이 있음.
    LOOP
      처리문;
      EXIT [WHEN 조건];
    END LOOP;
*/

-- 3단 출력
-- 유형1
    DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
    BEGIN
      LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
          vn_cnt := vn_cnt + 1;      -- 루프를 돌면서 vn_cnt 값은 1씩 증가됨

          EXIT WHEN vn_cnt > 9;      -- vn_cnt가 9보다 크면 루프 종료
      END LOOP;
    END;

-- 유형2
    DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
    BEGIN

      WHILE  vn_cnt <= 9           -- vn_cnt가 9보다 작거나 같을 때만 반복 처리
      LOOP
         DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
         EXIT WHEN vn_cnt = 5;     -- vn_cnt 값이 5가 되면 루프 종료
         vn_cnt := vn_cnt + 1;     -- vn_cnt 값을 1씩 증가
      END LOOP;
    END;

/*
FOR문도 다른 프로그래밍 언어에서 사용하는 것과 비슷한 형태이다. 오라클에서 제공하는 FOR문의 기본 유형은 다음과 같다.

    FOR 인덱스 IN [REVERSE]초깃값..최종값
    LOOP
      처리문;
    END LOOP;
*/
    DECLARE
      vn_base_num NUMBER := 3;
    BEGIN
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
    END;

    DECLARE
       vn_base_num NUMBER := 3;
    BEGIN
       FOR i IN REVERSE 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
    END;

/*
CONTINUE문은 FOR나 WHILE 같은 반복문은 아니지만, 반복문 내에서 특정 조건에 부합할 때 처리 로직을 건너뛰고
상단의 루프 조건으로 건너가 루프를 계속 수행할 때 사용한다. EXIT는 루프를 완전히 빠져 나오는데 반해,
CONTINUE는 제어 범위가 조건절로 넘어간다.
*/
    DECLARE
       vn_base_num NUMBER := 3;
    BEGIN
       FOR i IN 1..9
       LOOP
          CONTINUE WHEN i=5;
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
    END;


-- PL/SQL 코드 상에서 GOTO문을 만나면 GOTO문이 지정하는 라벨로 제어가 넘어간다.
-- 라벨(label) : 특정 구문에 이름을 부여. <<라벨이름>>
-- 개발에선 사용하지 않음. 지져분하기 때문임.
    DECLARE
       vn_base_num NUMBER := 3;
    BEGIN
       <<third>>
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
          IF i = 3 THEN
             GOTO fourth;
          END IF;
       END LOOP;

       <<fourth>>
       vn_base_num := 4;
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
    END;

/*
PL/SQL에서는 NULL문을 사용할 수 있다. NULL문은 아무것도 처리하지 않는 문장이다.
아무 것도 처리하지 않는데 굳이 사용할 필요가 있을까? PL/SQL 코드를 작성하다 보면 가끔씩 필요할 때가 있다.
NULL문은 보통 IF문이나 CASE문을 작성할 때 주로 사용하는데, 조건에 따라 처리 로직을 작성하고 앞에서 작성한 모든 조건에 부합되지 않을 때,
즉 ELSE절을 수행할 때 아무것도 처리하지 않고 싶은 경우 NULL문을 사용한다.
*/
    IF vn_variable = 'A' THEN
       처리로직1;
    ELSIF vn_variable = 'B' THEN
       처리로직2;
       ...
    ELSE NULL;
    END IF;

    CASE WHEN vn_variable = 'A' THEN
              처리로직1;
         WHEN vn_variable = 'B' THEN
              처리로직2;
         ...
         ELSE NULL;
    END CASE;


/*
PL/SQL을 이용한 사용자 정의 함수, 프로시저 생성

SQL 함수는 오라클에서 제공하는 내장 함수이고(그래서 빌트인 함수라고도 함), 여기에서 말하는 함수는 사용자가 직접 로직을 구현하는 사용자 정의 함수를 말한다.

    CREATE OR REPLACE FUNCTION 함수 이름 (매개변수1, 매개변수2, ...)
    RETURN 데이터타입;
    IS[AS] -- DECLARE 키워드 빠짐.
      변수, 상수 등 선언
    BEGIN
      실행부
    　
      RETURN 반환값;
    [EXCEPTION -- 프로그램은 EXCEPTION이 없는게 없음.
      예외 처리부]
    END [함수 이름];
*/
-- 처음 만들 땐 쓸 일 없는데 유지보수에선 이거 많이 씀.
CREATE OR REPLACE FUNCTION my_mod(num1 NUMBER, num2 NUMBER)
RETURN NUMBER
IS
    vn_remainder    NUMBER := 0;
    vn_quotient     NUMBER := 0;
BEGIN
    vn_quotient := FLOOR(num1 / num2);
    vn_remainder := num1 - (num2 * vn_quotient);
    
    RETURN vn_remainder; -- 위의 return타입대로 나옴.
END;

/*
함수 호출
이제 실제로 함수를 호출해 보자. 함수 호출 방식은 매개변수의 존재 유무에 따라 함수명과 매개변수를 명시하기도 하고, 함수명만 명시하기도 한다. 그리고 함수는 반환 값이 있으므로 SELECT 문장에서 사용할 수도 있고 PL/SQL 블록 내에서도 사용할 수 있다.

    <매개변수가 없는 함수 호출>
    함수명 혹은 함수명()
     
    <매개변수가 있는 함수 호출>
    함수명(매개변수1, 매개변수2,...)
*/
SELECT my_mod(14, 3) remainder FROM DUAL; -- 2
SELECT FLOOR(14/3) FROM DUAL; -- FLOOR() 내림함수 : 4

-- 국가명을 반환하는 함수
CREATE OR REPLACE FUNCTION fn_get_country_name( p_country_id NUMBER)
RETURN VARCHAR2 -- 매개변수와 리턴타입은 길이를 사용 안함.
IS
    vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
    vn_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO vn_count
    FROM countries
    WHERE country_id = p_country_id;
    RETURN vs_country_name; -- 국가명 반환
END;

SELECT fn_get_country_name(52777) COUN1, fn_get_country_name(10000) COUN2
FROM DUAL;
-- 10000번 국가 코드가 존재하지 않아 NULL 대신 '없음' 문자열로 대신하는 함수 수정을 하자.


    CREATE OR REPLACE FUNCTION fn_get_country_name ( p_country_id NUMBER )
       RETURN VARCHAR2  -- 국가명을 반환하므로 반환 데이터타입은 VARCHAR2
    IS
       vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
       vn_count NUMBER := 0;
    BEGIN
       SELECT COUNT(*)
         INTO vn_count
         FROM countries
        WHERE country_id = p_country_id;

      IF vn_count = 0 THEN
         vs_country_name := '해당국가 없음';
      ELSE
       SELECT country_name
         INTO vs_country_name
         FROM countries
        WHERE country_id = p_country_id;
      END IF;

     RETURN vs_country_name;  -- 국가명 반환

    END;

SELECT fn_get_country_name(52777) COUN1, fn_get_country_name(10000) COUN2
FROM DUAL;

/*
PL/SQL을 사용한 프로시저 생성
함수는 특정 연산을 수행한 뒤 결과 값을 반환하지만 프로시저는 특정한 로직을 처리하기만 하고 결과 값을 반환하지는 않는 서브 프로그램이다.
일반적으로 프로젝트 현장에서는 시스템 설계가 끝난 후 업무를 분할하고 이 분할한 업무 단위로 로직을 구현해야 하는데, 
개별적인 단위 업무는 주로 프로시저로 구현해 처리한다. 즉 테이블에서 데이터를 추출해 입맛에 맞게 조작하고 그 결과를 다른 테이블에
다시 저장하거나 갱신하는 일련의 처리를 할 때 주로 프로시저를 사용한다.
*/
/*
프로시저 생성
함수나 프로시저 모두 DB에 저장된 객체이므로 프로시저를 스토어드(Stored, 저장된) 프로시저라고 부르기도 하는데
이 책에서는 그냥 프로시저라고 하겠다(함수도 스토어드 함수라고도 한다). 프로시저의 생성 구문은 다음과 같다.

    CREATE OR REPLACE PROCEDURE 프로시저 이름
        (매개변수명1[IN |OUT | IN OUT] 데이터타입[:= 디폴트 값],
         매개변수명2[IN |OUT | IN OUT] 데이터타입[:= 디폴트 값],
         ...
        )
    IS[AS]
      변수, 상수 등 선언
    BEGIN
      실행부
    　
    [EXCEPTION
      예외 처리부]
    END [프로시저 이름];
*/

-- JOBS 테이블에 데이터 삽입하는 프로시저 생성(이 정도는 프로시저로 만들지 않음)
CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id      IN  JOBS.JOB_ID%TYPE, -- 여기서 IN, OUT, INOUT을 쓸 수 있음.
    p_job_title   IN  JOBS.JOB_TITLE%TYPE,  -- IN : 입력 매개변수
    p_min_salary  IN  JOBS.MIN_SALARY%TYPE,
    p_max_salary  IN  JOBS.MAX_SALARY%TYPE
)
IS

BEGIN
    INSERT INTO JOBS(job_id, job_title, min_salary, max_salary, create_date, update_date)
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
    COMMIT;
END;

    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE )
    IS

    BEGIN
      INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
      VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);

      COMMIT;
    END ;

-- 서블릿 파일 안에 아래 프로시저 호출 문장이 존재하게 된다.
    EXEC my_new_job_proc ('SM_JOB1', 'Sample JOB1', 1000, 5000);

    SELECT *
      FROM jobs
     WHERE job_id = 'SM_JOB1';


CREATE OR REPLACE PROCEDURE my_new_job_proc
(   p_job_id      IN  JOBS.JOB_ID%TYPE, -- 여기서 IN, OUT, INOUT을 쓸 수 있음.
    p_job_title   IN  JOBS.JOB_TITLE%TYPE,  -- IN : 입력 매개변수
    p_min_salary  IN  JOBS.MIN_SALARY%TYPE,
    p_max_salary  IN  JOBS.MAX_SALARY%TYPE)
IS
BEGIN
    INSERT INTO JOBS(job_id, job_title, min_salary, max_salary, create_date, update_date)
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
    COMMIT;
END;

    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE )
    IS
        vn_cnt  NUMBER := 0;
    BEGIN
        -- p_job_id값을 중복검사하여 존재하지 않으면 삽입. 존재하면 수정
        SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
        WHERE job_id = p_job_id;
        
        IF vn_cnt = 0 THEN
            INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
            VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
        ELSE
            UPDATE JOBS
                SET job_id = p_job_id, job_title = p_job_title, min_salary = p_min_sal, max_salary = p_max_sal,
                    update_date = SYSDATE
                WHERE job_id = p_job_id;
        END IF;
      COMMIT;
    END ;


    EXEC my_new_job_proc ('SM_JOB1', 'Sample JOB1', 2000, 6000);

    SELECT *
      FROM jobs
     WHERE job_id = 'SM_JOB1';

-- 매개변수명에 값을 대입하여 프로시저 실행 가능
     EXECUTE my_new_job_proc (p_job_id => 'SM_JOB1', p_job_title => 'Sample JOB1',
                               p_min_sal => 2000, p_max_sal => 7000);



-- 매개변수에 초기값 사용
    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE := 100 )
    IS
        vn_cnt  NUMBER := 0;
    BEGIN
        -- p_job_id값을 중복검사하여 존재하지 않으면 삽입. 존재하면 수정
        SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
        WHERE job_id = p_job_id;
        
        IF vn_cnt = 0 THEN
            INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
            VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
        ELSE
            UPDATE JOBS
                SET job_id = p_job_id, job_title = p_job_title, min_salary = p_min_sal, max_salary = p_max_sal,
                    update_date = SYSDATE
                WHERE job_id = p_job_id;
        END IF;
      COMMIT;
    END ;


-- OUT, IN OUT 매개변수
-- 데이터를 삽입 또는 수정 날짜를 받아오는 프로시저
    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE := 100,
      p_upd_date  OUT JOBS.UPDATE_DATE%TYPE )
    IS
        vn_cnt  NUMBER := 0;
        vn_cur_date OUT JOBS.UPDATE_DATE%TYPE := SYSDATE;
    BEGIN
        -- p_job_id값을 중복검사하여 존재하지 않으면 삽입. 존재하면 수정
        SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
        WHERE job_id = p_job_id;
        
        -- 존재하지 않으면
        IF vn_cnt = 0 THEN
            INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
            VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, vn_cur_date, vn_cur_date);
        ELSE -- 존재하면
            UPDATE JOBS
                SET job_title = p_job_title, min_salary = p_min_sal, max_salary = p_max_sal,
                    update_date = vn_cur_date
                WHERE job_id = p_job_id;
        END IF;
        -- OUT매개변수에 작업날짜 대입
        p_upd_date := vn_cur_date;
      COMMIT;
    END ;

-- OUT 매개변수가 있는 프로시저 실행
SET SERVEROUTPUT ON;
DECLARE
   vd_cur_date JOBS.UPDATE_DATE%TYPE; -- 이걸 만들고 들어와야 함.
BEGIN
-- 프로시저 단독 실행 시는 EXEC 키워드 사용. 하지만 단독이 아닌 경우는 반드시 제외해야 함.
  -- EXEC my_new_job_proc ('SM_JOB1', 'Sample JOB1', 2000, 6000, vd_cur_date);
  my_new_job_proc ('SM_JOB1', 'Sample JOB1', 2000, 6000, vd_cur_date);
  DBMS_OUTPUT.PUT_LINE(vd_cur_date);
END;


/*
RETURN문
함수에서 사용한 RETURN문을 프로시저에서도 사용할 수 있는데 그 쓰임새와 처리 내용은 다르다.
함수에서는 일정한 연산을 수행하고 결과 값을 반환하는 역할을 했지만, 프로시저에서는 RETURN문을 만나면 이후 로직을 처리하지 않고 수행을 종료,
즉 프로시저를 빠져나가 버린다. 반복문에서 일정 조건에 따라 루프를 빠져나가기 위해 EXIT를 사용하는 것과 유사하다.
*/

    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN  JOBS.JOB_ID%TYPE,
      p_job_title IN  JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN  JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN  JOBS.MAX_SALARY%TYPE := 100
      --p_upd_date  OUT JOBS.UPDATE_DATE%TYPE
    )
    IS
      vn_cnt NUMBER := 0;
      vn_cur_date JOBS.UPDATE_DATE%TYPE := SYSDATE;
    BEGIN
      -- 1000 보다 작으면 메시지 출력 후 빠져 나간다
      IF p_min_sal < 1000 THEN
         DBMS_OUTPUT.PUT_LINE('최소 급여값은 1000 이상이어야 합니다');
         RETURN; -- 프로시저가 종료되고 아래 구문은 실행되지 않음.
      END IF;

      -- 동일한 job_id가 있는지 체크
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;
    END;



























