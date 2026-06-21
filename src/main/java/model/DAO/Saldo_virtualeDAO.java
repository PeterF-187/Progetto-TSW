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
            // Usiamo while invece di if per scorrere tutta la tabella
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

    public void doSave(Saldo_virtuale s) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Saldo_virtuale (Username_Account, Valuta, Saldo, Stato,Data_ultimo_aggiornamento) VALUES(?,?,?,?,?)");

            ps.setString(1, s.getUsername());
            ps.setString(2, s.getValuta().name());
            ps.setBigDecimal(3, s.getSaldo());
            ps.setString(4, s.getStato().name());
            ps.setDate(5, (Date) s.getData());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}