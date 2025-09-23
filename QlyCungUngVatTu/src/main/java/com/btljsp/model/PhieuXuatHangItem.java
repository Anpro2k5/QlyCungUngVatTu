package com.btljsp.model;

import java.math.BigDecimal;
import java.util.Date;

public class PhieuXuatHangItem {
    private int id;
    private int phieuXuatId;
    private int mathangId;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal subtotal;
    private String note;
    private Date createdAt;

    public PhieuXuatHangItem() {}

    public PhieuXuatHangItem(int id, int phieuXuatId, int mathangId, int quantity, BigDecimal unitPrice, String note) {
        this.id = id;
        this.phieuXuatId = phieuXuatId;
        this.mathangId = mathangId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.note = note;
        this.subtotal = (unitPrice == null) ? BigDecimal.ZERO : unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getPhieuXuatId() { return phieuXuatId; }
    public void setPhieuXuatId(int phieuXuatId) { this.phieuXuatId = phieuXuatId; }
    public int getMathangId() { return mathangId; }
    public void setMathangId(int mathangId) { this.mathangId = mathangId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
