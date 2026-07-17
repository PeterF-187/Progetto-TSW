package model.DAO;

import model.ConPool;
import model.Obj.Metodo_pagamento;
import model.Obj.TipoMetodo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Metodo_pagamentoDAO {

    public List<Metodo_pagamento> doRetrieveAll() {
        List<Metodo_pagamento> metodi = new ArrayList<>();

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT IdMetodo, Username, TipoMetodo, Provider, TokenPagamento, " +
                            "Ultime4Cifre, ScadenzaMese, ScadenzaAnno, Predefinito, Attivo, DataCreazione " +
                            "FROM Metodo_pagamento"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Metodo_pagamento m = new Metodo_pagamento();

                m.setIdMetodo(rs.getInt(1));
                m.setUsername(rs.getString(2));
                String tipoMetodoDb = rs.getString(3);
                if (tipoMetodoDb != null) {
                    m.setTipoMetodo(TipoMetodo.valueOf(tipoMetodoDb));
                }

                m.setProvider(rs.getString(4));
                m.setTokenPagamento(rs.getString(5));
                m.setUltime4Cifre(rs.getString(6));
                m.setScadenzaMese(rs.getInt(7));
                m.setScadenzaAnno(rs.getInt(8));
                m.setPredefinito(rs.getBoolean(9));
                m.setAttivo(rs.getBoolean(10));
                m.setDataCreazione(rs.getDate(11));

                metodi.add(m);
            }

            return metodi;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Metodo_pagamento doRetrieveByUsername(String username) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT IdMetodo, Username, TipoMetodo, Provider, TokenPagamento, " +
                            "Ultime4Cifre, ScadenzaMese, ScadenzaAnno, Predefinito, Attivo, DataCreazione " +
                            "FROM Metodo_pagamento WHERE Username = ? LIMIT 1"
            );
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Metodo_pagamento m = new Metodo_pagamento();

                m.setIdMetodo(rs.getInt("IdMetodo"));
                m.setUsername(rs.getString("Username"));

                String tipo = rs.getString("TipoMetodo");
                if (tipo != null) {
                    try {
                        m.setTipoMetodo(TipoMetodo.valueOf(tipo));
                    } catch (Exception e) {
                        m.setTipoMetodo(TipoMetodo.Da_configurare);
                    }
                }

                m.setProvider(rs.getString("Provider"));
                m.setTokenPagamento(rs.getString("TokenPagamento"));
                m.setUltime4Cifre(rs.getString("Ultime4Cifre"));
                m.setScadenzaMese(rs.getInt("ScadenzaMese"));
                m.setScadenzaAnno(rs.getInt("ScadenzaAnno"));
                m.setPredefinito(rs.getBoolean("Predefinito"));
                m.setAttivo(rs.getBoolean("Attivo"));
                m.setDataCreazione(rs.getTimestamp("DataCreazione"));

                return m;
            }

            return null;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doUpdate(Metodo_pagamento m) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE Metodo_pagamento SET " +
                            "TipoMetodo=?, Provider=?, TokenPagamento=?, Ultime4Cifre=?, " +
                            "ScadenzaMese=?, ScadenzaAnno=?, Predefinito=?, Attivo=?, DataCreazione=? " +
                            "WHERE Username=?"
            );
            ps.setString(1, m.getTipoMetodo().name());
            ps.setString(2, m.getProvider());
            ps.setString(3, m.getTokenPagamento());
            ps.setString(4, m.getUltime4Cifre());
            ps.setInt(5, m.getScadenzaMese());
            ps.setInt(6, m.getScadenzaAnno());
            ps.setBoolean(7, m.isPredefinito());
            ps.setBoolean(8, m.isAttivo());
            ps.setTimestamp(9, new java.sql.Timestamp(m.getDataCreazione().getTime()));
            ps.setString(10, m.getUsername());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("Errore UPDATE Metodo_pagamento");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Metodo_pagamento m) {
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Metodo_pagamento " +
                            "(Username, TipoMetodo, Provider, TokenPagamento, Ultime4Cifre, " +
                            "ScadenzaMese, ScadenzaAnno, Predefinito, Attivo, DataCreazione) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, m.getUsername());
            ps.setString(2, m.getTipoMetodo() != null ? m.getTipoMetodo().name() : "Da configurare");
            ps.setString(3, m.getProvider());
            ps.setString(4, m.getTokenPagamento());
            ps.setString(5, m.getUltime4Cifre());
            ps.setInt(6, m.getScadenzaMese());
            ps.setInt(7, m.getScadenzaAnno());
            ps.setBoolean(8, m.isPredefinito());
            ps.setBoolean(9, m.isAttivo());
            ps.setTimestamp(10, new java.sql.Timestamp(m.getDataCreazione().getTime()));

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("Errore INSERT Metodo_pagamento");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}