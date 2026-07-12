package model.DAO;

import model.ConPool;
import model.Obj.Software_House;
import java.util.*;
import java.sql.*;

public class Software_HouseDAO {

    public List<Software_House> doRetrieveAll() {
        List<Software_House> softwareHouse = new ArrayList<>();

        // Modificato il nome della tabella in "Software_house" con la 'h' minuscola
        String sql = "SELECT Nome, Sede_legale, Anno_di_fondazione FROM Software_house";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Software_House sh = new Software_House();
                sh.setNome(rs.getString(1));
                sh.setSede(rs.getString(2));
                sh.setAnno(rs.getInt(3));
                softwareHouse.add(sh);
            }
            return softwareHouse;

        } catch (SQLException e) {
            throw new RuntimeException("Errore doRetrieveAll Software_house: " + e.getMessage(), e);
        }
    }

    public void doSave(Software_House sh) {
        // Modificato il nome della tabella in "Software_house" anche qui
        String sql = "INSERT INTO Software_house (Nome, Sede_legale, Anno_di_fondazione) VALUES(?,?,?)";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sh.getNome());
            ps.setString(2, sh.getSede());
            ps.setInt(3, sh.getAnno());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error su Software_house.");
            }

        } catch (SQLException e) {
            throw new RuntimeException("Errore doSave Software_house: " + e.getMessage(), e);
        }
    }
}