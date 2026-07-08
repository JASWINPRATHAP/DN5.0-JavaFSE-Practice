CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (TransactionID, AccountID, TransactionDate, Amount, TransactionType, LogTime)
    VALUES (:NEW.TransactionID, :NEW.AccountID, :NEW.TransactionDate, :NEW.Amount, :NEW.TransactionType, SYSDATE);
END;
/

DECLARE
    v_before NUMBER;
    v_after NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TRANSACTION AUDIT LOGGER TRIGGER TEST ===');
    SELECT COUNT(*) INTO v_before FROM AuditLog;
    DBMS_OUTPUT.PUT_LINE('AuditLog records before insert: ' || v_before);
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (99, 1, SYSDATE, 450, 'Deposit');
    
    SELECT COUNT(*) INTO v_after FROM AuditLog;
    DBMS_OUTPUT.PUT_LINE('AuditLog records after insert: ' || v_after);
    
    FOR r IN (SELECT LogID, TransactionID, AccountID, Amount, TransactionType, LogTime FROM AuditLog WHERE TransactionID = 99) LOOP
        DBMS_OUTPUT.PUT_LINE('Logged Details:');
        DBMS_OUTPUT.PUT_LINE('  - Audit Log ID: ' || r.LogID);
        DBMS_OUTPUT.PUT_LINE('  - Transaction ID: ' || r.TransactionID);
        DBMS_OUTPUT.PUT_LINE('  - Account ID: ' || r.AccountID);
        DBMS_OUTPUT.PUT_LINE('  - Amount: $' || r.Amount);
        DBMS_OUTPUT.PUT_LINE('  - Type: ' || r.TransactionType);
        DBMS_OUTPUT.PUT_LINE('  - Logged Time: ' || TO_CHAR(r.LogTime, 'YYYY-MM-DD HH24:MI:SS'));
    END LOOP;
    ROLLBACK;
END;
/
