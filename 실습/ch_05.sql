-- 기본 집계 함수
-- 집계함수란 대상 데이터를 특정 그룹으로 묶은 다음 이 그룹에 대해 총합, 평균, 최댓값, 최솟값 등을 구하는 함수

-- COUNT (expr) 사원 테이블의 데이터 행 갯수
SELECT COUNT(*) FROM employees;
-- 부서 테이블의 데이터 행수
SELECT COUNT(*) FROM employees;-- 107

-- * 대신 컬럼명을 사용할 수 가 있다.
SELECT COUNT(employee_id) FROM employees;
SELECT COUNT(department_id) FROM employees; --106/ null값은 빼고

-- 중복 데이터 제거
SELECT COUNT(DISTINCT department_id) FROM employees; -- 11
SELECT DISTINCT department_id FROM employees; -- 총 12개의 데이터(null포함)

-- SUM(expr)
-- expr의 전체 합계를 반환하는 함수로 매개변수 expr에는 숫자형만 올 수 있다.

-- 총 급여액 조회
SELECT SUM(salary) FROM employees;
-- SUM 함수 역시 expr 앞에 DISTINCT가 올 수 있는데, 이때 역시 중복된 급여는 1번만 셈해진 전체 합계를 반환
SELECT SUM(salary), SUM(DISTINCT salary) FROM employees;

-- AVG(expr) AVG는 매개변수 형태나 쓰임새는 COUNT, SUM과 동일하며 평균값을 반환
SELECT AVG(salary), AVG(DISTINCT salary) FROM employees;

-- MIN(expr), MAX(expr) 최솟값과 최댓값을 반환
SELECT MIN(salary), MAX(salary) FROM employees;

-- VARIANCE(expr), STDDEV(expr)
/*VARIANCE는 분산을, STDDEV는 표준편차를 구해 반환한다. 분산이란 주어진 범위의 개별 값과 평균값과의 차이인 편차를 구해
이를 제곱해서 평균한 값을 말하며, 표준편차는 분산 값의 제곱근이다. 분산은 제곱한 평균이므로, 
실제로 통계에서는 평균을 중심으로 값들이 어느 정도 분포하는지를 나타내는 수치인 표준편차를 지표로 사용
*/
SELECT VARIANCE(salary), STDDEV(salary) FROM employees;

-- GROUP BY 절과 HAVING 절
/* 지금까지 알아본 집계 함수의 예제는 모두 사원 전체를 기준으로 데이터를 추출했는데, 
전체가 아닌 특정 그룹으로 묶어 데이터를 집계할 수도 있다. 이때 사용되는 구문이 바로 GROUP BY 절이다. 
그룹으로 묶을 컬럼명이나 표현식을 GROUP BY 절에 명시해서 사용하며 GROUP BY 구문은 WHERE와 ORDER BY절 사이에 위치
*/

-- 각 부서별 총 급여액, 평균 급여액 조회
SELECT department_id, SUM(salary) AS "총급여", ROUND(AVG(salary),1) AS "평균급여"
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;

-- 한국 대출상태 조회
SELECT
    period,
    region,
    gubun,
    loan_jan_amt
FROM
    kor_loan_status;

--  테이블에는 월별, 지역별 가계대출 잔액(단위는 십억)이 들어 있고, 대출유형(gubun)은 ‘주택담보대출’과 ‘기타대출’ 두 종류만 존재한다.
-- 그럼 2013년 지역별 가계대출 총 잔액을 구해 보자.
SELECT
    period,
    region,
SUM(loan_jan_amt) AS "TOTAL LOAN"
FROM
    kor_loan_status
WHERE
    period
LIKE
    '2013%'
GROUP BY period, region
HAVING SUM(loan_jan_amt) > 100000
ORDER BY period;

-- 사원테이블 참고
-- 1. 각 부서별 최대급여, 최소급여, 평균급여를 조회
SELECT department_id "부서번호",
MAX(salary) "최대급여",
MIN(salary) "최소급여",
ROUND(AVG(salary), 1) "평균급여"
FROM employees
GROUP BY department_id -- 동일한 부서코드를 그룹화
ORDER BY department_id;

-- 각 부서별 최대급여, 최소급여, 평균급여를 조회
-- 위의 쿼리 데이터를 평균급여 오름차순으로 조회(별칭 사용)
SELECT department_id "부서번호",
MAX(salary) "최대급여",
MIN(salary) "최소급여",
ROUND(AVG(salary), 1) "평균급여"
FROM employees
GROUP BY department_id -- 동일한 부서코드를 그룹화
ORDER BY "평균급여" DESC;

-- 시나리오 : employees 테이블에서 직책별 직원 수, 최대급여, 최소급여, 평균급여를 소수점 첫째자리까지 구하라
-- 최대급여를 오름차순
SELECT job_id "직책",
COUNT(*) "직원수",
MAX(salary) "최대급여",
MIN(salary) "최소급여",
ROUND(AVG(salary), 1) "평균급여"
FROM employees
GROUP BY job_id
HAVING COUNT(*) > 10
ORDER BY 최대급여;


--  ROLLUP 절과 CUBE 절 : GROUP BY절에서 사용되어 그룹별 소계를 추가로 보여 주는 역할을 한다.

