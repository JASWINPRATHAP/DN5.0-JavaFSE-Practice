DECLARE
    v_annual_fee NUMBER := 25.00;

    CURSOR ApplyAnnualFee IS
        SELECT AccountID, CustomerID, Balance
        FROM Accounts
        FOR UPDATE OF Balance;

    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== APPLYING ANNUAL MAINTENANCE FEE ===');

    FOR r_acc IN ApplyAnnualFee LOOP
        DBMS_OUTPUT.PUT_LINE('Processing Account ID: ' || r_acc.AccountID ||
                             ' | Customer ID: ' || r_acc.CustomerID ||
                             ' | Balance: $' || r_acc.Balance);

        UPDATE Accounts
        SET Balance = Balance - v_annual_fee,
            LastModified = SYSDATE
        WHERE CURRENT OF ApplyAnnualFee;

        DBMS_OUTPUT.PUT_LINE('  --> Deducted $' || v_annual_fee ||
                             '. New Balance: $' || (r_acc.Balance - v_annual_fee));

        v_updated_count := v_updated_count + 1;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Annual maintenance fee applied to ' || v_updated_count || ' accounts.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to apply annual fee. Details: ' || SQLERRM);
END;
/
