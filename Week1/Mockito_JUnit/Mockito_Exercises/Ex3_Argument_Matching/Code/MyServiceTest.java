import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.mockito.Mockito.eq;
import static org.mockito.Mockito.verify;

public class MyServiceTest {
    @Test
    public void testArgumentMatching() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        MyService service = new MyService(mockApi);
        service.sendData("Test Data");
        verify(mockApi).sendData(eq("Test Data"));
    }

    interface ExternalApi {
        void sendData(String data);
    }

    static class MyService {
        private final ExternalApi externalApi;

        MyService(ExternalApi externalApi) {
            this.externalApi = externalApi;
        }

        void sendData(String data) {
            externalApi.sendData(data);
        }
    }
}
