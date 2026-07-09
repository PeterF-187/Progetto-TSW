package model.Obj;

public class ImpostazioniUtente {

    private String username;
    private boolean dueFattori;

    public ImpostazioniUtente() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isDueFattori() {
        return dueFattori;
    }

    public void setDueFattori(boolean dueFattori) {
        this.dueFattori = dueFattori;
    }
}