import java.util.Arrays;

public class Test {

    public static void main(String[] args) {

        Order[] orders = {
                new Order(101,"Arun",4500),
                new Order(102,"Bala",1200),
                new Order(103,"Charan",7800),
                new Order(104,"Divya",3100),
                new Order(105,"Esha",9800)
        };

        OrderSorter sorter = new OrderSorter();

        System.out.println("Original Orders");
        displayOrders(orders);

        Order[] bubbleSortedOrders =
                Arrays.copyOf(orders, orders.length);

        sorter.bubbleSort(bubbleSortedOrders);

        System.out.println();
        System.out.println("Orders After Bubble Sort");
        displayOrders(bubbleSortedOrders);

        Order[] quickSortedOrders =
                Arrays.copyOf(orders, orders.length);

        sorter.quickSort(quickSortedOrders,
                0, quickSortedOrders.length - 1);

        System.out.println();
        System.out.println("Orders After Quick Sort");
        displayOrders(quickSortedOrders);
    }

    private static void displayOrders(Order[] orders) {

        for(Order order : orders) {

            order.display();
        }
    }
}
