public class Test {

    public static void main(String[] args) {

        Image image =
                new ProxyImage("nature.jpg");

        System.out.println(
                "Image object created");

        image.display();

        image.display();

    }
}