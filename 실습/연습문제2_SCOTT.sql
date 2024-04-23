-- ����� �������� �ʰ�, ������ ���� Ǯ�����. 
-- ��ư� ��������, ��Ȱ� �Բ� Ǯ��, �ݺ��Ͽ� �ּ���.
-- ������(sys, system ) ���� �����Ͽ�, �н��� ������ scott ������ ��й�ȣ�� Ȱ��ȭ ���� �� scott���� ���� �� ���

-- 1. ALLEN �� �μ��� ���� ������� �����, �Ի����� ���(�޿� �������� ����)
SELECT ename, hiredate FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN')
ORDER BY sal DESC;

-- 2. ���� ���� �޿��� �޴� ������� �Ի����� ���� ����� �̸�, �Ի����� ���
SELECT ename, hiredate FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE sal = (SELECT MAX(sal) FROM emp));

-- 3. �̸��� 'T' �ڰ� ���� ������� �޿��� ���� ���ϼ���. (LIKE ���)
SELECT SUM(sal) FROM emp WHERE ename LIKE '%T%';

-- 4. ��� ����� ��ձ޿��� ���ϼ���. �Ҽ� ��°�ڸ� �ݿø�ǥ��
SELECT ROUND(AVG(sal),2) FROM emp;

-- 5. �� �μ��� ��� �޿��� ���ϼ���. �Ҽ� ��°�ڸ� �ݿø�ǥ�� (GROUP BY)
SELECT deptno, AVG(sal) FROM emp GROUP BY deptno ORDER BY deptno;

-- 6. �� �μ��� ��ձ޿�, ��ü�޿�, �ְ�޿�, �����޿��� ���Ͽ� ��ձ޿��� ���� ������ ���. ����� �Ҽ� ��°�ڸ� �ݿø�ǥ��
SELECT deptno, ROUND(AVG(sal), 2), SUM(sal), MAX(sal), MIN(sal) FROM emp GROUP BY deptno ORDER BY AVG(sal) DESC;

-- 7. 20�� �μ��� �ְ� �޿����� ���� ����� �����ȣ, �����, �޿��� ���
SELECT empno, ename, sal FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 20);

-- 8. SMITH �� ���� �μ��� ���� ������� ��ձ޿����� ū �޿��� �޴� ��� ����� �����, �޿��� ���
SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

-- 9. ȸ�系�� �ּұ޿��� �ִ�޿��� ���̸� ���ϼ���.
SELECT MAX(sal) - MIN(sal) FROM emp;

-- 10. JONES �� �޿����� 1000 �� �� �޿����� ���� �޴� ����� �̸�, �޿��� ���.
SELECT ename, sal FROM emp WHERE sal < (SELECT sal - 1000 FROM emp WHERE ename = 'JONES');

-- 11. JOB�� MANAGER�� ����� �� �ּұ޿��� �޴� ������� �޿��� ���� ����̸�, �޿��� ���
SELECT ename, sal FROM emp WHERE sal < (SELECT MIN(sal) FROM emp WHERE job = 'MANAGER');

-- 12. �̸��� S�� �����ϰ� ���������ڰ� H�� ����� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE 'S%H';

-- 13. WARD �� �Ҽӵ� �μ� ������� ��� �޿�����, �޿��� ���� ����� �̸�,�޿��� ���
SELECT ename, sal FROM emp 
WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'WARD'));

-- 14-1. EMP���̺��� ��� ������� ���
SELECT COUNT(ename) FROM emp;

-- 15. ������(JOB) ������� ���
SELECT job, COUNT(*) FROM emp GROUP BY job;

-- 16. �ּұ޿��� �޴� ����� ���� �μ��� ��� ������� ���
SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE sal = (SELECT MIN(sal) FROM emp));


COMMIT;