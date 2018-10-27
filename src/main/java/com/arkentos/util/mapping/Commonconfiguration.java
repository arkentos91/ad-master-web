/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.util.mapping;

// Generated Jun 11, 2018 1:15:35 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Commonconfiguration generated by hbm2java
 */
@Entity
@Table(name="COMMONCONFIGURATION"
)
public class Commonconfiguration  implements java.io.Serializable {


     private int id;
     private String alipaysettlementfile;
     private String merchantsettlementfile;
     private BigDecimal txnamounttolerance;
     private byte txnadaystolerance;
     private String bmlBankCode;
     private String eodlogpath;
     private String branchid;

    public Commonconfiguration() {
    }

	
    public Commonconfiguration(int id, String alipaysettlementfile, String merchantsettlementfile, BigDecimal txnamounttolerance, byte txnadaystolerance, String bmlBankCode) {
        this.id = id;
        this.alipaysettlementfile = alipaysettlementfile;
        this.merchantsettlementfile = merchantsettlementfile;
        this.txnamounttolerance = txnamounttolerance;
        this.txnadaystolerance = txnadaystolerance;
        this.bmlBankCode = bmlBankCode;
    }
    public Commonconfiguration(int id, String alipaysettlementfile, String merchantsettlementfile, BigDecimal txnamounttolerance, byte txnadaystolerance, String bmlBankCode, String eodlogpath, String branchid) {
       this.id = id;
       this.alipaysettlementfile = alipaysettlementfile;
       this.merchantsettlementfile = merchantsettlementfile;
       this.txnamounttolerance = txnamounttolerance;
       this.txnadaystolerance = txnadaystolerance;
       this.bmlBankCode = bmlBankCode;
       this.eodlogpath = eodlogpath;
       this.branchid = branchid;
    }
   
     @Id 

    
    @Column(name="ID", unique=true, nullable=false)
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }

    
    @Column(name="ALIPAYSETTLEMENTFILE", nullable=false, length=128)
    public String getAlipaysettlementfile() {
        return this.alipaysettlementfile;
    }
    
    public void setAlipaysettlementfile(String alipaysettlementfile) {
        this.alipaysettlementfile = alipaysettlementfile;
    }

    
    @Column(name="MERCHANTSETTLEMENTFILE", nullable=false, length=128)
    public String getMerchantsettlementfile() {
        return this.merchantsettlementfile;
    }
    
    public void setMerchantsettlementfile(String merchantsettlementfile) {
        this.merchantsettlementfile = merchantsettlementfile;
    }

    
    @Column(name="TXNAMOUNTTOLERANCE", nullable=false, precision=10)
    public BigDecimal getTxnamounttolerance() {
        return this.txnamounttolerance;
    }
    
    public void setTxnamounttolerance(BigDecimal txnamounttolerance) {
        this.txnamounttolerance = txnamounttolerance;
    }

    
    @Column(name="TXNADAYSTOLERANCE", nullable=false)
    public byte getTxnadaystolerance() {
        return this.txnadaystolerance;
    }
    
    public void setTxnadaystolerance(byte txnadaystolerance) {
        this.txnadaystolerance = txnadaystolerance;
    }

    
    @Column(name="BML_BANK_CODE", nullable=false, length=10)
    public String getBmlBankCode() {
        return this.bmlBankCode;
    }
    
    public void setBmlBankCode(String bmlBankCode) {
        this.bmlBankCode = bmlBankCode;
    }

    
    @Column(name="EODLOGPATH", length=128)
    public String getEodlogpath() {
        return this.eodlogpath;
    }
    
    public void setEodlogpath(String eodlogpath) {
        this.eodlogpath = eodlogpath;
    }

    
    @Column(name="BRANCHID",length=128)
    public String getBranchid() {
        return this.branchid;
    }
    
    public void setBranchid(String branchid) {
        this.branchid = branchid;
    }




}