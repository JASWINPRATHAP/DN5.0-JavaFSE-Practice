import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

public class MyServiceTest {
    @Test
    public void testMultipleReturns() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        when(mockApi.getData()).thenReturn("First Data", "Second Data");
        MyService service = new MyService(mockApi);
        assertEquals("First Data", service.fetchData());
        assertEquals("Second Data", service.fetchData());
    }

    interface ExternalApi {
        String getData();
    }

    static class MyService {
        private final ExternalApi externalApi;

        MyService(ExternalApi externalApi) {
            this.externalApi = externalApi;
        }

        String fetchData() {
            return externalApi.getData();
        }
    }
}
