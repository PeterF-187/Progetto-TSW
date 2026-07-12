package model.Service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.http.HttpServletRequest;
import java.util.Properties;

public class EmailService {

    private final String mittente = "gameorbit.noreplay@gmail.com";
    private final String password = "irejjkodhfptqgrn";

    public void send2FAEmail(HttpServletRequest request, String destinatario, String codice)
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
        message.setSubject("Codice di verifica 2FA");

        String html = "<h2>Nuovo accesso rilevato</h2>"
                + "<p>Inserisci il seguente codice di verifica nella pagina di login per completare l'accesso:</p>"
                + "<div style=\"display: inline-block; background: #f3f4f6; color: #a855f7; padding: 15px 30px; "
                + "font-size: 24px; font-weight: bold; letter-spacing: 5px; border-radius: 8px; border: 1px solid #e5e7eb;\">"
                + codice
                + "</div>"
                + "<p style=\"color: gray; font-size: 12px; margin-top: 15px;\">Questo codice scadrà tra 10 minuti.</p>";

        message.setContent(html, "text/html; charset=UTF-8");
        Transport.send(message);
    }
}