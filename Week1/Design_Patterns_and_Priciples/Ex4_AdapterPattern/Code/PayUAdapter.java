public class PayUAdapter
        implements PaymentProcessor {

    private PayUGateway payu;

    public PayUAdapter(
            PayUGateway payu) {

        this.payu = payu;

    }

    @Override
    public void processPayment(double amount) {

        payu.payAmount(amount);

    }
}