package model.DAO;

import model.ConPool;
import model.Obj.Acquisto;

import java.sql.*;
import java.util.*;

public class AcquistoDAO {

    public List<Acquisto> doRetrieveAll() {

        List<Acquisto> list = new ArrayList<>();

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT Username_Account, Id_prodotto, Data_acquisto, Prezzo_pagato, Metodo_di_pagamento, Id_key FROM Acquisto"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Acquisto a = new Acquisto();
                a.setUsername(rs.getString("Username_Account"));
                a.setId(rs.getInt("Id_prodotto"));
                a.setData_acquisto(rs.getDate("Data_acquisto"));
                a.setPrezzo_pagato(rs.getBigDecimal("Prezzo_pagato"));
                a.setMetodo_di_pagamento(rs.getString("Metodo_di_pagamento"));
                a.setId_key(rs.getInt("Id_key"));

                list.add(a);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    public void doSave(Acquisto a) {

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Acquisto (Username_Account, Id_prodotto, Data_acquisto, Prezzo_pagato, Metodo_di_pagamento, Id_key) " +
                            "VALUES (?,?,?,?,?,?)"
            );

            ps.setString(1, a.getUsername());
            ps.setInt(2, a.getId());
            ps.setDate(3, new java.sql.Date(a.getData_acquisto().getTime()));
            ps.setBigDecimal(4, a.getPrezzo_pagato());
            ps.setString(5, a.getMetodo_di_pagamento());
            ps.setInt(6, a.getId_key());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}