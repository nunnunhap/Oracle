/*
    SQL함수
    01 숫자 함수
    02 문자 함수
    03 날짜 함수
    04 변환 함수
    05 NULL 관련 함수
    06 기타 함수
*/

-- 숫자 함수 : 숫자 함수란 수식 연산을 하는 함수로 연산 대상 즉, 매개변수나 반환 값이 대부분 숫자 형태다.

-- 1) ABS(n) 매개변수로 숫자를 받아 그 절대값을 반환하는 함
SELECT ABS(10), ABS(-10), ABS(-10.213)
FROM DUAL; -- 10 10 10.213

-- 2) CEIL(n) 과 FLOOR(n)
-- CEIL 함수는 매개변수 n과 같거나 가장 큰 정수를 반환
SELECT CEIL(10.123), CEIL(10.541), CEIL(11.001)
FROM DUAL; -- 11 11 12

-- FLOOR 함수는 CEIL 함수와는 반대로 매개변수 n보다 작거나 가장 큰 정수를 반환
SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001)
FROM DUAL; -- 10 10 11

-- 3) ROUND(n, i)와 TRUNC(n1, n2)
-- ROUND(n) : 소수점 첫째자리에서 반올림
SELECT ROUND(10.154), ROUND(10.541), ROUND(11.001)
FROM DUAL; -- 10 11 11
-- ROUND(n, i) : 소수점 i자리까지 보여줌. i+1자리에서 반올림.
-- i가 양수면 소수 : 소수점 i자리까지 보여줌. i+1자리에서 반올림.
-- i가 음수면 정수 : 
SELECT ROUND(10.154, 1), ROUND(10.154, 2), ROUND(10.154, -1)
FROM DUAL; -- 10.2 10.15 10

-- TRUNC : 버림/ 잘라내기
SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2)
FROM DUAL; -- 115 115.1 115.15 100

-- POWER(n2, n1)와 SQRT(n)
-- POWER 함수는 n2를 n1 제곱한 결과를 반환한다. n1은 정수와 실수 모두 올 수 있는데, n2가 음수일 때 n1은 정수만 올 수 있다.
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001)
FROM DUAL; -- 9 27 27.0029~~~~

-- SQRT 함수는 n의 제곱근을 반환. 루트 개념
SELECT SQRT(2), SQRT(5)
FROM DUAL; -- 1.41421~ 2.2360~~

-- MOD(n2, n1)와 REMAINDER(n2, n1)
-- MOD 함수는 n2를 n1으로 나눈 나머지 값을 반환
SELECT MOD(19,4), MOD(19.123, 4.2)
FROM DUAL; -- 3 2.323  :  n2 - n1 * FLOOR (n2/n1)

-- REMAINDER(n2, n1) 나머지란 뜻. 
SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2)
FROM DUAL; -- -1 -1.877 : n2 - n1 * ROUND (n2/n1)



-- 문자함수
-- INITCAP(char), LOWER(char), UPPER(char)
-- INITCAP 함수는 매개변수로 들어오는 char의 첫 문자는 대문자로, 나머지는 소문자로 반환하는 함수
SELECT INITCAP('never say goodbye'), INITCAP('never6say*good가bye')
FROM DUAL; --Never Say Goodbye  Never6say*Good가Bye

SELECT emp_name, INITCAP(emp_name) FROM employees;
-- Samuel McCain  -> Samuel Mccain

COMMIT;


-- 소문자 대문자 변환
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye') FROM DUAL;

SELECT emp_name, LOWER(emp_name), UPPER(emp_name) FROM employees;

-- CONCAT 함수는 ‘||’ 연산자처럼 매개변수로 들어오는 두 문자를 붙여 반환
SELECT CONCAT('I HAVE', ' A DREAM'), 'I HAVE' || ' A DREAM' FROM DUAL;

SELECT CONCAT(emp_name, salary), emp_name || ' ' || salary FROM employees;

-- SUBSTR는 문자 함수 중 가장 많이 사용되는 함수로, 잘라올 대사 문자열인 char의 pos번째 문자부터 len길이만큼 잘라낸 결과를 반환하는 함수
-- 아래의 1은 위치(첫번째위치) 4는 갯수 // 음수로 나오면 뒤부터 따지는 것. 뒤에서 첫번째
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4) FROM DUAL;

SELECT SUBSTR(emp_name, 1, 3) || '*****' AS "사용자 아이디" FROM employees;

