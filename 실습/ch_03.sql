-- ����? EMPLOYEES���̺��� SALARY�� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ
SELECT DEPARTMENT_ID, EMP_NAME FROM EMPLOYEES WHERE SALARY > 5000;

SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 5000 ORDER BY EMPLOYEE_ID ASC; -- ��������

SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 5000 ORDER BY EMPLOYEE_ID DESC; -- ��������

-- ����? �޿��� 5000�̻��̰� JOB_ID�� 'IT_PROG'�� ����� ��ȸ
-- AND �����ڿ� JOB_ID�� �˻��ϴ� ������ �߰�
SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 5000
AND JOB_ID = 'IT_PROG' ORDER BY EMPLOYEE_ID ASC; -- ���ڿ� �����ʹ� ��ҹ��� �����ϴ� ����('IT_PROG')

-- ����? �޿��� 5000�̻��̰ų� JOB_ID�� 'IT_PROG'�� ����� ��ȸ
SELECT EMPLOYEE_ID, EMP_NAME, SALARY FROM EMPLOYEES
WHERE SALARY > 5000 OR JOB_ID = 'IT_PROG' 
ORDER BY EMPLOYEE_ID ASC;

-- INSERT��
-- INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES (��1, ��2);
CREATE TABLE EX3_1 (
    COL1        VARCHAR2(10),
    COL2        NUMBER,
    COL3        DATE
);

-- ������ ����
INSERT INTO EX3_1 (Col1, COL2, COL3) VALUES('ABC', 10, SYSDATE);

-- ������ ��ȸ
SELECT * FROM EX3_1;

-- �÷� ������ �ٲٴ��� VALUES���� �ִ� ���� �ٲ� ������ ���߱⸸ �ϸ� ������ ����.
INSERT INTO EX3_1(COL3, COL1, COL2) VALUES(SYSDATE, 'DEF', 20);

-- �÷�(�ʵ�, ��)�� NULL, DEFAULT�� ���� ����������. ������ ���� �� NULL�� ó��
INSERT INTO EX3_1(COL1, COL2) VALUES ('GHI', 20);
SELECT * FROM EX3_1;

-- INSERT - SELECT ����
-- Ű����(�����)�� �빮�ڷ�, �������� �ҹ��ڷ� ���� �������� �۾��ϴ� ���⵵ ����.

