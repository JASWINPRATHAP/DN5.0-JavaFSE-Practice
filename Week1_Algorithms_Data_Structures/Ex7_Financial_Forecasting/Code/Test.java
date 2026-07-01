public class Test {

    public static void main(String[] args) {

        FinancialForecast forecast =
                new FinancialForecast();

        double currentValue = 10000;
        double growthRate = 0.08;
        int years = 5;

        double futureValue =
                forecast.calculateFutureValue(
                        currentValue, growthRate, years);

        double optimizedValue =
                forecast.calculateFutureValueOptimized(
                        currentValue, growthRate, years);

        System.out.println("Current Value: " + currentValue);
        System.out.println("Growth Rate: " + growthRate);
        System.out.println("Years: " + years);
        System.out.println("Future Value Using Recursion: "
                + futureValue);
        System.out.println("Future Value Using Optimized Method: "
                + optimizedValue);
    }
}
