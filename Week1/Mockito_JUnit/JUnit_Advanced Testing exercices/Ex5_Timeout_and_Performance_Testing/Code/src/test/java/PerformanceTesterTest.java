import org.junit.jupiter.api.Test;

import java.time.Duration;

import static org.junit.jupiter.api.Assertions.assertTimeout;

public class PerformanceTesterTest {
    @Test
    public void testPerformTaskTimeout() {
        PerformanceTester performanceTester = new PerformanceTester();

        assertTimeout(Duration.ofMillis(500), performanceTester::performTask);
    }
}
