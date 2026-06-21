package model.Obj;

public class Fa_Parte_di {
    private int Id_prodotto;
    private String Titolo_Franchise;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public String getFranchise() {
        return Titolo_Franchise;
    }

    //setter
    public void setId_prodotto(int Id_prodotto) {
        this.Id_prodotto = Id_prodotto;
    }
    public void setFranchise(String Titolo_Franchise) {
        this.Titolo_Franchise = Titolo_Franchise;
    }
}
