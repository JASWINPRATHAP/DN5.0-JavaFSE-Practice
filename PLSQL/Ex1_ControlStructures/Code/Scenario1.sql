DECLARE
    v_age NUMBER;
    v_discount_rate NUMBER := 1;
    v_loans_updated NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== LOAN INTEREST DISCOUNT PROCESSOR ===');

    FOR r_cust IN (SELECT CustomerID, Name, DOB FROM Customers) LOOP

        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, r_cust.DOB) / 12);

        IF v_age > 60 THEN
            DBMS_OUTPUT.PUT_LINE('Processing senior customer: ' || r_cust.Name || ' (ID: ' || r_cust.CustomerID || ', Age: ' || v_age || ')');

            FOR r_loan IN (SELECT LoanID, InterestRate FROM Loans WHERE CustomerID = r_cust.CustomerID) LOOP
                DBMS_OUTPUT.PUT_LINE('  - Loan ID: ' || r_loan.LoanID || ' | Current Rate: ' || r_loan.InterestRate || '%');

                UPDATE Loans
                SET InterestRate = InterestRate - v_discount_rate
                WHERE LoanID = r_loan.LoanID;

                v_loans_updated := v_loans_updated + 1;
                DBMS_OUTPUT.PUT_LINE('    --> Applied 1% discount. New Rate: ' || (r_loan.InterestRate - v_discount_rate) || '%');
            END LOOP;
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total loans updated: ' || v_loans_updated);
    DBMS_OUTPUT.PUT_LINE('========================================');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error during update: ' || SQLERRM);
END;
/
