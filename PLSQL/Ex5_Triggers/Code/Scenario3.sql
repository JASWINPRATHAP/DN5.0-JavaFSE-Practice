CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_balance NUMBER;
BEGIN

    IF :NEW.TransactionType = 'Deposit' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
        END IF;

    ELSIF :NEW.TransactionType = 'Withdrawal' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Withdrawal amount must be positive.');
        END IF;

        SELECT Balance INTO v_balance
        FROM Accounts
        WHERE AccountID = :NEW.AccountID;

        IF :NEW.Amount > v_balance THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds. Account balance is $' || v_balance || ', trying to withdraw $' || :NEW.Amount);
        END IF;
    END IF;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TRANSACTION RULES TRIGGER TEST ===');
    DBMS_OUTPUT.PUT_LINE('--- Test Case 1: Negative Deposit ---');
    BEGIN
        INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
        VALUES (98, 1, SYSDATE, -100, 'Deposit');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('--- Test Case 2: Withdrawal Exceeding Balance ---');
    BEGIN
        INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
        VALUES (98, 1, SYSDATE, 50000, 'Withdrawal');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;
END;
/
