package model.Obj;

public class Appartiene_categoria {
    private int Id_prodotto;
    private Categorie Nome_Categoria;

    //getter
    public int getId_prodotto() {
        return Id_prodotto;
    }
    public Categorie getCategoria() {
        return Nome_Categoria;
    }

    //setter
    public void setId_prodotto(int Id_prodotto) {
        this.Id_prodotto = Id_prodotto;
    }
    public void setCategoria(Categorie Nome_Categoria) {
        this.Nome_Categoria = Nome_Categoria;
    }
}
