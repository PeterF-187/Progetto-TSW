package model.DAO;
import model.ConPool;
import model.Obj.Software_House;

import java.util.*;
import java.sql.*;

public class Software_HouseDAO {

    public List<Software_House> doRetrieveAll() {
        List<Software_House> softwareHouse = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Nome, Sede_legale, Anno_di_fondazione FROM Software_House");
            ResultSet rs = ps.executeQuery();
            // Usiamo while invece di if per scorrere tutta la tabella
            while (rs.next()) {
                Software_House sh = new Software_House();
                sh.setNome(rs.getString(1));
                sh.setSede(rs.getString(2));
                sh.setAnno(rs.getInt(3));
                softwareHouse.add(sh);
            }
            return softwareHouse;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Software_House sh) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Software_House (Nome, Sede_legale, Anno_di_fondazione) VALUES(?,?,?)");

            ps.setString(1, sh.getNome());
            ps.setString(2, sh.getSede());
            ps.setInt(3, sh.getAnno());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}