-- �̰��� 1��
CREATE TABLE ex3_2 (
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

INSERT INTO ex3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees
WHERE salary > 5000;

-- ������ ��ȸ
SELECT * FROM ex3_2;

-- �̰��� 2��
-- ���̺� ���, ���̺� ����
CREATE TABLE employees_bak
AS
SELECT employee_id, emp_name FROM employees
WHERE salary > 5000;

-- ������ ��ȸ
SELECT * FROM employees_bak;

-- ex3_1 ���̺��� col2 ���� ��� 50���� �����غ���.
-- UPDATE��. 
UPDATE ex3_1
SET col2 = 50; -- WHERE ���ǽ��� �����Ǹ� ���̺��� ��� �����͸� �����ϴ� �ǹ�.

-- ������ ��ȸ
SELECT * FROM ex3_1;

-- ����? COL1 �÷����� 'ABC'�� �������� COL2�÷��� ���� 100���� �����϶�.
UPDATE ex3_1
SET col2 = 100
WHERE col1 = 'ABC';

SELECT * FROM ex3_1 WHERE col1 = 'ABC';

-- ������ ��ȸ
SELECT * FROM ex3_2 ORDER BY emp_id ASC;

-- ����?
UPDATE ex3_2 SET emp_name = 'Peter Tucker Junior' WHERE emp_id = 150;

SELECT * FROM ex3_2 WHERE emp_id = 150;

-- �ó�����? employees ���̺��� salary �÷����� �޿��� 8000 �̻��� �����͸� ���� �÷�����
-- employee_id, emp_name, email, salary �����Ǵ� ���̺�(emp_salary_8000)�� ����
CREATE TABLE emp_salary_8000
AS
SELECT employee_id, emp_name, email, salary
FROM employees
WHERE salary > 8000;

SELECT * FROM emp_salary_8000 ORDER BY salary ASC;

-- ����? ��� ��ȣ�� 100���� �����͸� email�÷��� 'kings'�� �����ϰ� salary �÷��� 20000 ���� �����϶�.
UPDATE emp_salary_8000 SET email = 'KINGS', salary = 20000 WHERE employee_id = 100;

SELECT * FROM emp_salary_8000;


-- DELETE�� : ���̺� �ִ� �����͸� ������ �� DELETE�� �����.
SELECT * FROM emp_salary_8000 ORDER BY employee_id ASC;

-- 100�� �����͸� �����ϰ��� ��.
DELETE FROM emp_salary_8000 WHERE employee_id = 206;

-- ������ ��ȸ
SELECT * FROM emp_salary_8000 WHERE employee_id = 100;

-- �ó�����? �޿��� 10000~13000 ������ �����͸� ����
DELETE emp_salary_8000 WHERE salary BETWEEN 10000 AND 13000;

SELECT * FROM emp_salary_8000 ORDER BY salary ASC;

-- �ó�����? ����� 101 �Ǵ� 145�� �����͸� ����
DELETE emp_salary_8000 WHERE employee_id = 101 OR employee_id = 145;

SELECT * FROM emp_salary_8000 WHERE employee_id = 101 OR employee_id = 145 ORDER BY employee_id;

COMMIT;


-- TRUNCATE��
-- DELETE���� COMMIT�� �ؾ߸� ���� ������ �Ǹ� ROLLBACK �� ���� �����ϳ� �̰� ��� ���̺� �����Ͱ� ������.
CREATE TABLE ex3_4 (
    employee_id     NUMBER
);

INSERT INTO ex3_4 VALUES(100);

-- ������ ��ȸ
SELECT * FROM ex3_4;

ROLLBACK; -- ���� �Է��� �����Ͱ� ���

INSERT INTO ex3_4 VALUES(100);

SELECT * FROM ex3_4;

COMMIT;

-- ������ ��ȸ
SELECT * FROM ex3_4;

-- ���ǽ� WHERE�� ������ ������ �ȵ�. ROLLBACK ���� �ȵ�. ���� �Ұ�.
TRUNCATE TABLE ex3_4; -- Table EX3_4��(��) �߷Ƚ��ϴ�.

ROLLBACK;

SELECT * FROM ex3_4;


-- �ǻ��÷�
-- ���̺��� �÷�ó�� ���������� ������ ���̺� ������� �ʴ� �÷��� ����.

--1) ROWNUM : �������� ��ȯ�Ǵ� �� �ο�鿡 ���� ���� ���� ��Ÿ���� �ǻ��÷�
SELECT ROWNUM, employee_id, emp_name FROM employees WHERE salary > 5000;

-- ȭ�鿡 ��µǴ� �����͸� ����
SELECT ROWNUM, employee_id, emp_name FROM employees
WHERE ROWNUM <= 5;

SELECT ROWNUM, employee_id, emp_name FROM employees
WHERE ROWNUM <= 15;
-- �߰����� �������°� �Ұ�����. 

--2) ROWID
SELECT ROWNUM, ROWID, employee_id, emp_name FROM employees WHERE ROWNUM <= 5;



-- ������ : ���Ŀ����� NUMBER������Ÿ�Կ� �ش��ϴ� �÷� �Ǵ� ���� �����Ϳ� ���

-- ���̺� ���� ����
DESC employees;

SELECT employee_id, salary, commission_pct, salary * 12 + commission_pct
AS "����" FROM employees ORDER BY employee_id;

