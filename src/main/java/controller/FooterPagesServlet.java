package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet(urlPatterns = {"/ChiSiamo", "/Contattaci", "/affil", "/HowTo", "/FAQ", "/PReso"})
public class FooterPagesServlet extends HttpServlet {

    private static final Map<String, String> PAGES = Map.of(
            "/ChiSiamo", "/WEB-INF/views/footer/ChiSiamo.jsp",
            "/Contattaci", "/WEB-INF/views/footer/Contattaci.jsp",
            "/affil", "/WEB-INF/views/footer/affil.jsp",
            "/HowTo", "/WEB-INF/views/footer/HowTo.jsp",
            "/FAQ", "/WEB-INF/views/footer/FAQ.jsp",
            "/PReso", "/WEB-INF/views/footer/PReso.jsp"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = PAGES.get(request.getServletPath());

        if (view == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.getRequestDispatcher(view).forward(request, response);
    }
}