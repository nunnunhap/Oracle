-- ȸ�� ���̺� ����

CREATE TABLE t_member (
    id          VARCHAR2(10)    PRIMARY KEY,
    pwd         VARCHAR2(10)    NOT NULL,
    name        VARCHAR2(50)    NOT NULL,
    email       VARCHAR2(50)    NOT NULL,
    joinDate    DATE    DEFAULT SYSDATE -- ����ڰ� ���� ���Գ�¥ ���°� ���� �ȵǴ� DB���� �˾Ƽ� ó������.
);

-- ������ 3��
INSERT INTO t_member VALUES('user01', '1234', '�����', 'son@nate.com', SYSDATE);
INSERT INTO t_member VALUES('user02', '1234', '�̰���', 'lee@nate.com', SYSDATE);
INSERT INTO t_member VALUES('user03', '1234', 'Ȳ����', 'hwa@nate.com', SYSDATE);

COMMIT;

SELECT * FROM t_member;


