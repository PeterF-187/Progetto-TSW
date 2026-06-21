package model.Obj;
import java.util.Date;

public class Ticket {
    private int Id_ticket;
    private String Username_Account;
    private int Id_prodotto_riguardato;
    private Date Data_di_invio;
    private String Motivazione;
    private Tipo_ticket Tipo_ticket;
    private Stato Stato;

    //getter
    public int getId_Ticket() {
        return Id_ticket;
    }
    public String getUsername() {
        return Username_Account;
    }
    public int getId_prodotto() {
        return Id_prodotto_riguardato;
    }
    public Date getData() {
        return Data_di_invio;
    }
    public String getMotivazione() {
        return Motivazione;
    }
    public Tipo_ticket getTipo() {
        return Tipo_ticket;
    }
    public Stato getStato() {
        return Stato;
    }

    //setter
    public void setId_Ticket(int Id_ticket) {
        this.Id_ticket = Id_ticket;
    }
    public void setUsername(String Username) {
        this.Username_Account = Username;
    }
    public void setId_prodotto(int Id_prodotto) {
        this.Id_prodotto_riguardato = Id_prodotto;
    }
    public void setData(Date Data_di_invio) {
        this.Data_di_invio = Data_di_invio;
    }
    public void setMotivazione(String Motivazione) {
        this.Motivazione = Motivazione;
    }
    public void setTipo(Tipo_ticket Tipo_ticket) {
        this.Tipo_ticket = Tipo_ticket;
    }
    public void setStato(Stato Stato) {
        this.Stato = Stato;
    }
}
