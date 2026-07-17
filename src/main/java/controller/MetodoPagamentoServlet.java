package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.Metodo_pagamentoDAO;
import model.Obj.Metodo_pagamento;
import model.Obj.TipoMetodo;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "MetodoPagamento", value = "/metodoPagamento")
public class MetodoPagamentoServlet extends HttpServlet {

    private final Metodo_pagamentoDAO dao = new Metodo_pagamentoDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("username") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String username = (String) session.getAttribute("username");

            String tipo = request.getParameter("tipoMetodo");

            if (tipo == null || tipo.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=tipoMetodo");
                return;
            }

            TipoMetodo tipoEnum;
            try {
                tipoEnum = TipoMetodo.valueOf(tipo);
            } catch (Exception e) {
                throw new RuntimeException("Tipo metodo non valido: " + tipo);
            }

            String provider = request.getParameter("provider");
            String token = request.getParameter("tokenPagamento");
            String ultime4 = request.getParameter("ultime4Cifre");

            int mese = Integer.parseInt(request.getParameter("scadenzaMese"));
            int anno = Integer.parseInt(request.getParameter("scadenzaAnno"));

            Metodo_pagamento m = new Metodo_pagamento();
            m.setUsername(username);
            m.setTipoMetodo(tipoEnum);
            m.setProvider(provider);
            m.setTokenPagamento(token);
            m.setUltime4Cifre(ultime4);
            m.setScadenzaMese(mese);
            m.setScadenzaAnno(anno);

            m.setPredefinito(false);
            m.setAttivo(true);
            m.setDataCreazione(new Date());

            Metodo_pagamento esistente = dao.doRetrieveByUsername(username);

            if (esistente == null) {
                dao.doSave(m);
                System.out.println("INSERT metodo pagamento");
            } else {
                m.setIdMetodo(esistente.getIdMetodo());
                dao.doUpdate(m);
                System.out.println("UPDATE metodo pagamento");
            }

            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Errore salvataggio metodo pagamento", e);
        }
    }
}