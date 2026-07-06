import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertThrows;

public class ExceptionThrowerTest {
    @Test
    public void testThrowException() {
        ExceptionThrower exceptionThrower = new ExceptionThrower();

        assertThrows(IllegalArgumentException.class, exceptionThrower::throwException);
    }
}
