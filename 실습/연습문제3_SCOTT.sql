-- ����� �������� �ʰ�, ������ ���� Ǯ�����.
-- ��ư� ��������, ��Ȱ� �Բ� Ǯ��, �ݺ��Ͽ� �ּ���.
-- ������(sys, system ) ���� �����Ͽ�, �н��� ������ scott ������ ��й�ȣ�� Ȱ��ȭ ���� �� scott���� ���� �� ���
-- ��빮���� ��κ� JOIN, SUB QUERY �������� ����.

-- 1. ����(JOB)�� MANAGER�� ����� �̸�, �μ���, �Ի����� ���
SELECT e.ename, d.dname, e.hiredate FROM emp e, dept d WHERE e.deptno = d.deptno AND e.job = 'MANAGER';
SELECT e.ename, d.dname, e.hiredate FROM emp e INNER JOIN dept d ON e.deptno = d.deptno WHERE e.job = 'MANAGER';

-- 2. ������� WARD�� ����� �޿�, �μ���ȣ, �μ���ġ, Ŀ�̼��� ���
SELECT e.sal, e.deptno, d.loc, e.comm FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.ename = 'WARD';

-- 3. 30�� �μ��� ���ϴ� ����� �̸�, �μ���ȣ, �μ���ġ�� ���
SELECT e.ename, e.deptno, d.loc FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.deptno = 30;

-- 4-1. �޿��� 1250�� �ʰ�, 3000������ ����� �̸�, �޿�, �μ����� ���
SELECT e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.sal > 1250 AND e.sal <= 3000;

-- 4-2. �޿��� 1250�̻� 3000 ������ ������̸�, �޿�(BETWEEN ���)
SELECT e.ename, e.sal FROM emp e INNER JOIN dept d ON e.sal BETWEEN 1250 AND 3000;

-- 5. Ŀ�̼��� 0 �� ����� �̸�, �μ���ġ, Ŀ�̼��� ���
SELECT e.ename, d.loc, e.comm FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.comm = 0;

-- 6.Ŀ�̼� ����� �������� ����� �̸�, �μ����� ���
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.comm IS NULL;

-- 7. �Ի����� 81/06/09���� ���� ����� �̸�, �μ���ġ, �Ի��� ���(�Ի��� ��������)
SELECT e.ename, d.loc, e.hiredate FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.hiredate > '1981-06-09' ORDER BY hiredate ASC;

-- 8. ��� ����� �޿����� 1000�� ���� �޿���, �����, �޿�, �μ����� ���
SELECT e.sal + 1000, e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;

-- 9. FORD�� �Ի���, �μ����� ���
SELECT e.ename, e.hiredate, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.ename = 'FORD';

-- 10. ������� ALLEN�� ����� �޿�, �μ���ȣ, �μ���ġ�� ���
SELECT e.ename, e.sal, e.deptno, d.loc FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.ename = 'ALLEN';

-- 11. ALLEN�� �޿����� ���� �޿��� �޴� ����� �����, �μ���, �μ���ġ, �޿��� ���
SELECT e.ename, d.dname, d.loc FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
WHERE e.sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');

-- 12. ���� ����/���� Ŀ�̼��� ���ϼ���.
SELECT MAX(comm), MIN(comm) FROM emp;

-- 13. ���� ���� Ŀ�̼��� �޴� ����� �̸�, �μ����� ���ϼ���.
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.comm = (SELECT MAX(comm) FROM emp);

-- 14. JOB�� CLERK �� ������� �޿��� ���� ���ϼ���
SELECT SUM(sal) FROM emp WHERE job = 'CLERK';

-- 15. JOB �� CLERK �� ������� �޿��� �պ��� �޿��� ���� ����̸�, �μ����� ���
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.sal > (SELECT SUM(sal) FROM emp WHERE job = 'CLERK');

-- 16. JOB�� CLERK�� ������� �޿��� ���� �޿��� �޴� ����� �̸�,�μ���,�޿��� ���(�޿��� ���������� ���)
SELECT e.ename, d.dname, e.sal FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.sal IN (SELECT sal FROM emp WHERE job = 'CLERK')
ORDER BY e.sal DESC;

COMMIT;