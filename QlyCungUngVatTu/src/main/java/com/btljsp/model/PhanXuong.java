package com.btljsp.model;

public class PhanXuong {
    private int id;
    private String ten;
    private String diaChi;

    public PhanXuong() {
    }

    // Constructor matching DAO usage: (id, ten, diachi)
    public PhanXuong(int id, String ten, String diaChi) {
        this.id = id;
        this.ten = ten;
        this.diaChi = diaChi;
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

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }
}
