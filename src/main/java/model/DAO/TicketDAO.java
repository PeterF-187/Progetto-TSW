package model.DAO;
import model.ConPool;
import model.Obj.Tipo_ticket;
import model.Obj.Stato;
import model.Obj.Ticket;

import java.sql.Date;
import java.util.*;
import java.sql.*;

public class TicketDAO {

    public List<Ticket> doRetrieveAll() {
        List<Ticket> ticket = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Id_Ticket, Username_Account, id_prodotto_riguardato," +
                            " Data_di_invio, Motivazione, Tipo_ticket, Stato FROM Ticket");
            ResultSet rs = ps.executeQuery();
            // Usiamo while invece di if per scorrere tutta la tabella
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId_Ticket(rs.getInt(1));
                t.setUsername(rs.getString(2));
                t.setId_prodotto(rs.getInt(3));
                t.setData(rs.getDate(4));
                t.setMotivazione(rs.getString(5));
                t.setTipo(Tipo_ticket.valueOf(rs.getString(6)));
                t.setStato(Stato.valueOf(rs.getString(7)));
                ticket.add(t);
            }
            return ticket;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Ticket t) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Ticket (Id_Ticket, Username_Account, id_prodotto_riguardato," +
                            " Data_di_invio, Motivazione, Tipo_ticket, Stato) VALUES(?,?,?,?,?,?,?)");

            ps.setInt(1, t.getId_Ticket());
            ps.setString(2, t.getUsername());
            ps.setInt(3, t.getId_prodotto());
            ps.setDate(4, (Date) t.getData());
            ps.setString(5, t.getMotivazione());
            ps.setString(2, t.getTipo().name());
            ps.setString(2, t.getStato().name());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}