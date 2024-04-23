-- 문제 1) 사원들의 이름, 부서번호, 부서명을 출력하라
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- 문제 2) 30번 부서의 사원들의 이름, 직업코드, 부서명을 출력하라.(2개 테이블 참조)
-- 1. employees테이블 : 이름, 직업코드 2. departments테이블 : 부서명
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_id = 30;

-- 문제 3) 30번 부서의 사원들의 이름, 직업이름, 부서명을 출력하라(3개 테이블 참조)
-- 1. employees테이블 : 이름 2. departments테이블 : 부서명 3. jobs테이블 : 직업이름
SELECT e.first_name, j.job_title, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id
AND d.department_id = 30;

-- 문제 4) 커미션 받는 사원 이름, 직업, 부서번호, 부서명 출력
-- 1. employees : first_name, job_id  departments : department_name
SELECT *
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;

-- 문제 5) 지역번호 2500에서 근무하는 사원의 이름, 직업이름, 부서번호, 부서명을 출력하라.
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

-- 문제 6) 사원 이름과 부서명과 월급을 출력하는데 월급이 3000 이상인 사원을 출력하라.
SELECT e.first_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary >= 3000;

SELECT e.first_name, e.salary, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
AND e.salary >= 3000;

-- 문제 7) 급여가 3000에서 5000 사이인 사원의 이름과 부서명을 출력하라(between 3000 and 5000 이용)
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND salary BETWEEN 3000 AND 5000;

SELECT e.first_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
AND salary BETWEEN 3000 AND 5000;

-- 문제 8) 급여가 3000 이하인 사원의 이름과 급여, 근무지(CITY)를 출력하라
SELECT e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.salary <= 3000;




