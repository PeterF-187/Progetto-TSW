package model.DAO;
import model.ConPool;
import model.Obj.Appartiene_categoria;
import model.Obj.Categorie;

import java.util.*;
import java.sql.*;

public class Appartiene_categoriaDAO {

    public List<Appartiene_categoria> doRetrieveAll() {
        List<Appartiene_categoria> appartenenza = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Nome_Categoria FROM Appartiene_categoria");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appartiene_categoria a = new Appartiene_categoria();
                a.setId_prodotto(rs.getInt(1));
                a.setCategoria(Categorie.valueOf(rs.getString(2)));
                appartenenza.add(a);
            }
            return appartenenza;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Appartiene_categoria a) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Appartiene_categoria (Id_prodotto, Nome_Categoria) VALUES(?,?)");

            ps.setInt(1, a.getId_prodotto());
            ps.setString(2, a.getCategoria().name());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}