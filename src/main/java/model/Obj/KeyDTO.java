package model.Obj;

public class KeyDTO {

    private String titolo;
    private String key;

    public KeyDTO() {
    }

    public KeyDTO(String titolo, String key) {
        this.titolo = titolo;
        this.key = key;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}