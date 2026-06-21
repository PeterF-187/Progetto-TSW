package model.Obj;

import java.math.BigDecimal;
import java.util.List;

public class Publisher {
    private String Nome_SH;
    private BigDecimal Budget_marketing_annuo;
    private String Canali_distribuzione;

    //getter
    public String getNome_SH() {
        return Nome_SH;
    }
    public BigDecimal getBudget() {
        return Budget_marketing_annuo;
    }
    public String getCanali() {
        return Canali_distribuzione;
    }

    //setter
    public void setNome_SH(String Nome_SH) {
        this.Nome_SH = Nome_SH;
    }
    public void setBudget(BigDecimal Budget) {
        this.Budget_marketing_annuo = Budget;
    }
    public void setCanali(String Canali_distribuzione) {
        this.Canali_distribuzione = Canali_distribuzione;
    }
}
