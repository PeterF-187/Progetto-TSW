package model.Obj;

import java.math.BigDecimal;
import java.util.Date;

public class Saldo_virtuale {
    private String Username_Account;
    private valuta Valuta;
    private BigDecimal Saldo;
    private Stato_saldo Stato;
    private Date Data_ultimo_aggiornamento;

    //getter
    public String getUsername() {
        return Username_Account;
    }
    public valuta getValuta() {
        return Valuta;
    }
    public BigDecimal getSaldo() {
        return Saldo;
    }
    public Stato_saldo getStato() {
        return Stato;
    }
    public Date getData() {
        return Data_ultimo_aggiornamento;
    }

    //setter
    public void setUsername(String Username_Account) {
        this.Username_Account = Username_Account;
    }
    public void setValuta(valuta Valuta) {
        this.Valuta = Valuta;
    }
    public void setSaldo(BigDecimal Saldo) {
        this.Saldo = Saldo;
    }
    public void setStato(Stato_saldo Stato) {
        this.Stato = Stato;
    }
    public void setData(Date Data_ultimo_aggiornamento) {
        this.Data_ultimo_aggiornamento =  Data_ultimo_aggiornamento;
    }
}
