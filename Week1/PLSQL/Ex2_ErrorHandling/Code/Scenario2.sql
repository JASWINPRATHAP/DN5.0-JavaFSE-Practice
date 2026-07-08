CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id NUMBER,
    p_percentage  NUMBER
) IS
    v_name VARCHAR2(100);
    v_old_salary NUMBER;
    v_new_salary NUMBER;
    e_invalid_percentage EXCEPTION;
BEGIN

    IF p_percentage < -100 THEN
        RAISE e_invalid_percentage;
    END IF;

    SELECT Name, Salary INTO v_name, v_old_salary
    FROM Employees
    WHERE EmployeeID = p_employee_id;

    UPDATE Employees
    SET Salary = Salary * (1 + p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    v_new_salary := v_old_salary * (1 + p_percentage / 100);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Updated salary for ' || v_name || ' (ID: ' || p_employee_id ||
                         '). Old Salary: $' || v_old_salary || ' | New Salary: $' || ROUND(v_new_salary, 2));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_employee_id || ' does not exist.');
    WHEN e_invalid_percentage THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid salary change percentage: ' || p_percentage || '%.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Salary update failed. Details: ' || SQLERRM);
END UpdateSalary;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test Case 1: Successful Salary Update ---');
    UpdateSalary(1, 10);
    
    DBMS_OUTPUT.PUT_LINE('--- Test Case 2: Employee Does Not Exist ---');
    UpdateSalary(999, 10);
END;
/
