package controller;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.TicketDAO;
import model.Obj.Ticket;
import model.Obj.Tipo_ticket;
import model.Obj.Stato;
import model.Obj.Utente;

@WebServlet(name = "GestioneTicket", value = "/inviaTicket")
public class TicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        String tipoTicketStr = request.getParameter("tipoTicket");
        String motivazione = request.getParameter("motivazione");
        String idProdottoStr = request.getParameter("idProdottoTicket");

        try {
            Ticket t = new Ticket();
            t.setUsername(username);
            t.setTipo(Tipo_ticket.valueOf(tipoTicketStr));
            t.setMotivazione(motivazione);
            t.setData(new Date()); // Data di oggi
            t.setStato(Stato.Aperto); // Di default aperto

            // Se è un ticket "acquisto" cerchiamo l'id del prodotto, altrimenti rimane null
            if ("acquisto".equalsIgnoreCase(tipoTicketStr) && idProdottoStr != null && !idProdottoStr.trim().isEmpty()) {
                t.setId_prodotto(Integer.parseInt(idProdottoStr));
            } else {
                t.setId_prodotto(null);
            }

            TicketDAO dao = new TicketDAO();
            dao.doSave(t);

            // Rimanda alla dashboard impostando il parametro per mostrare il popup di successo
            response.sendRedirect(request.getContextPath() + "/dashboard?status=success");

        } catch (Exception e) {
            System.err.println("Errore inserimento ticket: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard?status=error");
        }
    }
}