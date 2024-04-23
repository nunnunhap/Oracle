-- 쇼핑몰 데이터베이스 설계
CREATE TABLE USERS (
    ID          VARCHAR2(20)    PRIMARY KEY, -- 회원 아이디
    PWD         VARCHAR2(20), -- 회원 비밀번호
    NAME        VARCHAR2(20), -- 회원 이름
    EMAIL       VARCHAR2(40), -- 회원 이메일
    ZIP_CODE    VARCHAR2(5), -- 회원 우편번호
    ADDRESS     VARCHAR2(100), -- 회원 주소
    PHONE       VARCHAR2(20), -- 회원 전화번호
    USEYN       NUMBER          DEFAULT 1, -- 회원 탈퇴여부
    REGDATE     DATE            DEFAULT SYSDATE -- 회원 가입일
);

CREATE TABLE PRODUCT (
    PRODNUM     NUMBER(5)   PRIMARY KEY, -- 상품번호
    NAME        VARCHAR2(200), -- 상품 이름
    KIND        CHAR(1)     CHECK(KIND BETWEEN 1 AND 4), -- 상품종류(BAG: 1, WALLET: 2, SHOES: 3, ACC: 4)
    PRICE1      NUMBER(7), -- 원가
    PRICE2      NUMBER(7), -- 판매가
    PRICE3      NUMBER(7), -- 이익
    CONTENT     VARCHAR2(1000), -- 상품 설명
    IMAGE       VARCHAR2(50), -- 상품 사진
    USEYN       CHAR(1)     DEFAULT 'Y', -- 판매유무(판매: Y, 판매중단: N)
    REGDATE     DATE -- 등록일
--    PRODUCT_SEQ SEQUENCE -- 상품번호 생성 시퀸스
);

CREATE TABLE ADMIN (
    ID      VARCHAR2(20)    PRIMARY KEY, -- 관리자 아이디
    PWD     VARCHAR2(20), -- 관리자 비밀번호
    NAME    VARCHAR2(20), -- 관리자 이름
    EMAIL   VARCHAR2(40), -- 관리자 이메일
    PHONE   VARCHAR2(20) -- 관리자 전화번호
);

CREATE TABLE CART (
    CARTNUM     NUMBER(8)       PRIMARY KEY, -- 장바구니 번호
    ID          VARCHAR2(20)    REFERENCES USERS(ID), -- 장바구니 이용 회원
    PRODNUM     NUMBER(5)       REFERENCES PRODUCT(PRODNUM), -- 상품번호
    QUANTITY    NUMBER(5), -- 수량
    RESULT      CHAR(1)         DEFAULT 1 CHECK(RESULT IN (1, 2)), -- 배송유무(배송 전: 1, 배송 후: 2)
    INDATE      DATE -- 카트 담은 날짜
--    CART_SEQ    SEQUENCE -- 장바구니 번호 생성
);

DROP TABLE CART;

CREATE TABLE ORDERS (
    ORDERNUM    NUMBER(10)      PRIMARY KEY, -- 주문번호
    ID          VARCHAR2(20)    REFERENCES USERS(ID), -- 주문한 회원 아이디
    INDATE      DATE -- 주문날짜
--    ORDERS_SEQ  SEQUENCE -- 주문번호 생성
);

CREATE TABLE ORDER_DETAIL (
    ODNUM       NUMBER(10)  PRIMARY KEY, -- 주문처리 번호
    ORDERNUM    NUMBER(10)  REFERENCES ORDERS(ORDERNUM), -- 주문번호
    PRODNUM     NUMBER(5)   REFERENCES PRODUCT(PRODNUM), -- 상품번호
    QUANTITY    NUMBER(5), -- 수량
    RESULT      CHAR(1)     DEFAULT 1 CHECK(RESULT IN (1, 2))-- 처리유무(배송 전: 1, 배송 후: 2)
--    ORDER_DETAIL_SEQ    SEQUENCE -- 주문처리 번호 생성
);

CREATE TABLE QNA (
    QSEQ        NUMBER(5)       PRIMARY KEY, -- 문의번호
    SUBJECT     VARCHAR2(30), -- 문의 제목
    CONTENT     VARCHAR2(1000), -- 문의내용
    REPLY       VARCHAR2(1000), -- 답변내용
    ID          VARCHAR2(20)    REFERENCES USERS(ID), -- 문의한 고객
    REP         CHAR(1)         DEFAULT 1 CHECK(REP IN (1, 2)), -- 답변 유무(답변전: 1, 답변후: 2)
    INDATE      DATE -- 문의날짜
--    QNA_SEQ     SEQUENCE -- 문의 번호 생성
);

COMMIT;