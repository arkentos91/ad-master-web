package com.arkentos.util.mapping;
// Generated Mar 26, 2018 11:02:46 AM by Hibernate Tools 4.3.1


import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Userpassword generated by hbm2java
 */
@Entity
@Table(name="USERPASSWORD"
)
public class Userpassword  implements java.io.Serializable {


     private UserpasswordId id;
     private Date lastupdatedtime;

    public Userpassword() {
    }

	
    public Userpassword(UserpasswordId id) {
        this.id = id;
    }
    public Userpassword(UserpasswordId id, Date lastupdatedtime) {
       this.id = id;
       this.lastupdatedtime = lastupdatedtime;
    }
   
     @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="username", column=@Column(name="USERNAME", nullable=false, length=20) ), 
        @AttributeOverride(name="password", column=@Column(name="PASSWORD", nullable=false, length=50) ) } )
    public UserpasswordId getId() {
        return this.id;
    }
    
    public void setId(UserpasswordId id) {
        this.id = id;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="LASTUPDATEDTIME", length=23)
    public Date getLastupdatedtime() {
        return this.lastupdatedtime;
    }
    
    public void setLastupdatedtime(Date lastupdatedtime) {
        this.lastupdatedtime = lastupdatedtime;
    }




}


