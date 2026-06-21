package model.DAO;
import model.ConPool;
import model.Obj.Sviluppatori;

import java.util.*;
import java.sql.*;

public class SviluppatoriDAO {

    public List<Sviluppatori> doRetrieveAll() {
        List<Sviluppatori> sviluppatori = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Nome_SH, N_Sviluppatori, Tipologia, Motore_grafico FROM Sviluppatori");
            ResultSet rs = ps.executeQuery();
            // Usiamo while invece di if per scorrere tutta la tabella
            while (rs.next()) {
                Sviluppatori s = new Sviluppatori();
                s.setNome_SH(rs.getString(1));
                s.setN_Sviluppatori(rs.getInt(2));
                s.setTipologia(rs.getString(3));
                s.setMotore_grafico(rs.getString(4));
                sviluppatori.add(s);
            }
            return sviluppatori;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Sviluppatori s) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Sviluppatori (Nome_SH, N_Sviluppatori, Tipologia, Motore_grafico) VALUES(?,?,?,?)");

            ps.setString(1, s.getNome_SH());
            ps.setInt(2, s.getN_Sviluppatori());
            ps.setString(3, s.getTipologia());
            ps.setString(3, s.getMotore_grafico());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}