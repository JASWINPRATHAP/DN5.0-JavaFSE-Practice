public class OrderSorter {

    public void bubbleSort(Order[] orders) {

        for(int i = 0; i < orders.length - 1; i++) {

            boolean swapped = false;

            for(int j = 0; j < orders.length - i - 1; j++) {

                if(orders[j].getTotalPrice()
                        < orders[j + 1].getTotalPrice()) {

                    swap(orders, j, j + 1);
                    swapped = true;
                }
            }

            if(!swapped) {

                break;
            }
        }
    }

    public void quickSort(Order[] orders,
                          int low,
                          int high) {

        if(low < high) {

            int pivotIndex = partition(orders, low, high);

            quickSort(orders, low, pivotIndex - 1);
            quickSort(orders, pivotIndex + 1, high);
        }
    }

    private int partition(Order[] orders,
                          int low,
                          int high) {

        double pivot = orders[high].getTotalPrice();
        int i = low - 1;

        for(int j = low; j < high; j++) {

            if(orders[j].getTotalPrice() >= pivot) {

                i++;
                swap(orders, i, j);
            }
        }

        swap(orders, i + 1, high);

        return i + 1;
    }

    private void swap(Order[] orders,
                      int first,
                      int second) {

        Order temp = orders[first];
        orders[first] = orders[second];
        orders[second] = temp;
    }
}
