package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.*;
import model.Obj.Utente;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/impostazioni")
public class ImpostazioniServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        String username = (String) session.getAttribute("username");
        String action = request.getParameter("action");

        UtenteDAO utenteDAO = new UtenteDAO();
        ImpostazioniDAO impostazioniDAO = new ImpostazioniDAO();

        /*
         * CAMBIO PASSWORD
         */
        if ("cambioPassword".equals(action)) {

            Utente u = utenteDAO.doRetrieveByUsername(username);

            String vecchia = request.getParameter("oldPassword");
            String nuova = request.getParameter("newPassword");
            String conferma = request.getParameter("confirmPassword");

            if (!BCrypt.checkpw(vecchia, u.getPassword())) {
                response.sendRedirect(
                        request.getContextPath() + "/dashboard?status=wrong_pass"
                );
                return;
            }

            if (!nuova.equals(conferma)) {
                response.sendRedirect(
                        request.getContextPath() + "/dashboard?status=no_match"
                );
                return;
            }

            String hash = BCrypt.hashpw(
                    nuova,
                    BCrypt.gensalt()
            );

            utenteDAO.doUpdate(username, hash);

            response.sendRedirect(
                    request.getContextPath() + "/dashboard?status=success"
            );
            return;
        }

        /*
         * 2FA
         */
        if ("toggle2FA".equals(action)) {

            boolean stato = Boolean.parseBoolean(
                    request.getParameter("stato2FA")
            );

            impostazioniDAO.setDueFattori(
                    username,
                    stato
            );

            response.sendRedirect(
                    request.getContextPath() + "/dashboard?status=success"
            );
        }
    }
}