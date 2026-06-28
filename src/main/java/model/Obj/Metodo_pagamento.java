package model.Obj;

import java.util.Date;

public class Metodo_pagamento {

    private int IdMetodo;
    private String Username;
    private TipoMetodo TipoMetodo;
    private String Provider;
    private String TokenPagamento;
    private String Ultime4Cifre;
    private int ScadenzaMese;
    private int ScadenzaAnno;
    private boolean Predefinito;
    private boolean Attivo;
    private Date DataCreazione;

    // getter
    public int getIdMetodo() { return IdMetodo; }
    public String getUsername() { return Username; }
    public TipoMetodo getTipoMetodo() { return TipoMetodo; }
    public String getProvider() { return Provider; }
    public String getTokenPagamento() { return TokenPagamento; }
    public String getUltime4Cifre() { return Ultime4Cifre; }
    public int getScadenzaMese() { return ScadenzaMese; }
    public int getScadenzaAnno() { return ScadenzaAnno; }
    public boolean isPredefinito() { return Predefinito; }
    public boolean isAttivo() { return Attivo; }
    public Date getDataCreazione() { return DataCreazione; }

    // setter
    public void setIdMetodo(int IdMetodo) { this.IdMetodo = IdMetodo; }
    public void setUsername(String Username) { this.Username = Username; }
    public void setTipoMetodo(TipoMetodo TipoMetodo) { this.TipoMetodo = TipoMetodo; }
    public void setProvider(String Provider) { this.Provider = Provider; }
    public void setTokenPagamento(String TokenPagamento) { this.TokenPagamento = TokenPagamento; }
    public void setUltime4Cifre(String Ultime4Cifre) { this.Ultime4Cifre = Ultime4Cifre; }
    public void setScadenzaMese(int ScadenzaMese) { this.ScadenzaMese = ScadenzaMese; }
    public void setScadenzaAnno(int ScadenzaAnno) { this.ScadenzaAnno = ScadenzaAnno; }
    public void setPredefinito(boolean Predefinito) { this.Predefinito = Predefinito; }
    public void setAttivo(boolean Attivo) { this.Attivo = Attivo; }
    public void setDataCreazione(Date DataCreazione) { this.DataCreazione = DataCreazione; }
}