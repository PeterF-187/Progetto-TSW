package model.DAO;
import model.ConPool;
import model.Obj.rilascio_su;
import model.Obj.Piattaforma;

import java.util.*;
import java.sql.*;

public class rilascio_suDAO {

    public List<rilascio_su> doRetrieveAll() {
        List<rilascio_su> rilascio = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Nome_Piattaforma FROM rilascio_su");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                rilascio_su r = new rilascio_su();
                r.setId_prodotto(rs.getInt(1));
                r.setPiattaforma(Piattaforma.valueOf(rs.getString(2)));
                rilascio.add(r);
            }
            return rilascio;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(rilascio_su r) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO rilascio_su (Id_prodotto, Nome_Piattaforma) VALUES(?,?)");

            ps.setInt(1, r.getId_prodotto());
            ps.setString(2, r.getPiattaforma().name());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}