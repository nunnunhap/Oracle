-- ������ ����HierarchicalQuery
-- 2���� ������ ���̺� ����� �����͸� ������ ������ ����� ��ȯ�ϴ� ������ ���Ѵ�. ���� �а�, ���κ�ó ��

-- ������ ������ ��¸������� �ۼ��� �ڵ�(������ ���)
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

-- ������ ������ �⺻ ����
/*
SELECT expr1, expr2, ...
  FROM ���̺�
 WHERE ����
 START WITH[�ֻ��� ����]
CONNECT BY [NOCYCLE][PRIOR ������ ���� ����];
*/

-- departments(�μ�) ���̺��� ������ ���������� ����϶�.
SELECT
    department_id,
    department_name
FROM
    departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id;
--PRIOR�� ��ü �ڵ带 ������ �ִµ� �ܴ�.

-- ����/����θ� �������� �����μ� ���
SELECT
    department_id,
    department_name
FROM
    departments
START WITH department_id = 30
CONNECT BY PRIOR department_id = parent_id;
-- CONNECT BY �� ����Ǿ� �ִ� �κ�.

SELECT
    department_id,
    department_name
FROM
    departments
START WITH department_id = 30
CONNECT BY department_id = PRIOR parent_id;

-- �� ������ ���� ����
-- ������ ������ ������ ������ �°� ������� ��µǴµ� ORDER BY ���� �� ������ ������ �� �ִ�.
-- ������ LEVEL �ǻ��÷����� Ȯ���� �� ����.
SELECT LEVEL, department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name
  FROM departments
 START WITH parent_id IS NULL
 CONNECT BY PRIOR department_id  = parent_id
ORDER BY department_name;
-- ���� ��� �� �μ��� ��� ������ ����Ǿ� ������ ���� ��±����� �� �� ����.
-- ORDER SIBLINGS BY
SELECT LEVEL, department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name
  FROM departments
 START WITH parent_id IS NULL
 CONNECT BY PRIOR department_id  = parent_id
ORDER SIBLINGS BY department_name;

-- �� CONNECT_BY_ROOT
-- CONNECT_BY_ROOT�� ������ �������� �ֻ��� �ο츦 ��ȯ�ϴ� �����ڴ�. �������̹Ƿ� CONNECT_BY_ROOT �������� ǥ������ �´�.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
       CONNECT_BY_ROOT department_name AS root_name
  FROM departments
 START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

-- �� CONNECT_BY_ISLEAF
-- CONNECT_BY_ISLEAF�� CONNECT BY ���ǿ� ���ǵ� ���迡 ���� �ش� �ο찡 ������ �ڽ� �ο��̸� 1��, �׷��� ������ 0�� ��ȯ�ϴ� �ǻ� �÷��̴�.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL, CONNECT_BY_ISLEAF
  FROM departments
 START WITH parent_id IS NULL
 CONNECT BY PRIOR department_id  = parent_id;

-- �� SYS_CONNECT_BY_PATH (colm, char)
-- SYS_CONNECT_BY_PATH�� ������ ���������� ����� �� �ִ� �Լ���, ��Ʈ ��忡�� ������ �ڽ��� ����� ����� ��� ������ ��ȯ
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
       SYS_CONNECT_BY_PATH( department_name, '|')
  FROM departments
  START WITH parent_id IS NULL
  CONNECT BY PRIOR department_id  = parent_id;
-- �� �ο캰�� � ���� ��θ� Ÿ�� �ִ��� �� �� �ִ�.
-- �� ��° �Ű������� �����ڷ� �ش� �÷� ���� ���Ե� ���ڴ� ����� �� ���ٴ� ���� �����ؾ� �Ѵ�.
-- �� �������� ����/����δ� ��/�����ڰ� ���� �ִµ�, �����ڷ� ��/���� ����ϸ� ������ ���� ������ �߻��Ѵ�.

-- �� CONNECT_BY_ISCYCLE
-- ��ġë������ �𸣰����� ����Ŭ�� ������ ������ ����(�ݺ�) �˰����� ����Ѵ�.
-- ������ ������ ������ ���̺� �ִ� �����Ϳ� ���� �������� ����ǹǷ�, ���������δ� ������ ���� �ڽ� ��带 ã�ư���.
-- ���� �˰��򿡼� ������ ���� ������ �߸� �ָ� ���ѷ����� Ÿ�� �ȴٴ� ���ε�,
-- ������ ���������� �θ�-�ڽ� ���� ���踦 �����ϴ� ���� �߸� �ԷµǸ� ���ѷ����� Ÿ�� ������ �߻��Ѵ�. �Ʒ� ����
UPDATE departments
   SET parent_id = 170
 WHERE department_id = 30;

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
       parent_id
  FROM departments
  START WITH department_id = 30
CONNECT BY PRIOR department_id  = parent_id;

-- �μ��� �����μ� ���� �߸� �ԷµǾ� ���� �߻� �� �ذ��ϱ� ���� ����
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name AS depname, LEVEL,
       CONNECT_BY_ISCYCLE IsLoop,
       parent_id
  FROM departments
  START WITH department_id = 30
CONNECT BY NOCYCLE PRIOR department_id  = parent_id;

ROLLBACK; -- UPDATE ���� ���


/* �м� �Լ��� window �Լ�
�м� �Լ�AnalyticFunction �� ���̺� �ִ� �ο쿡 ���� Ư�� �׷캰�� ���� ���� ������ �� ���ȴ�.
���� ���� ���� �� ������ �׷� ������ ����ϴµ�, �̶� GROUP BY ���� ���� ���� ���� ����� �׷캰�� �ο� ���� �پ���.
�̿� ����, ���� �Լ��� ����ϸ� �ο��� �ս� ���̵� �׷캰 ���� ���� ������ �� �� �ִ�.
�м� �Լ����� ����ϴ� �ο캰 �׷��� ������(window)��� �θ��µ�, �̴� ���� �� ����� ���� �ο��� ������ �����ϴ� ������ �Ѵ�.

    �м� �Լ�(�Ű�����) OVER
       ������(PARTITION BY expr1, expr2,...
                  ORDER BY expr3, expr4...
                window ��)
*/

