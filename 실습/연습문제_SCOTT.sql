-- ����� �������� �ʰ�, ������ ���� Ǯ�����. 
-- ��ư� ��������, ��Ȱ� �Բ� Ǯ��, �ݺ��Ͽ� �ּ���.

-- ������(sys, system ) ���� �����Ͽ�, �н��� ������ scott ������ ��й�ȣ�� Ȱ��ȭ ���� �� scott���� ���� �� ���

-- 1. ����(JOB)�� MANAGER �� ����� �̸�, �Ի��� ���
SELECT ename, hiredate FROM emp WHERE job = 'MANAGER';
?
-- 2. ������� WARD �� ����� �޿�, Ŀ�̼��� ���
SELECT sal, comm FROM emp WHERE ename = 'WARD';

-- 3. 30�� �μ��� ���ϴ� ����� �̸�, �μ���ȣ�� ���
SELECT ename, deptno FROM emp WHERE deptno = '30';

-- 4-1. �޿��� 1250�� �ʰ�, 3000������ ����� �̸�, �޿��� ���
SELECT ename, sal FROM emp WHERE sal BETWEEN 1250 AND 3000;

-- 4-2. �޿��� 1250�̻��̰�, 3000������ ����� �̸�, �޿��� ���(������ ���Ե�)
SELECT ename, sal FROM emp WHERE sal BETWEEN 1250 AND 3000;
?
-- 5. Ŀ�̼��� 0 �� ����� �̸�, Ŀ�̼��� ���
SELECT ename, comm FROM emp WHERE comm = 0;?

-- 6-1. Ŀ�̼� ����� ���� ���� ����� �̸��� ���
SELECT ename FROM emp WHERE comm IS NULL;
?
-- 6-2. Ŀ�̼� ����� �� ����� �̸��� ���
SELECT ename FROM emp WHERE comm IS NOT NULL;
?
-- 7. �Ի����� 81/06/09 ���� ���� ����� �̸�, �Ի��� ���(�Ի����� �������� ��������.)
SELECT ename, hiredate FROM emp WHERE hiredate > TO_DATE('19810609', 'YYYYMMDD') ORDER BY hiredate ASC;
SELECT ename, hiredate FROM emp WHERE hiredate > '19810609' ORDER BY hiredate;

-- 8. ��� ����� �޿����� 1000�� ���� �޿��� ���
SELECT ename, sal + 1000 FROM emp;

-- 9. FORD �� �Ի���, �μ���ȣ�� ���
SELECT ename, hiredate, deptno FROM emp WHERE ename = 'FORD';
?
-- 10. ������� ALLEN�� ����� �޿��� ����ϼ���.
SELECT ename, sal FROM emp WHERE ename = 'ALLEN';
?
-- 11. ALLEN�� �޿����� ���� �޿��� �޴� ����� �����, �޿��� ���
SELECT ename, sal FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');
?
-- 12. ���� ����/���� Ŀ�̼��� ���ϼ���.(�ִ밪/�ּҰ�)
SELECT MIN(comm), MAX(comm) FROM emp;
?
-- 13. ���� ���� Ŀ�̼��� �޴� ����� �̸��� ���ϼ���.
SELECT ename, comm FROM emp WHERE comm = (SELECT MAX(comm) FROM emp);

-- 14. ���� ���� Ŀ�̼��� �޴� ����� �Ի��Ϻ��� ���� ����� �̸� �Ի����� ���
SELECT ename, hiredate FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE comm = (SELECT MAX(comm) FROM emp));

-- 15. JOB�� CLERK �� ������� �޿��� ���� ���ϼ���.
SELECT AVG(sal) FROM emp WHERE job = 'CLERK';
?
-- 16. JOB �� CLERK �� ������� �޿��� �պ��� �޿��� ���� ����̸��� ���.
SELECT ename, sal FROM emp WHERE sal > (SELECT SUM(sal) FROM emp WHERE job = 'CLERK');

-- 17. JOB�� CLERK �� ������� �޿��� ���� �޿��� �޴� ����� �̸�, �޿��� ���(�޿� ������������)
SELECT ename, sal FROM emp WHERE sal = ANY(SELECT sal FROM emp WHERE job = 'CLERK') ORDER BY sal DESC;
SELECT ename, sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE job = 'CLERK') ORDER BY sal DESC;
?
-- 18. EMP���̺��� �������
DESC emp;


COMMIT;