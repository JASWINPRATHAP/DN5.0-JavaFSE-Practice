import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping(value = "/", produces = "text/html")
    public String index() {
        return "<html><head><style>" +
               "body { font-family: sans-serif; background-color: #f7f9fa; color: #333; text-align: center; padding-top: 100px; }" +
               ".container { background: white; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 40px; display: inline-block; max-width: 600px; }" +
               "h1 { color: #0288d1; margin-bottom: 20px; }" +
               "p { font-size: 1.1em; color: #555; }" +
               "a { display: inline-block; background-color: #0288d1; color: white; padding: 10px 20px; border-radius: 4px; text-decoration: none; font-weight: bold; margin-top: 20px; }" +
               "a:hover { background-color: #01579b; }" +
               "</style></head><body>" +
               "<div class='container'>" +
               "<h1>REST Country Service Dashboard</h1>" +
               "<p>Click the link below to access the REST Country service:</p>" +
               "<a href='/country'>Get Country India JSON Response</a>" +
               "</div>" +
               "</body></html>";
    }
}