-- 2013년 기간(period), 대출종류별 총 잔액(gubun)을 구하라.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY period, gubun
 ORDER BY period;

-- 2013년 10월 중간합계 -- 2013년 11월 중간합계 -- 전체합계
-- GROUP BY ROLLUP(period, gubun) : 컬럼수 + 1 = 3레벨 형태로 데이터 조회
-- 레벨 3 : 소계, 레벨 2 : 중간계산, 레벨 1 : 전체계산
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
 FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY ROLLUP(period, gubun);

-- GROUP BY period, ROLLUP( gubun ); ROLLUP 컬럼수 1개 + 1 = 2레벨형태 데이터 출력
-- 레벨2(period, gubun), 레벨1(period) 형태로 출력.
-- 전체 합계는 출력에서 제외
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY period, ROLLUP( gubun );


-- CUBE(expr1, expr2, …)
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY CUBE(period, gubun) ;
-- 2의 CUBE 컬럼 수 승 = 4가지 유형
/*
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
                                       2182852.1
       기타대출                        1357199.3
       주택담보대출                     825652.8
201310                                 1087493.9
201310 기타대출                           676078
201310 주택담보대출                     411415.9
201311                                 1095358.2
201311 기타대출                         681121.3
201311 주택담보대출                     414236.9
*/

--GROUP BY ROLLUP(a, b); 컬럼수 2+1 = 3레벨. (a, b), (a), (전체합계)
--GROUP BY CUBE(a, b); 컬럼수 2의 컬럼수 승 = 4유형. (a, b), (a), (b), (전체합계)

--  GROUP BY expr1, CUBE(expr2, expr3)로 명시했을 때,
-- (expr1, expr2, expr3), (expr1, expr2), (expr1, expr3), (expr1) 총 4가지(2^2^) 유형으로 집계


-- 집합연산자
-- 집합(Set) 연산자는 이러한 데이터 집합을 대상으로 연산을 수행하는 연산자를 말하며, 그 종류로는 UNION, UNION ALL, INTERSECT, MINUS

-- UNION 합집합
CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('한국', 1, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('한국', 2, '자동차');
INSERT INTO exp_goods_asia VALUES ('한국', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('한국', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('한국', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('한국', 6,  '자동차부품');
INSERT INTO exp_goods_asia VALUES ('한국', 7,  '휴대전화');
INSERT INTO exp_goods_asia VALUES ('한국', 8,  '환식탄화수소');
INSERT INTO exp_goods_asia VALUES ('한국', 9,  '무선송신기 디스플레이 부속품');
INSERT INTO exp_goods_asia VALUES ('한국', 10,  '철 또는 비합금강');

INSERT INTO exp_goods_asia VALUES ('일본', 1, '자동차');
INSERT INTO exp_goods_asia VALUES ('일본', 2, '자동차부품');
INSERT INTO exp_goods_asia VALUES ('일본', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('일본', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('일본', 5, '반도체웨이퍼');
INSERT INTO exp_goods_asia VALUES ('일본', 6, '화물차');
INSERT INTO exp_goods_asia VALUES ('일본', 7, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('일본', 8, '건설기계');
INSERT INTO exp_goods_asia VALUES ('일본', 9, '다이오드, 트랜지스터');
INSERT INTO exp_goods_asia VALUES ('일본', 10, '기계류');

COMMIT;

-- 한국 수출 품목 조회
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
 ORDER BY seq;

-- 한국& 일본 수출 품목 조회
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
UNION
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본';

SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
UNION ALL
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본';

-- INTERSECT : 합집합이 아닌 교집합을 의미한다. 즉 데이터 집합에서 공통된 항목만 추출
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
INTERSECT
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본';

-- MINUS : 차집합을 의미한다. 즉 한 데이터 집합을 기준으로 다른 데이터 집합과 공통된 항목을 제외한 결과만 추출
-- 한국만 수출하는 품목
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
 MINUS
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본';

-- 일본만 수출하는 품목
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본'
 MINUS
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국';

-- 집합 연산자의 제한사항
-- ① 집합 연산자로 연결되는 각 SELECT문의 SELECT 리스트의 개수와 데이터타입은 일치해야 한다
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
 UNION
SELECT seq, goods
  FROM exp_goods_asia
 WHERE country = '일본';

-- ② 집합 연산자로 SELECT 문을 연결할 때 ORDER BY절은 맨 마지막 문장에서만 사용할 수 있다
SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
 ORDER BY goods
 UNION
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본';

-- ③ BLOB, CLOB, BFILE 타입의 컬럼에 대해서는 집합 연산자를 사용할 수 없다
-- ④ UNION, INTERSECT, MINUS 연산자는 LONG형 컬럼에는 사용할 수 없다

-- GROUPING SETS 절
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
  FROM kor_loan_status
 WHERE period LIKE '2013%'
 GROUP BY GROUPING SETS(period, gubun);
-- (GROUP BY period) UNION ALL (GROUP BY gubun)

SELECT period, gubun, region, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
       AND region IN ('서울', '경기')
     GROUP BY GROUPING SETS(period, (gubun, region));
-- (GROUP BY period) UNION ALL (GROUP BY (gubun, region))



COMMIT;