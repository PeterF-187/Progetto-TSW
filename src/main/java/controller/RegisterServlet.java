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

        request.getRequestDispatcher("/WEB-INF/views/auth.jsp")
                .forward(request, response);
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
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dataNascita = sdf.parse(dataNascitaStr);

            String telefonoStr = request.getParameter("telefono");
            long numero = (telefonoStr != null && !telefonoStr.isEmpty())
                    ? Long.parseLong(telefonoStr)
                    : 0;

            UtenteDAO dao = new UtenteDAO();

            if (dao.existsByUsername(username)) {
                response.sendRedirect(request.getContextPath() + "/auth.jsp?registerError=1");
                return;
            }

            // 🔐 HASH PASSWORD
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            Utente u = new Utente();
            u.setUsername(username);
            u.setNome(nome);
            u.setCognome(cognome);
            u.setEmail(email);
            u.setPassword(hashedPassword); // ✔ password cifrata
            u.setData_di_nascita(dataNascita);
            u.setNumero(numero);

            dao.doSave(u);

            // saldo iniziale
            Saldo_virtualeDAO saldoDAO = new Saldo_virtualeDAO();
            Saldo_virtuale nuovoSaldo = new Saldo_virtuale();

            nuovoSaldo.setUsername(username);
            nuovoSaldo.setValuta(valuta.EUR);
            nuovoSaldo.setSaldo(new BigDecimal("0.00"));
            nuovoSaldo.setStato(Stato_saldo.Disponibile);
            nuovoSaldo.setData(new Date());

            saldoDAO.doSave(nuovoSaldo);

            // sessione
            HttpSession session = request.getSession();
            session.setAttribute("username", u.getUsername());
            session.setAttribute("user", u);

            Cookie cookie = new Cookie("username", u.getUsername());
            cookie.setMaxAge(60 * 60 * 24 * 30);
            cookie.setPath("/");
            cookie.setSecure(true);
            cookie.setHttpOnly(true);
            response.addCookie(cookie);

            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}