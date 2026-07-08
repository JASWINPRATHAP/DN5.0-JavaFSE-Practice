CREATE OR REPLACE FUNCTION CalculateAge(
    p_dob DATE
) RETURN NUMBER IS
    v_age NUMBER;
BEGIN
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END CalculateAge;
/

DECLARE
    v_dob DATE := TO_DATE('1990-07-20', 'YYYY-MM-DD');
    v_age NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== AGE CALCULATOR FUNCTION ===');
    v_age := CalculateAge(v_dob);
    DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || TO_CHAR(v_dob, 'YYYY-MM-DD') || ' | Calculated Age: ' || v_age || ' years');
END;
/
