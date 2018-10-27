/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.bean.hrmanagement;

import com.arkentos.bean.usermanagement.*;
import com.arkentos.util.mapping.Hrcandidate;
import com.arkentos.util.mapping.Status;
import com.arkentos.util.mapping.Systemuser;
import java.io.Serializable;
import java.util.List;

/**
 *
 * @author jayana_i
 */
public class InterviewInputBean implements Serializable {

    
    private String nic;
    private String interviewdate;
    private String interviewedby;
    private String interviewstatus;
    private String approvedby;
    private String remarks;
    private String status;
    
    
     /*-------for access control-----------*/
    private String defaultStatus;
    
    private List<Status> statusList;
    private List<Hrcandidate> candidateList;
    private List<Systemuser> interviewUserList;
    private String newvalue;
    private String oldvalue;
    private String message;
    /*-------for access control-----------*/
    private boolean vadd;
    private boolean vupdatebutt;
    private boolean vupdatelink;
    private boolean vdelete;
    private boolean vsearch;
    /*-------for access control-----------*/
    /*------------------------list data table  ------------------------------*/
    private List<InterviewBean> gridModel;
    private Integer rows = 0;
    private Integer page = 0;
    private Integer total = 0;
    private Long records = 0L;
    private String sord;
    private String sidx;
    private String searchField;
    private String searchString;
    private String searchOper;
    private boolean loadonce = false;
    /*------------------------for search ------------------------------*/
    private String nic_Search;
    private String interviewdate_Search;
    private String interviewedby_Search;
    private String statussearch;
    private boolean search;
    /*------------------------for search ------------------------------*/

 

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

    public String getDefaultStatus() {
        return defaultStatus;
    }

    public void setDefaultStatus(String defaultStatus) {
        this.defaultStatus = defaultStatus;
    }

    public List<Status> getStatusList() {
        return statusList;
    }

    public void setStatusList(List<Status> statusList) {
        this.statusList = statusList;
    }

    public String getNewvalue() {
        return newvalue;
    }

    public void setNewvalue(String newvalue) {
        this.newvalue = newvalue;
    }

    public String getOldvalue() {
        return oldvalue;
    }

    public void setOldvalue(String oldvalue) {
        this.oldvalue = oldvalue;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isVadd() {
        return vadd;
    }

    public void setVadd(boolean vadd) {
        this.vadd = vadd;
    }

    public boolean isVupdatebutt() {
        return vupdatebutt;
    }

    public void setVupdatebutt(boolean vupdatebutt) {
        this.vupdatebutt = vupdatebutt;
    }

    public boolean isVupdatelink() {
        return vupdatelink;
    }

    public void setVupdatelink(boolean vupdatelink) {
        this.vupdatelink = vupdatelink;
    }

    public boolean isVdelete() {
        return vdelete;
    }

    public void setVdelete(boolean vdelete) {
        this.vdelete = vdelete;
    }

    public boolean isVsearch() {
        return vsearch;
    }

    public void setVsearch(boolean vsearch) {
        this.vsearch = vsearch;
    }

    public List<InterviewBean> getGridModel() {
        return gridModel;
    }

    public void setGridModel(List<InterviewBean> gridModel) {
        this.gridModel = gridModel;
    }

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Long getRecords() {
        return records;
    }

    public void setRecords(Long records) {
        this.records = records;
    }

    public String getSord() {
        return sord;
    }

    public void setSord(String sord) {
        this.sord = sord;
    }

    public String getSidx() {
        return sidx;
    }

    public void setSidx(String sidx) {
        this.sidx = sidx;
    }

    public String getSearchField() {
        return searchField;
    }

    public void setSearchField(String searchField) {
        this.searchField = searchField;
    }

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public String getSearchOper() {
        return searchOper;
    }

    public void setSearchOper(String searchOper) {
        this.searchOper = searchOper;
    }

    public boolean isLoadonce() {
        return loadonce;
    }

    public void setLoadonce(boolean loadonce) {
        this.loadonce = loadonce;
    }

    public String getNic_Search() {
        return nic_Search;
    }

    public void setNic_Search(String nic_Search) {
        this.nic_Search = nic_Search;
    }

    public String getInterviewdate_Search() {
        return interviewdate_Search;
    }

    public void setInterviewdate_Search(String interviewdate_Search) {
        this.interviewdate_Search = interviewdate_Search;
    }

    public String getInterviewedby_Search() {
        return interviewedby_Search;
    }

    public void setInterviewedby_Search(String interviewedby_Search) {
        this.interviewedby_Search = interviewedby_Search;
    }

    public String getStatussearch() {
        return statussearch;
    }

    public void setStatussearch(String statussearch) {
        this.statussearch = statussearch;
    }

    public boolean isSearch() {
        return search;
    }

    public void setSearch(boolean search) {
        this.search = search;
    }

    public List<Hrcandidate> getCandidateList() {
        return candidateList;
    }

    public void setCandidateList(List<Hrcandidate> candidateList) {
        this.candidateList = candidateList;
    }

    public List<Systemuser> getInterviewUserList() {
        return interviewUserList;
    }

    public void setInterviewUserList(List<Systemuser> interviewUserList) {
        this.interviewUserList = interviewUserList;
    }

    
    
}
