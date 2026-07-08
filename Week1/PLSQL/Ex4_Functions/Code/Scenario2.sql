CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount      NUMBER,
    p_interest_rate    NUMBER,
    p_duration_years   NUMBER
) RETURN NUMBER IS
    v_monthly_rate     NUMBER;
    v_total_months     NUMBER;
    v_monthly_payment  NUMBER;
BEGIN

    v_monthly_rate := p_interest_rate / 12 / 100;

    v_total_months := p_duration_years * 12;

    IF v_monthly_rate = 0 THEN
        v_monthly_payment := p_loan_amount / v_total_months;
    ELSE

        v_monthly_payment := (p_loan_amount * v_monthly_rate * POWER(1 + v_monthly_rate, v_total_months)) /
                             (POWER(1 + v_monthly_rate, v_total_months) - 1);
    END IF;

    RETURN ROUND(v_monthly_payment, 2);
END CalculateMonthlyInstallment;
/

DECLARE
    v_emi NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== LOAN EMI CALCULATOR ===');
    v_emi := CalculateMonthlyInstallment(5000, 5, 5);
    DBMS_OUTPUT.PUT_LINE('Principal Loan Amount: $5000');
    DBMS_OUTPUT.PUT_LINE('Annual Interest Rate: 5%');
    DBMS_OUTPUT.PUT_LINE('Loan Duration: 5 years (60 months)');
    DBMS_OUTPUT.PUT_LINE('Calculated Monthly Installment (EMI): $' || ROUND(v_emi, 2));
END;
/
