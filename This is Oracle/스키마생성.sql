-- [����-SYSTEM]���� ������ �� ����
DROP USER sqlDB CASCADE; -- ���� ����� ����
CREATE USER sqlDB IDENTIFIED BY 1234 -- ����� �̸�: sqlDB, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO sqlDB; -- ���� �ο�
