DECLARE
    v_reminder_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== LOAN DUE DATE REMINDER SERVICE ===');

    FOR r_loan IN (
        SELECT l.LoanID, l.LoanAmount, l.EndDate, c.Name, c.CustomerID
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('REMINDER: Dear ' || r_loan.Name || ' (ID: ' || r_loan.CustomerID || '), ' ||
                             'your loan (ID: ' || r_loan.LoanID || ') of amount $' || r_loan.LoanAmount ||
                             ' is due on ' || TO_CHAR(r_loan.EndDate, 'YYYY-MM-DD') ||
                             '. Please ensure payment is processed on time.');
        v_reminder_count := v_reminder_count + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total reminders sent: ' || v_reminder_count);
    DBMS_OUTPUT.PUT_LINE('======================================');
END;
/
