/*
    VIEW : �ϳ� �̻��� ���̺��̳� �ٸ� ���� �����͸� �� �� �ְ� �ϴ� �����ͺ��̽� ��ü
    �����͸� ��ȸ�ϴ� �����̴ٺ��� SELECT���� �����.
    
    CREATE OR REPLACE VIEW [��Ű��.]��� AS
    SELECT ����;
    
    �뵵 : SELECT������ �����ϴ� �� ������ �����Ͽ� ������ �����ϰ� ��.
          ���������� �߿��� �÷��� ������ �ִ� ���̺� ������ ���� ��� ��ü
*/

-- ���� : VW_EMPLOYEES_DEPARTMENT_ID_50 �� �̸����� SELECT ������ �ڵ带 �����Ͽ� ������.
CREATE OR REPLACE VIEW VW_EMPLOYEES_DEPARTMENT_ID_50
AS
SELECT emp_name, EMPLOYEE_ID, HIRE_DATE, SALARY, RETIRE_DATE, COMMISSION_PCT
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- �� ���� : ��� ���� �����͸� ������ �ִ°� �ƴ϶� ����Ʈ���̶�� �ڵ带 ������ ����.
SELECT * FROM VW_EMPLOYEES_DEPARTMENT_ID_50;

-- �� ���� : DROP VIEW [��Ű��.]���;
DROP VIEW VW_EMPLOYEES_DEPARTMENT_ID_50;

-- SEQUENCE
CREATE SEQUENCE MY_SEQ1 --�밳 �̰� �ϳ��� ��.
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE
NOCACHE;

CREATE SEQUENCE MY_SEQ2;

-- ������ ��ɾ� NEXTVAL CURRVAL
SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- �ּҰ�1
SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- �������� �۵� +1 
SELECT MY_SEQ2.CURRVAL FROM DUAL; -- ���� ������ ��

CREATE SEQUENCE MY_SEQ3;
-- CURRVAL�� NEXTVAL�� �� �Ŀ��� ��� ����.
SELECT MY_SEQ2.CURRVAL FROM DAUL; -- ���� �߻�

-- ������ ���
CREATE SEQUENCE MY_SEQ4;

CREATE TABLE SAMPLE_8 (
    IDX         NUMBER          PRIMARY KEY,
    NAME        VARCHAR2(20)    NOT NULL,
    REG_DATE    DATE            DEFAULT SYSDATE
);

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '�����');
INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, 'Ȳ����');
INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '�����');
INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '�̰���');

SELECT * FROM SAMPLE_8;

-- ������ ����
CREATE SEQUENCE MY_SEQ5
START WITH 1000 -- �ʱⰪ
INCREMENT BY 10; -- ������, �������� ����

SELECT MY_SEQ5.NEXTVAL FROM DUAL;

-- ������ ����
ALTER SEQUENCE MY_SEQ5
INCREMENT BY 5;

DROP SEQUENCE MY_SEQ5;


-- �ε���Index�� ���̺� �ִ� �����͸� ���� ã�� ���� �뵵�� �����ͺ��̽� ��ü
/*
? �ε��� ���� �÷� ������ ���� �з�: ���� �ε����� ���� �ε���
? ���ϼ� ���ο� ���� �з�: UNIQUE �ε���, NON-UNIQUE �ε���
? �ε��� ���� ������ ���� �з�: B-tree �ε���, ��Ʈ�� �ε���, �Լ� ��� �ε���
�Ϲ������� B-tree �ε����� ���� ���� ����.
*/
-- ���̺� PRIMARY KEY ���������� �����ϸ� �ڵ����� UNIQUE �ε����� ������.
-- ������ ��������� ���ο� �ش�Ǵ� �����͵� ���� �������.

/*
    - �⺻Ű
        1) ����Ű - �÷� 1�� 2) ����Ű - �÷��� ������ �ϳ��� ������ ��� ����
  CREATE[UNIQUE] INDEX [��Ű����.]�ε�����
    ON [��Ű����.]���̺��(�÷�1, �÷�2, ...);
*/

-- �÷� 1���� ����ٰ� �Ͽ� '���� �ε���'
CREATE UNIQUE INDEX ex2_10_ix01
ON ex2_10 ( col11); 
--col1�÷��� �ߺ��� ������ ����, �÷��� ������ �˻� �� ��������� �������� �ε��� ����
SELECT * FROM ex2_10 WHERE col1 = ��;

-- ���� �ε���, �ߺ����� �ȵ�
CREATE INDEX ex2_10_ix2
ON ex2_10(col11, col2);

CREATE TABLE ȸ�� (
ȸ�� ���̵�, --PRIMARY KEY
�̸�,
�ֹε�Ϲ�ȣ
)
CREATE UNIQUE INDEX ȸ��_IDX
ON ȸ��(�ֹε�Ϲ�ȣ);

/*
    �ε����� �ʹ� ���� ����� SELECT �ܿ� INSERT, DELETE, UPDATE �� ���ɿ� ���ϰ� �ڵ���.
    �⺻������ ���Ļ��·� ����� ���̱� ������.
    
    �ε����� ������ �� ����ؾ� �� ������ �����ϸ� ������ ����.

? �Ϲ������� ���̺� ��ü �ο� ���� 15%������ �����͸� ��ȸ�� �� �ε����� �����Ѵ�
���� 15%�� ������ ���� �ƴϸ� ���̺� �Ǽ�, ������ ���� ������ ���� �޶�����.

? ���̺� �Ǽ��� ���ٸ�(�ڵ强 ���̺�) ���� �ε����� ���� �ʿ䰡 ����
������ ������ ���� ���̺��̳� �ε����� Ž���ϴ� ���� ��ĵ(scan)�̶�� �ϴµ�, ���̺� �Ǽ��� ������ �ε����� �����ϱ⺸��
���̺� ��ü�� ��ĵ�ϴ� ���� ������.

? �������� ���ϼ� ������ ���ų� ������ ���� ���� ���� �÷��� �ε����� ����� ���� ����

? NULL�� ���� ���Ե� �÷��� �ε��� �÷����� ����� ����ġ �ʴ�

? ���� �ε����� ���� ����, �÷��� ������ �߿��ϴ�
����, ���� ���Ǵ� �÷��� ������ �տ� �δ� ���� ����.

? ���̺� ���� �� �ִ� �ε��� ���� ������ ������, �ʹ� ���� ����� ������ ���� ���ϰ� �߻��Ѵ�
    
*/



COMMIT;


