-- DBA(데이터베이스 관리자)

-- 1) db생성작업
CREATE DATABASE shopmall;

-- 2) 사용자 계정 생성 및 권한 작업
CREATE USER user01@localhost identified by '1234'; -- 컴퓨터 내부 사용

CREATE USER 'user01'@'%' identified by '1234'; -- 외부 접근 권한 부여



