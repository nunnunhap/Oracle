-- 답안을 참고하지 않고, 문제를 먼저 풀어보세요. 
-- 어렵게 느껴지면, 답안과 함께 풀고, 반복하여 주세요.

-- 관리자(sys, system ) 으로 접속하여, 학습용 계정인 scott 계정을 비밀번호및 활성화 적용 후 scott계정 접속 후 사용

-- 1. 업무(JOB)가 MANAGER 인 사원의 이름, 입사일 출력
SELECT ename, hiredate FROM emp WHERE job = 'MANAGER';
?
-- 2. 사원명이 WARD 인 사원의 급여, 커미션을 출력
SELECT sal, comm FROM emp WHERE ename = 'WARD';

-- 3. 30번 부서에 속하는 사원의 이름, 부서번호를 출력
SELECT ename, deptno FROM emp WHERE deptno = '30';

-- 4-1. 급여가 1250을 초과, 3000이하인 사원의 이름, 급여를 출력
SELECT ename, sal FROM emp WHERE sal BETWEEN 1250 AND 3000;

-- 4-2. 급여가 1250이상이고, 3000이하인 사원의 이름, 급여를 출력(범위가 포함됨)
SELECT ename, sal FROM emp WHERE sal BETWEEN 1250 AND 3000;
?
-- 5. 커미션이 0 인 사원이 이름, 커미션을 출력
SELECT ename, comm FROM emp WHERE comm = 0;?

-- 6-1. 커미션 계약을 하지 않은 사원의 이름츨 출력
SELECT ename FROM emp WHERE comm IS NULL;
?
-- 6-2. 커미션 계약을 한 사원의 이름을 출력
SELECT ename FROM emp WHERE comm IS NOT NULL;
?
-- 7. 입사일이 81/06/09 보다 늦은 사원이 이름, 입사일 출력(입사일을 기준으로 오름차순.)
SELECT ename, hiredate FROM emp WHERE hiredate > TO_DATE('19810609', 'YYYYMMDD') ORDER BY hiredate ASC;
SELECT ename, hiredate FROM emp WHERE hiredate > '19810609' ORDER BY hiredate;

-- 8. 모든 사원의 급여마다 1000을 더한 급여를 출력
SELECT ename, sal + 1000 FROM emp;

-- 9. FORD 의 입사일, 부서번호를 출력
SELECT ename, hiredate, deptno FROM emp WHERE ename = 'FORD';
?
-- 10. 사원명이 ALLEN인 사원의 급여를 출력하세요.
SELECT ename, sal FROM emp WHERE ename = 'ALLEN';
?
-- 11. ALLEN의 급여보다 높은 급여를 받는 사원의 사원명, 급여를 출력
SELECT ename, sal FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');
?
-- 12. 가장 높은/낮은 커미션을 구하세요.(최대값/최소값)
SELECT MIN(comm), MAX(comm) FROM emp;
?
-- 13. 가장 높은 커미션을 받는 사원의 이름을 구하세요.
SELECT ename, comm FROM emp WHERE comm = (SELECT MAX(comm) FROM emp);

-- 14. 가장 높은 커미션을 받는 사원의 입사일보다 늦은 사원의 이름 입사일을 출력
SELECT ename, hiredate FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE comm = (SELECT MAX(comm) FROM emp));

-- 15. JOB이 CLERK 인 사원들의 급여의 합을 구하세요.
SELECT AVG(sal) FROM emp WHERE job = 'CLERK';
?
-- 16. JOB 이 CLERK 인 사원들의 급여의 합보다 급여가 많은 사원이름을 출력.
SELECT ename, sal FROM emp WHERE sal > (SELECT SUM(sal) FROM emp WHERE job = 'CLERK');

-- 17. JOB이 CLERK 인 사원들의 급여와 같은 급여를 받는 사원의 이름, 급여를 출력(급여 내림차순으로)
SELECT ename, sal FROM emp WHERE sal = ANY(SELECT sal FROM emp WHERE job = 'CLERK') ORDER BY sal DESC;
SELECT ename, sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE job = 'CLERK') ORDER BY sal DESC;
?
-- 18. EMP테이블의 구조출력
DESC emp;


COMMIT;