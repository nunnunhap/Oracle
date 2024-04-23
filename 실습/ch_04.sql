/*
    SQL�Լ�
    01 ���� �Լ�
    02 ���� �Լ�
    03 ��¥ �Լ�
    04 ��ȯ �Լ�
    05 NULL ���� �Լ�
    06 ��Ÿ �Լ�
*/

-- ���� �Լ� : ���� �Լ��� ���� ������ �ϴ� �Լ��� ���� ��� ��, �Ű������� ��ȯ ���� ��κ� ���� ���´�.

-- 1) ABS(n) �Ű������� ���ڸ� �޾� �� ���밪�� ��ȯ�ϴ� ��
SELECT ABS(10), ABS(-10), ABS(-10.213)
FROM DUAL; -- 10 10 10.213

-- 2) CEIL(n) �� FLOOR(n)
-- CEIL �Լ��� �Ű����� n�� ���ų� ���� ū ������ ��ȯ
SELECT CEIL(10.123), CEIL(10.541), CEIL(11.001)
FROM DUAL; -- 11 11 12

-- FLOOR �Լ��� CEIL �Լ��ʹ� �ݴ�� �Ű����� n���� �۰ų� ���� ū ������ ��ȯ
SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001)
FROM DUAL; -- 10 10 11

-- 3) ROUND(n, i)�� TRUNC(n1, n2)
-- ROUND(n) : �Ҽ��� ù°�ڸ����� �ݿø�
SELECT ROUND(10.154), ROUND(10.541), ROUND(11.001)
FROM DUAL; -- 10 11 11
-- ROUND(n, i) : �Ҽ��� i�ڸ����� ������. i+1�ڸ����� �ݿø�.
-- i�� ����� �Ҽ� : �Ҽ��� i�ڸ����� ������. i+1�ڸ����� �ݿø�.
-- i�� ������ ���� : 
SELECT ROUND(10.154, 1), ROUND(10.154, 2), ROUND(10.154, -1)
FROM DUAL; -- 10.2 10.15 10

-- TRUNC : ����/ �߶󳻱�
SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2)
FROM DUAL; -- 115 115.1 115.15 100

-- POWER(n2, n1)�� SQRT(n)
-- POWER �Լ��� n2�� n1 ������ ����� ��ȯ�Ѵ�. n1�� ������ �Ǽ� ��� �� �� �ִµ�, n2�� ������ �� n1�� ������ �� �� �ִ�.
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001)
FROM DUAL; -- 9 27 27.0029~~~~

-- SQRT �Լ��� n�� �������� ��ȯ. ��Ʈ ����
SELECT SQRT(2), SQRT(5)
FROM DUAL; -- 1.41421~ 2.2360~~

-- MOD(n2, n1)�� REMAINDER(n2, n1)
-- MOD �Լ��� n2�� n1���� ���� ������ ���� ��ȯ
SELECT MOD(19,4), MOD(19.123, 4.2)
FROM DUAL; -- 3 2.323  :  n2 - n1 * FLOOR (n2/n1)

-- REMAINDER(n2, n1) �������� ��. 
SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2)
FROM DUAL; -- -1 -1.877 : n2 - n1 * ROUND (n2/n1)



-- �����Լ�
-- INITCAP(char), LOWER(char), UPPER(char)
-- INITCAP �Լ��� �Ű������� ������ char�� ù ���ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȯ�ϴ� �Լ�
SELECT INITCAP('never say goodbye'), INITCAP('never6say*good��bye')
FROM DUAL; --Never Say Goodbye  Never6say*Good��Bye

SELECT emp_name, INITCAP(emp_name) FROM employees;
-- Samuel McCain  -> Samuel Mccain

COMMIT;


-- �ҹ��� �빮�� ��ȯ
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye') FROM DUAL;

SELECT emp_name, LOWER(emp_name), UPPER(emp_name) FROM employees;

-- CONCAT �Լ��� ��||�� ������ó�� �Ű������� ������ �� ���ڸ� �ٿ� ��ȯ
SELECT CONCAT('I HAVE', ' A DREAM'), 'I HAVE' || ' A DREAM' FROM DUAL;

SELECT CONCAT(emp_name, salary), emp_name || ' ' || salary FROM employees;

-- SUBSTR�� ���� �Լ� �� ���� ���� ���Ǵ� �Լ���, �߶�� ��� ���ڿ��� char�� pos��° ���ں��� len���̸�ŭ �߶� ����� ��ȯ�ϴ� �Լ�
-- �Ʒ��� 1�� ��ġ(ù��°��ġ) 4�� ���� // ������ ������ �ں��� ������ ��. �ڿ��� ù��°
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4) FROM DUAL;

SELECT SUBSTR(emp_name, 1, 3) || '*****' AS "����� ���̵�" FROM employees;

