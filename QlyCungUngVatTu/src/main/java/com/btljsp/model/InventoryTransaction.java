package com.btljsp.model;

import java.util.Date;

public class InventoryTransaction {
    private int id;
    private int mathangId;
    private int changeQty;
    private String txnType; // OUT, IN, ADJUST, RETURN
    private String referenceTable;
    private Integer referenceId;
    private Integer createdBy;
    private Date createdAt;
    private String note;

    public InventoryTransaction() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getMathangId() { return mathangId; }
    public void setMathangId(int mathangId) { this.mathangId = mathangId; }
    public int getChangeQty() { return changeQty; }
    public void setChangeQty(int changeQty) { this.changeQty = changeQty; }
    public String getTxnType() { return txnType; }
    public void setTxnType(String txnType) { this.txnType = txnType; }
    public String getReferenceTable() { return referenceTable; }
    public void setReferenceTable(String referenceTable) { this.referenceTable = referenceTable; }
    public Integer getReferenceId() { return referenceId; }
    public void setReferenceId(Integer referenceId) { this.referenceId = referenceId; }
    public Integer getCreatedBy() { return createdBy; }
    public void setCreatedBy(Integer createdBy) { this.createdBy = createdBy; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
