package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.VideogiocoDAO;
import model.DAO.Saldo_virtualeDAO;
import model.Obj.Videogioco;
import model.Obj.Saldo_virtuale;
import model.Obj.Stato_saldo;

@WebServlet(name = "Carrello", value = "/carrello")
public class CarrelloServlet extends HttpServlet {

    private final VideogiocoDAO videogiocoDAO = new VideogiocoDAO();
    private final Saldo_virtualeDAO saldoDAO = new Saldo_virtualeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Recupera il carrello dalla sessione
        List<Videogioco> carrello = (List<Videogioco>) session.getAttribute("carrello_oggetti");
        if (carrello == null) {
            carrello = new ArrayList<>();
        }

        // Calcola il costo totale del carrello
        BigDecimal totale = carrello.stream()
                .map(Videogioco::getPrezzo)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Controllo del saldo virtuale se l'utente è loggato
        String username = (String) session.getAttribute("username");
        if (username != null) {
            Saldo_virtuale saldoUtente = saldoDAO.doRetrieveByUsername(username);
            request.setAttribute("saldoUtente", saldoUtente);

            // Se lo stato è SOSPESO o BLOCCATO, disabilitiamo il check-out
            if (saldoUtente != null &&
                    (saldoUtente.getStato() == Stato_saldo.Sospeso || saldoUtente.getStato() == Stato_saldo.Bloccato)) {
                request.setAttribute("checkoutDisabilitato", true);
                request.setAttribute("motivoBlocco", "Il tuo saldo virtuale è attualmente " + saldoUtente.getStato().name().toLowerCase() + ".");
            }
        }

        request.setAttribute("prodottiCarrello", carrello);
        request.setAttribute("prezzoTotale", totale);

        request.getRequestDispatcher("/WEB-INF/views/carrello.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Videogioco> carrello = (List<Videogioco>) session.getAttribute("carrello_oggetti");
        if (carrello == null) {
            carrello = new ArrayList<>();
        }

        String idProdottoStr = request.getParameter("idProdotto");
        String action = request.getParameter("action");

        if (idProdottoStr != null) {
            int idProdotto = Integer.parseInt(idProdottoStr);

            if ("remove".equals(action)) {
                // Rimuove la prima occorrenza del gioco nel carrello
                carrello.removeIf(v -> v.getId_prodotto() == idProdotto);
            } else {
                // Aggiunge un prodotto al carrello
                Videogioco v = videogiocoDAO.doRetrieveById(idProdotto);
                if (v != null) {
                    carrello.add(v);
                }
            }
        }

        session.setAttribute("carrello_oggetti", carrello);
        response.sendRedirect(request.getContextPath() + "/carrello");
    }
}