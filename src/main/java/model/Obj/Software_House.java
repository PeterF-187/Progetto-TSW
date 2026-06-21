package model.Obj;

public class Software_House {
    private String Nome;
    private String Sede_Legale;
    private int Anno_di_fondazione;

    //getter
    public String getNome() {
        return Nome;
    }
    public String getSede() {
        return Sede_Legale;
    }
    public int getAnno() {
        return Anno_di_fondazione;
    }

    //setter
    public void setNome(String Nome) {
        this.Nome = Nome;
    }
    public void setSede(String Sede_Legale) {
        this.Sede_Legale = Sede_Legale;
    }
    public void setAnno(int Anno_di_fondazione) {
        this.Anno_di_fondazione = Anno_di_fondazione;
    }

}
