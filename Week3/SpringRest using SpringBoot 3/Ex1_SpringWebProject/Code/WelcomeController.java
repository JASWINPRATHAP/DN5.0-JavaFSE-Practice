import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping(value = "/", produces = "text/html")
    public String welcome() {
        return "<html><head><style>" +
               "body { font-family: sans-serif; background-color: #f7f9fa; color: #3es4; text-align: center; padding-top: 100px; }" +
               ".container { background: white; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 40px; display: inline-block; max-width: 600px; }" +
               "h1 { color: #0288d1; margin-bottom: 20px; }" +
               "p { font-size: 1.1em; color: #555; }" +
               "</style></head><body>" +
               "<div class='container'>" +
               "<h1>Welcome to Spring Learn!</h1>" +
               "<p>Your 1st Spring Boot Web App started successfully.</p>" +
               "</div>" +
               "</body></html>";
    }
}
