import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

@Tag("text")
public class TextTest {
    @Test
    public void testTextContainsValue() {
        assertTrue("JUnit Testing".contains("Testing"));
    }
}
