package com.btljsp.model;

import java.util.Date;

public class PhieuXuatHang {
    private int id;
    private Date ngayXuat;

    public PhieuXuatHang() {}

    public PhieuXuatHang(int id, Date ngayXuat) {
        this.id = id;
        this.ngayXuat = ngayXuat;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getNgayXuat() { return ngayXuat; }
    public void setNgayXuat(Date ngayXuat) { this.ngayXuat = ngayXuat; }
}
