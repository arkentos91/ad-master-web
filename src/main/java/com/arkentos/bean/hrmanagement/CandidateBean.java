/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.bean.hrmanagement;

import com.arkentos.bean.usermanagement.*;
import java.io.Serializable;

/**
 *
 * @author jayana_i
 */
public class CandidateBean implements Serializable {

     private String nic;
     private String status;
     private String fullname;
     private String position;
     private String mobile;
     private String email;
     private String address;
     private String interviewdate;
    private String remarks;
    private long fullCount;

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getFullCount() {
        return fullCount;
    }

    public void setFullCount(long fullCount) {
        this.fullCount = fullCount;
    }

    public String getInterviewdate() {
        return interviewdate;
    }

    public void setInterviewdate(String interviewdate) {
        this.interviewdate = interviewdate;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    
    
}
