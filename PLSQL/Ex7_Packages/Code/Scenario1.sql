CREATE OR REPLACE PACKAGE CustomerManagement IS
    PROCEDURE AddCustomer(
        p_customer_id NUMBER,
        p_name        VARCHAR2,
        p_dob         DATE,
        p_balance     NUMBER
    );

    PROCEDURE UpdateCustomer(
        p_customer_id NUMBER,
        p_name        VARCHAR2,
        p_balance     NUMBER
    );

    FUNCTION GetCustomerBalance(
        p_customer_id NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement IS

    PROCEDURE AddCustomer(
        p_customer_id NUMBER,
        p_name        VARCHAR2,
        p_dob         DATE,
        p_balance     NUMBER
    ) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
        VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE, 'FALSE');
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Package CustomerManagement: Customer ' || p_name || ' (ID: ' || p_customer_id || ') added successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Package Error: Customer ID ' || p_customer_id || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Package Error: ' || SQLERRM);
    END AddCustomer;

    PROCEDURE UpdateCustomer(
        p_customer_id NUMBER,
        p_name        VARCHAR2,
        p_balance     NUMBER
    ) IS
    BEGIN
        UPDATE Customers
        SET Name = p_name,
            Balance = p_balance,
            LastModified = SYSDATE
        WHERE CustomerID = p_customer_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Package Error: Customer ID ' || p_customer_id || ' not found for update.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Package CustomerManagement: Customer ID ' || p_customer_id || ' details updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Package Error: ' || SQLERRM);
    END UpdateCustomer;

    FUNCTION GetCustomerBalance(
        p_customer_id NUMBER
    ) RETURN NUMBER IS
        v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance
        FROM Customers
        WHERE CustomerID = p_customer_id;

        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN -1;
        WHEN OTHERS THEN
            RETURN -1;
    END GetCustomerBalance;

END CustomerManagement;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== CUSTOMER MANAGEMENT PACKAGE TEST ===');
    CustomerManagement.AddCustomer(6, 'Fiona Gallagher', TO_DATE('1994-09-05', 'YYYY-MM-DD'), 3000);
    CustomerManagement.UpdateCustomer(6, 'Fiona Gallagher Pratt', 3500);
    DBMS_OUTPUT.PUT_LINE('Customer Fiona Gallagher Pratt Balance: $' || CustomerManagement.GetCustomerBalance(6));
END;
/