-- ROW_NUMBER( ) ROWNUM �ǻ� �÷��� ����� ����� �ϴµ�, ��Ƽ������ ���ҵ� �׷캰�� �� �ο쿡 ���� ������ ��ȯ�ϴ� �Լ�
-- ROWNUM
SELECT ROWNUM,
    emp_name,
    email
FROM
    employees
WHERE
    ROWNUM <= 5;

-- GROUP BY ���� ���
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id ORDER BY department_id;

-- ROWNUMBER()
-- PARTITION BY : department_id�� ���� �����ͺ��� �з�
SELECT department_id, emp_name,
       ROW_NUMBER() OVER (PARTITION BY department_id
                          ORDER BY emp_name ) dep_rows
  FROM employees;

/*
�� RANK( ), DENSE_RANK( )
RANK �Լ��� ��Ƽ�Ǻ� ������ ��ȯ�Ѵ�. �μ����� �޿� ������ �Ű� ����.

�Է�

    SELECT department_id, emp_name,
           salary,
           RANK() OVER (PARTITION BY department_id
                        ORDER BY salary ) dep_rank
      FROM employees;
*/

-- �������� �� �� ���� �ǳʶ�.
    SELECT department_id, emp_name,
           salary,
           RANK() OVER (PARTITION BY department_id
                        ORDER BY salary DESC) dep_rank
      FROM employees;

-- �������� �� �� ���� �ǳʶ��� ����.
    SELECT department_id, emp_name,
           salary,
           DENSE_RANK() OVER (PARTITION BY department_id
                              ORDER BY salary DESC ) dep_rank
      FROM employees;

-- ���� : Ư�� ���ǿ� �´� ���� Ȥ�� ���� n���� �����͸� �����ϴ� TOP n ������ ���� �ۼ�
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


-- ���� ���̺� INSERT
/*
���� ���̺� INSERT ������ �� �ϳ��� INSERT �������� ���� ���� INSERT ���� �����ϴ� ȿ���� �� �� ���� �Ӹ� �ƴ϶�
Ư�� ���ǿ� �´� �����͸� Ư�� ���̺� �Էµǰ� �� �� �ִ� �����̴�. ���� ���� ���̺� INSERT ���� ������ ���� ����.

    INSERT ALL| FIRST
    WHEN ����1 THEN
    ��INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
    WHEN ����2 THEN
    ��INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
        ...
     ELSE
    �� INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
    SELECT ��;
    
    ? ALL: ����Ʈ ������ ���� WHEN �������� ������� �� �� ������ ������ INSERT�� ��� �����϶�� �ǹ̴�.

? FIRST: ���� WHEN �� ���ǽĿ� ���� INSERT���� ������ ��, ���� ������ ��ȯ�� �ο쿡 ���� ������ ���� WHEN ���� ������ �ش� INSERT���� �����ϰ� �������� ���ؼ��� ���� �򰡸� ���� �ʰ� ������.

? WHEN ���� THEN �� ELSE: Ư�� ���ǿ� ���� INSERT�� ������ �� �ش� ������ ���.

? SELECT ��: ���� ���̺� INSERT ���������� �ݵ�� ���� ������ ���ݵǾ�� �ϸ�, ���� ������ ����� ���ǿ� ���� ���� �����͸� INSERT �Ѵ�.
*/

    CREATE TABLE ex7_3 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

    CREATE TABLE ex7_4 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

    INSERT INTO ex7_3 VALUES (101, 'ȫ�浿');
    INSERT INTO ex7_3 VALUES (102, '������');
-- ���� ������ �Ʒ��� �Ѳ����� ������.
    INSERT ALL
      INTO ex7_3 VALUES (103, '������')
      INTO ex7_3 VALUES (104, '�����ҹ�')
    SELECT * -- INSERT ALL ���� ������ �̷� ���� ������ ���߸� ��.
      FROM DUAL;

ROLLBACK;

    INSERT ALL
      INTO ex7_3 VALUES (105, '������')
      INTO ex7_4 VALUES (105, '������')
    SELECT *
      FROM DUAL;


SELECT * FROM ex7_3;
SELECT * FROM ex7_4;

TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;

-- ���ǿ� ���� ���� INSERT (�ű� �۾����� �� ��� �� �ϴµ� �������� �� ���� ����)
INSERT ALL
      WHEN department_id = 30 THEN
      INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN department_id = 90 THEN
      INTO ex7_4 VALUES (employee_id, emp_name)
      -- SELETE������ ����� ����� ���Ե����ͷ� ���
      SELECT department_id,
           employee_id, emp_name
      FROM  employees;
-- depatment_id �����Ͱ� 30�̸� ex7_3 ���̺� ������ ����
-- depatment_id �����Ͱ� 90�̸� ex7_4 ���̺� ������ ����
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
/* ALL�� FIRST�� �������� �ԷµǴ� ��� �ο츦 �������� WHEN ���ǿ� ������ ó���ϴ� ��Ŀ� �ִ�.
���� FIRST�� ����ߴٸ� ù ��°�� ���� ���� TRUE�� �� �� �ش� �ο찡 �Էµǰ� ������.
���� �� ���� WHEN ���� ����� TRUE�� �Ǵ��� �̹� ���� �ܰ迡�� �Է��� �����Ƿ� �� �ο�� �߰��� �Էµ��� �ʴ´�. */
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