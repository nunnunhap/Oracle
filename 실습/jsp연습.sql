-- 회원 테이블 생성

CREATE TABLE t_member (
    id          VARCHAR2(10)    PRIMARY KEY,
    pwd         VARCHAR2(10)    NOT NULL,
    name        VARCHAR2(50)    NOT NULL,
    email       VARCHAR2(50)    NOT NULL,
    joinDate    DATE    DEFAULT SYSDATE -- 사용자가 직접 가입날짜 적는게 말이 안되니 DB에서 알아서 처리해줌.
);

-- 데이터 3개
INSERT INTO t_member VALUES('user01', '1234', '손흥민', 'son@nate.com', SYSDATE);
INSERT INTO t_member VALUES('user02', '1234', '이강인', 'lee@nate.com', SYSDATE);
INSERT INTO t_member VALUES('user03', '1234', '황희찬', 'hwa@nate.com', SYSDATE);

COMMIT;

SELECT * FROM t_member;


