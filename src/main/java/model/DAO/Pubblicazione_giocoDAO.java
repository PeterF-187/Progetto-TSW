package model.DAO;
import model.ConPool;
import model.Obj.Pubblicazione_gioco;

import java.util.*;
import java.sql.*;

public class Pubblicazione_giocoDAO {

    public List<Pubblicazione_gioco> doRetrieveAll() {
        List<Pubblicazione_gioco> pubblicazione = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Nome_Publisher FROM Pubblicazione_gioco");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pubblicazione_gioco p = new Pubblicazione_gioco();
                p.setId_prodotto(rs.getInt(1));
                p.setNome_Publisher(rs.getString(2));
                pubblicazione.add(p);
            }
            return pubblicazione;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Pubblicazione_gioco a) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Pubblicazione_gioco (Id_prodotto, Nome_Publisher) VALUES(?,?)");

            ps.setInt(1, a.getId_prodotto());
            ps.setString(2, a.getNome_Publisher());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<String> doRetrieveByIdProdotto(int id) {
        List<String> publishers = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Nome_Publisher FROM Pubblicazione_gioco WHERE Id_prodotto=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                publishers.add(rs.getString(1));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return publishers;
    }
}