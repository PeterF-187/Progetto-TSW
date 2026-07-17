package model.DAO;
import model.ConPool;
import model.Obj.Supporta;
import model.Obj.Lingue;

import java.util.*;
import java.sql.*;

public class SupportaDAO {

    public List<Supporta> doRetrieveAll() {
        List<Supporta> supporta = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Lingua FROM Supporta");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Supporta s = new Supporta();
                s.setId_prodotto(rs.getInt(1));
                s.setLingua(Lingue.valueOf(rs.getString(2)));
                supporta.add(s);
            }
            return supporta;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Supporta s) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Supporta (Id_prodotto, Lingua) VALUES(?,?)");

            ps.setInt(1, s.getId_prodotto());
            ps.setString(2, s.getLingua().name());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Lingue> doRetrieveByIdProdotto(int id) {
        List<Lingue> lingue = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Lingua FROM Supporta WHERE Id_prodotto=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                lingue.add(Lingue.valueOf(rs.getString(1)));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return lingue;
    }
}