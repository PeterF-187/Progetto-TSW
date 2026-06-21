package model.DAO;
import model.ConPool;
import model.Obj.Generi;
import model.Obj.Appartiene_genere;

import java.util.*;
import java.sql.*;

public class Appartiene_genereDAO {

    public List<Appartiene_genere> doRetrieveAll() {
        List<Appartiene_genere> appartenenza = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Nome_Genere FROM Appartiene_genere");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appartiene_genere a = new Appartiene_genere();
                a.setId_prodotto(rs.getInt(1));
                a.setGenere(Generi.valueOf(rs.getString(2)));
                appartenenza.add(a);
            }
            return appartenenza;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Appartiene_genere a) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Appartiene_genere (Id_prodotto, Nome_genere) VALUES(?,?)");

            ps.setInt(1, a.getId_prodotto());
            ps.setString(2, a.getGenere().name());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}