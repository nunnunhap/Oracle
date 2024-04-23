-- �⺻ ���� �Լ�
-- �����Լ��� ��� �����͸� Ư�� �׷����� ���� ���� �� �׷쿡 ���� ����, ���, �ִ�, �ּڰ� ���� ���ϴ� �Լ�

-- COUNT (expr) ��� ���̺��� ������ �� ����
SELECT COUNT(*) FROM employees;
-- �μ� ���̺��� ������ ���
SELECT COUNT(*) FROM employees;-- 107

-- * ��� �÷����� ����� �� �� �ִ�.
SELECT COUNT(employee_id) FROM employees;
SELECT COUNT(department_id) FROM employees; --106/ null���� ����

-- �ߺ� ������ ����
SELECT COUNT(DISTINCT department_id) FROM employees; -- 11
SELECT DISTINCT department_id FROM employees; -- �� 12���� ������(null����)

-- SUM(expr)
-- expr�� ��ü �հ踦 ��ȯ�ϴ� �Լ��� �Ű����� expr���� �������� �� �� �ִ�.

-- �� �޿��� ��ȸ
SELECT SUM(salary) FROM employees;
-- SUM �Լ� ���� expr �տ� DISTINCT�� �� �� �ִµ�, �̶� ���� �ߺ��� �޿��� 1���� ������ ��ü �հ踦 ��ȯ
SELECT SUM(salary), SUM(DISTINCT salary) FROM employees;

-- AVG(expr) AVG�� �Ű����� ���³� ���ӻ��� COUNT, SUM�� �����ϸ� ��հ��� ��ȯ
SELECT AVG(salary), AVG(DISTINCT salary) FROM employees;

-- MIN(expr), MAX(expr) �ּڰ��� �ִ��� ��ȯ
SELECT MIN(salary), MAX(salary) FROM employees;

-- VARIANCE(expr), STDDEV(expr)
/*VARIANCE�� �л���, STDDEV�� ǥ�������� ���� ��ȯ�Ѵ�. �л��̶� �־��� ������ ���� ���� ��հ����� ������ ������ ����
�̸� �����ؼ� ����� ���� ���ϸ�, ǥ�������� �л� ���� �������̴�. �л��� ������ ����̹Ƿ�, 
������ ��迡���� ����� �߽����� ������ ��� ���� �����ϴ����� ��Ÿ���� ��ġ�� ǥ�������� ��ǥ�� ���
*/
SELECT VARIANCE(salary), STDDEV(salary) FROM employees;

-- GROUP BY ���� HAVING ��
/* ���ݱ��� �˾ƺ� ���� �Լ��� ������ ��� ��� ��ü�� �������� �����͸� �����ߴµ�, 
��ü�� �ƴ� Ư�� �׷����� ���� �����͸� ������ ���� �ִ�. �̶� ���Ǵ� ������ �ٷ� GROUP BY ���̴�. 
�׷����� ���� �÷����̳� ǥ������ GROUP BY ���� ����ؼ� ����ϸ� GROUP BY ������ WHERE�� ORDER BY�� ���̿� ��ġ
*/

-- �� �μ��� �� �޿���, ��� �޿��� ��ȸ
SELECT department_id, SUM(salary) AS "�ѱ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;

-- �ѱ� ������� ��ȸ
SELECT
    period,
    region,
    gubun,
    loan_jan_amt
FROM
    kor_loan_status;

--  ���̺��� ����, ������ ������� �ܾ�(������ �ʾ�)�� ��� �ְ�, ��������(gubun)�� �����ô㺸���⡯�� ����Ÿ���⡯ �� ������ �����Ѵ�.
-- �׷� 2013�� ������ ������� �� �ܾ��� ���� ����.
SELECT
    period,
    region,
SUM(loan_jan_amt) AS "TOTAL LOAN"
FROM
    kor_loan_status
WHERE
    period
LIKE
    '2013%'
GROUP BY period, region
HAVING SUM(loan_jan_amt) > 100000
ORDER BY period;

-- ������̺� ����
-- 1. �� �μ��� �ִ�޿�, �ּұ޿�, ��ձ޿��� ��ȸ
SELECT department_id "�μ���ȣ",
MAX(salary) "�ִ�޿�",
MIN(salary) "�ּұ޿�",
ROUND(AVG(salary), 1) "��ձ޿�"
FROM employees
GROUP BY department_id -- ������ �μ��ڵ带 �׷�ȭ
ORDER BY department_id;

-- �� �μ��� �ִ�޿�, �ּұ޿�, ��ձ޿��� ��ȸ
-- ���� ���� �����͸� ��ձ޿� ������������ ��ȸ(��Ī ���)
SELECT department_id "�μ���ȣ",
MAX(salary) "�ִ�޿�",
MIN(salary) "�ּұ޿�",
ROUND(AVG(salary), 1) "��ձ޿�"
FROM employees
GROUP BY department_id -- ������ �μ��ڵ带 �׷�ȭ
ORDER BY "��ձ޿�" DESC;

