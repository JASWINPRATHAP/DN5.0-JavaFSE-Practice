CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== MONTHLY INTEREST PROCESSOR ===');

    DBMS_OUTPUT.PUT_LINE('Current Savings Accounts:');
    FOR r_acc IN (SELECT AccountID, Balance FROM Accounts WHERE AccountType = 'Savings') LOOP
        DBMS_OUTPUT.PUT_LINE('  - Account ID: ' || r_acc.AccountID || ' | Balance: $' || r_acc.Balance);
    END LOOP;

    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    v_updated_count := SQL%ROWCOUNT;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Interest Applied. New Balances:');
    FOR r_acc IN (SELECT AccountID, Balance FROM Accounts WHERE AccountType = 'Savings') LOOP
        DBMS_OUTPUT.PUT_LINE('  - Account ID: ' || r_acc.AccountID || ' | New Balance: $' || ROUND(r_acc.Balance, 2));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('SUCCESS: Processed monthly interest for ' || v_updated_count || ' savings accounts.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to process monthly interest. Details: ' || SQLERRM);
END ProcessMonthlyInterest;
/

BEGIN
    ProcessMonthlyInterest;
END;
/
