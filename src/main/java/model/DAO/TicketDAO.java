package model.DAO;

import model.ConPool;
import model.Obj.Tipo_ticket;
import model.Obj.Stato;
import model.Obj.Ticket;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO {

    // 1. Modifica il doRetrieveAll per leggere anche le risposte
    public List<Ticket> doRetrieveAll() {
        List<Ticket> tickets = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Id_Ticket, Username_Account, id_prodotto_riguardato, Data_di_invio, " +
                            "Motivazione, Tipo_ticket, Stato, Risposta_Admin, Username_Admin FROM Ticket");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId_Ticket(rs.getInt("Id_Ticket"));
                t.setUsername(rs.getString("Username_Account"));

                int idProd = rs.getInt("id_prodotto_riguardato");
                t.setId_prodotto(rs.wasNull() ? null : idProd);

                t.setData(rs.getDate("Data_di_invio"));
                t.setMotivazione(rs.getString("Motivazione"));
                t.setTipo(Tipo_ticket.valueOf(rs.getString("Tipo_ticket")));
                t.setStato(Stato.valueOf(rs.getString("Stato")));

                // 🔥 NUOVO: Recupero dati dell'evasione
                t.setRispostaAdmin(rs.getString("Risposta_Admin"));
                t.setUsernameAdmin(rs.getString("Username_Admin"));

                tickets.add(t);
            }
            return tickets;
        } catch (SQLException e) {
            throw new RuntimeException("Errore doRetrieveAll ticket: " + e.getMessage(), e);
        }
    }

    // 2. NUOVO METODO: Salva la risposta e aggiorna lo stato contemporaneamente
    public void doRispondiEChiudi(int idTicket, String risposta, String usernameAdmin, Stato nuovoStato) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE Ticket SET Stato = ?, Risposta_Admin = ?, Username_Admin = ? WHERE Id_Ticket = ?");
            ps.setString(1, nuovoStato.name());
            ps.setString(2, risposta);
            ps.setString(3, usernameAdmin);
            ps.setInt(4, idTicket);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("Errore salvataggio risposta ticket.");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore DB doRispondiEChiudi ticket: " + e.getMessage(), e);
        }
    }

    // 2. RECUPERA I TICKET DI UN SINGOLO UTENTE (Serve alla Dashboard del Cliente)
    public List<Ticket> doRetrieveByUsername(String username) {
        List<Ticket> tickets = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Id_Ticket, Username_Account, id_prodotto_riguardato, Data_di_invio, Motivazione, Tipo_ticket, Stato " +
                            "FROM Ticket WHERE Username_Account = ? ORDER BY Data_di_invio DESC");

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId_Ticket(rs.getInt("Id_Ticket"));
                t.setUsername(rs.getString("Username_Account"));

                int idProd = rs.getInt("id_prodotto_riguardato");
                t.setId_prodotto(rs.wasNull() ? null : idProd);

                t.setData(rs.getDate("Data_di_invio"));
                t.setMotivazione(rs.getString("Motivazione"));
                t.setTipo(Tipo_ticket.valueOf(rs.getString("Tipo_ticket")));
                t.setStato(Stato.valueOf(rs.getString("Stato")));
                tickets.add(t);
            }
            return tickets;
        } catch (SQLException e) {
            throw new RuntimeException("Errore recupero ticket utente: " + e.getMessage(), e);
        }
    }

    // 3. RECUPERA UN SINGOLO TICKET TRAMITE ID (Serve all'Admin quando deve rispondere)
    public Ticket doRetrieveById(int idTicket) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT Id_Ticket, Username_Account, id_prodotto_riguardato, Data_di_invio, Motivazione, Tipo_ticket, Stato " +
                            "FROM Ticket WHERE Id_Ticket = ?");
            ps.setInt(1, idTicket);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Ticket t = new Ticket();
                t.setId_Ticket(rs.getInt("Id_Ticket"));
                t.setUsername(rs.getString("Username_Account"));

                int idProd = rs.getInt("id_prodotto_riguardato");
                t.setId_prodotto(rs.wasNull() ? null : idProd);

                t.setData(rs.getDate("Data_di_invio"));
                t.setMotivazione(rs.getString("Motivazione"));
                t.setTipo(Tipo_ticket.valueOf(rs.getString("Tipo_ticket")));
                t.setStato(Stato.valueOf(rs.getString("Stato")));
                return t;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Errore recupero ticket per ID: " + e.getMessage(), e);
        }
    }

    // 4. AGGIORNA LO STATO DI UN TICKET (Serve all'Admin per chiudere le pratiche)
    public void doUpdateStato(int idTicket, Stato nuovoStato) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE Ticket SET Stato = ? WHERE Id_Ticket = ?");
            ps.setString(1, nuovoStato.name());
            ps.setInt(2, idTicket);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("Errore durante l'aggiornamento dello stato del ticket.");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore DB doUpdateStato ticket: " + e.getMessage(), e);
        }
    }

    // 5. SALVA UN NUOVO TICKET (Serve all'Utente quando invia il form)
    public void doSave(Ticket t) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Ticket (Username_Account, id_prodotto_riguardato, Data_di_invio, Motivazione, Tipo_ticket, Stato) " +
                            "VALUES(?,?,?,?,?,?)");

            ps.setString(1, t.getUsername());

            if (t.getId_prodotto() != null && t.getId_prodotto() > 0) {
                ps.setInt(2, t.getId_prodotto());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setDate(3, new java.sql.Date(t.getData().getTime()));
            ps.setString(4, t.getMotivazione());
            ps.setString(5, t.getTipo().name());
            ps.setString(6, t.getStato().name());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error ticket.");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore salvataggio ticket: " + e.getMessage(), e);
        }
    }
}