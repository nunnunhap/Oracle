-- 답안을 참고하지 않고, 문제를 먼저 풀어보세요. 
-- 어렵게 느껴지면, 답안과 함께 풀고, 반복하여 주세요.
-- 관리자(sys, system ) 으로 접속하여, 학습용 계정인 scott 계정을 비밀번호및 활성화 적용 후 scott계정 접속 후 사용

-- 1. ALLEN 과 부서가 같은 사원들의 사원명, 입사일을 출력(급여 내림차순 정렬)
SELECT ename, hiredate FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN')
ORDER BY sal DESC;

-- 2. 가장 높은 급여를 받는 사원보다 입사일이 늦은 사원의 이름, 입사일을 출력
SELECT ename, hiredate FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE sal = (SELECT MAX(sal) FROM emp));

-- 3. 이름에 'T' 자가 들어가는 사원들의 급여의 합을 구하세요. (LIKE 사용)
SELECT SUM(sal) FROM emp WHERE ename LIKE '%T%';

-- 4. 모든 사원의 평균급여를 구하세요. 소수 둘째자리 반올림표현
SELECT ROUND(AVG(sal),2) FROM emp;

-- 5. 각 부서별 평균 급여를 구하세요. 소수 둘째자리 반올림표현 (GROUP BY)
SELECT deptno, AVG(sal) FROM emp GROUP BY deptno ORDER BY deptno;

-- 6. 각 부서별 평균급여, 전체급여, 최고급여, 최저급여를 구하여 평균급여가 높은 순으로 출력. 평균은 소수 둘째자리 반올림표현
SELECT deptno, ROUND(AVG(sal), 2), SUM(sal), MAX(sal), MIN(sal) FROM emp GROUP BY deptno ORDER BY AVG(sal) DESC;

-- 7. 20번 부서의 최고 급여보다 많은 사원의 사원번호, 사원명, 급여를 출력
SELECT empno, ename, sal FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 20);

-- 8. SMITH 와 같은 부서에 속한 사원들의 평균급여보다 큰 급여를 받는 모든 사원의 사원명, 급여를 출력
SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

-- 9. 회사내의 최소급여와 최대급여의 차이를 구하세요.
SELECT MAX(sal) - MIN(sal) FROM emp;

-- 10. JONES 의 급여에서 1000 을 뺀 급여보다 적게 받는 사원의 이름, 급여를 출력.
SELECT ename, sal FROM emp WHERE sal < (SELECT sal - 1000 FROM emp WHERE ename = 'JONES');

-- 11. JOB이 MANAGER인 사원들 중 최소급여를 받는 사원보다 급여가 적은 사원이름, 급여를 출력
SELECT ename, sal FROM emp WHERE sal < (SELECT MIN(sal) FROM emp WHERE job = 'MANAGER');

-- 12. 이름이 S로 시작하고 마지막글자가 H인 사원의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE 'S%H';

-- 13. WARD 가 소속된 부서 사원들의 평균 급여보다, 급여가 높은 사원의 이름,급여를 출력
SELECT ename, sal FROM emp 
WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'WARD'));

-- 14-1. EMP테이블의 모든 사원수를 출력
SELECT COUNT(ename) FROM emp;

-- 15. 업무별(JOB) 사원수를 출력
SELECT job, COUNT(*) FROM emp GROUP BY job;

-- 16. 최소급여를 받는 사원과 같은 부서의 모든 사원명을 출력
SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE sal = (SELECT MIN(sal) FROM emp));


COMMIT;