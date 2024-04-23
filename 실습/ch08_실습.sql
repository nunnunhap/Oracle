/*
PL/SQL�� ������ ���� ������ ����� Ư¡�� ��� ������ �ִٰ� �ռ� �����ߴ�.
���ڴ� SQL�� ����� �� �ֱ� �����̰�, ���ڴ� �Ϲ� ���α׷��� ���ó�� ������ ���� �Ҵ��ϰ� ����ó���� �� �� ������
Ư�� ����� ó���ϴ� �Լ��� ���ν����� ���� �� �ִ� ����� �����ϱ� �����̴�.
PL/SQL�� �Ϲ� ���α׷��� ���� �ٸ� ���� ��� �ڵ尡 DB ���ο��� ������� ó�������ν� ���� �ӵ��� ���� ���鿡�� ū ������ �ִٴ� ���̴�.

��DB ���α׷��֡��̶� �ϸ� SQL�� ����� DML���� ����ϴ� ���� ��Ī�� ���� ������,
���� ������ ����Ͻ� ������ ����� ���� PL/SQL�� ����� �����ϴ� ���� �����̴�
*/

SET SERVEROUTPUT ON;
-- �Ʒ� dbms_output.put_line(vi.num); ��� ����� ȭ�鿡�� ���� ���Ͽ� ���

-- �͸� ���
DECLARE
    vi_num NUMBER; -- ���� ����
BEGIN
    vi_num := 100; -- ������ ���� ���
    dbms_output.put_line(vi_num); --System.out.println() ������.
END;

/*
PL/SQL ����� �������
1. ���� :������ �ٸ� ���α׷��� ���� ����ϴ� ������ ������ ������ ����ο��� ���� ������ �ϰ� ����ο��� ���
    ������ ������Ÿ�� := �ʱ갪;
���� ����� ���ÿ� �ʱ갪�� �Ҵ��� �� �ִµ�, �ʱ갪�� �Ҵ����� ������ ������ Ÿ�Կ� ������� �� ������ �ʱ갪�� NULL�� �ȴ�.
������ ������ �� �ִ� ������ Ÿ���� ũ�� �� ������ ������ �� �ִµ�, �ϳ��� SQL ������ Ÿ���̰� �ٸ� �ϳ��� PL/SQL ������ Ÿ��
�߿� : PL/SQL ������ Ÿ�Կ��� SQL ������ Ÿ���� ���ԵǾ� ����.

2. ��� : ����� �����ʹ� �޸� �� �� ���� �Ҵ��ϸ� ������ �ʴ´�. ��� ���� ���� ����� ����ϴ�.
    ����� CONSTANT ������Ÿ�� := �����;
����� ������ ���� �ݵ�� CONSTANT�� Ű���带 �ٿ� ������ �����ϸ�, ������ �� �ݵ�� �ʱ�ȭ�ؾ� �ϰ� 
����ο��� ����� �ٸ� ������ ������ �� ����. �ֳ��ϸ� �� �״�� ����� ����ϱ�!
*/

DECLARE -- ������ ��� ���� ��ġ(�����)
    a INTEGER := 2**2*3**2;
BEGIN -- �����
    DBMS_OUTPUT.PUT_LINE('a = ' || a);
END;

/*
PL/SQL ��� �󿡼� ����ϴ� ����, ���, �����ڴ� ��� �������� �뵵�� ���� ���̴�.
������ PL/SQL ����� �ۼ��ϴ� ������ ������ ���̺� �� �ִ� �����͸� �̸����� �����ؼ� Ư�� ������ ���� ���𰡸� ó���ϴ� ���̸�,
���� �ַ� ���Ǵ� ���� SQL���̴�. SQL�� �� DDL�� PL/SQL �󿡼� ���� �� �� ����(���� ���� ����� ���� ���� �ƴϴ�) DML���� ����Ѵ�.
*/
-- �ó�����? ��� ���̺��� Ư�� ����� �̸��� �μ����� ������ ����ϴ� �ڵ带 �ۼ�
-- 1) �Ϲ����� SQL����
SELECT e.emp_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.employee_id = 100;

-- 2) PL/SQL ����
DECLARE
    vs_emp_name     VARCHAR2(80); -- ����� ����
    vs_dep_name     VARCHAR2(80); -- �μ��� ����
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;
    
    -- ������ ���
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;

