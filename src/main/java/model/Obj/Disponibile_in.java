package model.Obj;

public class Disponibile_in {
    private int Id_prodotto;
    private Regione Nome_regione;

    //getter
    public int getId_prodotto(){
        return Id_prodotto;
    }
    public Regione getNome_regione(){
        return Nome_regione;
    }

    //setter
    public void setId_prodotto(int Id_prodotto){
        this.Id_prodotto = Id_prodotto;
    }
    public void setNome_regione(Regione Nome_regione){
        this.Nome_regione = Nome_regione;
    }
}
