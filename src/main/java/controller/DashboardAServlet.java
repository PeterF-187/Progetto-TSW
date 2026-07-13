package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.UtenteDAO;
import model.DAO.ImpostazioniDAO;
import model.DAO.TicketDAO;
import model.Obj.Utente;
import model.Obj.ImpostazioniUtente;
import model.Obj.Ticket;
import model.Obj.Stato;

@WebServlet(name = "DashboardA", value = "/dashboardA")
public class DashboardAServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Controllo di sicurezza: se non è loggato rimanda al login
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = ((String) session.getAttribute("username")).trim();

        System.out.println("===== DASHBOARD ADMIN =====");
        System.out.println("Username sessione: " + username);

        // Inizializzazione dei DAO necessari
        UtenteDAO utenteDAO = new UtenteDAO();
        ImpostazioniDAO impostazioniDAO = new ImpostazioniDAO();
        TicketDAO ticketDAO = new TicketDAO();

        /* UTENTE */
        Utente utente = utenteDAO.doRetrieveByUsername(username);
        if (utente == null) {
            System.out.println("Admin NON trovato nel database!");
        } else {
            System.out.println("Admin trovato: " + utente.getUsername());
        }

        /* IMPOSTAZIONI UTENTE (per la gestione del 2FA) */
        ImpostazioniUtente impostazioni = impostazioniDAO.doRetrieveByUsername(username);
        if (impostazioni == null) {
            System.out.println("Impostazioni admin non trovate");
        } else {
            System.out.println("2FA attiva per l'Admin: " + impostazioni.isDueFattori());
        }

        /* GESTIONE E SMISTAMENTO TICKET GLOBALI */
        List<Ticket> tuttiITicket = ticketDAO.doRetrieveAll();
        List<Ticket> ticketAperti = new ArrayList<>();
        List<Ticket> ticketChiusi = new ArrayList<>();

        if (tuttiITicket != null) {
            for (Ticket t : tuttiITicket) {
                if (t.getStato() == Stato.Aperto) {
                    ticketAperti.add(t);
                } else {
                    ticketChiusi.add(t);
                }
            }
        }

        System.out.println("Ticket aperti contati: " + ticketAperti.size());
        System.out.println("Ticket chiusi contati: " + ticketChiusi.size());

        /* ATTRIBUTI RICHIESTI DA dashboardA.jsp */
        request.setAttribute("utente", utente);
        request.setAttribute("impostazioni", impostazioni);
        request.setAttribute("ticketAperti", ticketAperti);  // Fornisce l'elenco delle pratiche da risolvere
        request.setAttribute("ticketChiusi", ticketChiusi);  // Fornisce l'elenco dello storico d'archivio

        System.out.println("Forward verso dashboardA.jsp");
        System.out.println("============================");

        // Reindirizzamento alla pagina jsp degli Admin
        request.getRequestDispatcher("/WEB-INF/views/dashboardA.jsp").forward(request, response);
    }
}