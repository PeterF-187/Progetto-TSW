package model.DAO;

import model.ConPool;
import model.Obj.Product_keys;
import model.Obj.Status;

import java.sql.*;
import java.util.*;

public class Product_keysDAO {

    public List<Product_keys> doRetrieveAll() {
        List<Product_keys> list = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Id_key, Id_prodotto, Chiave, status FROM Product_keys"
            );
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product_keys pk = new Product_keys();
                pk.setId_key(rs.getInt("Id_key"));
                pk.setId_prodotto(rs.getInt("Id_prodotto"));
                pk.setChiave(rs.getString("Chiave"));
                pk.setStatus(Status.valueOf(rs.getString("status")));

                list.add(pk);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    public Product_keys doRetrieveAvailableByProduct(int idProdotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Id_key, Id_prodotto, Chiave, status " +
                            "FROM Product_keys " +
                            "WHERE Id_prodotto = ? AND status = 'Disponibile' " +
                            "LIMIT 1"
            );

            ps.setInt(1, idProdotto);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product_keys pk = new Product_keys();
                pk.setId_key(rs.getInt("Id_key"));
                pk.setId_prodotto(rs.getInt("Id_prodotto"));
                pk.setChiave(rs.getString("Chiave"));
                pk.setStatus(Status.valueOf(rs.getString("status")));

                return pk;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public void doUpdateStatus(Product_keys pk) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE Product_keys SET status='Venduto' WHERE Id_key=?"
            );
            ps.setInt(1, pk.getId_key());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Product_keys pk) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Product_keys (Id_prodotto, Chiave, status) VALUES (?,?,?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, pk.getId_prodotto());
            ps.setString(2, pk.getChiave());
            ps.setString(3, pk.getStatus().name());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                pk.setId_key(rs.getInt(1));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}