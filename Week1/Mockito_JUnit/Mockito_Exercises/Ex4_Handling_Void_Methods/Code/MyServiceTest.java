import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.verify;

public class MyServiceTest {
    @Test
    public void testVoidMethod() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        doNothing().when(mockApi).logMessage("Process Started");
        MyService service = new MyService(mockApi);
        service.startProcess();
        verify(mockApi).logMessage("Process Started");
    }

    interface ExternalApi {
        void logMessage(String message);
    }

    static class MyService {
        private final ExternalApi externalApi;

        MyService(ExternalApi externalApi) {
            this.externalApi = externalApi;
        }

        void startProcess() {
            externalApi.logMessage("Process Started");
        }
    }
}
