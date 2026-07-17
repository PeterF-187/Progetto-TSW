package model.DAO;
import model.ConPool;
import model.Obj.Stato_saldo;
import model.Obj.valuta;
import model.Obj.Saldo_virtuale;

import java.sql.Date;

import java.util.*;
import java.sql.*;

public class Saldo_virtualeDAO {

    public List<Saldo_virtuale> doRetrieveAll() {
        List<Saldo_virtuale> saldo = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Username_Account, Valuta, " +
                            "Saldo, Stato,Data_ultimo_aggiornamento FROM Saldo_virtuale");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Saldo_virtuale s = new Saldo_virtuale();
                s.setUsername(rs.getString(1));
                s.setValuta(valuta.valueOf(rs.getString(2)));
                s.setSaldo(rs.getBigDecimal(3));
                s.setStato(Stato_saldo.valueOf(rs.getString(4)));
                s.setData(rs.getDate(5));
                saldo.add(s);
            }
            return saldo;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Saldo_virtuale doRetrieveByUsername(String username) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Username_Account, Valuta, Saldo, Stato, Data_ultimo_aggiornamento " +
                            "FROM Saldo_virtuale WHERE Username_Account = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Saldo_virtuale s = new Saldo_virtuale();
                s.setUsername(rs.getString(1));
                s.setValuta(valuta.valueOf(rs.getString(2)));
                s.setSaldo(rs.getBigDecimal(3));
                s.setStato(Stato_saldo.valueOf(rs.getString(4)));
                s.setData(rs.getDate(5));
                return s;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doUpdate(Saldo_virtuale s) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE Saldo_virtuale SET Saldo = ?, Stato = ?, Data_ultimo_aggiornamento = ? " +
                            "WHERE Username_Account = ?");

            ps.setBigDecimal(1, s.getSaldo());
            ps.setString(2, s.getStato().name());
            ps.setTimestamp(3, new java.sql.Timestamp(new java.util.Date().getTime())); // Imposta l'ora attuale come ultimo aggiornamento
            ps.setString(4, s.getUsername());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error su Saldo_virtuale.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Saldo_virtuale s) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Saldo_virtuale (Username_Account, Valuta, Saldo, Stato, Data_ultimo_aggiornamento) " +
                            "VALUES (?, ?, ?, ?, ?)");

            ps.setString(1, s.getUsername());
            ps.setString(2, s.getValuta().name());
            ps.setBigDecimal(3, s.getSaldo());
            ps.setString(4, s.getStato().name());

            // CORREZIONE QUI: Convertiamo i millisecondi in modo sicuro per il database
            if (s.getData() != null) {
                ps.setTimestamp(5, new java.sql.Timestamp(s.getData().getTime()));
            } else {
                ps.setNull(5, Types.TIMESTAMP);
            }

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}