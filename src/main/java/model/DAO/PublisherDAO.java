package model.DAO;

import model.ConPool;
import model.Obj.Publisher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PublisherDAO {

    public List<Publisher> doRetrieveAll() {
        List<Publisher> publisherList = new ArrayList<>();

        String sql = "SELECT Nome_SH, Budget_marketing_annuo, Canale_distribuzione FROM Publisher";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Publisher p = new Publisher();

                p.setNome_SH(rs.getString("Nome_SH"));
                p.setBudget(rs.getBigDecimal("Budget_marketing_annuo"));
                p.setCanali(rs.getString("Canale_distribuzione"));

                publisherList.add(p);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return publisherList;
    }

    public void doSave(Publisher p) {

        String sql = "INSERT INTO Publisher " +
                "(Nome_SH, Budget_marketing_annuo, Canale_distribuzione) " +
                "VALUES (?, ?, ?)";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNome_SH());
            ps.setBigDecimal(2, p.getBudget());
            ps.setString(3, p.getCanali());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error in Publisher");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}