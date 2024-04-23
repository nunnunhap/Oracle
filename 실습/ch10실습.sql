/*
����ó���� Ʈ����� �˾� ����
���α׷��� �����ϴ� ���� �پ��� ����� ���� �����ؼ� ���� Ȯ�� �� ����ó���� �ϴ� ���� �����ε� PL/SQL ���� ����������.
*/
-- ����ó�� : �ٽ� ����Ŭ���� �߻���Ű�� �ý��� ���ܿ� ����ڰ� �ǵ������� �߻���ų �� �ִ� ����� ���� ���ܷ� ������ �� �ִ�.
-- �ý��� ���ܴ� ����Ŭ ���ο� �̸� ���ǵ� ����
/*
    EXCEPTION WHEN ���ܸ�1 THEN ����ó�� ����1
     WHEN ���ܸ�2 THEN ����ó�� ����2
     ...
     WHEN OTHERS THEN ����ó�� ����n;
*/

-- PL/SQL ����
-- �Լ� �Ǵ� ���ν��� �̸����� ������ �ʰ� �Ʒ��� ���� �ڵ带 �����ϸ� �̸� �͸����̶�� ��.
DECLARE
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10/0; -- ������ 0���� ���Ǿ� ���ܹ߻�
    dbms_output.put_line('Success'); -- �������� �� ��.
    
    -- ����ó�� �۾�
    EXCEPTION WHEN OTHERS THEN -- oh
        dbms_output.put_line('���� �߻�');
END;


-- ����ó���� ���� ���ν���
CREATE OR REPLACE PROCEDURE ch10_no_exception_proc
IS
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10 / 0; -- ���ܹ߻�
    DBMS_OUTPUT.PUT('SUCCESS');
END;

-- ����ó���� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10 / 0; -- ���ܹ߻�
    dbms_output.put_line('SUCCESS');
    
    -- ����ó��
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('���� �߻�');
END;

-- ����ó���� ���� ���ν��� ����
DECLARE

BEGIN
    ch10_no_exception_proc;
    -- �� ������ �տ� ����ó���� ���� ���ν����� ����Ǿ� ���ܹ߻��� �Ǿ� ������� ����.
    DBMS_OUTPUT.PUT_LINE('SUCCESS!');
END;

-- ����ó���� �ִ� ���ν��� ����
DECLARE

BEGIN
    ch10_exception_proc; -- ��������
    DBMS_OUTPUT.PUT_LINE('SUCCESS!'); -- ���ܽ���
END;

-- ����ó���� �ִ� ���ν���(����)
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER := 0;
BEGIN
    vi_num := 10 / 0; -- ���ܹ߻�
    dbms_output.put_line('SUCCESS');
    
    -- ����ó��
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('���� �߻�');
    DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE); -- �����ڵ�
    DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM); -- �����޽���
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE)); -- �����ڵ�� ���� �޽���
END;


-- ����ó���� �ִ� ���ν���(����) ����
DECLARE

BEGIN
    ch10_exception_proc; -- ��������
    DBMS_OUTPUT.PUT_LINE('SUCCESS!'); -- ���ܽ���
END;


-- ����ó���� OTHERS�� ������� �ʰ� ZERO_DIVIDE ����ó���� ���
    CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM);
    END;


-- ����ó������ �� �� �̻����� �ϴ� ���ν��� ����
    CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('����1');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE1: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('����2');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE2: ' || SQLERRM);
    END;

-- SELECT INTO ���ܹ߻�
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
        dbms_output.put_line('job_id�� �����ϴ�.');
        RETURN;
    ELSE
        UPDATE employees
            SET job_id = p_job_id
        WHERE employee_id = p_employee_id;
    END IF;
    COMMIT;
END;

-- ���� ���ν����� ����ó�� ������ ���� �ڵ�� ��������.
CREATE OR REPLACE PROCEDURE ch10_upd_jobid_proc (
    p_employee_id   employees.employee_id%TYPE,
    p_job_id        jobs.job_id%TYPE
)
IS
    vn_cnt  NUMBER := 0;
BEGIN
-- ���ǽ��� ��ġ���� ������ ����Ŭ���� SELECT INTO������
-- ���ܰ� �߻��ϵ��� ����Ǿ� �ִ�.
    SELECT 1
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id; -- ���ǽ��� FALSE�̸� ���ܹ߻�
    
    UPDATE employees
        SET job_id = p_job_id
    WHERE employee_id = p_employee_id;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(p_job_id || '�� �ش��ϴ� job_id�� �����ϴ�.');
        WHEN OTHERS THEN
            DBMS_OUPUT.PUT_LINE('��Ÿ����: ' || SQLERRM);
    
    COMMIT;
END;

-- ���ν��� ���� �� SELECT�� ������¸� ����ϸ� �ȵȴ�.(�߿�)
CREATE OR REPLACE PROCEDURE udp_select
IS
BEGIN
    SELECT * FROM employees;
END;--PLS-00428: an INTO clause is expected in this SELECT statement














COMMIT;