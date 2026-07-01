import java.util.Arrays;
import java.util.Comparator;

public class Test {

    public static void main(String[] args) {

        Product[] products = {
                new Product(105,"Shoes","Fashion"),
                new Product(101,"Laptop","Electronics"),
                new Product(103,"Watch","Accessories"),
                new Product(104,"Headphones","Electronics"),
                new Product(102,"Book","Education")
        };

        ProductSearch search = new ProductSearch();

        System.out.println("Linear Search Result");
        Product linearResult =
                search.linearSearch(products,104);
        showResult(linearResult);

        Product[] sortedProducts =
                Arrays.copyOf(products, products.length);

        Arrays.sort(sortedProducts,
                Comparator.comparingInt(Product::getProductId));

        System.out.println();
        System.out.println("Products Sorted for Binary Search");

        for(Product product : sortedProducts) {

            product.display();
        }

        System.out.println();
        System.out.println("Binary Search Result");
        Product binaryResult =
                search.binarySearch(sortedProducts,104);
        showResult(binaryResult);
    }

    private static void showResult(Product product) {

        if(product != null) {

            product.display();
        }
        else {

            System.out.println("Product Not Found");
        }
    }
}
