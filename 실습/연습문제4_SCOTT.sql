-- 답안을 참고하지 않고, 문제를 먼저 풀어보세요.
-- 어렵게 느껴지면, 답안과 함께 풀고, 반복하여 주세요.
-- 관리자(sys, system ) 으로 접속하여, 학습용 계정인 scott 계정을 비밀번호및 활성화 적용 후 scott계정 접속 후 사용
-- 사용문법이 대부분 JOIN, SUB QUERY 문법위주 연습.

-- 1. 최소급여를 받는 사원과 같은 부서에서 근무하는 모든 사원명, 부서명을 출력
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno = (SELECT deptno FROM emp WHERE sal = (SELECT MIN(sal) FROM emp));

-- 2. CLARK보다 입사일이 늦은 사원과 같은 부서에서 근무하는 사원들의 부서명, 이름, 급여를 출력
SELECT d.dname, e.ename, e.sal FROM dept d INNER JOIN emp e
ON e.deptno = d.deptno AND e.hiredate > (SELECT hiredate FROM emp WHERE ename = 'CLARK');

-- 3. 이름에 'K'자가 들어가는 사원들 중 급여가 가장 적은 사원의 부서명, 사원명, 급여를 출력
SELECT d.dname, e.ename, e.sal FROM emp e INNER JOIN dept d
ON e.sal = (SELECT MIN(sal) FROM emp WHERE ename LIKE '%K%');

-- 4. 커미션 계약이 없는 사원중 입사일이 가장 빠른 사원의 부서명, 사원명, 입사일을 출력
SELECT d.dname, e.ename, e.hiredate FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.hiredate = (SELECT MIN(hiredate) FROM emp WHERE e.comm IS NULL);

-- 5. 위치가 시카고인 부서에 속한 사원들의 이름과 부서명을 출력
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno AND d.loc
= (SELECT loc FROM dept WHERE loc = 'CHICAGO');

-- 6. KING의 급여에서 CLARK의 급여를 뺀 결과보다 적은 급여를 받는 사원의 부서명, 이름, 급여를 출력
SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal < (SELECT sal FROM emp WHERE ename = 'KING') - (SELECT sal FROM emp WHERE ename = 'CLARK');

-- 7. DALLAS에 위치한 부서에 속한 사원의 총사원수, 평균급여,전체급여,최고급여,초저급여를 구하세요.
SELECT COUNT(ename), AVG(sal), SUM(e.sal), MAX(sal), MIN(sal)
FROM emp e
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

-- 8. 커미션 계약조건이 있으며 이름에 'N'자가 들어가는 사원들 중 급여가 가장 적은 사원의 사원명, 급여,부서명을 출력
SELECT e.ename, e.sal, d.dname FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal = (SELECT MIN(sal) FROM emp WHERE comm IS NOT NULL AND ename LIKE '%N%');

-- 9. ALLEN 보다 입사일이 빠른 사원의 부서명,사원명을 출력
SELECT d.dname, e.ename FROM dept d INNER JOIN emp e
ON d.deptno = e.deptno
AND e.hiredate < (SELECT hiredate FROM emp WHERE ename = 'ALLEN');

-- 10. EMP 테이블에서 이름이 5글자인 사원중 급여가 가장 높은 사원의 이름, 급여 , 부서명을 출력
SELECT e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename LIKE '_____');

SELECT e.ename, e.sal, d.dname FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE LENGTH(ename) = 5);

-- 11. CLARK 이 속한 부서의 평균 연봉보다 급여가 높은 사원중 입사일이 가장 빠른 사원의 부서명, 사원명, 급여를 출력
SELECT d.dname, e.ename, e.sal FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate = 
(SELECT MIN(hiredate) FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE ename = 'CLARK'));

-- 12. ALLEN의 부서명을 출력
SELECT dname FROM dept
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN');

-- 13. 이름에 J가 들어가는 사원들 중, 급여가 가장 높은 사원의 사원번호, 이름, 부서명, 급여, 부서위치를 출력
SELECT e.empno, e.ename, d.dname, d.loc FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename LIKE '%J%');

-- 14. 두번째로 많은 급여를 받는 사원의 이름과 부서명,급여를 출력
SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp);

-- 15. 입사일이 2번째로 빠른 사원의 부서명과 이름, 입사일을 출력
SELECT d.dname, e.ename, e.hiredate FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate =
(SELECT MIN(hiredate) FROM emp WHERE hiredate > (SELECT MIN(hiredate) FROM emp));

-- 16. DALLAS에 위치한 부서의 사원 중 최대 급여를 받는 사원의 급여에서 최소 급여를 받는 사원의 급여를 뺀 결과를 출력
SELECT ((SELECT MAX(e.sal) FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS')
-
(SELECT MIN(e.sal) FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS'))
AS "최대-최소 급여"
FROM DUAL;

SELECT MAX(e.sal) - MIN(e.sal) FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND d.loc = 'DALLAS';

COMMIT;