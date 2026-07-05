public class Test {

    public static void main(String[] args) {

        StockMarket market =
                new StockMarket();

        Observer mobile =
                new MobileApp();

        Observer web =
                new WebApp();

        market.registerObserver(mobile);
        market.registerObserver(web);

        market.setStockPrice(3500);

    }
}