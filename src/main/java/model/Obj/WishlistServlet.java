package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.VideogiocoDAO;
import model.Obj.Videogioco;

@WebServlet(name = "Wishlist", value = "/wishlist")
public class WishlistServlet extends HttpServlet {

    private final VideogiocoDAO videogiocoDAO = new VideogiocoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Videogioco> wishlist = (List<Videogioco>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new ArrayList<>();
        }

        // Passiamo la lista alla JSP tramite la request
        request.setAttribute("prodottiWishlist", wishlist);

        request.getRequestDispatcher("/WEB-INF/views/wishlist.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Recupera o crea la lista nella sessione
        List<Videogioco> wishlist = (List<Videogioco>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new ArrayList<>();
        }

        // Recupera l'ID del prodotto inviato dal form
        String idProdottoStr = request.getParameter("idProdotto");
        String action = request.getParameter("action"); // Opzionale per gestire la rimozione

        if (idProdottoStr != null) {
            int idProdotto = Integer.parseInt(idProdottoStr);

            // Se l'azione è "remove", togliamo il gioco, altrimenti lo aggiungiamo
            if ("remove".equals(action)) {
                wishlist.removeIf(v -> v.getId_prodotto() == idProdotto);
            } else {
                // Controlla se il gioco è già presente per evitare duplicati
                boolean giaPresente = wishlist.stream().anyMatch(v -> v.getId_prodotto() == idProdotto);

                if (!giaPresente) {
                    Videogioco v = videogiocoDAO.doRetrieveById(idProdotto);
                    // Verifichiamo che l'oggetto esista e che abbia un titolo sul database!
                    if (v != null && v.getTitolo() != null) {
                        wishlist.add(v);
                    }
                }
            }
        }

        // Aggiorna la lista in sessione
        session.setAttribute("wishlist", wishlist);

        // Redirect alla servlet stessa (in GET) per mostrare la pagina aggiornata ed evitare doppi invii del form
        response.sendRedirect(request.getContextPath() + "/wishlist");
    }
}