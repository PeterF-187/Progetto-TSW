package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.ConPool;
import model.DAO.Software_HouseDAO;
import model.DAO.*;
import model.Obj.*;

@WebServlet(name = "Admin", value = "/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente u = null;
        if (session != null) {
            u = (Utente) session.getAttribute("user");
        }

        // CONTROLLO SICUREZZA: L'utente esiste ed è un Admin?
        if (u != null && u.isAdmin()) {
            // ... dentro il controllo if (u != null && u.isAdmin()) di AdminServlet.java ...

            UtenteDAO utenteDAO = new UtenteDAO();
            request.setAttribute("listaUtenti", utenteDAO.doRetrieveAll());

            Software_HouseDAO shDAO = new Software_HouseDAO();
            request.setAttribute("listaSoftwareHouse", shDAO.doRetrieveAll());

// 🔥 AGGIUNTO: Carichiamo i Franchise per il form del nuovo videogioco
            FranchiseDAO franchiseDAO = new FranchiseDAO();
            request.setAttribute("listaFranchise", franchiseDAO.doRetrieveAll());

            request.getRequestDispatcher("/WEB-INF/views/AdminPage.jsp").forward(request, response);
        } else {
            System.out.println("Tentativo di accesso non autorizzato ad /admin bloccato.");
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente attuale = (Utente) (session != null ? session.getAttribute("user") : null);

        if (attuale == null || !attuale.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin?status=error");
            return;
        }

        try {
            switch (action) {
                case "modificaUtente":
                    String targetUser = request.getParameter("usernameSelezionato");
                    boolean nuovoIsAdmin = Boolean.parseBoolean(request.getParameter("ruoloAdmin"));
                    Stato_saldo nuovoStato = Stato_saldo.valueOf(request.getParameter("statoSaldo"));

                    // 1. Aggiornamento Ruolo
                    try (Connection con = ConPool.getConnection();
                         PreparedStatement ps = con.prepareStatement("UPDATE Utente SET is_admin = ? WHERE Username = ?")) {
                        ps.setBoolean(1, nuovoIsAdmin);
                        ps.setString(2, targetUser);
                        ps.executeUpdate();
                    }

                    // 2. Aggiornamento Stato Conto
                    Saldo_virtualeDAO saldoDAO = new Saldo_virtualeDAO();
                    Saldo_virtuale saldo = saldoDAO.doRetrieveByUsername(targetUser);
                    if (saldo != null) {
                        saldo.setStato(nuovoStato);
                        saldoDAO.doUpdate(saldo);
                    }
                    break;

                case "insertSH":
                    Software_House sh = new Software_House();
                    sh.setNome(request.getParameter("nomeSH"));
                    sh.setSede(request.getParameter("sedeLegale"));
                    sh.setAnno(Integer.parseInt(request.getParameter("annoFondazione")));

                    Software_HouseDAO shDAO = new Software_HouseDAO();
                    shDAO.doSave(sh);
                    break;

                case "insertPublisher":
                    Publisher pub = new Publisher();
                    pub.setNome_SH(request.getParameter("shEditore"));
                    pub.setBudget(new BigDecimal(request.getParameter("budgetMarketing")));
                    pub.setCanali(request.getParameter("canaliDistribuzione"));

                    PublisherDAO pubDAO = new PublisherDAO();
                    pubDAO.doSave(pub);
                    break;

                case "insertSviluppatori":
                    Sviluppatori dev = new Sviluppatori();
                    dev.setNome_SH(request.getParameter("shSviluppatore"));
                    dev.setN_Sviluppatori(Integer.parseInt(request.getParameter("numSviluppatori")));
                    dev.setTipologia(request.getParameter("tipologiaDev"));
                    dev.setMotore_grafico(request.getParameter("motoreGrafico"));

                    SviluppatoriDAO devDAO = new SviluppatoriDAO();
                    devDAO.doSave(dev);
                    break;

                case "insertFranchise":
                    Franchise fran = new Franchise();
                    fran.setTitolo(request.getParameter("titoloFranchise"));

                    FranchiseDAO franDAO = new FranchiseDAO();
                    franDAO.doSave(fran);
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/admin?status=error");
                    return;
            }

            response.sendRedirect(request.getContextPath() + "/admin?status=success");

        } catch (Exception e) {
            System.err.println("Errore processing action " + action + ": " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin?status=error");
        }
    }
}