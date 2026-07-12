package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.VideogiocoDAO;
import model.Obj.Videogioco;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        VideogiocoDAO giocoDAO = new VideogiocoDAO();

        String[] categorie = request.getParameterValues("categoria[]");
        String[] generi = request.getParameterValues("genere[]");
        String[] piattaforme = request.getParameterValues("piattaforma[]");
        String[] lingue = request.getParameterValues("lingua[]");
        String[] regioni = request.getParameterValues("regione[]");

        BigDecimal minPrice = null;
        BigDecimal maxPrice = null;

        String min = request.getParameter("minPrice");
        String max = request.getParameter("maxPrice");

        // Parsing sicuro per il prezzo minimo
        if (min != null && !min.trim().isEmpty()) {
            try {
                minPrice = new BigDecimal(min.trim());
            } catch (NumberFormatException e) {
                System.err.println("Bypass rilevato sul filtro prezzo minimo, valore ignorato: " + min);
            }
        }

        // Parsing sicuro per il prezzo massimo
        if (max != null && !max.trim().isEmpty()) {
            try {
                maxPrice = new BigDecimal(max.trim());
            } catch (NumberFormatException e) {
                System.err.println("Bypass rilevato sul filtro prezzo massimo, valore ignorato: " + max);
            }
        }

        List<Videogioco> videogiochiList;

        if ((categorie == null || categorie.length == 0)
                && (generi == null || generi.length == 0)
                && (piattaforme == null || piattaforme.length == 0)
                && (lingue == null || lingue.length == 0)
                && (regioni == null || regioni.length == 0)
                && minPrice == null
                && maxPrice == null) {

            videogiochiList = giocoDAO.doRetrieveAll();

        } else {
            videogiochiList = giocoDAO.filtra(
                    categorie, generi, piattaforme, lingue, regioni,
                    minPrice, maxPrice);
        }

        request.setAttribute("videogiochi", videogiochiList);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}