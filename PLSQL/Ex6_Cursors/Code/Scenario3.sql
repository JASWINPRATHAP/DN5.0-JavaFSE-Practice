DECLARE

    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, CustomerID, LoanAmount, InterestRate
        FROM Loans
        FOR UPDATE OF InterestRate;

    v_new_rate NUMBER;
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== UPDATING LOAN INTEREST RATES ===');

    FOR r_loan IN UpdateLoanInterestRates LOOP

        IF r_loan.LoanAmount > 10000 THEN
            v_new_rate := r_loan.InterestRate - 0.5;
        ELSE
            v_new_rate := r_loan.InterestRate + 0.25;
        END IF;

        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || r_loan.LoanID ||
                             ' | Customer ID: ' || r_loan.CustomerID ||
                             ' | Amount: $' || r_loan.LoanAmount ||
                             ' | Old Rate: ' || r_loan.InterestRate || '%');

        UPDATE Loans
        SET InterestRate = v_new_rate
        WHERE CURRENT OF UpdateLoanInterestRates;

        DBMS_OUTPUT.PUT_LINE('  --> Updated Interest Rate. New Rate: ' || v_new_rate || '%');

        v_updated_count := v_updated_count + 1;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Interest rates updated for ' || v_updated_count || ' loans.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to update loan interest rates. Details: ' || SQLERRM);
END;
/