/*
������ ���� %TYPE Ű���带 ���� �ش� ������ �÷� Ÿ���� �ڵ����� �����´�.
�ش� ���̺��� �÷� ������Ÿ���� �����Ǿ��� �� �Ʒ��� ���� �ϸ� �ڵ����� ����� ������Ÿ������ ������.
    ������ ���̺��.�÷���%TYPE;
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
SQL�� PL/SQL ������ Ÿ�Ժ� ����
SQL : VARCHAR2(4000)�� �ִ�ġ
PL/SQL : VARCHAR2(12006)�� �ִ�ġ
*/
CREATE TABLE ch08_varchar2 (
    var1    VARCHAR2(5000)); -- ���� �߻�

-- Ÿ�� ����
CREATE TABLE ch08_varchar2 (
       VAR1 VARCHAR2(4000)); -- 4000���� ����
    
INSERT INTO ch08_varchar2 VALUES('4000����Ʈ ũ�� ������');

SELECT * FROM ch08_varchar2;

COMMIT;

DECLARE
    vs_sql_varchar2     VARCHAR2(4000);
    vs_plsql_varchar2   VARCHAR2(32767);
BEGIN
    SELECT var1 INTO vs_sql_varchar2 FROM ch08_varchar2;
        
    vs_plsql_varchar2 := vs_plsql_varchar2 || ' - ' || vs_plsql_varchar2 || ' - ' || vs_plsql_varchar2;
    
    -- �� ������ ũ�⸦ �����.
    DBMS_OUTPUT.PUT_LINE('SQL VARCHAR2 ����  : ' || LENGHTB(vs_sql_varchar2));
    DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR2 ����  : ' || LENGHTB(vs_plsql_varchar2));
END;


-- PL/SQL ����� �Լ�, ���ν��� �˾� ����
/*
�͸� ��ϰ� �޸� �Լ��� ���ν����� �����ͺ��̽� ���� ����ǰ� �����ϵǹǷ� �������� ������ ������ ���α׷����� 
�Լ��� ���ν����� ����� ���� �� DB ���α׷����� �����̶�� �� �� �ִ�.
*/
--PL/SQL ���
DECLARE
    vn_num1 NUMBER := 1;
    vn_num2 NUMBER := 2;
BEGIN
    IF vn_num1 >= vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num1 || ' �� ū ��');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vn_num2 || ' �� ū ��');
    END IF;
END;

SELECT ROUND(DBMS_RANDOM.VALUE (10, 120), -1) FROM DUAL;

    DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
    BEGIN
    -- �μ��ڵ带 �������� ��ȯ
    -- 10~120 ������ �Ǽ��� �������� ����ϰ� �� �� ������ ù��° �ڸ����� �ݿø��ϱ�.
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

       SELECT salary
         INTO vn_salary
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1; -- ������ �μ��� ����� �������� ��� �տ� ������ 1���� ����

      DBMS_OUTPUT.PUT_LINE(vn_salary);

      IF vn_salary BETWEEN 1 AND 3000 THEN
         DBMS_OUTPUT.PUT_LINE('����');
      ELSIF vn_salary BETWEEN 3001 AND 6000 THEN
         DBMS_OUTPUT.PUT_LINE('�߰�');
      ELSIF vn_salary BETWEEN 6001 AND 10000 THEN
         DBMS_OUTPUT.PUT_LINE('����');
      ELSE
         DBMS_OUTPUT.PUT_LINE('�ֻ���');
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
CASE��
CASE���� 3�忡�� ����� CASE ǥ���İ� ����ϴ�. SELECT ������ CASE ǥ������ ����ߵ��� PL/SQL ���α׷� �������� CASE���� ����� �� �ִµ�, �� ������ ������ ����.

    <���� 1>
    CASE ǥ����
        WHEN ���1 THEN
             ó����1;
        WHEN ���2 THEN
             ó����2;
        ...
        ELSE
             ��Ÿ ó����;
    END CASE;
     
    <���� 2>
    CASE WHEN ǥ����1 THEN
             ó����1;
        WHEN ǥ����2 THEN
             ó����2;
        ...
        ELSE
             ��Ÿ ó����;
    END CASE;
*/

SET SERVEROUTPUT ON;

DECLARE -- �ʱⰪ�� �� �ָ� ���������� NULL�� �����.
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
            DBMS_OUPUT.PUT_LINE('����');
        WHEN vn_salary BETWEEN 3001 AND 6000 THEN
            DBMS_OUTPUT.PUT_LINE('�߰�');
        WHEN vn_salary BETWEEN 6001 AND 10000 THEN
            DBMS_OUPUT.PUT_LINE('����');
        ELSE
            DBMS_OUPUT.PUT_LINE('�ֻ���');
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
              DBMS_OUTPUT.PUT_LINE('����');
         WHEN vn_salary BETWEEN 3001 AND 6000 THEN
              DBMS_OUTPUT.PUT_LINE('�߰�');
         WHEN vn_salary BETWEEN 6001 AND 10000 THEN
              DBMS_OUTPUT.PUT_LINE('����');
         ELSE
              DBMS_OUTPUT.PUT_LINE('�ֻ���');
      END CASE;

    END;

