package model.Obj;

public class Supporta {
    private int Id_prodotto;
    private Lingue Lingua;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public Lingue getLingua() {
        return Lingua;
    }

    //setter
    public void setId_prodotto(int id_prodotto) {
        this.Id_prodotto = id_prodotto;
    }
    public void setLingua(Lingue Lingua) {
        this.Lingua = Lingua;
    }
}
