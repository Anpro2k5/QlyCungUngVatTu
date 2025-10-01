package com.btljsp.model;

public class NhanVien {
    private int id;
    private String ten;
    private String chucVu;
    private String sdt;

    public NhanVien() {
    }

    public NhanVien(int id, String ten, String chucVu, String sdt) {
        this.id = id;
        this.ten = ten;
        this.chucVu = chucVu;
        this.sdt = sdt;
    }

    // Getter & Setter
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

    @Override
    public String toString() {
        return "NhanVien{" +
                "id=" + id +
                ", ten='" + ten + '\'' +
                ", chucVu='" + chucVu + '\'' +
                ", sdt='" + sdt + '\'' +
                '}';
    }
}
