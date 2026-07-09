package model.Obj;

import java.sql.Timestamp;

public class Token2FA {

    private String token;
    private String username;
    private Timestamp scadenza;

    public Token2FA() {
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getScadenza() {
        return scadenza;
    }

    public void setScadenza(Timestamp scadenza) {
        this.scadenza = scadenza;
    }
}