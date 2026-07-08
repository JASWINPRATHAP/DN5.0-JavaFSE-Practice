CREATE OR REPLACE PACKAGE AccountOperations IS
    PROCEDURE OpenAccount(
        p_account_id   NUMBER,
        p_customer_id  NUMBER,
        p_account_type VARCHAR2,
        p_balance      NUMBER
    );

    PROCEDURE CloseAccount(
        p_account_id   NUMBER
    );

    FUNCTION GetTotalBalance(
        p_customer_id  NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations IS

    PROCEDURE OpenAccount(
        p_account_id   NUMBER,
        p_customer_id  NUMBER,
        p_account_type VARCHAR2,
        p_balance      NUMBER
    ) IS
    BEGIN
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_account_id, p_customer_id, p_account_type, p_balance, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Package AccountOperations: Account ID ' || p_account_id ||
                             ' (' || p_account_type || ') opened successfully for Customer ID ' || p_customer_id || '.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Package Error: Account ID ' || p_account_id || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Package Error: ' || SQLERRM);
    END OpenAccount;

    PROCEDURE CloseAccount(
        p_account_id   NUMBER
    ) IS
    BEGIN
        DELETE FROM Accounts WHERE AccountID = p_account_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Package Error: Account ID ' || p_account_id || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Package AccountOperations: Account ID ' || p_account_id || ' closed successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Package Error: ' || SQLERRM);
    END CloseAccount;

    FUNCTION GetTotalBalance(
        p_customer_id  NUMBER
    ) RETURN NUMBER IS
        v_total_balance NUMBER := 0;
        v_cust_exists NUMBER;
    BEGIN

        SELECT COUNT(*) INTO v_cust_exists FROM Customers WHERE CustomerID = p_customer_id;
        IF v_cust_exists = 0 THEN
            RETURN -1;
        END IF;

        SELECT SUM(Balance) INTO v_total_balance
        FROM Accounts
        WHERE CustomerID = p_customer_id;

        RETURN NVL(v_total_balance, 0);
    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;
    END GetTotalBalance;

END AccountOperations;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ACCOUNT OPERATIONS PACKAGE TEST ===');
    AccountOperations.OpenAccount(5, 1, 'Savings', 1000);
    AccountOperations.OpenAccount(6, 1, 'Checking', 1200);
    DBMS_OUTPUT.PUT_LINE('Customer ID 1 Total Balance across all accounts: $' || AccountOperations.GetTotalBalance(1));
    AccountOperations.CloseAccount(6);
    DBMS_OUTPUT.PUT_LINE('Customer ID 1 Total Balance after Account 6 closure: $' || AccountOperations.GetTotalBalance(1));
END;
/
