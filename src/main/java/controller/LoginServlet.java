package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;
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

    // 🟢 AGGIUNTO: Risolve l'errore 405 permettendo l'accesso in GET alla pagina
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Reindirizza la richiesta alla pagina JSP del login
        // NOTA: Se auth.jsp si trova in una cartella specifica (es. /WEB-INF/views/auth.jsp),
        // aggiorna il percorso qui sotto. Se è nella root (webapp), "/auth.jsp" va bene.
        request.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(request, response);
    }

    // 🔴 LA TUA LOGICA DI LOGIN ESISTENTE
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UtenteDAO utenteDAO = new UtenteDAO();
        Utente u = utenteDAO.doRetrieveByUsername(username);

        // 1. CONTROLLO CREDENZIALI
        if (u == null || !BCrypt.checkpw(password, u.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        // 2. CONTROLLO SE L'UTENTE VUOLE IL 2FA
        ImpostazioniDAO impostazioniDAO = new ImpostazioniDAO();
        if (!impostazioniDAO.isDueFattori(username)) {
            // Accesso diretto se il 2FA è disattivato
            System.out.println("2FA disattivato. Accesso diretto per: " + username);
            creaSessione(request, response, u);
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // 3. SE IL 2FA È ATTIVO: Verifichiamo i token
        Token2FADAO tokenDAO = new Token2FADAO();
        Token2FA tokenEsistente = tokenDAO.findByUsername(username);
        long adesso = System.currentTimeMillis();

        if (tokenEsistente != null) {
            // Se scaduto, lo cancelliamo
            if (tokenEsistente.getScadenza().before(new Timestamp(adesso))) {
                tokenDAO.deleteByUsername(username);
            }
            // Verifica autorizzazione precedente da 30 giorni
            else if (tokenEsistente.getScadenza().getTime() - adesso > (15 * 60 * 1000)) {
                System.out.println("Dispositivo già autorizzato (30gg). Accesso diretto per: " + username);
                creaSessione(request, response, u);
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            // Richiesta temporanea pendente, la puliamo per crearne una nuova
            else {
                tokenDAO.deleteByUsername(username);
            }
        }

        // 4. GENERAZIONE NUOVA RICHIESTA TEMPORANEA (10 minuti)
        String tokenRichiesta = UUID.randomUUID().toString();
        Token2FA tokenTmp = new Token2FA();
        tokenTmp.setUsername(username);
        tokenTmp.setToken(tokenRichiesta);
        tokenTmp.setScadenza(new Timestamp(System.currentTimeMillis() + (10 * 60 * 1000)));
        tokenDAO.save(tokenTmp);

        // 5. INVIO EMAIL
        try {
            EmailService emailService = new EmailService();
            emailService.send2FAEmail(request, u.getEmail(), tokenRichiesta);
        } catch (Exception e) {
            throw new RuntimeException("Errore invio email", e);
        }

        // Rimanda alla pagina login con il feedback "Controlla la mail"
        response.sendRedirect(request.getContextPath() + "/login?checkMail=1");
    }

    // Metodo di supporto per la creazione della sessione
    private void creaSessione(HttpServletRequest request, HttpServletResponse response, Utente u) {
        HttpSession session = request.getSession();
        session.setAttribute("username", u.getUsername());
        session.setAttribute("user", u);

        Cookie cookie = new Cookie("username", u.getUsername());
        cookie.setMaxAge(60 * 60 * 24 * 30); // 30 giorni
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }
}