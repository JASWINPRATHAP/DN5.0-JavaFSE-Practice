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
               "select, button { padding: 10px; font-size: 1em; border-radius: 4px; border: 1px solid #ccc; margin: 10px; }" +
               "button { background-color: #0288d1; color: white; border: none; font-weight: bold; cursor: pointer; }" +
               "button:hover { background-color: #01579b; }" +
               "</style><script>" +
               "function searchCountry() { " +
               "  var code = document.getElementById('countrySelect').value; " +
               "  window.location.href = '/countries/' + code; " +
               "}" +
               "</script></head><body>" +
               "<div class='container'>" +
               "<h1>Airlines Country Database Lookup</h1>" +
               "<p>Select a country to retrieve its ISO details dynamically:</p>" +
               "<select id='countrySelect'>" +
               "  <option value='us'>United States (US)</option>" +
               "  <option value='de'>Germany (DE)</option>" +
               "  <option value='in'>India (IN)</option>" +
               "  <option value='jp'>Japan (JP)</option>" +
               "</select>" +
               "<button onclick='searchCountry()'>Lookup Country</button>" +
               "</div>" +
               "</body></html>";
    }
}
