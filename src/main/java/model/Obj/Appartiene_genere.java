package model.Obj;

public class Appartiene_genere {
    private int Id_prodotto;
    private Generi Nome_Genere;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public Generi getGenere() {
        return Nome_Genere;
    }

    //setter
    public void setId_prodotto(int Id_prodotto) {
        this.Id_prodotto = Id_prodotto;
    }
    public void setGenere(Generi Nome_Genere) {
        this.Nome_Genere = Nome_Genere;
    }

}
