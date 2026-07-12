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

        // Controllo Sicurezza Admin
        if (attuale == null || !attuale.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // 1. Recupero parametri principali del Videogioco dal Form
        String titolo = request.getParameter("titolo");
        BigDecimal prezzo = new BigDecimal(request.getParameter("prezzo"));
        String dataParam = request.getParameter("dataRilascio");
        java.sql.Date dataRilascio = java.sql.Date.valueOf(dataParam);
        String descrizione = request.getParameter("descrizione");
        String immagine = request.getParameter("immagine");

        // Recupero parametri dei Dropdown
        String sviluppatore = request.getParameter("sviluppatoreSH");
        String publisher = request.getParameter("publisherSH");
        String franchiseSelezionato = request.getParameter("franchiseAppartenenza");

        // Recupero Array delle Checkbox N-to-N
        String[] piattaforme = request.getParameterValues("piattaforme");
        String[] regioni = request.getParameterValues("regioni");
        String[] generi = request.getParameterValues("generi");
        String[] categorie = request.getParameterValues("categorie");
        String[] lingue = request.getParameterValues("lingue");

        try {
            // STEP 1: Creazione e Salvataggio del Videogioco principale
            Videogioco v = new Videogioco();
            v.setTitolo(titolo);
            v.setPrezzo(prezzo);
            v.setData_rilascio(dataRilascio);
            v.setDesc(descrizione);
            v.setImg(immagine);

            VideogiocoDAO vDAO = new VideogiocoDAO();
            vDAO.doSave(v); // Questo metodo esegue l'insert e imposta l'ID generato tramite getGeneratedKeys

            int idProdotto = v.getId_prodotto();

            // STEP 2: Assegnazione dello Sviluppatore tramite Sviluppo_giocoDAO
            Sviluppo_gioco sg = new Sviluppo_gioco();
            sg.setId_prodotto(idProdotto);
            sg.setNome_SH(sviluppatore);
            Sviluppo_giocoDAO sgDAO = new Sviluppo_giocoDAO();
            sgDAO.doSave(sg);

            // STEP 3: Assegnazione del Publisher tramite Pubblicazione_giocoDAO
            Pubblicazione_gioco pg = new Pubblicazione_gioco();
            pg.setId_prodotto(idProdotto);
            pg.setNome_Publisher(publisher);
            Pubblicazione_giocoDAO pgDAO = new Pubblicazione_giocoDAO();
            pgDAO.doSave(pg);

            // STEP 4: Associazione al Franchise (solo se valorizzato)
            if (franchiseSelezionato != null && !franchiseSelezionato.trim().isEmpty()) {
                Fa_Parte_di fpd = new Fa_Parte_di();
                fpd.setId_prodotto(idProdotto);
                fpd.setFranchise(franchiseSelezionato);
                Fa_Parte_diDAO fpdDAO = new Fa_Parte_diDAO();
                fpdDAO.doSave(fpd);
            }

            // STEP 5: Inserimento Piattaforme (rilascio_su)
            if (piattaforme != null) {
                rilascio_suDAO rilascioDAO = new rilascio_suDAO();
                for (String p : piattaforme) {
                    rilascio_su r = new rilascio_su();
                    r.setId_prodotto(idProdotto);
                    r.setPiattaforma(Piattaforma.valueOf(p)); // Conversione sicura in Enum
                    rilascioDAO.doSave(r);
                }
            }

            // STEP 6: Inserimento Regioni di attivazione (Disponibile_in)
            if (regioni != null) {
                Disponibile_inDAO disponibileDAO = new Disponibile_inDAO();
                for (String r : regioni) {
                    Disponibile_in d = new Disponibile_in();
                    d.setId_prodotto(idProdotto);
                    d.setNome_regione(Regione.valueOf(r));
                    disponibileDAO.doSave(d);
                }
            }

            // STEP 7: Inserimento Generi (Appartiene_genere)
            if (generi != null) {
                Appartiene_genereDAO genereDAO = new Appartiene_genereDAO();
                for (String g : generi) {
                    Appartiene_genere ag = new Appartiene_genere();
                    ag.setId_prodotto(idProdotto);
                    ag.setGenere(Generi.valueOf(g));
                    genereDAO.doSave(ag);
                }
            }

            // STEP 8: Inserimento Categorie (Appartiene_categoria)
            if (categorie != null) {
                Appartiene_categoriaDAO categoriaDAO = new Appartiene_categoriaDAO();
                for (String c : categorie) {
                    Appartiene_categoria ac = new Appartiene_categoria();
                    ac.setId_prodotto(idProdotto);
                    ac.setCategoria(Categorie.valueOf(c));
                    categoriaDAO.doSave(ac);
                }
            }

            // STEP 9: Inserimento Lingue supportate (Supporta)
            if (lingue != null) {
                SupportaDAO supportaDAO = new SupportaDAO();
                for (String l : lingue) {
                    Supporta s = new Supporta();
                    s.setId_prodotto(idProdotto);
                    s.setLingua(Lingue.valueOf(l));
                    supportaDAO.doSave(s);
                }
            }

            // Tutto completato con successo
            response.sendRedirect(request.getContextPath() + "/admin?status=success");

        } catch (Exception e) {
            System.err.println("Errore inserimento videogioco tramite architettura DAO: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?status=error");
        }
    }
}