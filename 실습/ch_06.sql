-- ���� : 2���� ���̺��� �÷����� ���Ͽ�, ������ ���������� ���������� ������ ���
/*
ǥ�� : ����Ŭ ���ΰ� ANSI ����
������ ��������(INNER JOIN)�� �ܺ�����(OUTER JOIN)���� ����
- INNER JOIN : �Ϲ������� ������ ����ϸ� INNER JOIN �̾߱� ��.
- OUTER JOIN :
    1. LEFT OUTER JOIN
    2. RIGHT OUTER JOIN
    3. FULL OUTER JOIN
*/

-- ����? �����ȣ, �̸�, �μ����� ��ȸ
-- ��� ���̺� : �����ȣ, �̸�
-- �μ� ���̺� : �μ���

SELECT employee_id, emp_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- �ó����� emp���̺�� dept���̺��� �����Ͽ� �����͸� ����϶�.
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

-- ���̺� ��Ī�� ����Ͽ� INNER JOIN�ϴ� ����
SELECT a.employee_id, a.emp_name, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;

SELECT e.employee_id, e.emp_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

-- ���̺� 3�� ���� : ����Ŭ ����
SELECT *
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id
INNER JOIN job_history
ON departments.department_id = job_history.department_id;

--OUTER JOIN
-- 1. �Ϲ� ����
-- ��ġ�Ǵ� �����͸� �������� �������� ���

-- ��ġ�Ǵ� ��������� ��ġ���� �ʴ� �����͵� �����Ͽ� ���.
-- 2. �ܺ� ����
-- departments ���̺� : ��� �μ�����, job_history ���̺� : �μ��� ���� ������Ʈ ������ ����. (+) ǥ��
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
-- ���� �� ���� ������ ���� �����.

-- �Ʒ� �� ���� ������ �� �����.
-- LEFT OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b,
     departments a
WHERE b.department_id = a.department_id (+); -- 10��

-- INNER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM job_history b,
     departments a
WHERE b.department_id = a.department_id; -- 10��
-- �ΰ��� ���� ������ ������ : job_history���̺� ��ġ���� �ʴ� �μ��� �������� ����.

-- FULL OUTER JOIN : ����Ŭ �������� �������� ����.
SELECT a.department_id, a.department_name, b.job_id, b.department_id
  FROM departments a,
       job_history b
 WHERE a.department_id (+) = b.department_id (+) ;

-- FULL OUTER JOIN : ANSI JOIN���� ����ؾ� ��.
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

-- ���� ����
-- ���� �ٸ� �� ���̺��� �ƴ� ������ �� ���̺��� ����� �����ϴ� ����� ���Ѵ�.
-- �Ϲ� ���߿��� �� ���� ���� ����.
SELECT a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id
  FROM employees a,
       employees b
 WHERE a.employee_id < b.employee_id
   AND a.department_id = b.department_id
   AND a.department_id = 20;

-- ��� ���̺��� �μ��ڵ尡 20�� ��� ���
SELECT employee_id, emp_name, department_id
FROM employees
WHERE department_id = 20;

-- īŸ�þ� ����(CATASIAN PRODUCT) : ������������ ���� �� ���߿��� ����� �� ����.
-- WHERE ���� ���� ������ ���� ������ ���Ѵ�. �� FROM ���� ���̺��� ���������, �� ���̺� �� ���� ������ ���� �����̴�.
-- WHERE�� : JOIN ���ǽ��� ����.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
  FROM employees a, -- 107
       departments b; -- 27
-- ��ü ������ 2889
-- ANSI�������� CROSS �����̶�� ��. CATASIAN JOIN�� ����Ŭ
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
  FROM employees a
 CROSS JOIN departments b;
 -- ��ü ������ 2889



-- ���� �� �򰥷� �ϴ� ���
-- <�߸��� ���>
-- �Է�
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
      FROM employees a
     INNER JOIN departments b
     USING (department_id) --�÷����� ���ٸ� ON ��� ��� : ON a.department_id = b.department_id
     WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');