-- 바이트 단위
SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('가나다라마바사', 1, 6) FROM DUAL;
-- 한글이 몇 바이트로 관리?
SELECT LENGTHB('가') FROM DUAL;

-- LTRIM/ RTRIM 좌측/우측공백제거
SELECT LTRIM('      ABCDEF'), RTRIM('ABCED      ') FROM DUAL;

SELECT LENGTH('       ABCD'), LENGTH(LTRIM('       ABCD')) FROM DUAL;

SELECT LTRIM('ABCDEFGABC', 'ABC'),
    LTRIM('가나다라', '가'),
    RTRIM('ABCDEFGABC', 'ABC'),
    RTRIM('가나다라', '라')
FROM DUAL;

--LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
CREATE TABLE ex4_1 (
       phone_num VARCHAR2(30));

INSERT INTO ex4_1 VALUES ('111-1111');

INSERT INTO ex4_1 VALUES ('111-2222');

INSERT INTO ex4_1 VALUES ('111-3333');

SELECT *
  FROM ex4_1;


SELECT phone_num, LPAD(phone_num, 12, '(02)') FROM ex4_1;

SELECT RPAD(phone_num, 12, '****') FROM ex4_1;


--  REPLACE(char, search_str, replace_str)
--  char 문자열에서 search_str 문자열을 찾아 이를 replace_str 문자열로 대체한 결과를 반환하는 함수
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너')
FROM DUAL;

-- 문자열에 있는 모든 공백을 제거
SELECT LTRIM(' ABC DEF '),
       RTRIM(' ABC DEF '),
       REPLACE(' ABC DEF ', ' ', '')
FROM DUAL;

-- TRANSLATE 함수 : REPLACE와 다른 점은 문자열 자체가 아닌 문자 한 글자씩 매핑해 바꾼 결과를 반환
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS rep,
       TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS trn
  FROM DUAL;

-- INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)
-- str 문자열에서 substr과 일치하는 위치를 반환하는데, pos는 시작 위치로 디폴트 값은 1,
-- occur은 몇 번째 일치하는지를 명시하며 디폴트 값은 1이다.
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1,
       INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2,
       INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3
  FROM DUAL;
-- 뒤에 숫자 안 써있으면 맨 앞부터 찾고, 5, 2 써있으면 5번째 위치에서부터 2번째 만약의 위치를 찾아라.

-- LENGTH 함수는 매개변수로 들어온 문자열의 개수를 반환하며, LENGTHB 함수는 해당 문자열의 바이트 수를 반환한다.
SELECT LENGTH('대한민국'),
       LENGTHB('대한민국')
  FROM DUAL;

-- 날짜 함수는 DATE 함수나 TIMESTAMP 함수와 같은 날짜형을 대상으로 연산을 수행해 결과를 반환하는 함수다.
-- 날짜 함수 역시 대부분 반환 결과는 날짜형이나 함수에 따라 숫자를 반환할 때도 있다.

-- SYSDATE(초), SYSTIMESTAMP(밀리초)
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

-- ADD_MONTHS (date, integer)
-- 날짜의 월을 더한 의미. 음수를 사용하여 뺀 의미도 구할 수 있음.
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1)
  FROM DUAL;

-- MONTHS_BETWEEN(date1, date2)
-- 두 날짜 사이의 개월 수를 반환하는데, date2가 date1보다 빠른 날짜가 온다.
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
  FROM DUAL;

-- 근속년수 따지기
SELECT
    employee_id,
    emp_name,
MONTHS_BETWEEN(SYSDATE, HIRE_DATE) AS mon1,
ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE), 1) / 12 AS 근속년수
FROM
    employees
ORDER BY employee_id;

-- LAST_DAY는 date 날짜를 기준으로 해당 월의 마지막 일자를 반환
SELECT LAST_DAY('2024-02-01') FROM DUAL;

-- ROUND(date, format), TRUNC(date, format)
-- 숫자 함수이면서 날짜 함수로도 쓰이는데, ROUND는 format에 따라 반올림한 날짜를, TRUNC는 잘라낸 날짜를 반환
SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month') FROM DUAL;

-- TO_DATE()는 문자열을 날짜 데이터타입으로 캐스팅해주는 것.
SELECT SYSDATE, ROUND(TO_DATE('2024-04-15'), 'month'),
TRUNC(TO_DATE('2024-04-15'), 'month') FROM DUAL;

SELECT SYSDATE, ROUND(TO_DATE('2024-04-16'), 'month'),
TRUNC(TO_DATE('2024-04-16'), 'month') FROM DUAL;