/*
LOOP���� ������ ���� �ݺ��ؼ� ������ ó���ϴ� �ݺ����̴�. �̷��� �ݺ������� LOOP�� �ܿ��� WHILE��, FOR���� ����.
    LOOP
      ó����;
      EXIT [WHEN ����];
    END LOOP;
*/

-- 3�� ���
-- ����1
    DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
    BEGIN
      LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
          vn_cnt := vn_cnt + 1;      -- ������ ���鼭 vn_cnt ���� 1�� ������

          EXIT WHEN vn_cnt > 9;      -- vn_cnt�� 9���� ũ�� ���� ����
      END LOOP;
    END;

-- ����2
    DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
    BEGIN

      WHILE  vn_cnt <= 9           -- vn_cnt�� 9���� �۰ų� ���� ���� �ݺ� ó��
      LOOP
         DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
         EXIT WHEN vn_cnt = 5;     -- vn_cnt ���� 5�� �Ǹ� ���� ����
         vn_cnt := vn_cnt + 1;     -- vn_cnt ���� 1�� ����
      END LOOP;
    END;

/*
FOR���� �ٸ� ���α׷��� ���� ����ϴ� �Ͱ� ����� �����̴�. ����Ŭ���� �����ϴ� FOR���� �⺻ ������ ������ ����.

    FOR �ε��� IN [REVERSE]�ʱ갪..������
    LOOP
      ó����;
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
CONTINUE���� FOR�� WHILE ���� �ݺ����� �ƴ�����, �ݺ��� ������ Ư�� ���ǿ� ������ �� ó�� ������ �ǳʶٰ�
����� ���� �������� �ǳʰ� ������ ��� ������ �� ����Ѵ�. EXIT�� ������ ������ ���� �����µ� ����,
CONTINUE�� ���� ������ �������� �Ѿ��.
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


-- PL/SQL �ڵ� �󿡼� GOTO���� ������ GOTO���� �����ϴ� �󺧷� ��� �Ѿ��.
-- ��(label) : Ư�� ������ �̸��� �ο�. <<���̸�>>
-- ���߿��� ������� ����. �������ϱ� ������.
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
PL/SQL������ NULL���� ����� �� �ִ�. NULL���� �ƹ��͵� ó������ �ʴ� �����̴�.
�ƹ� �͵� ó������ �ʴµ� ���� ����� �ʿ䰡 ������? PL/SQL �ڵ带 �ۼ��ϴ� ���� ������ �ʿ��� ���� �ִ�.
NULL���� ���� IF���̳� CASE���� �ۼ��� �� �ַ� ����ϴµ�, ���ǿ� ���� ó�� ������ �ۼ��ϰ� �տ��� �ۼ��� ��� ���ǿ� ���յ��� ���� ��,
�� ELSE���� ������ �� �ƹ��͵� ó������ �ʰ� ���� ��� NULL���� ����Ѵ�.
*/
    IF vn_variable = 'A' THEN
       ó������1;
    ELSIF vn_variable = 'B' THEN
       ó������2;
       ...
    ELSE NULL;
    END IF;

    CASE WHEN vn_variable = 'A' THEN
              ó������1;
         WHEN vn_variable = 'B' THEN
              ó������2;
         ...
         ELSE NULL;
    END CASE;


/*
PL/SQL�� �̿��� ����� ���� �Լ�, ���ν��� ����

SQL �Լ��� ����Ŭ���� �����ϴ� ���� �Լ��̰�(�׷��� ��Ʈ�� �Լ���� ��), ���⿡�� ���ϴ� �Լ��� ����ڰ� ���� ������ �����ϴ� ����� ���� �Լ��� ���Ѵ�.

    CREATE OR REPLACE FUNCTION �Լ� �̸� (�Ű�����1, �Ű�����2, ...)
    RETURN ������Ÿ��;
    IS[AS] -- DECLARE Ű���� ����.
      ����, ��� �� ����
    BEGIN
      �����
    ��
      RETURN ��ȯ��;
    [EXCEPTION -- ���α׷��� EXCEPTION�� ���°� ����.
      ���� ó����]
    END [�Լ� �̸�];
*/
-- ó�� ���� �� �� �� ���µ� ������������ �̰� ���� ��.
CREATE OR REPLACE FUNCTION my_mod(num1 NUMBER, num2 NUMBER)
RETURN NUMBER
IS
    vn_remainder    NUMBER := 0;
    vn_quotient     NUMBER := 0;
