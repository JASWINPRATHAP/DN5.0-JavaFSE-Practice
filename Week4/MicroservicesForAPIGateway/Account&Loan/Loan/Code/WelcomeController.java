import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping(value = "/", produces = "text/html")
    public String index() {
        return "<html><head><style>" +
               "body { font-family: sans-serif; background-color: #fef3c7; color: #78350f; text-align: center; padding-top: 80px; }" +
               ".container { background: white; border-radius: 12px; padding: 40px; display: inline-block; width: 100%; max-width: 500px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); }" +
               "h1 { color: #78350f; margin-bottom: 20px; font-size: 1.8em; }" +
               "input { width: 100%; padding: 12px; margin: 10px 0; border-radius: 6px; border: 1px solid #fcd34d; box-sizing: border-box; color: #78350f; background: #fffbeb; }" +
               "button { width: 100%; padding: 12px; margin-top: 15px; background: #d97706; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; font-size: 1em; }" +
               "button:hover { background: #b45309; }" +
               ".result { margin-top: 25px; text-align: left; background: #fffbeb; padding: 20px; border-radius: 6px; border: 1px solid #fcd34d; display: none; }" +
               ".result h3 { color: #d97706; margin-top: 0; }" +
               "table { width: 100%; border-collapse: collapse; }" +
               "td { padding: 8px 0; border-bottom: 1px solid #fcd34d; }" +
               "td.label { font-weight: bold; color: #b45309; }" +
               "</style><script>" +
               "function fetchLoan() { " +
               "  var num = document.getElementById('loanNum').value; " +
               "  fetch('/loans/' + num)" +
               "    .then(res => res.json())" +
               "    .then(data => { " +
               "      document.getElementById('resNum').innerText = data.number; " +
               "      document.getElementById('resType').innerText = data.type; " +
               "      document.getElementById('resAmount').innerText = '$' + data.loan.toLocaleString(); " +
               "      document.getElementById('resEmi').innerText = '$' + data.emi.toLocaleString(); " +
               "      document.getElementById('resTenure').innerText = data.tenure + ' months'; " +
               "      document.getElementById('resultBox').style.display = 'block'; " +
               "    }); " +
               "}" +
               "</script></head><body>" +
               "<div class='container'>" +
               "<h1>Loan Microservice</h1>" +
               "<input type='text' id='loanNum' placeholder='Enter Loan Account Number' value='H00987987972342'>" +
               "<button onclick='fetchLoan()'>Query Loan Details</button>" +
               "<div id='resultBox' class='result'>" +
               "<h3>Loan Details Summary</h3>" +
               "<table>" +
               "<tr><td class='label'>Loan Account Number:</td><td id='resNum'></td></tr>" +
               "<tr><td class='label'>Loan Type:</td><td id='resType'></td></tr>" +
               "<tr><td class='label'>Principal Amount:</td><td id='resAmount'></td></tr>" +
               "<tr><td class='label'>Monthly EMI:</td><td id='resEmi'></td></tr>" +
               "<tr><td class='label'>Tenure Period:</td><td id='resTenure'></td></tr>" +
               "</table>" +
               "</div>" +
               "</div>" +
               "</body></html>";
    }
}
