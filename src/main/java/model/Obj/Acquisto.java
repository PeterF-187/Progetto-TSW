package model.Obj;

import java.util.Date;
import java.math.BigDecimal;

public class Acquisto {
    private String Username_Account;
    private int Id_prodotto;
    private Date Data_acquisto;
    private BigDecimal Prezzo_pagato;
    private String Metodo_di_pagamento;
    private int Id_key;

    //getter
    public String getUsername(){
        return Username_Account;
    }
    public int getId(){
        return Id_prodotto;
    }
    public Date getData_acquisto(){
        return Data_acquisto;
    }
    public BigDecimal getPrezzo_pagato(){
        return Prezzo_pagato;
    }
    public String getMetodo_di_pagamento(){
        return Metodo_di_pagamento;
    }
    public int getId_key(){
        return Id_key;
    }

    //setter
    public void setUsername(String Username_Account){
        this.Username_Account = Username_Account;
    }
    public void setId(int Id_prodotto){
        this.Id_prodotto = Id_prodotto;
    }
    public void setData_acquisto(Date Data_acquisto){
        this.Data_acquisto = Data_acquisto;
    }
    public void setPrezzo_pagato(BigDecimal Prezzo_pagato){
        this.Prezzo_pagato = Prezzo_pagato;
    }
    public void setMetodo_di_pagamento(String Metodo_di_pagamento){
        this.Metodo_di_pagamento = Metodo_di_pagamento;
    }
    public void setId_key(int Id_key){
        this.Id_key = Id_key;
    }
}