-- ����Ʈ ����
SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('�����ٶ󸶹ٻ�', 1, 6) FROM DUAL;
-- �ѱ��� �� ����Ʈ�� ����?
SELECT LENGTHB('��') FROM DUAL;

-- LTRIM/ RTRIM ����/������������
SELECT LTRIM('      ABCDEF'), RTRIM('ABCED      ') FROM DUAL;

SELECT LENGTH('       ABCD'), LENGTH(LTRIM('       ABCD')) FROM DUAL;

SELECT LTRIM('ABCDEFGABC', 'ABC'),
    LTRIM('�����ٶ�', '��'),
    RTRIM('ABCDEFGABC', 'ABC'),
    RTRIM('�����ٶ�', '��')
FROM DUAL;

--LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
CREATE TABLE ex4_1 (
       phone_num VARCHAR2(30));

INSERT INTO ex4_1 VALUES ('111-1111');

INSERT INTO ex4_1 VALUES ('111-2222');

INSERT INTO ex4_1 VALUES ('111-3333');

SELECT *
  FROM ex4_1;


SELECT phone_num, LPAD(phone_num, 12, '(02)') FROM ex4_1;

SELECT RPAD(phone_num, 12, '****') FROM ex4_1;


--  REPLACE(char, search_str, replace_str)
--  char ���ڿ����� search_str ���ڿ��� ã�� �̸� replace_str ���ڿ��� ��ü�� ����� ��ȯ�ϴ� �Լ�
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '��', '��')
FROM DUAL;

-- ���ڿ��� �ִ� ��� ������ ����
SELECT LTRIM(' ABC DEF '),
       RTRIM(' ABC DEF '),
       REPLACE(' ABC DEF ', ' ', '')
FROM DUAL;

-- TRANSLATE �Լ� : REPLACE�� �ٸ� ���� ���ڿ� ��ü�� �ƴ� ���� �� ���ھ� ������ �ٲ� ����� ��ȯ
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') AS rep,
       TRANSLATE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') AS trn
  FROM DUAL;

-- INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)
-- str ���ڿ����� substr�� ��ġ�ϴ� ��ġ�� ��ȯ�ϴµ�, pos�� ���� ��ġ�� ����Ʈ ���� 1,
-- occur�� �� ��° ��ġ�ϴ����� ����ϸ� ����Ʈ ���� 1�̴�.
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����') AS INSTR1,
       INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����', 5) AS INSTR2,
       INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����', 5, 2) AS INSTR3
  FROM DUAL;
-- �ڿ� ���� �� �������� �� �պ��� ã��, 5, 2 �������� 5��° ��ġ�������� 2��° ������ ��ġ�� ã�ƶ�.

-- LENGTH �Լ��� �Ű������� ���� ���ڿ��� ������ ��ȯ�ϸ�, LENGTHB �Լ��� �ش� ���ڿ��� ����Ʈ ���� ��ȯ�Ѵ�.
SELECT LENGTH('���ѹα�'),
       LENGTHB('���ѹα�')
  FROM DUAL;

-- ��¥ �Լ��� DATE �Լ��� TIMESTAMP �Լ��� ���� ��¥���� ������� ������ ������ ����� ��ȯ�ϴ� �Լ���.
-- ��¥ �Լ� ���� ��κ� ��ȯ ����� ��¥���̳� �Լ��� ���� ���ڸ� ��ȯ�� ���� �ִ�.

-- SYSDATE(��), SYSTIMESTAMP(�и���)
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

-- ADD_MONTHS (date, integer)
-- ��¥�� ���� ���� �ǹ�. ������ ����Ͽ� �� �ǹ̵� ���� �� ����.
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1)
  FROM DUAL;

-- MONTHS_BETWEEN(date1, date2)
-- �� ��¥ ������ ���� ���� ��ȯ�ϴµ�, date2�� date1���� ���� ��¥�� �´�.
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
  FROM DUAL;

-- �ټӳ�� ������
SELECT
    employee_id,
    emp_name,
MONTHS_BETWEEN(SYSDATE, HIRE_DATE) AS mon1,
ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE), 1) / 12 AS �ټӳ��
FROM
    employees
ORDER BY employee_id;

-- LAST_DAY�� date ��¥�� �������� �ش� ���� ������ ���ڸ� ��ȯ
SELECT LAST_DAY('2024-02-01') FROM DUAL;

-- ROUND(date, format), TRUNC(date, format)
-- ���� �Լ��̸鼭 ��¥ �Լ��ε� ���̴µ�, ROUND�� format�� ���� �ݿø��� ��¥��, TRUNC�� �߶� ��¥�� ��ȯ
SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month') FROM DUAL;

-- TO_DATE()�� ���ڿ��� ��¥ ������Ÿ������ ĳ�������ִ� ��.
SELECT SYSDATE, ROUND(TO_DATE('2024-04-15'), 'month'),
TRUNC(TO_DATE('2024-04-15'), 'month') FROM DUAL;

