package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.VideogiocoDAO;
import model.Obj.Videogioco;

@WebServlet(name = "ResultsServlet", value = "/risultati")
public class ResultsServlet extends HttpServlet {

    private final VideogiocoDAO videogiocoDAO = new VideogiocoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("q");

        List<Videogioco> risultati;
        if (query != null && !query.trim().isEmpty()) {
            query = query.trim();
            // Utilizza lo stesso metodo DAO che usi per la barra dei suggerimenti asincrona
            risultati = videogiocoDAO.cercaPerTitolo(query);
            request.setAttribute("parametroRicerca", query);
        } else {
            // Se la query viene forzata vuota, mostriamo la lista completa
            risultati = videogiocoDAO.doRetrieveAll();
        }

        request.setAttribute("videogiochi", risultati);
        request.getRequestDispatcher("/WEB-INF/views/results.jsp").forward(request, response);
    }
}