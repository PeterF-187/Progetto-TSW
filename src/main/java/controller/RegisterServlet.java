package controller;

import model.DAO.UtenteDAO;
import model.DAO.Saldo_virtualeDAO;
import model.Obj.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.text.SimpleDateFormat;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "Register", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String dataNascitaStr = request.getParameter("data_nascita");
            String telefonoStr = request.getParameter("telefono");

            // 1. RIGIDO CONTROLLO LATO SERVER SUI CAMPI OBBLIGATORI VUOTI
            if (username == null || username.trim().isEmpty() ||
                    nome == null || nome.trim().isEmpty() ||
                    cognome == null || cognome.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    dataNascitaStr == null || dataNascitaStr.trim().isEmpty()) {

                // Rimandiamo indietro l'utente segnalando un errore di campi obbligatori mancanti
                response.sendRedirect(request.getContextPath() + "/register?registerError=2");
                return;
            }

            // Pulizia spazi bianchi sui dati sensibili di testo
            username = username.trim();
            email = email.trim();

            // Conversione sicura della data di nascita
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dataNascita = sdf.parse(dataNascitaStr);

            // Parsing sicuro e controllato per il numero di telefono opzionale
            long numero = 0;
            if (telefonoStr != null && !telefonoStr.trim().isEmpty()) {
                try {
                    numero = Long.parseLong(telefonoStr.trim());
                } catch (NumberFormatException e) {
                    System.err.println("Formato numero di telefono non valido in registrazione: " + telefonoStr);
                    // Prosegue impostando il valore di default a 0 senza interrompere il processo
                }
            }

            UtenteDAO dao = new UtenteDAO();

            // Controllo univocità dell'username
            if (dao.existsByUsername(username)) {
                response.sendRedirect(request.getContextPath() + "/register?registerError=1");
                return;
            }

            // 🔐 HASH PASSWORD
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            Utente u = new Utente();
            u.setUsername(username);
            u.setNome(nome.trim());
            u.setCognome(cognome.trim());
            u.setEmail(email);
            u.setPassword(hashedPassword);
            u.setData_di_nascita(dataNascita);
            u.setNumero(numero);

            // Salvataggio sul Database
            dao.doSave(u);

            // Inizializzazione automatica del Saldo Virtuale associato
            Saldo_virtualeDAO saldoDAO = new Saldo_virtualeDAO();
            Saldo_virtuale nuovoSaldo = new Saldo_virtuale();

            nuovoSaldo.setUsername(username);
            nuovoSaldo.setValuta(valuta.EUR);
            nuovoSaldo.setSaldo(new BigDecimal("0.00"));
            nuovoSaldo.setStato(Stato_saldo.Disponibile);
            nuovoSaldo.setData(new Date());

            saldoDAO.doSave(nuovoSaldo);

            // Apertura e gestione della sessione utente
            HttpSession session = request.getSession();
            session.setAttribute("username", u.getUsername());
            session.setAttribute("user", u);

            // Generazione del Cookie di autenticazione persistente
            Cookie cookie = new Cookie("username", u.getUsername());
            cookie.setMaxAge(60 * 60 * 24 * 30);
            cookie.setPath("/");
            cookie.setSecure(true);
            cookie.setHttpOnly(true);
            response.addCookie(cookie);

            // Successo: Accesso alla Home Page
            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            System.err.println("Errore imprevisto intercettato in RegisterServlet: " + e.getMessage());
            e.printStackTrace();
            // ❌ RIMOSSO IL THROW SERVLETEXCEPTION (Evita la schermata d'errore nativa di Tomcat)
            // Reindirizziamo l'utente in sicurezza mostrando una notifica di errore generico controllato
            response.sendRedirect(request.getContextPath() + "/register?registerError=3");
        }
    }
}