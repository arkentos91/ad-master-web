package com.arkentos.util.mapping;
// Generated Feb 16, 2018 9:38:55 AM by Hibernate Tools 4.3.1


import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Systemaudit generated by hbm2java
 */
@Entity
@Table(name="SYSTEMAUDIT"
)
public class Systemaudit  implements java.io.Serializable {


     private long systemauditid;
     private Date createtime;
     private String description;
     private String ip;
     private Date lastupdatedtime;
     private String lastupdateduser;
     private String newvalue;
     private String oldvalue;
     private String pagecode;
     private String sectioncode;
     private String taskcode;
     private String userrolecode;

    public Systemaudit() {
    }

    public Systemaudit(Date createtime, String description, String ip, Date lastupdatedtime, String lastupdateduser, String newvalue, String oldvalue, String pagecode, String sectioncode, String taskcode, String userrolecode) {
       this.createtime = createtime;
       this.description = description;
       this.ip = ip;
       this.lastupdatedtime = lastupdatedtime;
       this.lastupdateduser = lastupdateduser;
       this.newvalue = newvalue;
       this.oldvalue = oldvalue;
       this.pagecode = pagecode;
       this.sectioncode = sectioncode;
       this.taskcode = taskcode;
       this.userrolecode = userrolecode;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="SYSTEMAUDITID", unique=true, nullable=false, precision=18, scale=0)
    public long getSystemauditid() {
        return this.systemauditid;
    }
    
    public void setSystemauditid(long systemauditid) {
        this.systemauditid = systemauditid;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="CREATETIME", length=23)
    public Date getCreatetime() {
        return this.createtime;
    }
    
    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    
    @Column(name="DESCRIPTION")
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    
    @Column(name="IP", length=64)
    public String getIp() {
        return this.ip;
    }
    
    public void setIp(String ip) {
        this.ip = ip;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="LASTUPDATEDTIME", length=23)
    public Date getLastupdatedtime() {
        return this.lastupdatedtime;
    }
    
    public void setLastupdatedtime(Date lastupdatedtime) {
        this.lastupdatedtime = lastupdatedtime;
    }

    
    @Column(name="LASTUPDATEDUSER", length=20)
    public String getLastupdateduser() {
        return this.lastupdateduser;
    }
    
    public void setLastupdateduser(String lastupdateduser) {
        this.lastupdateduser = lastupdateduser;
    }

    
    @Column(name="NEWVALUE", length=2048)
    public String getNewvalue() {
        return this.newvalue;
    }
    
    public void setNewvalue(String newvalue) {
        this.newvalue = newvalue;
    }

    
    @Column(name="OLDVALUE", length=2048)
    public String getOldvalue() {
        return this.oldvalue;
    }
    
    public void setOldvalue(String oldvalue) {
        this.oldvalue = oldvalue;
    }

    
    @Column(name="PAGECODE", length=20)
    public String getPagecode() {
        return this.pagecode;
    }
    
    public void setPagecode(String pagecode) {
        this.pagecode = pagecode;
    }

    
    @Column(name="SECTIONCODE", length=20)
    public String getSectioncode() {
        return this.sectioncode;
    }
    
    public void setSectioncode(String sectioncode) {
        this.sectioncode = sectioncode;
    }

    
    @Column(name="TASKCODE", length=20)
    public String getTaskcode() {
        return this.taskcode;
    }
    
    public void setTaskcode(String taskcode) {
        this.taskcode = taskcode;
    }

    
    @Column(name="USERROLECODE", length=20)
    public String getUserrolecode() {
        return this.userrolecode;
    }
    
    public void setUserrolecode(String userrolecode) {
        this.userrolecode = userrolecode;
    }




}

