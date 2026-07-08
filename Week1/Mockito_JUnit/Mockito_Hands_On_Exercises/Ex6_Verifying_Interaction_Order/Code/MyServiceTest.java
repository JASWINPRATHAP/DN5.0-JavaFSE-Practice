import org.junit.jupiter.api.Test;
import org.mockito.InOrder;
import org.mockito.Mockito;

import static org.mockito.Mockito.inOrder;
import static org.mockito.Mockito.when;

public class MyServiceTest {
    @Test
    public void testInteractionOrder() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        when(mockApi.getData()).thenReturn("Mock Data");
        MyService service = new MyService(mockApi);
        service.fetchData();
        InOrder inOrder = inOrder(mockApi);
        inOrder.verify(mockApi).connect();
        inOrder.verify(mockApi).getData();
        inOrder.verify(mockApi).disconnect();
    }

    interface ExternalApi {
        void connect();

        String getData();

        void disconnect();
    }

    static class MyService {
        private final ExternalApi externalApi;

        MyService(ExternalApi externalApi) {
            this.externalApi = externalApi;
        }

        String fetchData() {
            externalApi.connect();
            String data = externalApi.getData();
            externalApi.disconnect();
            return data;
        }
    }
}
