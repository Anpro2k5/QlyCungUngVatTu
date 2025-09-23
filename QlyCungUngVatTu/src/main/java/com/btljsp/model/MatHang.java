package com.btljsp.model;

public class MatHang {
    private int id;
    private String ten;
    private String donViTinh;
    private int soLuong;

    public MatHang() {
    }

    // Constructor matching DAO usage: (id, ten, donvitinh, soluong)
    public MatHang(int id, String ten, String donViTinh, int soLuong) {
        this.id = id;
        this.ten = ten;
        this.donViTinh = donViTinh;
        this.soLuong = soLuong;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTen() {
        return ten;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public String getDonViTinh() {
        return donViTinh;
    }

    public void setDonViTinh(String donViTinh) {
        this.donViTinh = donViTinh;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }
}
