/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.bean.hrmanagement;

import com.arkentos.bean.usermanagement.*;
import com.arkentos.util.mapping.Status;
import java.io.Serializable;
import java.util.List;

/**
 *
 * @author jayana_i
 */
public class CandidateInputBean implements Serializable {

    private String nic;
    private String status;
    private String fullname;
    private String position;
    private String mobile;
    private String email;
    private String address;
    private String interviewdate;
    private String remarks;
    private String defaultStatus;
    private List<Status> statusList;
    private List<MapBean> positionList;
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
    private List<CandidateBean> gridModel;
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
    private String fullname_Search;
    private String position_Search;
    private String mobile_Search;
    private String email_Search;
    private String statussearch;
    private String SearchAudit;
    private boolean search;
    /*------------------------for search ------------------------------*/

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

    public List<CandidateBean> getGridModel() {
        return gridModel;
    }

    public void setGridModel(List<CandidateBean> gridModel) {
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

    public String getFullname_Search() {
        return fullname_Search;
    }

    public void setFullname_Search(String fullname_Search) {
        this.fullname_Search = fullname_Search;
    }

    public String getPosition_Search() {
        return position_Search;
    }

    public void setPosition_Search(String position_Search) {
        this.position_Search = position_Search;
    }

    public String getMobile_Search() {
        return mobile_Search;
    }

    public void setMobile_Search(String mobile_Search) {
        this.mobile_Search = mobile_Search;
    }

    public String getEmail_Search() {
        return email_Search;
    }

    public void setEmail_Search(String email_Search) {
        this.email_Search = email_Search;
    }

    public String getStatussearch() {
        return statussearch;
    }

    public void setStatussearch(String statussearch) {
        this.statussearch = statussearch;
    }

    public String getSearchAudit() {
        return SearchAudit;
    }

    public void setSearchAudit(String SearchAudit) {
        this.SearchAudit = SearchAudit;
    }

    public boolean isSearch() {
        return search;
    }

    public void setSearch(boolean search) {
        this.search = search;
    }

    public String getDefaultStatus() {
        return defaultStatus;
    }

    public void setDefaultStatus(String defaultStatus) {
        this.defaultStatus = defaultStatus;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<MapBean> getPositionList() {
        return positionList;
    }

    public void setPositionList(List<MapBean> positionList) {
        this.positionList = positionList;
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
