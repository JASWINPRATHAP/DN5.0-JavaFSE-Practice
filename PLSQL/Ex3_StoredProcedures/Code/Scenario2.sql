CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department       VARCHAR2,
    p_bonus_percentage NUMBER
) IS
    v_updated_count NUMBER := 0;
    e_invalid_bonus EXCEPTION;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== DEPARTMENT BONUS PROCESSOR ===');

    IF p_bonus_percentage < 0 THEN
        RAISE e_invalid_bonus;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Employees in ' || p_department || ' before bonus:');
    FOR r_emp IN (SELECT EmployeeID, Name, Salary FROM Employees WHERE Department = p_department) LOOP
        DBMS_OUTPUT.PUT_LINE('  - ID: ' || r_emp.EmployeeID || ' | Name: ' || r_emp.Name || ' | Salary: $' || r_emp.Salary);
    END LOOP;

    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percentage / 100)
    WHERE Department = p_department;

    v_updated_count := SQL%ROWCOUNT;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employees in ' || p_department || ' after bonus:');
    FOR r_emp IN (SELECT EmployeeID, Name, Salary FROM Employees WHERE Department = p_department) LOOP
        DBMS_OUTPUT.PUT_LINE('  - ID: ' || r_emp.EmployeeID || ' | Name: ' || r_emp.Name || ' | New Salary: $' || ROUND(r_emp.Salary, 2));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('SUCCESS: Applied a ' || p_bonus_percentage || '% bonus to ' || v_updated_count || ' employees in ' || p_department || ' department.');

EXCEPTION
    WHEN e_invalid_bonus THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Bonus percentage cannot be negative.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to update employee bonus. Details: ' || SQLERRM);
END UpdateEmployeeBonus;
/

BEGIN
    UpdateEmployeeBonus('IT', 5);
END;
/
