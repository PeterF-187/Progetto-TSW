package model.DAO;
import model.ConPool;
import model.Obj.Regione;
import model.Obj.Disponibile_in;

import java.util.*;
import java.sql.*;

public class Disponibile_inDAO {

    public List<Disponibile_in> doRetrieveAll() {
        List<Disponibile_in> disponibilita = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Nome_Regione FROM Disponibile_in");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Disponibile_in d = new Disponibile_in();
                d.setId_prodotto(rs.getInt(1));
                d.setNome_regione(Regione.valueOf(rs.getString(2)));
                disponibilita.add(d);
            }
            return disponibilita;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Disponibile_in d) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Disponibile_in (Id_prodotto, Nome_Regione) VALUES(?,?)");

            ps.setInt(1, d.getId_prodotto());
            ps.setString(2, d.getNome_regione().name());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Regione> doRetrieveByIdProdotto(int id) {

        List<Regione> regioni = new ArrayList<>();

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT Nome_Regione FROM Disponibile_in WHERE Id_prodotto=?");

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                regioni.add(Regione.valueOf(rs.getString(1)));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return regioni;
    }
}