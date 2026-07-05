import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class CalculatorFixtureTest {
    private Calculator calculator;

    @Before
    public void setUp() {
        calculator = new Calculator();
    }

    @After
    public void tearDown() {
        calculator = null;
        assertNull(calculator);
    }

    @Test
    public void testAddUsingAAA() {
        int first = 2;
        int second = 3;

        int result = calculator.add(first, second);

        assertEquals(5, result);
    }

    @Test
    public void testMultiplyUsingAAA() {
        int first = 4;
        int second = 3;

        int result = calculator.multiply(first, second);

        assertEquals(12, result);
    }
}