-- �ó����� : employees ���̺��� ��å�� ���� ��, �ִ�޿�, �ּұ޿�, ��ձ޿��� �Ҽ��� ù°�ڸ����� ���϶�
-- �ִ�޿��� ��������
SELECT job_id "��å",
COUNT(*) "������",
MAX(salary) "�ִ�޿�",
MIN(salary) "�ּұ޿�",
ROUND(AVG(salary), 1) "��ձ޿�"
FROM employees
GROUP BY job_id
HAVING COUNT(*) > 10
ORDER BY �ִ�޿�;


--  ROLLUP ���� CUBE �� : GROUP BY������ ���Ǿ� �׷캰 �Ұ踦 �߰��� ���� �ִ� ������ �Ѵ�.

-- 2013�� �Ⱓ(period), ���������� �� �ܾ�(gubun)�� ���϶�.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY period, gubun
 ORDER BY period;

-- 2013�� 10�� �߰��հ� -- 2013�� 11�� �߰��հ� -- ��ü�հ�
-- GROUP BY ROLLUP(period, gubun) : �÷��� + 1 = 3���� ���·� ������ ��ȸ
-- ���� 3 : �Ұ�, ���� 2 : �߰����, ���� 1 : ��ü���
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
 FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY ROLLUP(period, gubun);

-- GROUP BY period, ROLLUP( gubun ); ROLLUP �÷��� 1�� + 1 = 2�������� ������ ���
-- ����2(period, gubun), ����1(period) ���·� ���.
-- ��ü �հ�� ��¿��� ����
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY period, ROLLUP( gubun );


-- CUBE(expr1, expr2, ��)
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY CUBE(period, gubun) ;
-- 2�� CUBE �÷� �� �� = 4���� ����
/*
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
                                       2182852.1
       ��Ÿ����                        1357199.3
       ���ô㺸����                     825652.8
201310                                 1087493.9
201310 ��Ÿ����                           676078
201310 ���ô㺸����                     411415.9
201311                                 1095358.2
201311 ��Ÿ����                         681121.3
201311 ���ô㺸����                     414236.9
*/

--GROUP BY ROLLUP(a, b); �÷��� 2+1 = 3����. (a, b), (a), (��ü�հ�)
--GROUP BY CUBE(a, b); �÷��� 2�� �÷��� �� = 4����. (a, b), (a), (b), (��ü�հ�)

--  GROUP BY expr1, CUBE(expr2, expr3)�� ������� ��,
-- (expr1, expr2, expr3), (expr1, expr2), (expr1, expr3), (expr1) �� 4����(2^2^) �������� ����


-- ���տ�����
-- ����(Set) �����ڴ� �̷��� ������ ������ ������� ������ �����ϴ� �����ڸ� ���ϸ�, �� �����δ� UNION, UNION ALL, INTERSECT, MINUS

-- UNION ������
CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('�ѱ�', 1, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 2, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 6,  '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 7,  '�޴���ȭ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 8,  'ȯ��źȭ����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 9,  '�����۽ű� ���÷��� �μ�ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 10,  'ö �Ǵ� ���ձݰ�');

INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 1, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 5, '�ݵ�ü������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 6, 'ȭ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 7, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 8, '�Ǽ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 10, '����');

COMMIT;

-- �ѱ� ���� ǰ�� ��ȸ
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
 ORDER BY seq;

-- �ѱ�& �Ϻ� ���� ǰ�� ��ȸ
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
UNION
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�';

SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
UNION ALL
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�';

-- INTERSECT : �������� �ƴ� �������� �ǹ��Ѵ�. �� ������ ���տ��� ����� �׸� ����
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
INTERSECT
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�';

-- MINUS : �������� �ǹ��Ѵ�. �� �� ������ ������ �������� �ٸ� ������ ���հ� ����� �׸��� ������ ����� ����
-- �ѱ��� �����ϴ� ǰ��
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
 MINUS
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�';

-- �Ϻ��� �����ϴ� ǰ��
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�'
 MINUS
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�';

-- ���� �������� ���ѻ���
-- �� ���� �����ڷ� ����Ǵ� �� SELECT���� SELECT ����Ʈ�� ������ ������Ÿ���� ��ġ�ؾ� �Ѵ�
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
 UNION
SELECT seq, goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�';

-- �� ���� �����ڷ� SELECT ���� ������ �� ORDER BY���� �� ������ ���忡���� ����� �� �ִ�
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�ѱ�'
 ORDER BY goods
 UNION
SELECT goods
  FROM exp_goods_asia
 WHERE country = '�Ϻ�';

-- �� BLOB, CLOB, BFILE Ÿ���� �÷��� ���ؼ��� ���� �����ڸ� ����� �� ����
-- �� UNION, INTERSECT, MINUS �����ڴ� LONG�� �÷����� ����� �� ����

-- GROUPING SETS ��
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY GROUPING SETS(period, gubun);
-- (GROUP BY period) UNION ALL (GROUP BY gubun)

SELECT period, gubun, region, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
       AND region IN ('����', '���')
     GROUP BY GROUPING SETS(period, (gubun, region));
-- (GROUP BY period) UNION ALL (GROUP BY (gubun, region))



COMMIT;