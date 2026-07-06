import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import static org.junit.jupiter.api.Assertions.assertEquals;

@TestMethodOrder(OrderAnnotation.class)
public class OrderedTests {
    private static String result = "";

    @Test
    @Order(1)
    public void firstTest() {
        result += "A";
        assertEquals("A", result);
    }

    @Test
    @Order(2)
    public void secondTest() {
        result += "B";
        assertEquals("AB", result);
    }

    @Test
    @Order(3)
    public void thirdTest() {
        result += "C";
        assertEquals("ABC", result);
    }
}
