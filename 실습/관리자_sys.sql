-- �н��� ���������ϱ�
-- �����ڸ� ��������
CREATE USER sqldb IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
    
-- ���Ѻο�
GRANT connect, resource, dba TO sqldb; -- ���� ���ȶ����� dba�� ���ȶ����� �ο����� ����.
