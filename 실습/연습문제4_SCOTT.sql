-- ����� �������� �ʰ�, ������ ���� Ǯ�����.
-- ��ư� ��������, ��Ȱ� �Բ� Ǯ��, �ݺ��Ͽ� �ּ���.
-- ������(sys, system ) ���� �����Ͽ�, �н��� ������ scott ������ ��й�ȣ�� Ȱ��ȭ ���� �� scott���� ���� �� ���
-- ��빮���� ��κ� JOIN, SUB QUERY �������� ����.

-- 1. �ּұ޿��� �޴� ����� ���� �μ����� �ٹ��ϴ� ��� �����, �μ����� ���
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno = (SELECT deptno FROM emp WHERE sal = (SELECT MIN(sal) FROM emp));

-- 2. CLARK���� �Ի����� ���� ����� ���� �μ����� �ٹ��ϴ� ������� �μ���, �̸�, �޿��� ���
SELECT d.dname, e.ename, e.sal FROM dept d INNER JOIN emp e
ON e.deptno = d.deptno AND e.hiredate > (SELECT hiredate FROM emp WHERE ename = 'CLARK');

-- 3. �̸��� 'K'�ڰ� ���� ����� �� �޿��� ���� ���� ����� �μ���, �����, �޿��� ���
SELECT d.dname, e.ename, e.sal FROM emp e INNER JOIN dept d
ON e.sal = (SELECT MIN(sal) FROM emp WHERE ename LIKE '%K%');

-- 4. Ŀ�̼� ����� ���� ����� �Ի����� ���� ���� ����� �μ���, �����, �Ի����� ���
SELECT d.dname, e.ename, e.hiredate FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.hiredate = (SELECT MIN(hiredate) FROM emp WHERE e.comm IS NULL);

-- 5. ��ġ�� ��ī���� �μ��� ���� ������� �̸��� �μ����� ���
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno AND d.loc
= (SELECT loc FROM dept WHERE loc = 'CHICAGO');

-- 6. KING�� �޿����� CLARK�� �޿��� �� ������� ���� �޿��� �޴� ����� �μ���, �̸�, �޿��� ���
SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal < (SELECT sal FROM emp WHERE ename = 'KING') - (SELECT sal FROM emp WHERE ename = 'CLARK');

-- 7. DALLAS�� ��ġ�� �μ��� ���� ����� �ѻ����, ��ձ޿�,��ü�޿�,�ְ�޿�,�����޿��� ���ϼ���.
SELECT COUNT(ename), AVG(sal), SUM(e.sal), MAX(sal), MIN(sal)
FROM emp e
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

-- 8. Ŀ�̼� ��������� ������ �̸��� 'N'�ڰ� ���� ����� �� �޿��� ���� ���� ����� �����, �޿�,�μ����� ���
SELECT e.ename, e.sal, d.dname FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal = (SELECT MIN(sal) FROM emp WHERE comm IS NOT NULL AND ename LIKE '%N%');

-- 9. ALLEN ���� �Ի����� ���� ����� �μ���,������� ���
SELECT d.dname, e.ename FROM dept d INNER JOIN emp e
ON d.deptno = e.deptno
AND e.hiredate < (SELECT hiredate FROM emp WHERE ename = 'ALLEN');

-- 10. EMP ���̺��� �̸��� 5������ ����� �޿��� ���� ���� ����� �̸�, �޿� , �μ����� ���
SELECT e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename LIKE '_____');

SELECT e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE LENGTH(ename) = 5);

-- 11. CLARK �� ���� �μ��� ��� �������� �޿��� ���� ����� �Ի����� ���� ���� ����� �μ���, �����, �޿��� ���
SELECT d.dname, e.ename, e.sal FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate = 
(SELECT MIN(hiredate) FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE ename = 'CLARK'));

-- 12. ALLEN�� �μ����� ���
SELECT dname FROM dept
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN');

-- 13. �̸��� J�� ���� ����� ��, �޿��� ���� ���� ����� �����ȣ, �̸�, �μ���, �޿�, �μ���ġ�� ���
SELECT e.empno, e.ename, d.dname, d.loc FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename LIKE '%J%');

-- 14. �ι�°�� ���� �޿��� �޴� ����� �̸��� �μ���,�޿��� ���
SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp);

-- 15. �Ի����� 2��°�� ���� ����� �μ���� �̸�, �Ի����� ���
SELECT d.dname, e.ename, e.hiredate FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate =
(SELECT MIN(hiredate) FROM emp WHERE hiredate > (SELECT MIN(hiredate) FROM emp));

-- 16. DALLAS�� ��ġ�� �μ��� ��� �� �ִ� �޿��� �޴� ����� �޿����� �ּ� �޿��� �޴� ����� �޿��� �� ����� ���
SELECT ((SELECT MAX(e.sal) FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS')
-
(SELECT MIN(e.sal) FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS'))
AS "�ִ�-�ּ� �޿�"
FROM DUAL;

SELECT MAX(e.sal) - MIN(e.sal) FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND d.loc = 'DALLAS';

COMMIT;