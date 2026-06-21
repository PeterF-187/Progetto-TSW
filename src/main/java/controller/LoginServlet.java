package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.UtenteDAO;
import model.Obj.Utente;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "Login", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/auth.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UtenteDAO dao = new UtenteDAO();

        // 🔥 ORA SOLO USERNAME
        Utente u = dao.doRetrieveByUsername(username);

        // ❌ utente non trovato
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        // 🔐 controllo password con BCrypt
        if (!BCrypt.checkpw(password, u.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/login?loginError=1");
            return;
        }

        // ✔ login OK
        HttpSession session = request.getSession();
        session.setAttribute("username", u.getUsername());
        session.setAttribute("user", u);

        Cookie cookie = new Cookie("username", u.getUsername());
        cookie.setMaxAge(60 * 60 * 24 * 30);
        cookie.setPath("/");
        cookie.setSecure(true);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        response.sendRedirect(request.getContextPath() + "/home");
    }
}