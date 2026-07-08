CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_account_id NUMBER,
    p_amount     NUMBER
) RETURN BOOLEAN IS
    v_balance NUMBER;
BEGIN

    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN

        RETURN FALSE;
    WHEN OTHERS THEN
        RETURN FALSE;
END HasSufficientBalance;
/

DECLARE
    v_res BOOLEAN;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== SUFFICIENT BALANCE CHECKER ===');
    DBMS_OUTPUT.PUT_LINE('Account ID: 1 | Checking Amount: $500');
    v_res := HasSufficientBalance(1, 500);
    IF v_res THEN
        DBMS_OUTPUT.PUT_LINE('Result: TRUE (Account has sufficient balance)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Result: FALSE (Account has insufficient balance)');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Account ID: 1 | Checking Amount: $10000');
    v_res := HasSufficientBalance(1, 10000);
    IF v_res THEN
        DBMS_OUTPUT.PUT_LINE('Result: TRUE (Account has sufficient balance)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Result: FALSE (Account has insufficient balance)');
    END IF;
END;
/
