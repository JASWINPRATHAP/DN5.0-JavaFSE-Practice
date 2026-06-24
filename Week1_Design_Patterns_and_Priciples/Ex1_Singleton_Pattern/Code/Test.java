public class Test {
    public static void main(String[] args) {

        Logger logger1 = Logger.getInstance();
        logger1.logobj("Logger 1 initialized.");

        Logger logger2 = Logger.getInstance();
        logger2.logobj("Logger 2 initialized.");

        if (logger1 == logger2) {
            System.out.println("The test case passed: Both logger1 and logger2 are the same instance.");
        } else {
            System.out.println("Test case failed: logger1 and logger2 are different instances.");
        }
    }
}