-- NEXT_DAY는 date를 char에 명시한 날짜로 다음 주 주중 일자를 반환
-- 현재 날짜 기준으로 돌아오는 금요일은?
SELECT NEXT_DAY(SYSDATE, '금요일')
  FROM DUAL;

-- 변환함수
SELECT TO_CHAR(123456789, '999,999,999')
  FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;--sysdate는 초까지 존재하기에 년월일 추출 이렇게.

-- TO_NUMBER(expr, format) 문자나 다른 유형의 숫자를 NUMBER 형으로 변환하는 함수
SELECT TO_NUMBER('123456')
FROM DUAL;

-- TO_DATE(char, format), TO_TIMESTAMP(char, format)
SELECT TO_DATE('20140101', 'YYYY-MM-DD')
  FROM DUAL;

SELECT TO_DATE('20140101 13:44:50', 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;


-- NULL
-- ① NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
-- expr1이 NULL일 때 expr2를 반환
SELECT NVL(manager_id, employee_id)
  FROM employees
 WHERE manager_id IS NULL;

SELECT NVL(NULL, 10), NVL(10, 20) FROM DUAL;
-- NULL이면 param1이 NOT NULL이면 pram2가 출력됨.

-- NVL2는 NVL을 확장한 함수로 expr1이 NULL이 아니면 expr2를, NULL이면 expr3를 반환하는 함
SELECT employee_id,
NVL2(commision_pct, salary + (salary * commision_pct), salary) AS salary2
FROM employees;

SELECT NVL2(NULL, 10, 20), NVL2(10, 20, 30) FROM DUAL;

-- NULL과 연산 시 결과는 NULL이 된다.(중요)
SELECT NULL + 100 FROM DUAL;

-- ② COALESCE (expr1, expr2, …)
-- 매개변수로 들어오는 표현식에서 NULL이 아닌 첫 번째 표현식을 반환하는 함수
SELECT employee_id, salary, commission_pct,
       COALESCE (salary * commission_pct, salary) AS salary2
  FROM employees;
  
SELECT COALESCE(NULL, NULL, 1), COALESCE(NULL, 1, 2),
COALESCE(1, 2, 3), COALESCE(NULL, NULL, NULL) FROM DUAL;

-- LNNVL(조건식) 매개변수로 들어오는 조건식의 결과가 FALSE이면 TRUE
-- 조건식의 결과가 TRUE이면 FALSE로 반환

SELECT emp_name, commission_pct FROM employees
WHERE LNNVL(commission_pct = 0);
-- 위의 구문을 다음처럼 변경 가능
SELECT emp_name, commission_pct FROM employees
WHERE commission_pct IS NULL OR commission_pct != 0;

SELECT salary FROM employees
WHERE LNNVL ( salary > 5000);
SELECT salary FROM employees
WHERE salary <= 5000;


-- NULLIF (expr1, expr2)
-- expr1과 expr2을 비교해 같으면 NULL을, 같지 않으면 expr1을 반환
SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL;

SELECT employee_id,
       TO_CHAR(start_date, 'YYYY') start_year,
       TO_CHAR(end_date, 'YYYY') end_year,
       NULLIF(TO_CHAR(end_date, 'YYYY'), TO_CHAR(start_date, 'YYYY') ) nullif_year
FROM job_history;

--  GREATEST(expr1, expr2, …), LEAST(expr1, expr2, …) ...은 매개변수의 제한이 없음.
-- 매개변수로 들어오는 표현식에서 가장 큰 값을, LEAST는 가장 작은 값을 반환하는 함수
SELECT GREATEST(1, 2, 3, 2) AS "가장 큰 값",
LEAST(1, 2, 3, 4) AS "가장 작은 값" FROM DUAL;

-- DECODE (expr, search1, result1, search2, result2, …, default)
SELECT prod_id,
         DECODE(channel_id, 3, 'Direct',
                            9, 'Direct',
                            5, 'Indirect',
                            4, 'Indirect',
                               'Others')  decodes
   FROM sales
  WHERE rownum < 10;

CREATE TABLE test02(
    varvar          VARCHAR2(10),
    create_date     DATE       DEFAULT  SYSDATE    
);

INSERT INTO test02(varvar) values('나다');

SELECT varvar, create_date FROM test02;



COMMIT; -- 데이터 작업내용을 실제 데이터베이스 파일에 물리적으로 반영.