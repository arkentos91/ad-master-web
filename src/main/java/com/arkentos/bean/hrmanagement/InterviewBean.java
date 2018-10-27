/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.bean.hrmanagement;

import java.io.Serializable;

/**
 *
 * @author jayana_i
 */
public class InterviewBean implements Serializable {

    private String interviewid;
    private String nic;
    private String fullname;
    private String interviewdate;
    private String interviewedby;
    private String interviewstatus;
    private String approvedby;
    private String remarks;
    private String status;
    private long fullCount;

    public String getInterviewid() {
        return interviewid;
    }

    public void setInterviewid(String interviewid) {
        this.interviewid = interviewid;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getInterviewdate() {
        return interviewdate;
    }

    public void setInterviewdate(String interviewdate) {
        this.interviewdate = interviewdate;
    }

    public String getInterviewedby() {
        return interviewedby;
    }

    public void setInterviewedby(String interviewedby) {
        this.interviewedby = interviewedby;
    }

    public String getInterviewstatus() {
        return interviewstatus;
    }

    public void setInterviewstatus(String interviewstatus) {
        this.interviewstatus = interviewstatus;
    }

    public String getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(String approvedby) {
        this.approvedby = approvedby;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public long getFullCount() {
        return fullCount;
    }

    public void setFullCount(long fullCount) {
        this.fullCount = fullCount;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

     
    

}
