package model.DAO;

import model.ConPool;
import model.Obj.ImpostazioniUtente;

import java.sql.*;

public class ImpostazioniDAO {

    public ImpostazioniUtente doRetrieveByUsername(String username){
        try(Connection con = ConPool.getConnection()){
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Impostazioni_Utente WHERE Username=?"
            );
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                ImpostazioniUtente i = new ImpostazioniUtente();
                i.setUsername(rs.getString("Username"));
                i.setDueFattori(rs.getBoolean("Due_Fattori"));

                return i;
            }
            return null;

        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public boolean isDueFattori(String username){
        ImpostazioniUtente i = doRetrieveByUsername(username);
        return i != null && i.isDueFattori();
    }

    public boolean setDueFattori(String username, boolean stato){
        try(Connection con = ConPool.getConnection()){
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE Impostazioni_Utente SET Due_Fattori=? WHERE Username=?"
            );
            ps.setBoolean(1, stato);
            ps.setString(2, username);

            return ps.executeUpdate()==1;

        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
}