package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.Token2FADAO;
import model.DAO.UtenteDAO;
import model.DAO.ImpostazioniDAO;
import model.Obj.Token2FA;
import model.Obj.Utente;
import model.Service.EmailService;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "Login", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /* Inoltro della richiesta alla pagina di autenticazione */
        request.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        /* Recupero dei parametri di autenticazione inviati dall'utente */
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        /* Inizializzazione del DAO ed estrazione dell'utente dal database */
        UtenteDAO utenteDAO = new UtenteDAO();
        Utente u = utenteDAO.doRetrieveByUsername(username);

        /* Controllo delle credenziali e verifica dell'hash della password */
        if (u == null || !BCrypt.checkpw(password, u.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        /* Verifica se l'utente ha abilitato l'autenticazione a due fattori */
        ImpostazioniDAO impostazioniDAO = new ImpostazioniDAO();
        if (!impostazioniDAO.isDueFattori(username)) {
            System.out.println("2FA disattivato. Accesso diretto per: " + username);
            creaSessione(request, response, u);

            /* Smistamento del percorso in base al ruolo amministrativo o utente base */
            if (u.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        /* Gestione e verifica dei token di sicurezza esistenti */
        Token2FADAO tokenDAO = new Token2FADAO();
        Token2FA tokenEsistente = tokenDAO.findByUsername(username);
        long adesso = System.currentTimeMillis();

        if (tokenEsistente != null) {
            /* Rimozione del token se la data di validità è scaduta */
            if (tokenEsistente.getScadenza().before(new Timestamp(adesso))) {
                tokenDAO.deleteByUsername(username);
            }
            /* Controllo della validità dell'autorizzazione a lungo termine (30 giorni) */
            else if (tokenEsistente.getScadenza().getTime() - adesso > (15 * 60 * 1000)) {
                System.out.println("Dispositivo già autorizzato (30gg). Accesso diretto per: " + username);
                creaSessione(request, response, u);

                /* Smistamento basato sul ruolo per gli accessi successivi autorizzati */
                if (u.isAdmin()) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
                return;
            }
            /* Eliminazione di una richiesta temporanea precedente rimasta in sospeso */
            else {
                tokenDAO.deleteByUsername(username);
            }
        }

        /* Nuova Logica: Generazione di un codice numerico casuale a 6 cifre */
        String codice2FA = String.format("%06d", new Random().nextInt(1000000));

        Token2FA tokenTmp = new Token2FA();
        tokenTmp.setUsername(username);
        tokenTmp.setToken(codice2FA);
        tokenTmp.setScadenza(new Timestamp(System.currentTimeMillis() + (10 * 60 * 1000))); // Scadenza 10 minuti
        tokenDAO.save(tokenTmp);

        /* Invio della mail contenente il codice per il secondo fattore */
        try {
            EmailService emailService = new EmailService();
            emailService.send2FAEmail(request, u.getEmail(), codice2FA);
        } catch (Exception e) {
            throw new RuntimeException("Errore invio email", e);
        }

        /* Salviamo l'utente temporaneamente in sessione per lo step successivo di verifica */
        request.getSession().setAttribute("pending2FAUser", u);

        /* Reindirizzamento alla pagina di login attivando il form del codice tramite checkMail=1 */
        response.sendRedirect(request.getContextPath() + "/login?checkMail=1");
    }

    private void creaSessione(HttpServletRequest request, HttpServletResponse response, Utente u) {
        /* Creazione della sessione e salvataggio degli attributi utente */
        HttpSession session = request.getSession();
        session.setAttribute("username", u.getUsername());
        session.setAttribute("user", u);

        /* Generazione e configurazione del cookie per la persistenza della sessione */
        Cookie cookie = new Cookie("username", u.getUsername());
        cookie.setMaxAge(60 * 60 * 24 * 30);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }
}