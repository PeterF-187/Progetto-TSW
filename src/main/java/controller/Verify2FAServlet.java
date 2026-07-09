package controller;

import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.Token2FADAO;
import model.DAO.UtenteDAO;
import model.Obj.Token2FA;
import model.Obj.Utente;

@WebServlet(name = "Verify2FA", value = "/verify2fa")
public class Verify2FAServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String token = request.getParameter("token");
        Token2FADAO dao = new Token2FADAO();
        Token2FA t = dao.findByToken(token);

        // Se il token non esiste o qualcuno ha alterato il link
        if (t == null) {
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        // Se l'utente ha cliccato dopo i 10 minuti di scadenza della mail
        if (t.getScadenza().before(new java.util.Date())) {
            dao.deleteByUsername(t.getUsername());
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        /* 🔥 IL MOMENTO DEL CLICK: L'utente ha confermato l'identità.
           Aggiorniamo la scadenza di questo record sul DB a 30 giorni da adesso.
           Grazie alla query ON DUPLICATE KEY UPDATE del tuo DAO, questo sovrascriverà il vecchio record.
        */
        long trentaGiorni = 30L * 24 * 60 * 60 * 1000;
        t.setScadenza(new Timestamp(System.currentTimeMillis() + trentaGiorni));

        // Salviamo l'aggiornamento sul DB
        dao.save(t);

        // Recuperiamo l'utente completo per metterlo in sessione
        UtenteDAO utenteDAO = new UtenteDAO();
        Utente u = utenteDAO.doRetrieveByUsername(t.getUsername());

        // Loggiamo l'utente creando la sessione e il cookie nella scheda del browser in cui ha cliccato
        HttpSession session = request.getSession();
        session.setAttribute("username", t.getUsername());
        session.setAttribute("user", u);

        // Generiamo anche qui il cookie persistente per mantenere l'utente loggato su questa scheda
        Cookie cookie = new Cookie("username", u.getUsername());
        cookie.setMaxAge(60 * 60 * 24 * 30);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        // Mandiamo l'utente direttamente alla home
        response.sendRedirect(request.getContextPath() + "/home");
    }
}