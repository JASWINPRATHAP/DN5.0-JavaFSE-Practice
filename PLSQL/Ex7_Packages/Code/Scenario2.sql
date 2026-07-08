CREATE OR REPLACE PACKAGE EmployeeManagement IS
    PROCEDURE HireEmployee(
        p_employee_id NUMBER,
        p_name        VARCHAR2,
        p_position    VARCHAR2,
        p_salary      NUMBER,
        p_department  VARCHAR2,
        p_hiredate    DATE
    );

    PROCEDURE UpdateEmployee(
        p_employee_id NUMBER,
        p_name        VARCHAR2,
        p_position    VARCHAR2,
        p_salary      NUMBER,
        p_department  VARCHAR2
    );

    FUNCTION CalculateAnnualSalary(
        p_employee_id NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement IS

    PROCEDURE HireEmployee(
        p_employee_id NUMBER,
        p_name        VARCHAR2,
        p_position    VARCHAR2,
        p_salary      NUMBER,
        p_department  VARCHAR2,
        p_hiredate    DATE
    ) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_employee_id, p_name, p_position, p_salary, p_department, p_hiredate);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Package EmployeeManagement: Hired new employee ' || p_name || ' (ID: ' || p_employee_id || ') successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Package Error: Employee ID ' || p_employee_id || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Package Error: ' || SQLERRM);
    END HireEmployee;

    PROCEDURE UpdateEmployee(
        p_employee_id NUMBER,
        p_name        VARCHAR2,
        p_position    VARCHAR2,
        p_salary      NUMBER,
        p_department  VARCHAR2
    ) IS
    BEGIN
        UPDATE Employees
        SET Name = p_name,
            Position = p_position,
            Salary = p_salary,
            Department = p_department
        WHERE EmployeeID = p_employee_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Package Error: Employee ID ' || p_employee_id || ' not found for update.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Package EmployeeManagement: Employee ID ' || p_employee_id || ' details updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Package Error: ' || SQLERRM);
    END UpdateEmployee;

    FUNCTION CalculateAnnualSalary(
        p_employee_id NUMBER
    ) RETURN NUMBER IS
        v_salary NUMBER;
    BEGIN
        SELECT Salary INTO v_salary
        FROM Employees
        WHERE EmployeeID = p_employee_id;

        RETURN v_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN -1;
        WHEN OTHERS THEN
            RETURN -1;
    END CalculateAnnualSalary;

END EmployeeManagement;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== EMPLOYEE MANAGEMENT PACKAGE TEST ===');
    EmployeeManagement.HireEmployee(4, 'Diana Prince', 'Analyst', 5000, 'Finance', TO_DATE('2020-01-15', 'YYYY-MM-DD'));
    EmployeeManagement.UpdateEmployee(4, 'Diana Prince', 'Senior Analyst', 5500, 'Finance');
    DBMS_OUTPUT.PUT_LINE('Employee Diana Prince Annual Salary: $' || EmployeeManagement.CalculateAnnualSalary(4));
END;
/