-- ���� ��°�� �� NULL�� Ȯ�εǴ� ���� �÷� �����Ͱ� NULL�� �����ϸ�, ����� NULL�� ��.

-- ���� �� NULL�� �����ϰ� ������ NULL�� �����ϸ� ����� NULL�� ��.
-- NULL ���� ����� NULL ���� �Լ��� �ҽ��ؾ� ��.
SELECT 10 + 20 FROM DUAL; -- NULL

-- �� ������: >, <, >=, <=, =, <>, !=, \^=

-- ǥ���� : CASE�� : https://gent.tistory.com/311
-- CASE�� ����
SELECT employee_id, emp_name, department_id FROM employees ORDER BY department_id;
--1) IF�� ���� : �μ��÷� �����Ͱ� 10�̸� New York, 20���̸� Dallas, ��Ÿ �������� Unknown
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

--2) SWITCH�� ����
SELECT employee_id, emp_name, department_id,
    CASE department_id
        WHEN 10 THEN 'NEW YORK'
        WHEN 20 THEN 'Dallas'
        ELSE 'Unknown'
    END AS department_city
FROM
    employees
ORDER BY department_id;

-- ELSE �����ϴ� ���
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

-- �ó����� : salary(�޿�)�� 15000�̻��̸� ��׿���. 10000�̻��̸� ������� �������� �Ϲݿ������� ����϶�
SELECT
    employee_id
    , emp_name
    , salary
    , CASE
        WHEN salary >= 15000 THEN '��׿���'
        WHEN salary >= 10000 THEN '�������'
        ELSE '�Ϲݿ���'
    END AS salary_gubun
FROM
    employees
ORDER BY
    salary DESC;

-- ��ø CASE �߰������۾� ����
SELECT
    employee_id, emp_name, department_id, salary,
    CASE
        WHEN department_id = 10 THEN
            CASE
                WHEN salary >= 15000 THEN '1���'
                WHEN salary >= 10000 THEN '2���'
                WHEN salary >= 3000  THEN '3���'
            END
        WHEN department_id = 20 THEN
            CASE
                WHEN salary >= 18000 THEN '1���'
                WHEN salary >= 15000 THEN '2���'
                WHEN salary >= 5000  THEN '3���'
            END
        WHEN department_id = 30 THEN
            CASE
                WHEN salary >= 8000 THEN '1���'
                WHEN salary >= 5000 THEN '2���'
                WHEN salary >= 2000 THEN '3���'
            END
        ELSE ' '
    END AS salary_gubun
FROM
    employees
ORDER BY department_id ASC;


-- �� ���ǽ� : ANY, SOME, ALL
-- salary�� 2000 3000 4000 �� �����͸� ��ȸ ANY�� OR�� ����.
--1) ANY ���
SELECT employee_id, salary
FROM employees
WHERE salary = ANY (2000, 3000, 4000)
ORDER BY employee_id;
--2) OR ���
SELECT employee_id, salary
FROM employees
WHERE salary = 2000
    OR salary = 3000
    OR salary = 4000
ORDER BY employee_id;
--3) ALL����� �Ұ���. 2000,3000,4000�� ���ÿ� ������ �� ����.

-- 4000���� salary�� ū ������ ��ȸ
SELECT employee_id, salary
FROM employees
WHERE salary > ALL (2000, 3000, 4000)
ORDER BY employee_id;

-- salary�� 2000���� ū ������ ��ȸ
SELECT employee_id, salary
FROM employees
WHERE salary > ANY (2000, 3000, 4000)
ORDER BY employee_id;

-- salary�� 2000���� ū ������ ��ȸ
SELECT employee_id, salary
FROM employees
WHERE salary > SOME (2000, 3000, 4000)
ORDER BY employee_id;
-- SOME�� ANY�� ����.