SELECT SYSDATE, ROUND(TO_DATE('2024-04-16'), 'month'),
TRUNC(TO_DATE('2024-04-16'), 'month') FROM DUAL;

-- NEXT_DAY�� date�� char�� ����� ��¥�� ���� �� ���� ���ڸ� ��ȯ
-- ���� ��¥ �������� ���ƿ��� �ݿ�����?
SELECT NEXT_DAY(SYSDATE, '�ݿ���')
  FROM DUAL;

-- ��ȯ�Լ�
SELECT TO_CHAR(123456789, '999,999,999')
  FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;--sysdate�� �ʱ��� �����ϱ⿡ ����� ���� �̷���.

-- TO_NUMBER(expr, format) ���ڳ� �ٸ� ������ ���ڸ� NUMBER ������ ��ȯ�ϴ� �Լ�
SELECT TO_NUMBER('123456')
FROM DUAL;

-- TO_DATE(char, format), TO_TIMESTAMP(char, format)
SELECT TO_DATE('20140101', 'YYYY-MM-DD')
  FROM DUAL;

SELECT TO_DATE('20140101 13:44:50', 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;


-- NULL
-- �� NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
-- expr1�� NULL�� �� expr2�� ��ȯ
SELECT NVL(manager_id, employee_id)
  FROM employees
 WHERE manager_id IS NULL;

SELECT NVL(NULL, 10), NVL(10, 20) FROM DUAL;
-- NULL�̸� param1�� NOT NULL�̸� pram2�� ��µ�.

-- NVL2�� NVL�� Ȯ���� �Լ��� expr1�� NULL�� �ƴϸ� expr2��, NULL�̸� expr3�� ��ȯ�ϴ� ��
SELECT employee_id,
NVL2(commision_pct, salary + (salary * commision_pct), salary) AS salary2
FROM employees;

SELECT NVL2(NULL, 10, 20), NVL2(10, 20, 30) FROM DUAL;

-- NULL�� ���� �� ����� NULL�� �ȴ�.(�߿�)
SELECT NULL + 100 FROM DUAL;

-- �� COALESCE (expr1, expr2, ��)
-- �Ű������� ������ ǥ���Ŀ��� NULL�� �ƴ� ù ��° ǥ������ ��ȯ�ϴ� �Լ�
SELECT employee_id, salary, commission_pct,
       COALESCE (salary * commission_pct, salary) AS salary2
  FROM employees;
  
SELECT COALESCE(NULL, NULL, 1), COALESCE(NULL, 1, 2),
COALESCE(1, 2, 3), COALESCE(NULL, NULL, NULL) FROM DUAL;

-- LNNVL(���ǽ�) �Ű������� ������ ���ǽ��� ����� FALSE�̸� TRUE
-- ���ǽ��� ����� TRUE�̸� FALSE�� ��ȯ

SELECT emp_name, commission_pct FROM employees
WHERE LNNVL(commission_pct = 0);
-- ���� ������ ����ó�� ���� ����
SELECT emp_name, commission_pct FROM employees
WHERE commission_pct IS NULL OR commission_pct != 0;

SELECT salary FROM employees
WHERE LNNVL ( salary > 5000);
SELECT salary FROM employees
WHERE salary <= 5000;


-- NULLIF (expr1, expr2)
-- expr1�� expr2�� ���� ������ NULL��, ���� ������ expr1�� ��ȯ
SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL;

SELECT employee_id,
       TO_CHAR(start_date, 'YYYY') start_year,
       TO_CHAR(end_date, 'YYYY') end_year,
       NULLIF(TO_CHAR(end_date, 'YYYY'), TO_CHAR(start_date, 'YYYY') ) nullif_year
FROM job_history;

--  GREATEST(expr1, expr2, ��), LEAST(expr1, expr2, ��) ...�� �Ű������� ������ ����.
-- �Ű������� ������ ǥ���Ŀ��� ���� ū ����, LEAST�� ���� ���� ���� ��ȯ�ϴ� �Լ�
SELECT GREATEST(1, 2, 3, 2) AS "���� ū ��",
LEAST(1, 2, 3, 4) AS "���� ���� ��" FROM DUAL;

-- DECODE (expr, search1, result1, search2, result2, ��, default)
SELECT prod_id,
         DECODE(channel_id, 3, 'Direct',
                            9, 'Direct',
                            5, 'Indirect',
                            4, 'Indirect',
                               'Others')  decodes
   FROM sales
  WHERE rownum < 10;

CREATE TABLE test02(
    varvar          VARCHAR2(10),
    create_date     DATE       DEFAULT  SYSDATE    
);

INSERT INTO test02(varvar) values('����');

SELECT varvar, create_date FROM test02;



COMMIT; -- ������ �۾������� ���� �����ͺ��̽� ���Ͽ� ���������� �ݿ�.