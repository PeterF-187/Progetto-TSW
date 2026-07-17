package model.DAO;

import model.ConPool;
import model.Obj.Token2FA;

import java.sql.*;

public class Token2FADAO {

    public void save(Token2FA token) {
        String sql =
                "INSERT INTO token_2fa (Username, Token, Scadenza) " +
                        "VALUES (?, ?, ?) " +
                        "ON DUPLICATE KEY UPDATE " +
                        "Token = VALUES(Token), " +
                        "Scadenza = VALUES(Scadenza)";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, token.getUsername());
            ps.setString(2, token.getToken());
            ps.setTimestamp(
                    3,
                    new Timestamp(token.getScadenza().getTime())
            );

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public Token2FA findByUsername(String username) {
        String sql = "SELECT * FROM token_2fa WHERE Username = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Token2FA t = new Token2FA();
                t.setUsername(rs.getString("Username"));
                t.setToken(rs.getString("Token"));
                t.setScadenza(rs.getTimestamp("Scadenza"));

                return t;
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Errore findByUsername token 2FA: " + e.getMessage(),e);
        }
        return null;
    }

    public void deleteByUsername(String username) {
        String sql = "DELETE FROM token_2fa WHERE Username = ?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}