package model.Obj;

public class Sviluppatori {
    private String Nome_SH;
    private int N_Sviluppatori;
    private String Tipologia;
    private String Motore_grafico;

    //getter
    public String getNome_SH(){
        return this.Nome_SH;
    }
    public int getN_Sviluppatori(){
        return this.N_Sviluppatori;
    }
    public String getTipologia(){
        return this.Tipologia;
    }
    public String getMotore_grafico(){
        return this.Motore_grafico;
    }

    //setter
    public void setNome_SH(String Nome_SH) {
        this.Nome_SH = Nome_SH;
    }
    public void setN_Sviluppatori(int N_Sviluppatori){
        this.N_Sviluppatori = N_Sviluppatori;
    }
    public void setTipologia(String Tipologia){
        this.Tipologia = Tipologia;
    }
    public void setMotore_grafico(String Motore_grafico){
        this.Motore_grafico = Motore_grafico;
    }
}
