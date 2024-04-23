-- 답안을 참고하지 않고, 문제를 먼저 풀어보세요.
-- 어렵게 느껴지면, 답안과 함께 풀고, 반복하여 주세요.
-- 관리자(sys, system ) 으로 접속하여, 학습용 계정인 scott 계정을 비밀번호및 활성화 적용 후 scott계정 접속 후 사용
-- 사용문법이 대부분 JOIN, SUB QUERY 문법위주 연습.

-- 1. 업무(JOB)가 MANAGER인 사원의 이름, 부서명, 입사일을 출력
SELECT e.ename, d.dname, e.hiredate FROM emp e, dept d WHERE e.deptno = d.deptno AND e.job = 'MANAGER';
SELECT e.ename, d.dname, e.hiredate FROM emp e INNER JOIN dept d ON e.deptno = d.deptno WHERE e.job = 'MANAGER';

-- 2. 사원명이 WARD인 사원의 급여, 부서번호, 부서위치, 커미션을 출력
SELECT e.sal, e.deptno, d.loc, e.comm FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.ename = 'WARD';

-- 3. 30번 부서에 속하는 사원의 이름, 부서번호, 부서위치를 출력
SELECT e.ename, e.deptno, d.loc FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.deptno = 30;

-- 4-1. 급여가 1250을 초과, 3000이하인 사원의 이름, 급여, 부서명을 출력
SELECT e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.sal > 1250 AND e.sal <= 3000;

-- 4-2. 급여가 1250이상 3000 이하인 사원의이름, 급여(BETWEEN 사용)
SELECT e.ename, e.sal FROM emp e INNER JOIN dept d ON e.sal BETWEEN 1250 AND 3000;

-- 5. 커미션이 0 인 사원의 이름, 부서위치, 커미션을 출력
SELECT e.ename, d.loc, e.comm FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.comm = 0;

-- 6.커미션 계약을 하지않은 사원의 이름, 부서명을 출력
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.comm IS NULL;

-- 7. 입사일이 81/06/09보다 늦은 사원이 이름, 부서위치, 입사일 출력(입사일 오름차순)
SELECT e.ename, d.loc, e.hiredate FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.hiredate > '1981-06-09' ORDER BY hiredate ASC;

-- 8. 모든 사원의 급여마다 1000을 더한 급여액, 사원명, 급여, 부서명을 출력
SELECT e.sal + 1000, e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;

-- 9. FORD의 입사일, 부서명을 출력
SELECT e.ename, e.hiredate, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.ename = 'FORD';

-- 10. 사원명이 ALLEN인 사원의 급여, 부서번호, 부서위치를 출력
SELECT e.ename, e.sal, e.deptno, d.loc FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND e.ename = 'ALLEN';

-- 11. ALLEN의 급여보다 높은 급여를 받는 사원의 사원명, 부서명, 부서위치, 급여를 출력
SELECT e.ename, d.dname, d.loc FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
WHERE e.sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');

-- 12. 가장 높은/낮은 커미션을 구하세요.
SELECT MAX(comm), MIN(comm) FROM emp;

-- 13. 가장 높은 커미션을 받는 사원의 이름, 부서명을 구하세요.
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.comm = (SELECT MAX(comm) FROM emp);

-- 14. JOB이 CLERK 인 사원들의 급여의 합을 구하세요
SELECT SUM(sal) FROM emp WHERE job = 'CLERK';

-- 15. JOB 이 CLERK 인 사원들의 급여의 합보다 급여가 많은 사원이름, 부서명을 출력
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.sal > (SELECT SUM(sal) FROM emp WHERE job = 'CLERK');

-- 16. JOB이 CLERK인 사원들의 급여와 같은 급여를 받는 사원의 이름,부서명,급여를 출력(급여가 높은순으로 출력)
SELECT e.ename, d.dname, e.sal FROM emp e INNER JOIN dept d ON e.deptno = d.deptno
AND e.sal IN (SELECT sal FROM emp WHERE job = 'CLERK')
ORDER BY e.sal DESC;

COMMIT;