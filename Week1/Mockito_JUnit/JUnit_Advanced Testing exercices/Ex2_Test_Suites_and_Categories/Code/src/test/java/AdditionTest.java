import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

@Tag("math")
public class AdditionTest {
    @Test
    public void testAddition() {
        assertEquals(5, 2 + 3);
    }
}
