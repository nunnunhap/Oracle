-- PL/SQL
-- SQL : DCL, DDL, DML, TCL
-- DML : SELECT, INSERT, UPGRATE, DROP, MERGE ��ɾ� �н�
-- SELELCT : ���̺��� �����͸� ��ȸ�ϴ� ��ɾ�
/*
SELECT �÷���, �÷���, .... FROM ���̺��
*/

-- SQL��ɾ�� ��ҹ��� ���о���.
SELECT * FROM employees; -- * : ���̺��� ��� �÷��� �ǹ�.

-- ��Ű�� : ���̺�� ���� �����ͺ��̽� ��ü���� ������ ������ ��� ����
SELECT * FROM HR.employees; -- ���� �Ǵ� ������°� HR�� �Ǿ� ������, ��Ű�� �̸��� ��������

-- ������̺��� �����ȣ, �̸�, ���ڿ���, �Ի���, �޿��� ��ȸ�϶�. ||�� ���ϱ⸦ �ǹ�
SELECT employee_id, first_name || last_name, email, hire_date, salary FROM employees;

-- ���̺��� �÷��� �����Ͽ� ���콺�� �巡��
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- �÷���Ī ��� AS
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME AS NAME,
EMAIL, HIRE_DATE, SALARY FROM employees;

-- AS ����
SELECT employee_id ID, FIRST_NAME || ' ' || LAST_NAME AS NAME,
EMAIL EMAIL,HIRE_DATE HD, SALARY SAL FROM employees;

-- �μ� ���̺��� �μ����� ��ȸ�϶�.
SELECT department_name FROM departments;

-- �μ� ���̺��� �μ��ڵ�, �μ����� ��ȸ�϶�. "����"�� �ۼ��϶� ��� ��.
SELECT department_id "�μ� ��ȣ", department_name �μ��� FROM departments;