-- ���
-- SQL ����: ORA-25154: USING ���� �� �κ��� �ĺ��ڸ� ���� �� ����.

-- <�� �� ���>
-- �Է�
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


-- ���� ����Sub-Query �� �� SQL ���� �ȿ��� ������ ���Ǵ� �� �ٸ� SELECT���� �ǹ��Ѵ�. ���� ����� ����ϴ� ������ ���� ������� �Ѵٸ�,
-- �̸� ���� �߰� �ܰ� Ȥ�� ���� ������ �ϴ� SELECT���� ���� ������ �Ѵ�. ���� ������ �Ұ��ߴ� SQL�� �� ��ȣ �ȿ� 
-- ����ִ� SELECT���� �ٷ� ���� ������ ���Ѵ�. �ϳ��� SQL���� �������� ���� ������ ������ ������ ��� SELECT���� ���� ������ ���� �Ǹ�,
-- ���� ���� ������ ���� ���� ����� �� �ִ�.
-- ���� ������ �پ��� ���·� ���ȴ�. �� SELECT, FROM, WHERE �� ��ο��� ����� �� ���� �Ӹ� �ƴ϶�,
-- INSERT, UPDATE, MERGE, DELETE �������� ����� �� �ִ�. ���� ������ �� Ư���� ���¿� ���� ������ ���� ������ �� �ִ�.

-- ������ ���� ���� ����1 : ���������� ������ ���� �ʰ� �������� �ܵ����� �����ص� ������ �ȳ�.
-- ���������� ���� �� ��ȯ
-- 1) ����� ��� �޿�
SELECT AVG(salary) FROM employees; -- 6461.831775700934579439252336448598130841\
-- 2) �� ����� ��� �޿� �̻��� �޴� ��� ���� ��ȸ�ϴ� ����
SELECT COUNT(*) FROM employees
WHERE salary >= (SELECT AVG(salary) FROM employees);
-- �������� : ���� SELECT, �������� : ���� SELECT

-- ������ ���� ���� ����2
-- ���������� ���� ���� ��ȯ
-- �μ� ���̺��� parent_id�� NULL�� �μ���ȣ�� ���� ����� �� �Ǽ��� ��ȯ�ϴ� ����
SELECT count(*)
  FROM employees
 WHERE department_id IN ( SELECT department_id
                            FROM departments
                           WHERE parent_id IS NULL);
-- ���������� ����� �������� ���� IN Ű���� ���
-- ���������� ����� �ϳ��� ��츸 ��ȣ, �ε�ȣ ������ ����� ������.
SELECT count(*)
  FROM employees
 WHERE department_id = ( SELECT department_id
                            FROM departments
                           WHERE parent_id IS NULL);

-- ������ ���� ���� ����3
--  job_history ���̺� �ִ� employee_id, job_id �� ���� ���� ���� ��� ���̺��� ã�� ������ ���� ������ ���� ������ �������� ����.
SELECT employee_id, emp_name, job_id
  FROM employees
 WHERE (employee_id, job_id ) IN ( SELECT employee_id, job_id
                                    FROM job_history);


/* ������ �ִ� ���� ����
���� �������� �������� �ִ� ���� ����, �� ���� ���̺�� ���� ������ �ɸ� ���� ������ ���Ѵ�.
���� �������� ����ϴ� �÷����� ���� ���̺��� �÷����� ����

�Է�
*/
-- WHERE������ ������ �ִ� ���� ���� ���
SELECT a.department_id, a.department_name
  FROM departments a -- 27��
 WHERE EXISTS ( SELECT 1
                  FROM job_history b
                 WHERE a.department_id = b.department_id ); -- �ߺ��� department_id �÷��� �����Ͱ� ���ŵ�. 6��
