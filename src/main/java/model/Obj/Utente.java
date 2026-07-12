package model.Obj;

import java.util.Date;

public class Utente {

    private String Username;
    private String Nome;
    private String Cognome;
    private String Email;
    private String Password;
    private Date Data_di_nascita;
    private long Numero_di_telefono;
    private boolean is_admin;

    //getter
    public String getUsername() {
        return Username;
    }
    public String getNome() {
        return Nome;
    }
    public String getCognome() {
        return Cognome;
    }
    public String getEmail() {
        return Email;
    }
    public String getPassword() {
        return Password;
    }
    public Date getData_di_nascita() {
        return Data_di_nascita;
    }
    public long getNumero() {
        return Numero_di_telefono;
    }
    public boolean isAdmin() {
        return is_admin;
    }

    //setter
    public void setUsername(String username) {
        Username = username;
    }
    public void setNome(String nome) {
        Nome = nome;
    }
    public void setCognome(String cognome) {
        Cognome = cognome;
    }
    public void setEmail(String email) {
        Email = email;
    }
    public void setPassword(String password) {
        Password = password;
    }
    public void setData_di_nascita(Date data_di_nascita) {
        Data_di_nascita = data_di_nascita;
    }
    public void setNumero(long numero) {
        Numero_di_telefono = numero;
    }

    public void setAdmin(boolean admin) {
        this.is_admin = admin;
    }
}