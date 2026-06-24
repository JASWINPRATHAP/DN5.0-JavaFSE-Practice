public class CashfreeAdapter
        implements PaymentProcessor {

    private CashfreeGateway cashfree;

    public CashfreeAdapter(
            CashfreeGateway cashfree) {

        this.cashfree = cashfree;

    }

    @Override
    public void processPayment(double amount) {

        cashfree.makePayment(amount);

    }
}