--���ۼ���
-- ���� ���� departments ���̺��� 27�� �����Ͱ� �ϳ���
-- ���������� WHERE a.department_id = b.department_id�� ��ġ�Ǹ� 1�� �����ͷ� ���.
-- EXISTS�Լ��� TRUE�� �Ǿ�, ��ġ�Ǵ� department_id�� ���� ������ ��ȯ.
-- ���� ��ġ���� ������ 1�� �����ͷ� ��µ��� �ʰ� EXISTS�Լ��� FALSE�� �Ǿ�,
-- a.department_id ���������� ��ȯ���� ����.
-- ����� ���������� ��ȯ�� ������ ���� �÷��� a.department_id, a.department_name�� ��µ�.

-- ������ �ִ� ���������� �������� ��ȯ�غ���
SELECT DISTINCT a.department_id, a.department_name
  FROM departments a, job_history b
 WHERE a.department_id = b.department_id; -- �ߺ��� ������ ���� ���� �ȵ�. 10��


-- EXISTS() �Լ� ����
-- () ���� ����� �����ϸ� TRUE, �������� ������ FALSE ��ȯ.
SELECT 1 FROM dual WHERE 1 = 0; -- ���ǽ��� FALSE�� ��� 1�� ������������ ��� �� ��.
SELECT 1 FROM dual WHERE 1 != 0; -- ���ǽ��� TRUE�� ��� 1�� ������������ ���

-- EXISTS�Լ��� ������������ �����Ͱ� �������� �ʾƼ� FALSE : ��°�� ����.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 = 0);
-- EXISTS�Լ��� ������������ �����Ͱ� �������� �ʾƼ� TRUE : ��°�� ����.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 != 0);


-- SELECT������ ������ �ִ� �������� ���
SELECT a.employee_id,
       ( SELECT b.emp_name
           FROM employees b
          WHERE a.employee_id = b.employee_id) AS emp_name,
       a.department_id,
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id) AS dep_name
FROM job_history a;
-- ���ۼ���
/*
job_history���̺��� 10���� �����Ͱ� �ϳ��� ���� ������ ���ǽ� WHERE a.employee_id = b.employee_id �񱳵Ǿ�
��ġ�ϸ� ��ȯ�ǰ�, ��ġ���� ������ ������. ��ġ�Ǵ� �����͸� ���� ���� SELECT a.employee_id, a.department_id ��µ�.
*/


/*
�ζ��� ��
FROM ���� ����ϴ� ���� ������ �ζ��� ��InlineView ��� �Ѵ�. ���� FROM ������ ���̺��̳� �䰡 ���µ�,
���� ������ FROM ���� ����� �ϳ��� ���̺��̳� ��ó�� ����� �� �ִ�. �並 ��ü�ϸ� �ϳ��� �������� SELECT���̹Ƿ�
FROM ���� ����ϴ� ���� ������ �ϳ��� ��� �� �� �־ �ζ��� ���� �̸��� ���� ���̴�.

SELECT * FROM ���̺�� �Ǵ� ���;
SELECT * FROM (������ ���� ��������) -- �ζ��� ��
*/
-- ���� �Ʒ� �� ������ ����Ǯ�̴� �������� �� ��.
-- ����1
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
  FROM employees a,
       departments b,
       ( SELECT AVG(c.salary) AS avg_salary
           FROM departments b,
                employees c
          WHERE b.parent_id = 90  -- ��ȹ��
            AND b.department_id = c.department_id ) d
 WHERE a.department_id = b.department_id
   AND a.salary > d.avg_salary;
-- �޸� �� a, b, d �� ���� ���̺��� ����.

-- ����2
SELECT a.*
  FROM ( SELECT a.sales_month, ROUND(AVG(a.amount_sold)) AS month_avg
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy' -- ��Ż����
          GROUP BY a.sales_month
       )  a,
       ( SELECT ROUND(AVG(a.amount_sold)) AS year_avg
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy' -- ��Ż����
       ) b
 WHERE a.month_avg > b.year_avg ;














COMMIT;