public class FinancialForecast {

    public double calculateFutureValue(double currentValue,
                                       double growthRate,
                                       int years) {

        if(years == 0) {

            return currentValue;
        }

        return calculateFutureValue(
                currentValue * (1 + growthRate),
                growthRate,
                years - 1);
    }

    public double calculateFutureValueOptimized(double currentValue,
                                                double growthRate,
                                                int years) {

        return currentValue
                * Math.pow(1 + growthRate, years);
    }
}
