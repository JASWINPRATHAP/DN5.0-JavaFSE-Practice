public class Test {

    public static void main(String[] args) {

        Inventory inventory = new Inventory();

        inventory.addProduct(
                new Product(101,"Mouse",50,500));

        inventory.addProduct(
                new Product(102,"Keyboard",20,900));

        inventory.addProduct(
                new Product(103,"Monitor",10,12000));

        inventory.displayProducts();

        System.out.println();

        inventory.updateProduct(102,30,950);

        inventory.deleteProduct(101);

        System.out.println();

        inventory.displayProducts();

    }

}