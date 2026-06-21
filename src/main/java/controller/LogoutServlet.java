package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "Logout", value = "/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }


        Cookie cookie = new Cookie("username", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        cookie.setSecure(true);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        // Torna alla home
        response.sendRedirect(request.getContextPath() + "/home");
    }
}