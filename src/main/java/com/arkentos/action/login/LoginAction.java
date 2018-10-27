/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.login;

import com.arkentos.bean.login.LoginBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.dao.login.LoginDAO;
import com.arkentos.util.common.Common;
import com.arkentos.util.mapping.Page;
import com.arkentos.util.mapping.Section;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Task;
import com.arkentos.util.mapping.Systemuser;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.LogoutMsgVarList;
import com.arkentos.util.varlist.MessageVarList;
import com.arkentos.util.varlist.PageVarList;
import com.arkentos.util.varlist.SectionVarList;
import com.arkentos.util.varlist.SessionVarlist;
import com.arkentos.util.varlist.TaskVarList;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author jayana_i
 */
public class LoginAction extends ActionSupport implements ModelDriven<Object> {

    LoginBean loginBean = new LoginBean();
    Systemuser sysUser = new Systemuser();
    Calendar cal2 = Calendar.getInstance();
    Calendar cal4 = Calendar.getInstance();

    @Override
    public Object getModel() {
        return loginBean;
    }

    public String execute() {
        System.out.println("called LoginAction : execute");
        return SUCCESS;
    }

    public String Check() {
        String result = "message";
        String warnmsg = "";
        try {
            String message = this.validateUser();
            if (message.isEmpty()) {

                HttpSession sessionPrevious = ServletActionContext.getRequest().getSession(false);
                if (sessionPrevious != null) {
                    sessionPrevious.invalidate();
                }
                //set user to the session
                HttpSession session = ServletActionContext.getRequest().getSession(true);
                session.setAttribute(SessionVarlist.SYSTEMUSER, sysUser);
                System.out.println("+++++++++++++++++++++++++++++"+sysUser.getUsername());
                //set user and sessionid to hashmap
                HashMap<String, String> userMap = null;

                ServletContext sc = ServletActionContext.getServletContext();
                userMap = (HashMap<String, String>) sc.getAttribute(SessionVarlist.USERMAP);
                if (userMap == null) {
                    userMap = new HashMap<String, String>();
                }
                userMap.put(sysUser.getUsername(), session.getId());
                sc.setAttribute(SessionVarlist.USERMAP, userMap);

                LoginDAO loginDao = new LoginDAO();

                HashMap<String, List<Task>> pageMap = loginDao.getPageTask(sysUser.getUserrole().getUserrolecode());
                session.setAttribute(SessionVarlist.TASKMAP, pageMap); // to be used in the user privilages test

                HashMap<Section, List<Page>> sectionPagesMap = loginDao.getSectionPages(sysUser.getUserrole().getUserrolecode());

                session.setAttribute(SessionVarlist.SECTIONPAGELIST, sectionPagesMap);
                System.err.print("sectionPagesMap.size() "+sectionPagesMap.size());
                
                if (Integer.parseInt(sysUser.getInitialloginstatus()) == 0) {

//                    result = "firstlogin";
                    result = SUCCESS;

                }else {

                    result = SUCCESS;
                }

            } else {
                loginBean.setErrormessage(message);
                addActionError(message);
            }
        } catch (Exception ex) {
            Logger.getLogger(LoginAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    private String validateUser() {   //comment if Database needed, Local Environment, always true
        
        String message = "";
        System.out.println("-- called validateUser-- from ldap");
        try {
            LoginDAO loginDao = new LoginDAO();
            HttpServletRequest request = ServletActionContext.getRequest();
            if (loginBean.getUsername() == null || loginBean.getUsername().isEmpty()) {
                message = MessageVarList.LOGIN_EMPTY_USERNAME;
            } else if (loginBean.getPassword() == null || loginBean.getPassword().isEmpty()) {
                message = MessageVarList.LOGIN_EMPTY_PASSWORD;
            } else {

                try {
//                    ValidateUser valUser = new ValidateUser();
//                    XMLReader ldapConfig =new XMLReader(CommonVarList.LDAP_CONFIG_FILE_PATH);
//                    ldapConfig.getDBConfig();
//                    ldapConfig=null;
//                    if (valUser.validateLogin(loginBean.getUsername(), loginBean.getPassword())) { 
                    if (true) {
                        message = "";
                        sysUser = loginDao.findUserbyUsername(loginBean.getUsername());

                        if (sysUser == null) {
                            message = MessageVarList.LOGIN_INVALID;
                        }
                        else if (!sysUser.getStatus().getStatuscode().equals(CommonVarList.STATUS_ACTIVE)) {
                            message = MessageVarList.LOGIN_DEACTIVE;
                        } 
                        else if (sysUser.getUserrole().getUserrolecode().equals("MERC")) {
                            message = MessageVarList.LOGIN_USERROLE_BLOCK;
                        }
                        else{ //else if to else
                            loginBean.setAttempts(new Integer("0"));
                            loginBean.setStatus(sysUser.getStatus().getStatuscode());

                            Systemaudit audit = Common.makeAudittrace(request, sysUser, TaskVarList.LOGIN_TASK, PageVarList.LOGIN_PAGE, SectionVarList.DEFAULT_SECTION, "Login successfully", null);
                            loginDao.updateUser(loginBean, audit, true);
                        }
                    } else {
                        message = MessageVarList.LOGIN_INVALID;
                    }
                } catch (Exception e) {
                }
            }

        } catch (Exception ex) {
            message = MessageVarList.LOGIN_ERROR_LOAD;
            Logger.getLogger(LoginAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return message;
    }

    public String Logout() {
        String result = "message";
        System.out.println("called LoginAction : Logout");

        try {
            //invalidate session
            HttpSession session = ServletActionContext.getRequest().getSession(false);
            if (session != null) {
                //error messages
                if (loginBean.getMessage() != null && !loginBean.getMessage().isEmpty()) {
                    String message = loginBean.getMessage();
                    if (message.equals("error1")) {
                        loginBean.setErrormessage("Access denied. Please login again.");
                        addActionError("Access denied. Please login again.");
                    } else if (message.equals("error2")) {
                        addActionError("You have been logged in from another mechine. Access denied.");
                        loginBean.setErrormessage("You have been logged in from another mechine. Access denied.");
                    } else if (message.equals("error3")) {
                    } else if (message.equals("success1")) {
                        addActionMessage("Your password changed successfully. Please login with the new password.");
                        loginBean.setErrormessage("Your password changed successfully. Please login with the new password.");
                    }
                } else {//if loginbean not set check for the session message
                    if (session != null) {
                        String msg = String.valueOf(session.getAttribute("intercept"));
                        if (msg.equalsIgnoreCase("ERROR_ACCESS")) {
                            addActionError(LogoutMsgVarList.ERROR_ACCESS);
                            loginBean.setErrormessage(LogoutMsgVarList.ERROR_ACCESS);
                        } else if (msg.equals("ERROR_ACCESSPOINT")) {
                            addActionError(LogoutMsgVarList.ERROR_ACCESSPOINT);
                            loginBean.setErrormessage(LogoutMsgVarList.ERROR_ACCESSPOINT);
                        } else if (msg.equals("ERROR_USER_INFO")) {
                            addActionError(LogoutMsgVarList.ERROR_USER_INFO);
                            loginBean.setErrormessage(LogoutMsgVarList.ERROR_USER_INFO);
                        } else if (msg.equals("PASSWORD_CHANGE_SUCCESS")) {
                            loginBean.setErrormessage(LogoutMsgVarList.PASSWORD_CHANGE_SUCCESS);
                            addActionMessage(LogoutMsgVarList.PASSWORD_CHANGE_SUCCESS);
                        } else {
                            addActionError(LogoutMsgVarList.ERROR_SESSION);
                            loginBean.setErrormessage(LogoutMsgVarList.ERROR_SESSION);
                        }
                    }
                }

                sysUser = ((Systemuser) session.getAttribute(SessionVarlist.SYSTEMUSER));

                if (sysUser != null) {

                    LoginDAO loginDao = new LoginDAO();

                    Systemaudit audit = Common.makeAudittrace(ServletActionContext.getRequest(), sysUser, TaskVarList.LOGOUT_TASK, PageVarList.LOGIN_PAGE, SectionVarList.DEFAULT_SECTION, "Log out successfully", null);
                    loginBean.setStatus(sysUser.getStatus().getStatuscode());
                    loginBean.setUsername(sysUser.getUsername());

                    loginDao.updateUser(loginBean, audit, false);
                }

                session.invalidate();

            }

        } catch (Exception ex) {
            Logger.getLogger(LoginAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public static long daysBetween(Calendar startDate, Calendar endDate) {
        Calendar date = (Calendar) startDate.clone();
        long daysBetween = -1;
        while (date.before(endDate)) {
            date.add(Calendar.DAY_OF_MONTH, 1);
            daysBetween++;
        }
        return daysBetween;
    }

}
