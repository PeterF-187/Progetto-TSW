package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.*;
import model.Obj.*;

@WebServlet(name = "Checkout", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    private final Saldo_virtualeDAO saldoDAO = new Saldo_virtualeDAO();
    private final AcquistoDAO acquistoDAO = new AcquistoDAO();
    private final Product_keysDAO keysDAO = new Product_keysDAO();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Videogioco> carrello =
                (List<Videogioco>) session.getAttribute("carrello_oggetti");

        if (carrello == null || carrello.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrello");
            return;
        }

        String selectedPayment = request.getParameter("selectedPayment");

        BigDecimal totale = carrello.stream()
                .map(Videogioco::getPrezzo)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Date dataCorrente = new Date();

        List<KeyDTO> productKeys = new ArrayList<>();

        try {

            // =========================
            // PAGAMENTO
            // =========================
            if ("saldo".equalsIgnoreCase(selectedPayment)) {

                Saldo_virtuale saldo = saldoDAO.doRetrieveByUsername(username);

                if (saldo == null ||
                        saldo.getStato() == Stato_saldo.Sospeso ||
                        saldo.getStato() == Stato_saldo.Bloccato) {

                    throw new RuntimeException("Portafoglio non valido");
                }

                if (saldo.getSaldo().compareTo(totale) < 0) {
                    throw new RuntimeException("Saldo insufficiente");
                }

                saldo.setSaldo(saldo.getSaldo().subtract(totale));
                saldoDAO.doUpdate(saldo);
            }

            if (selectedPayment == null || selectedPayment.isEmpty()) {
                throw new RuntimeException("Metodo di pagamento non valido");
            }

            String metodoFinale =
                    "saldo".equalsIgnoreCase(selectedPayment)
                            ? TipoMetodo.Saldo.name()
                            : selectedPayment;

            // =========================
            // ACQUISTO + KEY
            // =========================
            for (Videogioco gioco : carrello) {

                Product_keys pk =
                        keysDAO.doRetrieveAvailableByProduct(gioco.getId_prodotto());

                if (pk == null) {
                    throw new RuntimeException("Nessuna key disponibile per " + gioco.getTitolo());
                }

                keysDAO.doUpdateStatus(pk);

                productKeys.add(new KeyDTO(
                        gioco.getTitolo(),
                        pk.getChiave()
                ));

                Acquisto a = new Acquisto();
                a.setUsername(username);
                a.setId(gioco.getId_prodotto());
                a.setId_key(pk.getId_key());
                a.setData_acquisto(dataCorrente);
                a.setPrezzo_pagato(gioco.getPrezzo());
                a.setMetodo_di_pagamento(metodoFinale);

                acquistoDAO.doSave(a);
            }

            session.setAttribute("carrello_oggetti", new ArrayList<Videogioco>());

            request.setAttribute("successo", true);
            request.setAttribute("productKeys", productKeys);

            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            request.setAttribute("successo", false);
            request.setAttribute("messaggioError", e.getMessage());

            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                    .forward(request, response);
        }
    }
}