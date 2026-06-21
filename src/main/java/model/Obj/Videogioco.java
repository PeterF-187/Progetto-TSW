package model.Obj;
import java.math.BigDecimal;
import java.util.Date;

public class Videogioco {
    private int Id_prodotto;
    private String Titolo;
    private BigDecimal Prezzo;
    private Date Data_rilascio;
    private String Descrizione_testuale;
    private String immagine;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public String getTitolo() {
        return Titolo;
    }
    public BigDecimal getPrezzo() {
        return Prezzo;
    }
    public Date getData_rilascio() {
        return Data_rilascio;
    }
    public String getDesc() {
        return Descrizione_testuale;
    }
    public String getImg() {
        return immagine;
    }

    //setter
    public void setId_prodotto(int id_prodotto) {
        this.Id_prodotto = id_prodotto;
    }
    public void setTitolo(String Titolo) {
        this.Titolo = Titolo;
    }
    public void setPrezzo(BigDecimal Prezzo) {
        this.Prezzo = Prezzo;
    }
    public void setData_rilascio(Date Data_rilascio) {
        this.Data_rilascio = Data_rilascio;
    }
    public void setDesc(String Descrizione) {
        this.Descrizione_testuale = Descrizione;
    }
    public void setImg(String immagine) {
        this.immagine = immagine;
    }
}
