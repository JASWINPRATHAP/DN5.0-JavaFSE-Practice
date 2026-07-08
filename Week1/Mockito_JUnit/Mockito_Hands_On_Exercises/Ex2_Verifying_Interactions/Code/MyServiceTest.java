import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.mockito.Mockito.verify;

public class MyServiceTest {
    @Test
    public void testVerifyInteraction() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        MyService service = new MyService(mockApi);
        service.fetchData();
        verify(mockApi).getData();
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
