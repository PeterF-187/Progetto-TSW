package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.*;
import model.Obj.*;

@WebServlet(name = "Dashboard", value = "/dashboard")
public class DashboardServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession(false);


        if (session == null || session.getAttribute("username") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }



        String username =
                ((String) session.getAttribute("username")).trim();



        System.out.println("===== DASHBOARD =====");
        System.out.println("Username sessione: " + username);



        // DAO

        UtenteDAO utenteDAO =
                new UtenteDAO();

        AcquistoDAO acquistoDAO =
                new AcquistoDAO();

        Saldo_virtualeDAO saldoDAO =
                new Saldo_virtualeDAO();

        Metodo_pagamentoDAO metodoDAO =
                new Metodo_pagamentoDAO();

        ImpostazioniDAO impostazioniDAO =
                new ImpostazioniDAO();




        /*
            UTENTE
        */


        Utente utente =
                utenteDAO.doRetrieveByUsername(username);



        if (utente == null) {

            System.out.println(
                    "Utente NON trovato!"
            );

        } else {

            System.out.println(
                    "Utente trovato: "
                            + utente.getUsername()
            );

        }




        /*
            IMPOSTAZIONI UTENTE
        */


        ImpostazioniUtente impostazioni =
                impostazioniDAO
                        .doRetrieveByUsername(username);



        if(impostazioni == null){

            System.out.println(
                    "Impostazioni utente non trovate"
            );

        }else{

            System.out.println(
                    "2FA attiva: "
                            + impostazioni.isDueFattori()
            );

        }





        /*
            ACQUISTI
        */


        List<Videogioco> acquistiUtente =
                acquistoDAO
                        .doRetrieveVideogiochiByUsername(username);






        /*
            SALDO
        */


        Saldo_virtuale saldoVirtuale =
                saldoDAO
                        .doRetrieveByUsername(username);



        if (saldoVirtuale == null) {


            System.out.println(
                    "Saldo NON trovato."
            );


            saldoVirtuale = new Saldo_virtuale();

            saldoVirtuale.setUsername(username);

            saldoVirtuale.setSaldo(
                    new java.math.BigDecimal("0.00")
            );

            saldoVirtuale.setValuta(
                    valuta.EUR
            );

            saldoVirtuale.setStato(
                    Stato_saldo.Disponibile
            );

            saldoVirtuale.setData(
                    new java.util.Date()
            );


        } else {


            System.out.println(
                    "Saldo trovato."
            );

            System.out.println(
                    "Saldo = "
                            + saldoVirtuale.getSaldo()
            );

            System.out.println(
                    "Valuta = "
                            + saldoVirtuale.getValuta()
            );

            System.out.println(
                    "Stato = "
                            + saldoVirtuale.getStato()
            );

        }





        /*
            METODI PAGAMENTO
        */


        List<Metodo_pagamento> metodiUtente =
                new ArrayList<>();



        List<Metodo_pagamento> tuttiIMetodi =
                metodoDAO.doRetrieveAll();




        if (tuttiIMetodi != null) {


            for (Metodo_pagamento m : tuttiIMetodi) {


                System.out.println("------------------------");

                System.out.println(
                        "Username DB : "
                                + m.getUsername()
                );

                System.out.println(
                        "Tipo        : "
                                + m.getTipoMetodo()
                );

                System.out.println(
                        "Attivo      : "
                                + m.isAttivo()
                );



                // Ignora placeholder

                if (m.getUsername() != null
                        && m.getUsername()
                        .trim()
                        .equalsIgnoreCase(username)

                        && m.isAttivo()

                        && m.getTipoMetodo()
                        != TipoMetodo.Da_configurare) {



                    metodiUtente.add(m);



                    System.out.println(
                            ">>> Metodo valido aggiunto"
                    );

                }

            }

        }




        boolean haMetodoAttivo =
                !metodiUtente.isEmpty();




        System.out.println(
                "Metodi validi trovati: "
                        + metodiUtente.size()
        );


        System.out.println(
                "haMetodoAttivo = "
                        + haMetodoAttivo
        );





        /*
            ATTRIBUTI JSP
        */


        request.setAttribute(
                "utente",
                utente
        );


        request.setAttribute(
                "impostazioni",
                impostazioni
        );


        request.setAttribute(
                "acquistiUtente",
                acquistiUtente
        );


        request.setAttribute(
                "saldoVirtuale",
                saldoVirtuale
        );


        request.setAttribute(
                "metodiUtente",
                metodiUtente
        );


        request.setAttribute(
                "haMetodoAttivo",
                haMetodoAttivo
        );





        System.out.println(
                "Forward verso dashboard.jsp"
        );

        System.out.println(
                "============================"
        );



        request.getRequestDispatcher(
                        "/WEB-INF/views/dashboard.jsp"
                )
                .forward(request, response);


    }

}