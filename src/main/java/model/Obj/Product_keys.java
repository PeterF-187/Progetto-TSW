package model.Obj;

public class Product_keys {
    private int Id_key;
    private int Id_prodotto;
    private String Chiave;
    private Status status;

    //getter
    public int getId_key()
    {
        return Id_key;
    }
    public int  getId_prodotto()
    {
        return Id_prodotto;
    }
    public String getChiave()
    {
        return Chiave;
    }
    public Status getStatus()
    {
        return status;
    }

    //setter
public void setId_key(int id_key){
        Id_key = id_key;
}
public void setId_prodotto(int id_prodotto){
        Id_prodotto = id_prodotto;
}
    public void setChiave(String chiave){
        this.Chiave = chiave;
    }
public void setStatus(Status status){
        this.status = status;
}

}
