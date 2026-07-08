import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.verify;

public class MyServiceTest {
    @Test
    public void testVoidMethodThrowsException() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        doThrow(new RuntimeException("API error")).when(mockApi).saveData("Bad Data");
        MyService service = new MyService(mockApi);
        RuntimeException exception = assertThrows(RuntimeException.class, () -> service.saveData("Bad Data"));
        assertEquals("API error", exception.getMessage());
        verify(mockApi).saveData("Bad Data");
    }

    interface ExternalApi {
        void saveData(String data);
    }

    static class MyService {
        private final ExternalApi externalApi;

        MyService(ExternalApi externalApi) {
            this.externalApi = externalApi;
        }

        void saveData(String data) {
            externalApi.saveData(data);
        }
    }
}
