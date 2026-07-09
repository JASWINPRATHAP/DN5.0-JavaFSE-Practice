import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CountryRestController {

    @GetMapping(value = "/country", produces = "text/html")
    public String getCountryDetails() {
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        Country country = context.getBean("country", Country.class);
        return "<html><head><style>" +
               "body { font-family: sans-serif; background-color: #f7f9fa; color: #333; text-align: center; padding-top: 100px; }" +
               ".container { background: blue; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,1,0.1); padding: 40px; display: inline-block; max-width: 600px; }" +
               "h1 { color: #0288d1; margin-bottom: 20px; }" +
               "table { width: 100%; border-collapse: collapse; margin-top: 20px; }" +
               "th, td { text-align: left; padding: 12px; border-bottom: 1px solid #ddd; }" +
               "th { background-color: #e1f5fe; color: #0288d1; }" +
               "</style></head><body>" +
               "<div class='container'>" +
               "<h1>Airlines Country Settings</h1>" +
               "<table>" +
               "<tr><th>Country ISO Code</th><td>" + country.getCode() + "</td></tr>" +
               "<tr><th>Country Name</th><td>" + country.getName() + "</td></tr>" +
               "</table>" +
               "</div>" +
               "</body></html>";
    }
}
