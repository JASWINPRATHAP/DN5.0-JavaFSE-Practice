import java.util.HashMap;

public class Inventory {

    HashMap<Integer, Product> products =
            new HashMap<>();

    public void addProduct(Product product) {

        products.put(product.getProductId(), product);

        System.out.println("Product Added");
    }

    public void updateProduct(int id,
                              int quantity,
                              double price) {

        Product product = products.get(id);

        if(product != null){

            product.setQuantity(quantity);
            product.setPrice(price);

            System.out.println("Product Updated");
        }

        else{

            System.out.println("Product Not Found");
        }

    }

    public void deleteProduct(int id){

        products.remove(id);

        System.out.println("Product Deleted");
    }

    public void displayProducts(){

        for(Product product : products.values()){

            product.display();
        }
    }

}