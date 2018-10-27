/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.arkentos.bean.usermanagement;

import com.arkentos.util.mapping.Userrole;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author jayana_i
 */

public class UserRolePrivilegeInputBean {
    
        /* ---------user inputs data-----  */	
    private String userRole;
    private String userRoleDes;
    private String message;
    private String Category;
    private String page;
    private List<Userrole> userRoleList = new ArrayList<Userrole>();
    private List<String> categoryList = new ArrayList<String>();    
    private Map<String,String> currentList = new HashMap<String, String>();
    private Map<String,String> newList = new HashMap<String, String>();
    private Map<String, String> sectionMap = new HashMap<String, String>();
    private HashMap<String, String> pageMap = new HashMap<String, String>();
    private List<String> newBox;
    private List<String> currentBox;
    private String section;
    private String sectionpage;
    private String oldvalue;
        /* ---------user inputs data-----  */	
    
        /*-------for access control-----------*/
    private boolean vmanage;
    private boolean vassign;
        /*-------for access control-----------*/    

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getUserRoleDes() {
        return userRoleDes;
    }

    public void setUserRoleDes(String userRoleDes) {
        this.userRoleDes = userRoleDes;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCategory() {
        return Category;
    }

    public void setCategory(String Category) {
        this.Category = Category;
    }

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public List<Userrole> getUserRoleList() {
        return userRoleList;
    }

    public void setUserRoleList(List<Userrole> userRoleList) {
        this.userRoleList = userRoleList;
    }

    public List<String> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<String> categoryList) {
        this.categoryList = categoryList;
    }

    public Map<String, String> getCurrentList() {
        return currentList;
    }

    public void setCurrentList(Map<String, String> currentList) {
        this.currentList = currentList;
    }

    public Map<String, String> getNewList() {
        return newList;
    }

    public void setNewList(Map<String, String> newList) {
        this.newList = newList;
    }

    public Map<String, String> getSectionMap() {
        return sectionMap;
    }

    public void setSectionMap(Map<String, String> sectionMap) {
        this.sectionMap = sectionMap;
    }

    public HashMap<String, String> getPageMap() {
        return pageMap;
    }

    public void setPageMap(HashMap<String, String> pageMap) {
        this.pageMap = pageMap;
    }

    public List<String> getNewBox() {
        return newBox;
    }

    public void setNewBox(List<String> newBox) {
        this.newBox = newBox;
    }

    public List<String> getCurrentBox() {
        return currentBox;
    }

    public void setCurrentBox(List<String> currentBox) {
        this.currentBox = currentBox;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getSectionpage() {
        return sectionpage;
    }

    public void setSectionpage(String sectionpage) {
        this.sectionpage = sectionpage;
    }

    public boolean isVmanage() {
        return vmanage;
    }

    public void setVmanage(boolean vmanage) {
        this.vmanage = vmanage;
    }

    public boolean isVassign() {
        return vassign;
    }

    public void setVassign(boolean vassign) {
        this.vassign = vassign;
    }

    public String getOldvalue() {
        return oldvalue;
    }

    public void setOldvalue(String oldvalue) {
        this.oldvalue = oldvalue;
    }


}