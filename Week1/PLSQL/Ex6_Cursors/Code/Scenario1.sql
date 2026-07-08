DECLARE

    CURSOR GenerateMonthlyStatements IS
        SELECT c.CustomerID,
               c.Name AS CustomerName,
               a.AccountID,
               t.TransactionID,
               t.TransactionDate,
               t.Amount,
               t.TransactionType
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE)
        ORDER BY c.CustomerID, t.TransactionDate;

    v_current_customer Customers.CustomerID%TYPE := -1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== MONTHLY TRANSACTION STATEMENTS ===');

    FOR r_tx IN GenerateMonthlyStatements LOOP

        IF r_tx.CustomerID <> v_current_customer THEN
            IF v_current_customer <> -1 THEN
                DBMS_OUTPUT.PUT_LINE('--------------------------------------');
            END IF;
            DBMS_OUTPUT.PUT_LINE('Customer: ' || r_tx.CustomerName || ' (ID: ' || r_tx.CustomerID || ')');
            v_current_customer := r_tx.CustomerID;
        END IF;

        DBMS_OUTPUT.PUT_LINE('  Tx ID: ' || r_tx.TransactionID ||
                             ' | Acc ID: ' || r_tx.AccountID ||
                             ' | Date: ' || TO_CHAR(r_tx.TransactionDate, 'YYYY-MM-DD') ||
                             ' | Type: ' || RPAD(r_tx.TransactionType, 10, ' ') ||
                             ' | Amount: $' || r_tx.Amount);
    END LOOP;

    IF v_current_customer <> -1 THEN
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No transactions found for the current month.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('======================================');
END;
/
