package model.DAO;

import model.ConPool;
import model.Obj.Utente;

import java.sql.*;
import java.util.*;

public class UtenteDAO {

    public List<Utente> doRetrieveAll() {
        List<Utente> utenti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Username, Nome, Cognome, Email, Password, Data_di_nascita, Numero_di_telefono, is_admin FROM Utente");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Utente u = new Utente();
                u.setUsername(rs.getString("Username"));
                u.setNome(rs.getString("Nome"));
                u.setCognome(rs.getString("Cognome"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setData_di_nascita(rs.getDate("Data_di_nascita"));
                u.setNumero(rs.getLong("Numero_di_telefono"));

                u.setAdmin(rs.getBoolean("is_admin"));

                utenti.add(u);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Errore doRetrieveAll: " + e.getMessage(), e);
        }

        return utenti;
    }

    public Utente doRetrieveByUsername(String username) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Utente WHERE Username = ?");
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Utente u = new Utente();
                u.setUsername(rs.getString("Username"));
                u.setNome(rs.getString("Nome"));
                u.setCognome(rs.getString("Cognome"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password")); // hash BCrypt
                u.setData_di_nascita(rs.getDate("Data_di_nascita"));
                u.setNumero(rs.getLong("Numero_di_telefono"));
                u.setAdmin(rs.getBoolean("is_admin"));
                return u;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Errore recupero utente: " + e.getMessage(), e);
        }
        return null;
    }

    public boolean doUpdate(String username, String nuovaPassword) {

        String sql = "UPDATE Utente SET Password = ? WHERE Username = ?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuovaPassword);
            ps.setString(2, username);

            int rows = ps.executeUpdate();

            return rows == 1;

        } catch (SQLException e) {
            throw new RuntimeException("Errore doUpdate password: " + e.getMessage(), e);
        }
    }

    public void doSave(Utente u) {
        String sql = "INSERT INTO Utente " +
                "(Username, Nome, Cognome, Email, Password, Data_di_nascita, Numero_di_telefono) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getNome());
            ps.setString(3, u.getCognome());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPassword());

            if (u.getData_di_nascita() != null) {
                ps.setDate(6, new java.sql.Date(u.getData_di_nascita().getTime()));
            } else {
                ps.setNull(6, Types.DATE);
            }

            if (u.getNumero() > 0) {
                ps.setLong(7, u.getNumero());
            } else {
                ps.setNull(7, Types.BIGINT);
            }
            int rows = ps.executeUpdate();

            if (rows != 1) {
                throw new RuntimeException("Insert fallito, righe inserite = " + rows);
            }
        } catch (SQLException e) {
            throw new RuntimeException("DB ERROR doSave: " + e.getMessage(), e);
        }
    }

    public boolean existsByUsername(String username) {

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT 1 FROM Utente WHERE Username = ?"
             )) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Errore existsByUsername: " + e.getMessage(), e);
        }
    }
}