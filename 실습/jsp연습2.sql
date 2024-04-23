DROP TABLE t_member;

CREATE TABLE t_member(
    id      VARCHAR2(10),
    pwd     VARCHAR2(10),
    name    VARCHAR2(50),
    email   VARCHAR2(50),
    joindate DATE DEFAULT SYSDATE
);