/*
예외처리와 트랜잭션 알아 보기
프로그램을 개발하다 보면 다양한 경우의 수를 산정해서 오류 확인 및 예외처리를 하는 것이 보통인데 PL/SQL 역시 마찬가지다.
*/
-- 예외처리 : 다시 오라클에서 발생시키는 시스템 예외와 사용자가 의도적으로 발생시킬 수 있는 사용자 정의 예외로 구분할 수 있다.
-- 시스템 예외는 오라클 내부에 미리 정의된 예외
/*
    EXCEPTION WHEN 예외명1 THEN 예외처리 구문1
     WHEN 예외명2 THEN 예외처리 구문2
     ...
     WHEN OTHERS THEN 예외처리 구문n;
*/

-- PL/SQL 구문
-- 함수 또는 프로시저 이름으로 만들지 않고 아래와 같이 코드를 구성하면 이를 익명블록이라고 함.
DECLARE
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10/0; -- 제수가 0으로 사용되어 예외발생
    dbms_output.put_line('Success'); -- 실행조차 못 됨.
    
    -- 예외처리 작업
    EXCEPTION WHEN OTHERS THEN -- oh
        dbms_output.put_line('오류 발생');
END;


-- 예외처리가 없는 프로시저
CREATE OR REPLACE PROCEDURE ch10_no_exception_proc
IS
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10 / 0; -- 예외발생
    DBMS_OUTPUT.PUT('SUCCESS');
END;

-- 예외처리가 있는 프로시저
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10 / 0; -- 예외발생
    dbms_output.put_line('SUCCESS');
    
    -- 예외처리
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('오류 발생');
END;

-- 예외처리가 없는 프로시저 실행
DECLARE

BEGIN
    ch10_no_exception_proc;
    -- 이 구문이 앞에 예외처리가 없는 프로시저가 실행되어 예외발생이 되어 실행되지 않음.
    DBMS_OUTPUT.PUT_LINE('SUCCESS!');
END;

-- 예외처리가 있는 프로시저 실행
DECLARE

BEGIN
    ch10_exception_proc; -- 예외존재
    DBMS_OUTPUT.PUT_LINE('SUCCESS!'); -- 예외실행
END;

-- 예외처리가 있는 프로시저(수정)
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10 / 0; -- 예외발생
    dbms_output.put_line('SUCCESS');
    
    -- 예외처리
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('오류 발생');
    DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE); -- 에러코드
    DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM); -- 에러메시지
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE)); -- 에러코드와 에러 메시지
END;


-- 예외처리가 있는 프로시저(수정) 실행
DECLARE

BEGIN
    ch10_exception_proc; -- 예외존재
    DBMS_OUTPUT.PUT_LINE('SUCCESS!'); -- 예외실행
END;


-- 예외처리를 OTHERS를 사용하지 않고 ZERO_DIVIDE 예외처리명 사용
    CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM);
    END;


-- 예외처리명을 두 개 이상으로 하는 프로시저 변경
    CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('오류1');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE1: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('오류2');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE2: ' || SQLERRM);
    END;

-- SELECT INTO 예외발생
CREATE OR REPLACE PROCEDURE ch10_upd_jobid_proc (
    p_employee_id   employees.employee_id%TYPE,
    p_job_id        jobs.job_id%TYPE
)
IS
    vn_cnt  NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id;
    
    IF vn_cnt = 0 THEN
        dbms_output.put_line('job_id가 없습니다.');
        RETURN;
    ELSE
        UPDATE employees
            SET job_id = p_job_id
        WHERE employee_id = p_employee_id;
    END IF;
    COMMIT;
END;

-- 위의 프로시저를 예외처리 로직이 사용된 코드로 변경하자.
CREATE OR REPLACE PROCEDURE ch10_upd_jobid_proc (
    p_employee_id   employees.employee_id%TYPE,
    p_job_id        jobs.job_id%TYPE
)
IS
    vn_cnt  NUMBER := 0;
BEGIN
-- 조건식이 일치하지 않으면 오라클에선 SELECT INTO구문이
-- 예외가 발생하도록 설계되어 있다.
    SELECT 1
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id; -- 조건식이 FALSE이면 예외발생
    
    UPDATE employees
        SET job_id = p_job_id
    WHERE employee_id = p_employee_id;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(p_job_id || '에 해당하는 job_id가 없습니다.');
        WHEN OTHERS THEN
            DBMS_OUPUT.PUT_LINE('기타에러: ' || SQLERRM);
    
    COMMIT;
END;

-- 프로시저 생성 시 SELECT문 결과형태를 사용하면 안된다.(중요)
CREATE OR REPLACE PROCEDURE udp_select
IS
BEGIN
    SELECT * FROM employees;
END;--PLS-00428: an INTO clause is expected in this SELECT statement














COMMIT;