DECLARE
    v_vip_threshold NUMBER := 10000;
    v_vip_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== CUSTOMER VIP PROMOTION PROCESSOR ===');

    FOR r_cust IN (SELECT CustomerID, Name, Balance, IsVIP FROM Customers) LOOP
        IF r_cust.Balance > v_vip_threshold THEN
            DBMS_OUTPUT.PUT_LINE('Promoting Customer: ' || r_cust.Name || ' (ID: ' || r_cust.CustomerID || ') | Balance: $' || r_cust.Balance || ' to VIP.');

            UPDATE Customers
            SET IsVIP = 'TRUE',
                LastModified = SYSDATE
            WHERE CustomerID = r_cust.CustomerID;

            v_vip_count := v_vip_count + 1;
        ELSE

            UPDATE Customers
            SET IsVIP = 'FALSE',
                LastModified = SYSDATE
            WHERE CustomerID = r_cust.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total customers promoted to VIP: ' || v_vip_count);
    DBMS_OUTPUT.PUT_LINE('========================================');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error during VIP promotion: ' || SQLERRM);
END;
/