BEGIN
    vn_quotient := FLOOR(num1 / num2);
    vn_remainder := num1 - (num2 * vn_quotient);
    
    RETURN vn_remainder; -- ���� returnŸ�Դ�� ����.
END;

/*
�Լ� ȣ��
���� ������ �Լ��� ȣ���� ����. �Լ� ȣ�� ����� �Ű������� ���� ������ ���� �Լ���� �Ű������� ����ϱ⵵ �ϰ�, �Լ��� ����ϱ⵵ �Ѵ�. �׸��� �Լ��� ��ȯ ���� �����Ƿ� SELECT ���忡�� ����� ���� �ְ� PL/SQL ��� �������� ����� �� �ִ�.

    <�Ű������� ���� �Լ� ȣ��>
    �Լ��� Ȥ�� �Լ���()
     
    <�Ű������� �ִ� �Լ� ȣ��>
    �Լ���(�Ű�����1, �Ű�����2,...)
*/
SELECT my_mod(14, 3) remainder FROM DUAL; -- 2
SELECT FLOOR(14/3) FROM DUAL; -- FLOOR() �����Լ� : 4

-- �������� ��ȯ�ϴ� �Լ�
CREATE OR REPLACE FUNCTION fn_get_country_name( p_country_id NUMBER)
RETURN VARCHAR2 -- �Ű������� ����Ÿ���� ���̸� ��� ����.
IS
    vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
    vn_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO vn_count
    FROM countries
    WHERE country_id = p_country_id;
    RETURN vs_country_name; -- ������ ��ȯ
END;

SELECT fn_get_country_name(52777) COUN1, fn_get_country_name(10000) COUN2
FROM DUAL;
-- 10000�� ���� �ڵ尡 �������� �ʾ� NULL ��� '����' ���ڿ��� ����ϴ� �Լ� ������ ����.


    CREATE OR REPLACE FUNCTION fn_get_country_name ( p_country_id NUMBER )
       RETURN VARCHAR2  -- �������� ��ȯ�ϹǷ� ��ȯ ������Ÿ���� VARCHAR2
    IS
       vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
       vn_count NUMBER := 0;
    BEGIN
       SELECT COUNT(*)
         INTO vn_count
         FROM countries
        WHERE country_id = p_country_id;

      IF vn_count = 0 THEN
         vs_country_name := '�ش籹�� ����';
      ELSE
       SELECT country_name
         INTO vs_country_name
         FROM countries
        WHERE country_id = p_country_id;
      END IF;

     RETURN vs_country_name;  -- ������ ��ȯ

    END;

SELECT fn_get_country_name(52777) COUN1, fn_get_country_name(10000) COUN2
FROM DUAL;

/*
PL/SQL�� ����� ���ν��� ����
�Լ��� Ư�� ������ ������ �� ��� ���� ��ȯ������ ���ν����� Ư���� ������ ó���ϱ⸸ �ϰ� ��� ���� ��ȯ������ �ʴ� ���� ���α׷��̴�.
�Ϲ������� ������Ʈ ���忡���� �ý��� ���谡 ���� �� ������ �����ϰ� �� ������ ���� ������ ������ �����ؾ� �ϴµ�, 
�������� ���� ������ �ַ� ���ν����� ������ ó���Ѵ�. �� ���̺��� �����͸� ������ �Ը��� �°� �����ϰ� �� ����� �ٸ� ���̺�
�ٽ� �����ϰų� �����ϴ� �Ϸ��� ó���� �� �� �ַ� ���ν����� ����Ѵ�.
*/
/*
���ν��� ����
�Լ��� ���ν��� ��� DB�� ����� ��ü�̹Ƿ� ���ν����� ������(Stored, �����) ���ν������ �θ��⵵ �ϴµ�
�� å������ �׳� ���ν������ �ϰڴ�(�Լ��� ������ �Լ���� �Ѵ�). ���ν����� ���� ������ ������ ����.

    CREATE OR REPLACE PROCEDURE ���ν��� �̸�
        (�Ű�������1[IN |OUT | IN OUT] ������Ÿ��[:= ����Ʈ ��],
         �Ű�������2[IN |OUT | IN OUT] ������Ÿ��[:= ����Ʈ ��],
         ...
        )
    IS[AS]
      ����, ��� �� ����
    BEGIN
      �����
    ��
    [EXCEPTION
      ���� ó����]
    END [���ν��� �̸�];
*/

