public class Test {

    public static void main(String[] args) {

        PaymentProcessor cashfree =
                new CashfreeAdapter(
                        new CashfreeGateway());

        cashfree.processPayment(5000);


        PaymentProcessor payu =
                new PayUAdapter(
                        new PayUGateway());

        payu.processPayment(3000);

    }
}