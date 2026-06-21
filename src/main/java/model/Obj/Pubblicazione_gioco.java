package model.Obj;

public class Pubblicazione_gioco {
    private int Id_prodotto;
    private String Nome_Publisher;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public String getNome_Publisher() {
        return Nome_Publisher;
    }

    //setter
    public void setId_prodotto(int Id_prodotto) {
        this.Id_prodotto = Id_prodotto;
    }
    public void setNome_Publisher(String Nome_Publisher) {
        this.Nome_Publisher = Nome_Publisher;
    }
}