-- �� ���ǽ� : AND OR NOT
SELECT employee_id, salary
FROM employees
WHERE NOT (salary >= 2500)
ORDER BY employee_id;
-- ���� ������ ���� ����ϴ� ��찡 ����
SELECT employee_id, salary
FROM employees
WHERE salary < 2500
ORDER BY employee_id;


-- NULL ���ǽ�
-- ���ǽĿ��� ���Ǵ� IS NULL, IS NOT NULL
SELECT employee_id, emp_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NULL;

SELECT employee_id, emp_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;


-- IN ���ǽ� : �������� ����� ���� ���Ե� ���� ��ȯ�ϴµ� �տ��� ����� ANY�� ����ϴ�.

-- �޿��� 2000, 3000, 4000�� ���ԵǴ� ����� ������ ���
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN (2000, 3000, 4000); -- OR, ANY�� ��ȯ ����

SELECT employee_id, emp_name, salary FROM employees
WHERE salary NOT IN (2000, 3000, 4000);


-- LIKE ���ǽ� : ���ڿ��� ������ �˻��� �� ����ϴ� ���ǽ�
-- ��� ���̺��� ����̸��� ��A���� ���۵Ǵ� ����� ��ȸ�ϴ� ����
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'Al%'
ORDER BY emp_name;
-- �̷��� ���ϵ� ī�� ���ڴ� ������ LIKE �ٿ��־�� ��.
SELECT emp_name
FROM employees
WHERE emp_name = 'A%' -- ����
ORDER BY emp_name;

-- %
CREATE TABLE ex3_5 (
    name    VARCHAR2(30)
);

INSERT INTO ex3_5 VALUES('ȫ�浿');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ��');

SELECT * FROM ex3_5;

SELECT * FROM ex3_5
WHERE name LIKE 'ȫ��%';

SELECT * FROM ex3_5
WHERE name LIKE 'ȫ��_';

-- MERGE
/*
MERGE���� ������ ���ؼ� ���̺� �ش� ���ǿ� �´� �����Ͱ� ������ INSERT, ������ UPDATE�� �����ϴ� �����̴�.
Ư�� ���ǿ� ���� � ���� INSERT��, �� �ٸ� ��쿡�� UPDATE���� �����ؾ� �� ��, ���ſ��� �ش� ������ ó���ϴ� ������ ������ �ۼ��ؾ� ������,
MERGE���� ���� ���п� ���� �� �������� ó���� �� �ְ� �Ǿ���.

    MERGE INTO [��Ű��.]���̺��
        USING (update�� insert�� ������ ��õ)
             ON (update�� ����)
    WHEN MATCHED THEN
           SET �÷�1 = ��1, �÷�2 = ��2, ...
    WHERE update ����
           DELETE WHERE update_delete ����
    WHEN NOT MATCHED THEN
           INSERT (�÷�1, �÷�2, ...) VALUES (��1, ��2,...)
           WHERE insert ����;
*/

-- HR���� ���ӻ��, SCOTT ���� ���� ���
-- 1) ���� ���̺� ���(DUAL)
-- �ó�����? ������̺��� �����ȣ 7738�� �����ϸ� ������Ʈ
-- �������� ������ INSERT�۾��� ����.
SELECT * FROM EMP WHERE empno = 7738; --������ ����.

MERGE
    INTO emp a
    USING DUAL
        ON (a.empno = 7738)
    WHEN MATCHED THEN -- ���� ������ ���̸�
        -- UPDATE emp a SET a.deptno = 20 WHERE a.empno = 7738
        UPDATE
            SET a.deptno = 20
    WHEN NOT MATCHED THEN
        -- INSERT emp a (a.empno, a.ename, a.deptno) VALUES(7788, 'SCOTT', 20);
        INSERT (a.empno, a.ename, a.deptno)
        VALUES(7738, 'SCOTT', 20);

ROLLBACK;

-- 2) JOIN ��� : scott���� ���ӿ��� job_history���̺��� ���� ����.
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
        
-- DELETE�� ���
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
