package model.DAO;
import model.ConPool;
import model.Obj.Videogioco;

import java.sql.Date;
import java.util.*;
import java.sql.*;
import java.math.BigDecimal;

public class VideogiocoDAO {

    public List<Videogioco> doRetrieveAll() {
        List<Videogioco> videogioco = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_prodotto, Titolo, Prezzo, " +
                            "Data_rilascio, Descrizione_testuale, immagine FROM Videogioco");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Videogioco v = new Videogioco();
                v.setId_prodotto(rs.getInt(1));
                v.setTitolo(rs.getString(2));
                v.setPrezzo(rs.getBigDecimal(3));
                v.setData_rilascio(rs.getDate(4));
                v.setDesc(rs.getString(5));
                v.setImg(rs.getString(6));
                videogioco.add(v);
            }
            return videogioco;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Videogioco> doRetrieveConsigliati(int idProdotto) {

        List<Videogioco> lista = new ArrayList<>();

        String sql =
                "SELECT DISTINCT v.* " +
                        "FROM Videogioco v " +
                        "JOIN Appartiene_genere ag ON v.Id_prodotto = ag.Id_prodotto " +
                        "WHERE ag.Nome_Genere IN (" +
                        "SELECT Nome_Genere " +
                        "FROM Appartiene_genere " +
                        "WHERE Id_prodotto = ?" +
                        ") " +
                        "AND v.Id_prodotto <> ? " +
                        "LIMIT 3";

        try(Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, idProdotto);
            ps.setInt(2, idProdotto);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Videogioco v = new Videogioco();

                v.setId_prodotto(rs.getInt("Id_prodotto"));
                v.setTitolo(rs.getString("Titolo"));
                v.setPrezzo(rs.getBigDecimal("Prezzo"));
                v.setDesc(rs.getString("Descrizione_testuale"));
                v.setImg(rs.getString("immagine"));
                v.setData_rilascio(rs.getDate("Data_rilascio"));

                lista.add(v);
            }

        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

    public List<Videogioco> cercaPerTitolo(String query) {

        List<Videogioco> lista = new ArrayList<>();

        try(Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Videogioco WHERE Titolo LIKE ? LIMIT 5");

            ps.setString(1, query + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Videogioco v = new Videogioco();

                v.setId_prodotto(rs.getInt("Id_prodotto"));
                v.setTitolo(rs.getString("Titolo"));
                v.setPrezzo(rs.getBigDecimal("Prezzo"));
                v.setDesc(rs.getString("Descrizione_testuale"));
                v.setImg(rs.getString("immagine"));

                lista.add(v);
            }

        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

    public Videogioco doRetrieveById(int id) {

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT Id_prodotto, Titolo, Prezzo, Data_rilascio, " +
                            "Descrizione_testuale, immagine " +
                            "FROM Videogioco WHERE Id_prodotto = ?");

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Videogioco v = new Videogioco();

                v.setId_prodotto(rs.getInt("Id_prodotto"));
                v.setTitolo(rs.getString("Titolo"));
                v.setPrezzo(rs.getBigDecimal("Prezzo"));
                v.setData_rilascio(rs.getDate("Data_rilascio"));
                v.setDesc(rs.getString("Descrizione_testuale"));
                v.setImg(rs.getString("immagine"));

                return v;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }


    public void doSave(Videogioco v) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Videogioco (Titolo, Prezzo, Data_rilascio, Descrizione_testuale, immagine) VALUES(?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, v.getTitolo());
            ps.setBigDecimal(2, v.getPrezzo());
            ps.setDate(3, (Date) v.getData_rilascio());
            ps.setString(4, v.getDesc());
            ps.setString(5, v.getImg());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int id = rs.getInt(1);
            v.setId_prodotto(id);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Videogioco> filtra(
            String[] categorie,
            String[] generi,
            String[] piattaforme,
            String[] lingue,
            String[] regioni,
            BigDecimal minPrice,
            BigDecimal maxPrice) {

        List<Videogioco> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT v.* " +
                        "FROM Videogioco v ");

        if (categorie != null && categorie.length > 0)
            sql.append("JOIN Appartiene_categoria ac ON v.Id_prodotto = ac.Id_prodotto ");

        if (generi != null && generi.length > 0)
            sql.append("JOIN Appartiene_genere ag ON v.Id_prodotto = ag.Id_prodotto ");

        if (piattaforme != null && piattaforme.length > 0)
            sql.append("JOIN rilascio_su rs ON v.Id_prodotto = rs.Id_prodotto ");

        if (lingue != null && lingue.length > 0)
            sql.append("JOIN Supporta s ON v.Id_prodotto = s.Id_prodotto ");

        if (regioni != null && regioni.length > 0)
            sql.append("JOIN Disponibile_in d ON v.Id_prodotto = d.Id_prodotto ");

        sql.append("WHERE 1=1 ");

        if (categorie != null && categorie.length > 0) {
            sql.append("AND ac.Nome_categoria IN (");
            for (int i = 0; i < categorie.length; i++) {
                sql.append("?");
                if (i < categorie.length - 1)
                    sql.append(",");
            }
            sql.append(") ");
        }

        if (generi != null && generi.length > 0) {
            sql.append("AND ag.Nome_genere IN (");
            for (int i = 0; i < generi.length; i++) {
                sql.append("?");
                if (i < generi.length - 1)
                    sql.append(",");
            }
            sql.append(") ");
        }

        if (piattaforme != null && piattaforme.length > 0) {
            sql.append("AND rs.Nome_piattaforma IN (");
            for (int i = 0; i < piattaforme.length; i++) {
                sql.append("?");
                if (i < piattaforme.length - 1)
                    sql.append(",");
            }
            sql.append(") ");
        }

        if (lingue != null && lingue.length > 0) {
            sql.append("AND s.Lingua IN (");
            for (int i = 0; i < lingue.length; i++) {
                sql.append("?");
                if (i < lingue.length - 1)
                    sql.append(",");
            }
            sql.append(") ");
        }

        if (regioni != null && regioni.length > 0) {
            sql.append("AND d.Nome_regione IN (");
            for (int i = 0; i < regioni.length; i++) {
                sql.append("?");
                if (i < regioni.length - 1)
                    sql.append(",");
            }
            sql.append(") ");
        }

        if (minPrice != null)
            sql.append("AND v.Prezzo >= ? ");

        if (maxPrice != null)
            sql.append("AND v.Prezzo <= ? ");

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(sql.toString());

            int indice = 1;

            if (categorie != null)
                for (String c : categorie)
                    ps.setString(indice++, c);

            if (generi != null)
                for (String g : generi)
                    ps.setString(indice++, g);

            if (piattaforme != null)
                for (String p : piattaforme)
                    ps.setString(indice++, p);

            if (lingue != null)
                for (String l : lingue)
                    ps.setString(indice++, l);

            if (regioni != null)
                for (String r : regioni)
                    ps.setString(indice++, r);

            if (minPrice != null)
                ps.setBigDecimal(indice++, minPrice);

            if (maxPrice != null)
                ps.setBigDecimal(indice++, maxPrice);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Videogioco v = new Videogioco();

                v.setId_prodotto(rs.getInt("Id_prodotto"));
                v.setTitolo(rs.getString("Titolo"));
                v.setPrezzo(rs.getBigDecimal("Prezzo"));
                v.setData_rilascio(rs.getDate("Data_rilascio"));
                v.setDesc(rs.getString("Descrizione_testuale"));
                v.setImg(rs.getString("immagine"));

                lista.add(v);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

}