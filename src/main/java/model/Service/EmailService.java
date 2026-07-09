package model.Service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.http.HttpServletRequest;
import java.util.Properties;

public class EmailService {

    private final String mittente = "gameorbit.noreplay@gmail.com";
    private final String password = "irejjkodhfptqgrn";

    // Aggiungi il parametro HttpServletRequest al metodo
    public void send2FAEmail(HttpServletRequest request, String destinatario, String token)
            throws MessagingException {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(mittente, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(mittente));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Conferma accesso account");

        /* 🔥 RE-INDIRIZZAMENTO DINAMICO CORRETTO:
           Costruisce l'URL prendendo esattamente il protocollo (http/https) e la porta corretta del tuo server locale
        */
        String schema = request.getScheme();             // http o https
        String nomeServer = request.getServerName();     // localhost
        int portaServer = request.getServerPort();       // 8080 o 8443
        String contesto = request.getContextPath();      // /Progetto_war_exploded

        String baseURLLink = schema + "://" + nomeServer + ":" + portaServer + contesto + "/verify2fa?token=" + token;

        String html = "<h2>Nuovo accesso rilevato</h2>"
                + "<p>Se sei stato tu a effettuare l'accesso, clicca sul pulsante qui sotto per confermare il dispositivo:</p>"
                + "<a href=\"" + baseURLLink + "\" style=\"display: inline-block; background: #a855f7; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; font-weight: bold;\">"
                + "SONO IO"
                + "</a>"
                + "<p style=\"color: gray; font-size: 12px; margin-top: 15px;\">Questo link scadrà tra 10 minuti.</p>";

        message.setContent(html, "text/html; charset=UTF-8");
        Transport.send(message);
    }
}