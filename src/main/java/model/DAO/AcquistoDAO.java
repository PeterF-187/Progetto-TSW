package model.DAO;
import model.ConPool;
import model.Obj.Acquisto;

import java.sql.Date;
import java.util.*;
import java.sql.*;

public class AcquistoDAO {

    public List<Acquisto> doRetrieveAll() {
        List<Acquisto> acquisto = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Username_Account, Id_prodotto, Data_acquisto, " +
                            "Prezzo_pagato, Metodo_di_pagamento FROM Acquisto");
            ResultSet rs = ps.executeQuery();
            // Usiamo while invece di if per scorrere tutta la tabella
            while (rs.next()) {
                Acquisto a = new Acquisto();
                a.setUsername(rs.getString(1));
                a.setId(rs.getInt(2));
                a.setData_acquisto(rs.getDate(3));
                a.setPrezzo_pagato(rs.getBigDecimal(4));
                a.setMetodo_di_pagamento(rs.getString(5));
                acquisto.add(a);
            }
            return acquisto;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Acquisto a) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Acquisto (Username_Account, Id_prodotto, Data_acquisto, Prezzo_pagato, Metodo_di_pagamento) VALUES(?,?,?,?,?)");

            ps.setString(1, a.getUsername());
            ps.setInt(2, a.getId());
            ps.setDate(3, (Date) a.getData_acquisto());
            ps.setBigDecimal(4, a.getPrezzo_pagato());
            ps.setString(5, a.getMetodo_di_pagamento());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}