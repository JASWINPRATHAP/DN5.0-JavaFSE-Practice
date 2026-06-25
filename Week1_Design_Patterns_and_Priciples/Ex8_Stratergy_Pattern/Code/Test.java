public class Test {

    public static void main(String[] args) {

        PaymentContext payment =
                new PaymentContext(
                        new CreditCardPayment());

        payment.makePayment(5000);


        payment =
                new PaymentContext(
                        new PayPalPayment());

        payment.makePayment(3000);

    }
}