-- JOBS ���̺� ������ �����ϴ� ���ν��� ����(�� ������ ���ν����� ������ ����)
CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id      IN  JOBS.JOB_ID%TYPE, -- ���⼭ IN, OUT, INOUT�� �� �� ����.
    p_job_title   IN  JOBS.JOB_TITLE%TYPE,  -- IN : �Է� �Ű�����
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

-- ���� ���� �ȿ� �Ʒ� ���ν��� ȣ�� ������ �����ϰ� �ȴ�.
    EXEC my_new_job_proc ('SM_JOB1', 'Sample JOB1', 1000, 5000);

    SELECT *
      FROM jobs
     WHERE job_id = 'SM_JOB1';


CREATE OR REPLACE PROCEDURE my_new_job_proc
(   p_job_id      IN  JOBS.JOB_ID%TYPE, -- ���⼭ IN, OUT, INOUT�� �� �� ����.
    p_job_title   IN  JOBS.JOB_TITLE%TYPE,  -- IN : �Է� �Ű�����
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
        -- p_job_id���� �ߺ��˻��Ͽ� �������� ������ ����. �����ϸ� ����
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

-- �Ű������� ���� �����Ͽ� ���ν��� ���� ����
     EXECUTE my_new_job_proc (p_job_id => 'SM_JOB1', p_job_title => 'Sample JOB1',
                               p_min_sal => 2000, p_max_sal => 7000);



-- �Ű������� �ʱⰪ ���
    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE := 100 )
    IS
        vn_cnt  NUMBER := 0;
    BEGIN
        -- p_job_id���� �ߺ��˻��Ͽ� �������� ������ ����. �����ϸ� ����
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


-- OUT, IN OUT �Ű�����
-- �����͸� ���� �Ǵ� ���� ��¥�� �޾ƿ��� ���ν���
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
        -- p_job_id���� �ߺ��˻��Ͽ� �������� ������ ����. �����ϸ� ����
        SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
        WHERE job_id = p_job_id;
        
        -- �������� ������
        IF vn_cnt = 0 THEN
            INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
            VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, vn_cur_date, vn_cur_date);
        ELSE -- �����ϸ�
            UPDATE JOBS
                SET job_title = p_job_title, min_salary = p_min_sal, max_salary = p_max_sal,
                    update_date = vn_cur_date
                WHERE job_id = p_job_id;
        END IF;
        -- OUT�Ű������� �۾���¥ ����
        p_upd_date := vn_cur_date;
      COMMIT;
    END ;

-- OUT �Ű������� �ִ� ���ν��� ����
SET SERVEROUTPUT ON;
DECLARE
   vd_cur_date JOBS.UPDATE_DATE%TYPE; -- �̰� ����� ���;� ��.
BEGIN
-- ���ν��� �ܵ� ���� �ô� EXEC Ű���� ���. ������ �ܵ��� �ƴ� ���� �ݵ�� �����ؾ� ��.
  -- EXEC my_new_job_proc ('SM_JOB1', 'Sample JOB1', 2000, 6000, vd_cur_date);
  my_new_job_proc ('SM_JOB1', 'Sample JOB1', 2000, 6000, vd_cur_date);
  DBMS_OUTPUT.PUT_LINE(vd_cur_date);
END;


/*
RETURN��
�Լ����� ����� RETURN���� ���ν��������� ����� �� �ִµ� �� ���ӻ��� ó�� ������ �ٸ���.
�Լ������� ������ ������ �����ϰ� ��� ���� ��ȯ�ϴ� ������ ������, ���ν��������� RETURN���� ������ ���� ������ ó������ �ʰ� ������ ����,
�� ���ν����� �������� ������. �ݺ������� ���� ���ǿ� ���� ������ ���������� ���� EXIT�� ����ϴ� �Ͱ� �����ϴ�.
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
      -- 1000 ���� ������ �޽��� ��� �� ���� ������
      IF p_min_sal < 1000 THEN
         DBMS_OUTPUT.PUT_LINE('�ּ� �޿����� 1000 �̻��̾�� �մϴ�');
         RETURN; -- ���ν����� ����ǰ� �Ʒ� ������ ������� ����.
      END IF;

      -- ������ job_id�� �ִ��� üũ
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;
    END;



























