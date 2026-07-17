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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        // Recuperiamo l'utente
        Utente u = (Utente) session.getAttribute("pending2FAUser");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String codeInserito = request.getParameter("code");
        Token2FADAO dao = new Token2FADAO();

        // Cerchiamo il token associato a questo specifico utente
        Token2FA t = dao.findByUsername(u.getUsername());

        // Se il token non esiste o il codice inserito non corrisponde
        if (t == null || !t.getToken().equals(codeInserito)) {
            response.sendRedirect(request.getContextPath() + "/login?checkMail=1&codeError=1");
            return;
        }

        // Se il codice è scaduto (oltre i 10 minuti previsti)
        if (t.getScadenza().before(new java.util.Date())) {
            dao.deleteByUsername(u.getUsername());
            session.removeAttribute("pending2FAUser");
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        // Aggiornamento tabella Token con scadenza di 30 giorni
        long trentaGiorni = 30L * 24 * 60 * 60 * 1000;
        t.setScadenza(new Timestamp(System.currentTimeMillis() + trentaGiorni));
        dao.save(t); // Fa l'ON DUPLICATE KEY UPDATE impostando la nuova scadenza a 30gg

        // Pulizia della sessione temporanea e login definitivo dell'utente
        session.removeAttribute("pending2FAUser");
        session.setAttribute("username", u.getUsername());
        session.setAttribute("user", u);

        // Creazione del cookie per la sessione
        Cookie cookie = new Cookie("username", u.getUsername());
        cookie.setMaxAge(60 * 60 * 24 * 30);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        if (u.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}