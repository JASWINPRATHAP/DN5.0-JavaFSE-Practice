public class Test {

    public static void main(String[] args) {

        Notifier notifier =
                new SMSNotifierDecorator(
                        new EmailNotifier());

        notifier.send(
                "Server is Down");

    }
}