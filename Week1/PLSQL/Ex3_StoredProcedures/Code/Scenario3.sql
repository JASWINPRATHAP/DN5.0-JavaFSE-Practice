CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account NUMBER,
    p_to_account   NUMBER,
    p_amount       NUMBER
) IS
    v_from_balance NUMBER;
    v_to_exist NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ACCOUNT-TO-ACCOUNT FUND TRANSFER ===');

    SELECT Balance INTO v_from_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    SELECT COUNT(*) INTO v_to_exist FROM Accounts WHERE AccountID = p_to_account;
    IF v_to_exist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Destination Account ID ' || p_to_account || ' does not exist.');
        RETURN;
    END IF;

    IF v_from_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('ABORTED: Insufficient balance in Account ' || p_from_account || '. Available balance: $' || v_from_balance);
        RETURN;
    END IF;

    UPDATE Accounts SET Balance = Balance - p_amount, LastModified = SYSDATE WHERE AccountID = p_from_account;
    UPDATE Accounts SET Balance = Balance + p_amount, LastModified = SYSDATE WHERE AccountID = p_to_account;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Transferred $' || p_amount || ' from Account ' || p_from_account || ' to Account ' || p_to_account);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Source Account ID ' || p_from_account || ' does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed. Details: ' || SQLERRM);
END TransferFunds;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test Case 1: Valid Transfer ---');
    TransferFunds(3, 1, 500);
    
    DBMS_OUTPUT.PUT_LINE('--- Test Case 2: Insufficient Balance ---');
    TransferFunds(1, 2, 100000);
END;
/
