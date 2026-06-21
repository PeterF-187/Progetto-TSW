package model.DAO;
import model.ConPool;
import model.Obj.Franchise;
import java.util.*;
import java.sql.*;

public class FranchiseDAO {

    public List<Franchise> doRetrieveAll() {
        List<Franchise> franchise = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT Titolo FROM Franchise");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Franchise f = new Franchise();
                f.setTitolo(rs.getString(1));
                franchise.add(f);
            }
            return franchise;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Franchise f) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Franchise (Titolo) VALUES(?)");
            ps.setString(1, f.getTitolo());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
