create table users(
    id varchar2(20) primary key,
    pwd varchar2(20),
    name varchar2(20),
    email varchar2(40),
    zip_code char(5),
    address varchar2(100),
    phone varchar2(20),
    useyn number default 1, -- 활동 : 1, 탈퇴 : 2
    regdate date default sysdate);
    
 create table product(
    prodnum number(5) primary key,
    name varchar2(200),
    kind char(1) check (kind in ('1', '2','3','4')), -- bag : 1, wallet : 2, shoes : 3, acc : 4
    price1 number(7) default 0,
    price2 number(7) default 0,
    price3 number(7) default 0,
    content varchar2(1000),
    image varchar2(50) default 'default.jpg',
    useyn char default 'y', -- 판매 : y, 판매중단 : n
    regdate date default sysdate);
    
create sequence product_seq start with 1 increment by 1;

create table admin(
    id varchar2(20) primary key,
    pwd varchar2(20),
    name varchar2(40),
    email varchar2(40),
    phone varchar2(20));
    
    
create table cart(
    cartnum number(8) primary key,
    id varchar2(20),
    prodnum number(5),
    quantity number(5) default 1,
    result char(1) default 1, -- 배송 전 : 1, 배송 완료 : 2
    indate date default sysdate, -- 카트 담은 날짜
    constraint fk_id foreign key(id) references users(id),
    constraint fk_prodnum foreign key(prodnum) references product(prodnum));
    
create sequence cart_seq start with 1 increment by 1;

create table orders(
    ordernum number(10) primary key,
    id varchar2(20),
    indate date default sysdate,
    constraint fk_order_id foreign key(id) references users(id));
    
create sequence orders_seq start with 1 increment by 1;

create table order_detail(
    odnum number(10) primary key,
    ordernum number(10),
    prodnum number(5),
    quantity number(5),
    result char(1) default 1,
    constraint fk_order_detail foreign key(ordernum) references orders(ordernum),
    constraint fk_prod_detail foreign key(prodnum) references product(prodnum));
    
    create sequence order_detail_seq start with 1 increment by 1;
    
create table qna(
    qseq number(5) primary key,
    subject varchar2(30),
    content varchar2(1000),
    reply varchar2(1000),
    id varchar2(20),
    rep char(1) default 1,
    indate date default sysdate,
    constraint fk_qna_id foreign key(id) references users(id));
    
create sequence qna_seq start with 1 increment by 1;    