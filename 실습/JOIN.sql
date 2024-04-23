-- ���� 1) ������� �̸�, �μ���ȣ, �μ����� ����϶�
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- ���� 2) 30�� �μ��� ������� �̸�, �����ڵ�, �μ����� ����϶�.(2�� ���̺� ����)
-- 1. employees���̺� : �̸�, �����ڵ� 2. departments���̺� : �μ���
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_id = 30;

-- ���� 3) 30�� �μ��� ������� �̸�, �����̸�, �μ����� ����϶�(3�� ���̺� ����)
-- 1. employees���̺� : �̸� 2. departments���̺� : �μ��� 3. jobs���̺� : �����̸�
SELECT e.first_name, j.job_title, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id
AND d.department_id = 30;

-- ���� 4) Ŀ�̼� �޴� ��� �̸�, ����, �μ���ȣ, �μ��� ���
-- 1. employees : first_name, job_id  departments : department_name
SELECT *
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;

-- ���� 5) ������ȣ 2500���� �ٹ��ϴ� ����� �̸�, �����̸�, �μ���ȣ, �μ����� ����϶�.
--1. employees : first_name, 2. jobs : job_title 3. departments : department_id, department_name
SELECT e.first_name, j.job_title, d.department_id, d.department_name
FROM employees e, jobs j, departments d
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id
AND d.location_id = 2500;

SELECT e.first_name, j.job_title, d.department_id, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN jobs j
ON e.job_id = j.job_id
AND d.location_id = 2500;

-- ���� 6) ��� �̸��� �μ���� ������ ����ϴµ� ������ 3000 �̻��� ����� ����϶�.
SELECT e.first_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary >= 3000;

SELECT e.first_name, e.salary, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
AND e.salary >= 3000;

-- ���� 7) �޿��� 3000���� 5000 ������ ����� �̸��� �μ����� ����϶�(between 3000 and 5000 �̿�)
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND salary BETWEEN 3000 AND 5000;

SELECT e.first_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
AND salary BETWEEN 3000 AND 5000;

-- ���� 8) �޿��� 3000 ������ ����� �̸��� �޿�, �ٹ���(CITY)�� ����϶�
SELECT e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.salary <= 3000;




