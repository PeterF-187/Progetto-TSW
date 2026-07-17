package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.DAO.TicketDAO;
import model.DAO.UtenteDAO;
import model.Obj.Ticket;
import model.Obj.Stato;
import model.Obj.Utente;
import model.Service.EmailService;

@WebServlet(name = "RispondiTicket", value = "/rispondiTicket")
public class RispondiTicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente adminCorrente = (Utente) (session != null ? session.getAttribute("user") : null);

        // Controllo di sicurezza: l'utente esiste ed è un Admin autorizzato?
        if (adminCorrente == null || !adminCorrente.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Recupero parametri dal modulo Admin
        String idTicketStr = request.getParameter("idTicket");
        String rispostaAdmin = request.getParameter("rispostaAdmin");
        String nuovoStatoStr = request.getParameter("nuovoStato");

        if (idTicketStr == null || rispostaAdmin == null || nuovoStatoStr == null) {
            response.sendRedirect(request.getContextPath() + "/dashboardA?status=error");
            return;
        }

        try {
            int idTicket = Integer.parseInt(idTicketStr.trim());
            TicketDAO ticketDAO = new TicketDAO();
            Ticket ticket = ticketDAO.doRetrieveById(idTicket);

            if (ticket == null) {
                response.sendRedirect(request.getContextPath() + "/dashboardA?status=error");
                return;
            }

            //Recupero dell'email del cliente destinatario tramite UtenteDAO
            UtenteDAO utenteDAO = new UtenteDAO();
            Utente utenteCliente = utenteDAO.doRetrieveByUsername(ticket.getUsername());

            if (utenteCliente == null || utenteCliente.getEmail() == null) {
                throw new Exception("Impossibile trovare l'indirizzo email dell'utente associato al ticket.");
            }

            Stato statoFinale = Stato.valueOf(nuovoStatoStr);

            //Aggiornamento dello stato, della risposta e del nome operatore nel DB
            ticketDAO.doRispondiEChiudi(
                    idTicket,
                    rispostaAdmin.trim(),
                    adminCorrente.getUsername(),
                    statoFinale
            );

            // Spedizione della mail all'utente tramite EmailService
            EmailService emailService = new EmailService();
            emailService.sendTicketReplyEmail(
                    utenteCliente.getEmail(),
                    idTicket,
                    ticket.getMotivazione(),
                    rispostaAdmin.trim(),
                    statoFinale.name()
            );

            //Se tutto va bene ricarica la Dashboard Admin
            response.sendRedirect(request.getContextPath() + "/dashboardA?status=success");

        } catch (Exception e) {
            System.err.println("Errore durante l'evasione del ticket lato admin: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboardA?status=error");
        }
    }
}