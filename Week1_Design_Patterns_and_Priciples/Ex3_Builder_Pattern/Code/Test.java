public class Test {

    public static void main(String[] args) {

        Computer gamingcomp =
            new Computer.Builder()
                .setCPU("Intel i9")
                .setRAM(32)
                .setStorage(1000)
                .build();

        Computer Professional =
            new Computer.Builder()
                .setCPU("Intel i5")
                .setRAM(8)
                .setStorage(256)
                .build();


        gamingcomp.display();

        System.out.println();

        Professional.display();
    }
}