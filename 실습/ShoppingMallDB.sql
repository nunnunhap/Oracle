-- ���θ� �����ͺ��̽� ����
CREATE TABLE USERS (
    ID          VARCHAR2(20)    PRIMARY KEY, -- ȸ�� ���̵�
    PWD         VARCHAR2(20), -- ȸ�� ��й�ȣ
    NAME        VARCHAR2(20), -- ȸ�� �̸�
    EMAIL       VARCHAR2(40), -- ȸ�� �̸���
    ZIP_CODE    VARCHAR2(5), -- ȸ�� �����ȣ
    ADDRESS     VARCHAR2(100), -- ȸ�� �ּ�
    PHONE       VARCHAR2(20), -- ȸ�� ��ȭ��ȣ
    USEYN       NUMBER          DEFAULT 1, -- ȸ�� Ż�𿩺�
    REGDATE     DATE            DEFAULT SYSDATE -- ȸ�� ������
);

CREATE TABLE PRODUCT (
    PRODNUM     NUMBER(5)   PRIMARY KEY, -- ��ǰ��ȣ
    NAME        VARCHAR2(200), -- ��ǰ �̸�
    KIND        CHAR(1)     CHECK(KIND BETWEEN 1 AND 4), -- ��ǰ����(BAG: 1, WALLET: 2, SHOES: 3, ACC: 4)
    PRICE1      NUMBER(7), -- ����
    PRICE2      NUMBER(7), -- �ǸŰ�
    PRICE3      NUMBER(7), -- ����
    CONTENT     VARCHAR2(1000), -- ��ǰ ����
    IMAGE       VARCHAR2(50), -- ��ǰ ����
    USEYN       CHAR(1)     DEFAULT 'Y', -- �Ǹ�����(�Ǹ�: Y, �Ǹ��ߴ�: N)
    REGDATE     DATE -- �����
--    PRODUCT_SEQ SEQUENCE -- ��ǰ��ȣ ���� ������
);

CREATE TABLE ADMIN (
    ID      VARCHAR2(20)    PRIMARY KEY, -- ������ ���̵�
    PWD     VARCHAR2(20), -- ������ ��й�ȣ
    NAME    VARCHAR2(20), -- ������ �̸�
    EMAIL   VARCHAR2(40), -- ������ �̸���
    PHONE   VARCHAR2(20) -- ������ ��ȭ��ȣ
);

CREATE TABLE CART (
    CARTNUM     NUMBER(8)       PRIMARY KEY, -- ��ٱ��� ��ȣ
    ID          VARCHAR2(20)    REFERENCES USERS(ID), -- ��ٱ��� �̿� ȸ��
    PRODNUM     NUMBER(5)       REFERENCES PRODUCT(PRODNUM), -- ��ǰ��ȣ
    QUANTITY    NUMBER(5), -- ����
    RESULT      CHAR(1)         DEFAULT 1 CHECK(RESULT IN (1, 2)), -- �������(��� ��: 1, ��� ��: 2)
    INDATE      DATE -- īƮ ���� ��¥
--    CART_SEQ    SEQUENCE -- ��ٱ��� ��ȣ ����
);

DROP TABLE CART;

CREATE TABLE ORDERS (
    ORDERNUM    NUMBER(10)      PRIMARY KEY, -- �ֹ���ȣ
    ID          VARCHAR2(20)    REFERENCES USERS(ID), -- �ֹ��� ȸ�� ���̵�
    INDATE      DATE -- �ֹ���¥
--    ORDERS_SEQ  SEQUENCE -- �ֹ���ȣ ����
);

CREATE TABLE ORDER_DETAIL (
    ODNUM       NUMBER(10)  PRIMARY KEY, -- �ֹ�ó�� ��ȣ
    ORDERNUM    NUMBER(10)  REFERENCES ORDERS(ORDERNUM), -- �ֹ���ȣ
    PRODNUM     NUMBER(5)   REFERENCES PRODUCT(PRODNUM), -- ��ǰ��ȣ
    QUANTITY    NUMBER(5), -- ����
    RESULT      CHAR(1)     DEFAULT 1 CHECK(RESULT IN (1, 2))-- ó������(��� ��: 1, ��� ��: 2)
--    ORDER_DETAIL_SEQ    SEQUENCE -- �ֹ�ó�� ��ȣ ����
);

CREATE TABLE QNA (
    QSEQ        NUMBER(5)       PRIMARY KEY, -- ���ǹ�ȣ
    SUBJECT     VARCHAR2(30), -- ���� ����
    CONTENT     VARCHAR2(1000), -- ���ǳ���
    REPLY       VARCHAR2(1000), -- �亯����
    ID          VARCHAR2(20)    REFERENCES USERS(ID), -- ������ ��
    REP         CHAR(1)         DEFAULT 1 CHECK(REP IN (1, 2)), -- �亯 ����(�亯��: 1, �亯��: 2)
    INDATE      DATE -- ���ǳ�¥
--    QNA_SEQ     SEQUENCE -- ���� ��ȣ ����
);

COMMIT;