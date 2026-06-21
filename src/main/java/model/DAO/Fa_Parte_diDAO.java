package model.DAO;
import model.ConPool;
import model.Obj.Fa_Parte_di;

import java.util.*;
import java.sql.*;

public class Fa_Parte_diDAO {

    public List<Fa_Parte_di> doRetrieveAll() {
        List<Fa_Parte_di> fpd = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Titolo_Franchise FROM Fa_Parte_di");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Fa_Parte_di f = new Fa_Parte_di();
                f.setId_prodotto(rs.getInt(1));
                f.setFranchise(rs.getString(2));
                fpd.add(f);
            }
            return fpd;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Fa_Parte_di f) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Fa_Parte_di (Id_prodotto, Titolo_Franchise) VALUES(?,?)");

            ps.setInt(1, f.getId_prodotto());
            ps.setString(2, f.getFranchise());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public String doRetrieveByIdProdotto(int id) {

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT Titolo_Franchise FROM Fa_Parte_di WHERE Id_prodotto=?");

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }
}