package model.DAO;
import model.ConPool;
import model.Obj.Sviluppo_gioco;

import java.util.*;
import java.sql.*;

public class Sviluppo_giocoDAO {

    public List<Sviluppo_gioco> doRetrieveAll() {
        List<Sviluppo_gioco> sviluppo = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Nome_SH FROM Sviluppo_gioco");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Sviluppo_gioco s = new Sviluppo_gioco();
                s.setId_prodotto(rs.getInt(1));
                s.setNome_SH(rs.getString(2));
                sviluppo.add(s);
            }
            return sviluppo;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Sviluppo_gioco s) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Sviluppo_gioco (Id_prodotto, Nome_SH) VALUES(?,?)");

            ps.setInt(1, s.getId_prodotto());
            ps.setString(1, s.getNome_SH());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public List<String> doRetrieveByIdProdotto(int id) {
        List<String> sviluppatori = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Nome_SH FROM Sviluppo_gioco WHERE Id_prodotto=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                sviluppatori.add(rs.getString(1));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return sviluppatori;
    }
}