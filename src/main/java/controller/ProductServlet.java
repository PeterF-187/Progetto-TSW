package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.*;
import model.Obj.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Prodotto", value = "/prodotto")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID mancante");
            return;
        }

        int id;

        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID non valido");
            return;
        }

        VideogiocoDAO giocoDAO = new VideogiocoDAO();
        Disponibile_inDAO regDAO = new Disponibile_inDAO();
        Sviluppo_giocoDAO devDAO = new Sviluppo_giocoDAO();
        Pubblicazione_giocoDAO pubDAO = new Pubblicazione_giocoDAO();
        Fa_Parte_diDAO frDAO = new Fa_Parte_diDAO();
        SupportaDAO supDAO = new SupportaDAO();

        Videogioco gioco = giocoDAO.doRetrieveById(id);

        if (gioco == null) {
            response.sendError(404);
            return;
        }

        request.setAttribute("gioco", gioco);

        request.setAttribute("regioni", regDAO.doRetrieveByIdProdotto(id));
        request.setAttribute("sviluppatori", devDAO.doRetrieveByIdProdotto(id));
        request.setAttribute("publishers", pubDAO.doRetrieveByIdProdotto(id));
        request.setAttribute("franchise", frDAO.doRetrieveByIdProdotto(id));
        request.setAttribute("lingue", supDAO.doRetrieveByIdProdotto(id));

        request.setAttribute("consigliati",
                giocoDAO.doRetrieveConsigliati(id));

        request.getRequestDispatcher("/WEB-INF/views/prodotto.jsp")
                .forward(request, response);
    }
}