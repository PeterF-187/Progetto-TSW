package controller;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.*;
import model.Obj.*;

@WebServlet(name = "InsertVideogioco", value = "/insertVideogioco")
public class InsertVideogiocoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente attuale = (Utente) (session != null ? session.getAttribute("user") : null);

        // verifica permessi admin
        if (attuale == null || !attuale.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // recupero campi testuali e date dal form
        String titolo = request.getParameter("titolo");
        BigDecimal prezzo = new BigDecimal(request.getParameter("prezzo"));
        String dataParam = request.getParameter("dataRilascio");
        java.sql.Date dataRilascio = java.sql.Date.valueOf(dataParam);
        String descrizione = request.getParameter("descrizione");
        String immagine = request.getParameter("immagine");

        // recupero parametri delle select
        String sviluppatore = request.getParameter("sviluppatoreSH");
        String publisher = request.getParameter("publisherSH");
        String franchiseSelezionato = request.getParameter("franchiseAppartenenza");

        // recupero array delle checkbox
        String[] piattaforme = request.getParameterValues("piattaforme");
        String[] regioni = request.getParameterValues("regioni");
        String[] generi = request.getParameterValues("generi");
        String[] categorie = request.getParameterValues("categorie");
        String[] lingue = request.getParameterValues("lingue");

        try {
            // salvataggio del videogioco base
            Videogioco v = new Videogioco();
            v.setTitolo(titolo);
            v.setPrezzo(prezzo);
            v.setData_rilascio(dataRilascio);
            v.setDesc(descrizione);
            v.setImg(immagine);

            VideogiocoDAO vDAO = new VideogiocoDAO();
            vDAO.doSave(v);

            int idProdotto = v.getId_prodotto();

            // assegnazione sviluppatore
            Sviluppo_gioco sg = new Sviluppo_gioco();
            sg.setId_prodotto(idProdotto);
            sg.setNome_SH(sviluppatore);
            Sviluppo_giocoDAO sgDAO = new Sviluppo_giocoDAO();
            sgDAO.doSave(sg);

            // assegnazione publisher
            Pubblicazione_gioco pg = new Pubblicazione_gioco();
            pg.setId_prodotto(idProdotto);
            pg.setNome_Publisher(publisher);
            Pubblicazione_giocoDAO pgDAO = new Pubblicazione_giocoDAO();
            pgDAO.doSave(pg);

            // collegamento al franchise se specificato
            if (franchiseSelezionato != null && !franchiseSelezionato.trim().isEmpty()) {
                Fa_Parte_di fpd = new Fa_Parte_di();
                fpd.setId_prodotto(idProdotto);
                fpd.setFranchise(franchiseSelezionato);
                Fa_Parte_diDAO fpdDAO = new Fa_Parte_diDAO();
                fpdDAO.doSave(fpd);
            }

            // collegamento piattaforme
            if (piattaforme != null) {
                rilascio_suDAO rilascioDAO = new rilascio_suDAO();
                for (String p : piattaforme) {
                    rilascio_su r = new rilascio_su();
                    r.setId_prodotto(idProdotto);
                    r.setPiattaforma(Piattaforma.valueOf(p));
                    rilascioDAO.doSave(r);
                }
            }

            // collegamento regioni
            if (regioni != null) {
                Disponibile_inDAO disponibileDAO = new Disponibile_inDAO();
                for (String r : regioni) {
                    Disponibile_in d = new Disponibile_in();
                    d.setId_prodotto(idProdotto);
                    d.setNome_regione(Regione.valueOf(r));
                    disponibileDAO.doSave(d);
                }
            }

            // collegamento generi
            if (generi != null) {
                Appartiene_genereDAO genereDAO = new Appartiene_genereDAO();
                for (String g : generi) {
                    Appartiene_genere ag = new Appartiene_genere();
                    ag.setId_prodotto(idProdotto);
                    ag.setGenere(Generi.valueOf(g));
                    genereDAO.doSave(ag);
                }
            }

            // collegamento categorie
            if (categorie != null) {
                Appartiene_categoriaDAO categoriaDAO = new Appartiene_categoriaDAO();
                for (String c : categorie) {
                    Appartiene_categoria ac = new Appartiene_categoria();
                    ac.setId_prodotto(idProdotto);
                    ac.setCategoria(Categorie.valueOf(c));
                    categoriaDAO.doSave(ac);
                }
            }

            // collegamento lingue
            if (lingue != null) {
                SupportaDAO supportaDAO = new SupportaDAO();
                for (String l : lingue) {
                    Supporta s = new Supporta();
                    s.setId_prodotto(idProdotto);
                    s.setLingua(Lingue.valueOf(l));
                    supportaDAO.doSave(s);
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin?status=success");

        } catch (Exception e) {
            System.err.println("errore durante il salvataggio del videogioco: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?status=error");
        }
    }
}