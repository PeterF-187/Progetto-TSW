package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet({
        "/ChiSiamo",
        "/Contattaci",
        "/affil",
        "/Howto", // Modificato qui
        "/FAQ",
        "/PReso"
})
public class FooterPagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        String view;

        switch (path) {

            case "/ChiSiamo":
                view = "/WEB-INF/views/footer/ChiSiamo.jsp";
                break;

            case "/Contattaci":
                view = "/WEB-INF/views/footer/Contattaci.jsp";
                break;

            case "/affil":
                view = "/WEB-INF/views/footer/affil.jsp";
                break;

            case "/Howto":
                view = "/WEB-INF/views/footer/HowTo.jsp";
                break;

            case "/FAQ":
                view = "/WEB-INF/views/footer/FAQ.jsp";
                break;

            case "/PReso":
                view = "/WEB-INF/views/footer/PReso.jsp";
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
        }

        request.getRequestDispatcher(view).forward(request, response);
    }
}