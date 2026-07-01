public class ProductSearch {

    public Product linearSearch(Product[] products,
                                int productId) {

        for(Product product : products) {

            if(product.getProductId() == productId) {

                return product;
            }
        }

        return null;
    }

    public Product binarySearch(Product[] products,
                                int productId) {

        int low = 0;
        int high = products.length - 1;

        while(low <= high) {

            int mid = (low + high) / 2;

            if(products[mid].getProductId() == productId) {

                return products[mid];
            }
            else if(products[mid].getProductId() < productId) {

                low = mid + 1;
            }
            else {

                high = mid - 1;
            }
        }

        return null;
    }
}
