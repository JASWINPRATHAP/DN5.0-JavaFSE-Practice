import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping(value = "/", produces = "text/html")
    public String index() {
        return "<html><head><style>" +
               "body { font-family: sans-serif; background-color: #0f172a; color: #f8fafc; text-align: center; padding-top: 50px; }" +
               ".container { background: #1e293b; border-radius: 12px; border: 1px solid #334155; padding: 40px; display: inline-block; width: 100%; max-width: 500px; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3); }" +
               "h1 { color: #38bdf8; margin-bottom: 20px; font-size: 1.8em; }" +
               "input { width: 100%; padding: 12px; margin: 10px 0; border-radius: 6px; border: 1px solid #475569; background: #0f172a; color: #f8fafc; box-sizing: border-box; }" +
               "button { width: 100%; padding: 12px; margin-top: 15px; background: #0284c7; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; font-size: 1em; }" +
               "button:hover { background: #0369a1; }" +
               ".result { margin-top: 25px; text-align: left; background: #0f172a; padding: 15px; border-radius: 6px; border: 1px solid #334155; display: none; }" +
               ".result h3 { color: #38bdf8; margin-top: 0; }" +
               ".token-text { word-break: break-all; font-family: monospace; color: #34d399; font-size: 0.9em; }" +
               "</style><script>" +
               "function generateToken() { " +
               "  var user = document.getElementById('username').value; " +
               "  var pass = document.getElementById('password').value; " +
               "  var credentials = btoa(user + ':' + pass); " +
               "  fetch('/authenticate', { headers: { 'Authorization': 'Basic ' + credentials } })" +
               "    .then(res => res.json())" +
               "    .then(data => { " +
               "      document.getElementById('tokenArea').innerText = data.token; " +
               "      document.getElementById('resultBox').style.display = 'block'; " +
               "    }); " +
               "}" +
               "</script></head><body>" +
               "<div class='container'>" +
               "<h1>JWT Authentication Portal</h1>" +
               "<input type='text' id='username' placeholder='Username' value='user'>" +
               "<input type='password' id='password' placeholder='Password' value='pwd'>" +
               "<button onclick='generateToken()'>Generate JWT Token</button>" +
               "<div id='resultBox' class='result'>" +
               "<h3>Generated Token</h3>" +
               "<div id='tokenArea' class='token-text'></div>" +
               "</div>" +
               "</div>" +
               "</body></html>";
    }
}
