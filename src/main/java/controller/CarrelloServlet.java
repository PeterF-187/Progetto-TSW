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
import model.DAO.Metodo_pagamentoDAO;
import model.Obj.Videogioco;
import model.Obj.Saldo_virtuale;
import model.Obj.Stato_saldo;
import model.Obj.Metodo_pagamento;
import model.Obj.TipoMetodo;

@WebServlet(name = "Carrello", value = "/carrello")
public class CarrelloServlet extends HttpServlet {

    private final VideogiocoDAO videogiocoDAO = new VideogiocoDAO();
    private final Saldo_virtualeDAO saldoDAO = new Saldo_virtualeDAO();
    private final Metodo_pagamentoDAO metodoDAO = new Metodo_pagamentoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession();

        List<Videogioco> carrello = (List<Videogioco>) session.getAttribute("carrello_oggetti");
        if (carrello == null) {
            carrello = new ArrayList<>();
        }

        BigDecimal totale = carrello.stream()
                .map(Videogioco::getPrezzo)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        String sessionUser = (String) session.getAttribute("username");
        if (sessionUser != null) {
            String username = sessionUser.trim();

            Saldo_virtuale saldoUtente = saldoDAO.doRetrieveByUsername(username);
            request.setAttribute("saldoUtente", saldoUtente);

            if (saldoUtente != null && (saldoUtente.getStato() == Stato_saldo.Sospeso || saldoUtente.getStato() == Stato_saldo.Bloccato)) {
                request.setAttribute("checkoutDisabilitato", true);
                request.setAttribute("motivoBlocco", "Il tuo saldo virtuale è attualmente " + saldoUtente.getStato().name().toLowerCase() + ".");
            }

            List<Metodo_pagamento> tuttiIMetodi = metodoDAO.doRetrieveAll();
            Metodo_pagamento metodoUtente = null;

            if (tuttiIMetodi != null) {
                metodoUtente = tuttiIMetodi.stream()
                        .filter(m -> m.getUsername() != null && m.getUsername().trim().equalsIgnoreCase(username))
                        .findFirst()
                        .orElse(null);
            }

            boolean daConfigurare = (metodoUtente == null || metodoUtente.getTipoMetodo() == TipoMetodo.Da_configurare);
            request.setAttribute("metodoDaConfigurare", daConfigurare);
        }

        request.setAttribute("prodottiCarrello", carrello);
        request.setAttribute("prezzoTotale", totale);

        request.getRequestDispatcher("/WEB-INF/views/carrello.jsp").forward(request, response);
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

        if (idProdottoStr != null && !idProdottoStr.trim().isEmpty()) {
            try {
                // Protetti da NumberFormatException tramite blocco di cattura mirato
                int idProdotto = Integer.parseInt(idProdottoStr.trim());

                if ("remove".equals(action)) {
                    for (int i = 0; i < carrello.size(); i++) {
                        if (carrello.get(i).getId_prodotto() == idProdotto) {
                            carrello.remove(i);
                            break;
                        }
                    }
                } else {
                    Videogioco v = videogiocoDAO.doRetrieveById(idProdotto);
                    if (v != null) {
                        carrello.add(v);
                    }
                }
            } catch (NumberFormatException e) {
                System.err.println("Tentativo di inserimento ID prodotto non valido rintracciato: " + idProdottoStr);
                // Impedisce il crash rimandando l'utente alla schermata iniziale del carrello
            }
        }

        session.setAttribute("carrello_oggetti", carrello);
        response.sendRedirect(request.getContextPath() + "/carrello");
    }
}