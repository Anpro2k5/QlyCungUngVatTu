package com.btljsp.dao;

import com.btljsp.model.InventoryTransaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InventoryTransactionDAO {

    public void insert(InventoryTransaction tx, Connection conn) throws SQLException {
        String sql = "INSERT INTO inventory_transaction (mathang_id, change_qty, txn_type, reference_table, reference_id, created_by, note) VALUES (?,?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tx.getMathangId());
            ps.setInt(2, tx.getChangeQty());
            ps.setString(3, tx.getTxnType());
            ps.setString(4, tx.getReferenceTable());
            if (tx.getReferenceId() != null) ps.setInt(5, tx.getReferenceId()); else ps.setNull(5, java.sql.Types.INTEGER);
            if (tx.getCreatedBy() != null) ps.setInt(6, tx.getCreatedBy()); else ps.setNull(6, java.sql.Types.INTEGER);
            ps.setString(7, tx.getNote());
            ps.executeUpdate();
        }
    }
}
