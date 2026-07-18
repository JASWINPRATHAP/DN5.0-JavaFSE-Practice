import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping(value = "/", produces = "text/html")
    public String index() {
        return "<html><head><style>" +
               "body { font-family: sans-serif; background-color: #f0f4f8; color: #1e293b; text-align: center; padding-top: 80px; }" +
               ".container { background: white; border-radius: 12px; padding: 40px; display: inline-block; width: 100%; max-width: 500px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); }" +
               "h1 { color: #0f172a; margin-bottom: 20px; font-size: 1.8em; }" +
               "input { width: 100%; padding: 12px; margin: 10px 0; border-radius: 6px; border: 1px solid #cbd5e1; box-sizing: border-box; }" +
               "button { width: 100%; padding: 12px; margin-top: 15px; background: #0284c7; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; font-size: 1em; }" +
               "button:hover { background: #0369a1; }" +
               ".result { margin-top: 25px; text-align: left; background: #f8fafc; padding: 20px; border-radius: 6px; border: 1px solid #e2e8f0; display: none; }" +
               ".result h3 { color: #0284c7; margin-top: 0; }" +
               "table { width: 100%; border-collapse: collapse; }" +
               "td { padding: 8px 0; border-bottom: 1px solid #e2e8f0; }" +
               "td.label { font-weight: bold; color: #475569; }" +
               "</style><script>" +
               "function fetchAccount() { " +
               "  var num = document.getElementById('accNum').value; " +
               "  fetch('/accounts/' + num)" +
               "    .then(res => res.json())" +
               "    .then(data => { " +
               "      document.getElementById('resNum').innerText = data.number; " +
               "      document.getElementById('resType').innerText = data.type; " +
               "      document.getElementById('resBalance').innerText = '$' + data.balance.toLocaleString(); " +
               "      document.getElementById('resultBox').style.display = 'block'; " +
               "    }); " +
               "}" +
               "</script></head><body>" +
               "<div class='container'>" +
               "<h1>Account Microservice</h1>" +
               "<input type='text' id='accNum' placeholder='Enter Account Number' value='00987987973432'>" +
               "<button onclick='fetchAccount()'>Query Account Details</button>" +
               "<div id='resultBox' class='result'>" +
               "<h3>Account Summary</h3>" +
               "<table>" +
               "<tr><td class='label'>Account Number:</td><td id='resNum'></td></tr>" +
               "<tr><td class='label'>Account Type:</td><td id='resType'></td></tr>" +
               "<tr><td class='label'>Current Balance:</td><td id='resBalance'></td></tr>" +
               "</table>" +
               "</div>" +
               "</div>" +
               "</body></html>";
    }
}
