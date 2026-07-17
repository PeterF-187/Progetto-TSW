package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.DAO.VideogiocoDAO;
import model.Obj.Videogioco;

@WebServlet(name = "SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("query");
        PrintWriter out = response.getWriter();

        // Se la query è vuota o troppo corta, restituiamo un array JSON vuoto
        if (query == null || query.trim().length() < 2) {
            out.print("[]");
            out.flush();
            return;
        }

        query = query.trim();

        VideogiocoDAO videogioco = new VideogiocoDAO();
        List<Videogioco> suggerimenti = videogioco.cercaPerTitolo(query);

        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < suggerimenti.size(); i++) {
            Videogioco v = suggerimenti.get(i);

            json.append("{");
            json.append("\"id\":").append(v.getId_prodotto()).append(",");
            json.append("\"titolo\":\"").append(v.getTitolo().replace("\"", "\\\"")).append("\",");
            json.append("\"immagine\":\"").append(v.getImg().replace("\"", "\\\"")).append("\",");
            json.append("\"prezzo\":").append(v.getPrezzo().toString());
            json.append("}");

            if (i < suggerimenti.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        out.print(json.toString());
        out.flush();
    }
}