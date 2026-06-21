package model.Obj;

public class rilascio_su {
    private int Id_prodotto;
    private Piattaforma Nome_Piattaforma;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public Piattaforma getPiattaforma() {
        return Nome_Piattaforma;
    }

    //setter
    public void setId_prodotto(int Id_prodotto) {
        this.Id_prodotto = Id_prodotto;
    }
    public void setPiattaforma(Piattaforma Nome_Piattaforma) {
        this.Nome_Piattaforma = Nome_Piattaforma;
    }
}
