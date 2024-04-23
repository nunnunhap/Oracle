-- 학습용 계정생성하기
-- 관리자만 생성가능
CREATE USER sqldb IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
    
-- 권한부여
GRANT connect, resource, dba TO sqldb; -- 원래 보안때문에 dba는 보안때문에 부여하지 않음.
