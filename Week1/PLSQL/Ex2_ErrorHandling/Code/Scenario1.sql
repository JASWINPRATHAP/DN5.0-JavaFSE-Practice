CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account NUMBER,
    p_to_account   NUMBER,
    p_amount       NUMBER
) IS
    v_from_balance NUMBER;
    v_to_balance   NUMBER;
    e_insufficient_funds EXCEPTION;
    e_invalid_amount EXCEPTION;
BEGIN

    IF p_amount <= 0 THEN
        RAISE e_invalid_amount;
    END IF;

    BEGIN
        SELECT Balance INTO v_from_balance FROM Accounts WHERE AccountID = p_from_account;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Source Account ' || p_from_account || ' does not exist.');
    END;

    BEGIN
        SELECT Balance INTO v_to_balance FROM Accounts WHERE AccountID = p_to_account;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'Destination Account ' || p_to_account || ' does not exist.');
    END;

    IF v_from_balance < p_amount THEN
        RAISE e_insufficient_funds;
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount, LastModified = SYSDATE
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount, LastModified = SYSDATE
    WHERE AccountID = p_to_account;

    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (
        (SELECT NVL(MAX(TransactionID), 0) + 1 FROM Transactions),
        p_from_account,
        SYSDATE,
        p_amount,
        'Withdrawal'
    );

    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (
        (SELECT NVL(MAX(TransactionID), 0) + 1 FROM Transactions),
        p_to_account,
        SYSDATE,
        p_amount,
        'Deposit'
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Transferred $' || p_amount || ' from Account ' || p_from_account || ' to Account ' || p_to_account);

EXCEPTION
    WHEN e_insufficient_funds THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed due to insufficient funds in Account ' || p_from_account || '.');
    WHEN e_invalid_amount THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed. Amount must be positive.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed. Details: ' || SQLERRM);
END SafeTransferFunds;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== SAFE TRANSFER FUNDS TEST ===');
    DBMS_OUTPUT.PUT_LINE('--- Test Case 1: Valid Transfer ---');
    SafeTransferFunds(1, 2, 100);
    
    DBMS_OUTPUT.PUT_LINE('--- Test Case 2: Insufficient Balance ---');
    SafeTransferFunds(1, 2, 100000);
    
    DBMS_OUTPUT.PUT_LINE('--- Test Case 3: Invalid Amount ---');
    SafeTransferFunds(1, 2, -50);
END;
/
