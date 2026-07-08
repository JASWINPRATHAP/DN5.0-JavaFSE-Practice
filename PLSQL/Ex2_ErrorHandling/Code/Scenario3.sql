CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customer_id NUMBER,
    p_name        VARCHAR2,
    p_dob         DATE,
    p_balance     NUMBER
) IS
BEGIN

    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE, 'FALSE');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Added customer ' || p_name || ' (ID: ' || p_customer_id || ').');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Customer with ID ' || p_customer_id || ' already exists. Insertion prevented.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Customer insertion failed. Details: ' || SQLERRM);
END AddNewCustomer;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test Case 1: Insert New Customer ---');
    AddNewCustomer(5, 'David Wright', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 5000);
    
    DBMS_OUTPUT.PUT_LINE('--- Test Case 2: Duplicate Customer ID ---');
    AddNewCustomer(1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 5000);
END;
/
