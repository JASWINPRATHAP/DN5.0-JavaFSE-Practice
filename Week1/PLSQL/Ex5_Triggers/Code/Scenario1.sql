CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

DECLARE
    v_before DATE;
    v_after DATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== CUSTOMER LAST MODIFIED TRIGGER TEST ===');
    SELECT LastModified INTO v_before FROM Customers WHERE CustomerID = 1;
    DBMS_OUTPUT.PUT_LINE('Before Update LastModified: ' || TO_CHAR(v_before, 'YYYY-MM-DD HH24:MI:SS'));
    
    UPDATE Customers SET Balance = Balance + 0 WHERE CustomerID = 1;
    
    SELECT LastModified INTO v_after FROM Customers WHERE CustomerID = 1;
    DBMS_OUTPUT.PUT_LINE('After Update LastModified: ' || TO_CHAR(v_after, 'YYYY-MM-DD HH24:MI:SS'));
    ROLLBACK;
END;
/
