package com.btljsp.model;

public class NhanVien {
    private int id;
    private String ten;
    private String chucVu;
    private String sdt;
    private int phanXuongId;

    public NhanVien() {
    }

    // Constructor matching DAO usage: (id, ten, chucvu, sdt, phanxuong_id)
    public NhanVien(int id, String ten, String chucVu, String sdt, int phanXuongId) {
        this.id = id;
        this.ten = ten;
        this.chucVu = chucVu;
        this.sdt = sdt;
        this.phanXuongId = phanXuongId;
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

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public int getPhanXuongId() {
        return phanXuongId;
    }

    public void setPhanXuongId(int phanXuongId) {
        this.phanXuongId = phanXuongId;
    }
}
