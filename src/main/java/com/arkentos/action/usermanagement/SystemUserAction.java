/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.usermanagement;

import com.arkentos.bean.usermanagement.SystemUserDataBean;
import com.arkentos.bean.usermanagement.SystemUserInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.dao.usermanagement.PasswordPolicyDAO;
import com.arkentos.dao.usermanagement.SystemUserDAO;
import com.arkentos.util.common.AccessControlService;
import com.arkentos.util.common.Common;
import com.arkentos.util.common.Validation;
import com.arkentos.util.mapping.Passwordpolicy;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Systemuser;
import com.arkentos.util.mapping.Task;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.MessageVarList;
import com.arkentos.util.varlist.OracleMessage;
import com.arkentos.util.varlist.PageVarList;
import com.arkentos.util.varlist.SectionVarList;
import com.arkentos.util.varlist.SessionVarlist;
import com.arkentos.util.varlist.TaskVarList;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author jayana_i
 */
public class SystemUserAction extends ActionSupport implements ModelDriven<Object>, AccessControlService {

    SystemUserInputBean inputBean = new SystemUserInputBean();

    public String view() {

        String result = "view";
        try {
            if (this.applyUserPrivileges()) {

                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setUserroleList(dao.getUserRoleList());

                // set password expiry period (inserted)
//                PasswordPolicyDAO passPolicydao = new PasswordPolicyDAO();
                Calendar cal = Calendar.getInstance();
//                Passwordpolicy passPolicy = passPolicydao.getPasswordPolicyDetails();
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                cal.setTime(CommonDAO.getSystemDateLogin());
                cal.add(Calendar.DAY_OF_MONTH,100);

                // set expiry date to session
                HttpServletRequest request = ServletActionContext.getRequest();
                request.getSession(false).setAttribute(SessionVarlist.PASSWORD_EXPIRY_PERIOD, formatter.format(cal.getTime()));

                inputBean.setExpirydate(formatter.format(cal.getTime()));

            } else {
                result = "loginpage";
            }

            HttpSession session = ServletActionContext.getRequest().getSession(false);
            if (session.getAttribute(SessionVarlist.MIN_PASSWORD_CHANGE_PERIOD) != null && session.getAttribute(SessionVarlist.ONLY_SHOW_ONTIME) != null) {
                if ((Integer) session.getAttribute(SessionVarlist.ONLY_SHOW_ONTIME) == 0) {
                    session.setAttribute(SessionVarlist.ONLY_SHOW_ONTIME, 1);
                    addActionError((String) session.getAttribute(SessionVarlist.MIN_PASSWORD_CHANGE_PERIOD));
                }
            }

            System.out.println("called SystemUserAction :view");

        } catch (Exception ex) {
            addActionError("System user " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String changePassword() {
        System.out.println("called SystemUserAction :changePassword");
        String retType = "changepassword";
        try {

            String[] parts = inputBean.getUsernameUserrole().split("\\|");

            inputBean.setUsername(parts[0]);
            inputBean.setHusername(parts[0]);
            inputBean.setUserrole(parts[1]);

        } catch (Exception ex) {
            addActionError(" Passsword Reset " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return retType;
    }

    public String updateChangePassword() {
        System.out.println("called SystemUserAction :updateChangePassword");
        String retType = "message";

        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            String message = this.validateChangePasswordInputs();

            if (message.isEmpty()) {
                SystemUserDAO dao = new SystemUserDAO();
                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.SYSTEM_USER, SectionVarList.USERMANAGEMENT, "Password of " + inputBean.getHusername() + " Reset ", null);
                inputBean.setRenewpwd(Common.makeHash(inputBean.getRenewpwd().trim()));
                message = dao.updatePasswordReset(inputBean, audit);

                if (message.isEmpty()) {
                    addActionMessage(MessageVarList.RESET_PASSWORD_SUCCESS);
                } else {
                    addActionError(message);
                }

            } else {
                addActionError(message);
            }
        } catch (Exception ex) {
            addActionError(MessageVarList.COMMON_ERROR_UPDATE + " Password Reset");
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return retType;
    }

    public String list() {
        System.out.println("called SystemUserAction: list");
        try {

            int rows = inputBean.getRows();
            int page = inputBean.getPage();
            int to = (rows * page);
            int from = to - rows;
            long records = 0;

            String sortIndex = "";
            String sortOrder = "";

            if (!inputBean.getSidx().isEmpty()) {
                sortIndex = inputBean.getSidx();
                sortOrder = inputBean.getSord();
            }

            SystemUserDAO dao = new SystemUserDAO();
            List<SystemUserDataBean> dataList = dao.getSearchList(inputBean, rows, from, sortIndex, sortOrder);
            if (!dataList.isEmpty()) {

                records = dataList.get(0).getFullCount();
                inputBean.setRecords(records);
                inputBean.setGridModel(dataList);
                int total = (int) Math.ceil((double) records / (double) rows);
                inputBean.setTotal(total);

            } else {
                inputBean.setRecords(0L);
                inputBean.setTotal(0);
            }

        } catch (Exception e) {
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE,
                    null, e);
            addActionError(MessageVarList.COMMON_ERROR_PROCESS
                    + " System user Action");
        }
        return "list";
    }

    private boolean applyUserPrivileges() {
        HttpServletRequest request = ServletActionContext.getRequest();
        List<Task> tasklist = new Common().getUserTaskListByPage(PageVarList.SYSTEM_USER, request);

        inputBean.setVadd(true);
        inputBean.setVdelete(true);
        inputBean.setVupdatelink(true);
        inputBean.setVsearch(true);
        inputBean.setVpasswordreset(true);

        if (tasklist != null && tasklist.size() > 0) {
            for (Task task : tasklist) {
                if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.ADD_TASK)) {
                    inputBean.setVadd(false);
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.DELETE_TASK)) {
                    inputBean.setVdelete(false);
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.LOGIN_TASK)) {
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.UPDATE_TASK)) {
                    inputBean.setVupdatelink(false);
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.SEARCH_TASK)) {
                    inputBean.setVsearch(false);
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.PASSWORD_RESET_TASK)) {
                    inputBean.setVpasswordreset(false);
                }
            }
        }
        inputBean.setVupdatebutt(true);

        return true;
    }

    public String add() {
        System.out.println("called SystemUserAction : add");
        String result = "message";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            SystemUserDAO dao = new SystemUserDAO();
            String message = this.validateInputs();

            if (message.isEmpty()) {

                String serid_audit = "";
                String add1_audit = "";
//                String add2_audit = "";
                String city_audit = "";
//                inputBean.setStatus("ACT");
                if (inputBean.getServiceid() == null || inputBean.getServiceid().isEmpty()) {
                    serid_audit = "--";
                } else {
                    serid_audit = inputBean.getServiceid();
                }
                if (inputBean.getAddress1() == null || inputBean.getAddress1().isEmpty()) {
                    add1_audit = "--";
                } else {
                    add1_audit = inputBean.getAddress1();
                }
                if (inputBean.getCity() == null || inputBean.getCity().isEmpty()) {
                    city_audit = "--";
                } else {
                    city_audit = inputBean.getCity();
                }

                String newV = inputBean.getUsername() + "|" + inputBean.getUserrole()
                        + "|admin|" + inputBean.getStatus() + "|" + inputBean.getFullname()
                        //                        + "|" + inputBean.getDualauthuser() + "|" + inputBean.getStatus() + "|" + inputBean.getFullname()
                        + "|" + inputBean.getContactno() + "|" + inputBean.getEmail() + "|" + inputBean.getNic()
                        + "|" + inputBean.getDateofbirth() + "|" + serid_audit + "|" + add1_audit + "|" + city_audit;

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.ADD_TASK, PageVarList.SYSTEM_USER, SectionVarList.USERMANAGEMENT, "System user "+inputBean.getUsername()+" added", null, null, newV);
                message = dao.insertSystemUser(inputBean, audit);

                if (message.isEmpty()) {
                    addActionMessage("System user " + MessageVarList.COMMON_SUCC_INSERT);
                } else {
                    addActionError(message);
                }
            } else {
                addActionError(message);
            }

        } catch (Exception ex) {
            addActionError("System user Management " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String update() {

        System.out.println("called SystemUserAction : update");
        String retType = "message";

        try {
            if (inputBean.getUsername() != null && !inputBean.getUsername().isEmpty()) {

                //set username get in hidden fileds
                inputBean.setUsername(inputBean.getUsername());
//                inputBean.setStatus("ACT");

                String message = this.validateUpdateInputs();

                if (message.isEmpty()) {

                    HttpServletRequest request = ServletActionContext.getRequest();
                    SystemUserDAO dao = new SystemUserDAO();

                    String serid_audit = "";
                    String add1_audit = "";
                    String city_audit = "";

                    if (inputBean.getServiceid() == null || inputBean.getServiceid().isEmpty()) {
                        serid_audit = "--";
                    } else {
                        serid_audit = inputBean.getServiceid();
                    }
                    if (inputBean.getAddress1() == null || inputBean.getAddress1().isEmpty()) {
                        add1_audit = "--";
                    } else {
                        add1_audit = inputBean.getAddress1();
                    }
//                    if (inputBean.getAddress2() == null || inputBean.getAddress2().isEmpty()) {
//                        add2_audit = "--";
//                    } else {
//                        add2_audit = inputBean.getAddress2();
//                    }
                    if (inputBean.getCity() == null || inputBean.getCity().isEmpty()) {
                        city_audit = "--";
                    } else {
                        city_audit = inputBean.getCity();
                    }

                    String newV = inputBean.getUsername() + "|" + inputBean.getUserrole()
                            + "|admin|" + inputBean.getStatus() + "|" + inputBean.getFullname()
                            + "|" + inputBean.getContactno() + "|" + inputBean.getEmail() + "|" + inputBean.getNic()
                            + "|" + inputBean.getDateofbirth() + "|" + serid_audit + "|" + add1_audit + "|" + city_audit;

                    Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.SYSTEM_USER, SectionVarList.USERMANAGEMENT, "System user updated", null, inputBean.getOldvalue(), newV);
                    message = dao.updateSystemUser(inputBean, audit);

                    if (message.isEmpty()) {
                        addActionMessage("System user " + MessageVarList.COMMON_SUCC_UPDATE);
                    } else {
                        addActionError(message);
                    }

                } else {
                    addActionError(message);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
            addActionError("System user " + MessageVarList.COMMON_ERROR_UPDATE);
        }
        return retType;
    }

    public String delete() {
        System.out.println("called SystemUserAction : delete");
        String message = null;
        String retType = "delete";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            Systemuser cuUser = ((Systemuser) request.getSession(false).getAttribute(SessionVarlist.SYSTEMUSER));
            SystemUserDAO dao = new SystemUserDAO();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.SYSTEM_USER, SectionVarList.USERMANAGEMENT, "System user " + inputBean.getUsername() + " deleted", null);
            message = dao.deleteSystemUser(inputBean, cuUser, audit);
            if (message.isEmpty()) {
                message = "System user " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);
        } catch (Exception e) {
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage()));
//            inputBean.setMessage(MessageVarList.COMMON_ERROR_DELETE);
        }
        return retType;
    }

    public String findDualAuthUsers() {
        System.out.println("called SystemUserAction : findDualAuthUsers");
        try {

            if (inputBean.getUserrole() != null && !inputBean.getUserrole().isEmpty()) {

                SystemUserDAO dao = new SystemUserDAO();

//                int currUserLevel = dao.getCurrUsersUserLevel(inputBean.getUserrole());
                long currUserLevel = dao.getCurrUsersUserLevel(inputBean.getUserrole());

                dao.findUsersByUserRole(inputBean, currUserLevel);

            } else {
                inputBean.setMessage("");
            }

        } catch (Exception ex) {
            inputBean.setMessage("System user " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "findDualAuthUsers";

    }

    public String find() {
        System.out.println("called UserManagementAction: find");
        Systemuser user = new Systemuser();
        try {
            if (inputBean.getUsername() != null && !inputBean.getUsername().isEmpty()) {

                SystemUserDAO dao = new SystemUserDAO();

                user = dao.getSystemUserByUserName(inputBean.getUsername());

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

                try {
                    inputBean.setUsername(user.getUsername());
                } catch (NullPointerException e) {
                    inputBean.setUsername("");
                }

                try {
                    inputBean.setExpirydate(sdf.format(user.getExpirydate()));
                } catch (NullPointerException e) {
                    inputBean.setExpirydate("");
                }

                try {
                    inputBean.setUserrole(user.getUserrole().getUserrolecode());
                } catch (NullPointerException e) {
                    inputBean.setUserrole("");
                }

//                try {
////                    inputBean.setDualauthuser(user.getDualauthuserrole().getUsername());
//                    inputBean.setDualauthuser(user.getDualauthuserrole());
//                } catch (NullPointerException e) {
//                    inputBean.setDualauthuser("");
//                }
                try {
                    inputBean.setStatus(user.getStatus().getStatuscode());
                } catch (NullPointerException e) {
                    inputBean.setStatus("");
                }

                try {
                    inputBean.setFullname(user.getFullname());
                } catch (NullPointerException e) {
                    inputBean.setFullname("");
                }

                try {
                    inputBean.setServiceid(user.getEmpid());
                } catch (NullPointerException e) {
                    inputBean.setServiceid("");
                }

                try {
                    inputBean.setAddress1(user.getAddress());
                } catch (NullPointerException e) {
                    inputBean.setAddress1("");
                }

//                try {
//                    inputBean.setAddress2(user.getAddress2());
//                } catch (NullPointerException e) {
//                    inputBean.setAddress2("");
//                }
                try {
                    inputBean.setCity(user.getCity());
                } catch (NullPointerException e) {
                    inputBean.setCity("");
                }

                try {
                    inputBean.setContactno(user.getMobile());
                } catch (NullPointerException e) {
                    inputBean.setContactno("");
                }

                try {
                    inputBean.setEmail(user.getEmail());
                } catch (NullPointerException e) {
                    inputBean.setEmail("");
                }

                try {
                    inputBean.setNic(user.getNic());
                } catch (NullPointerException e) {
                    inputBean.setNic("");
                }

                try {
                    inputBean.setDateofbirth(sdf.format(user.getDateofbirth()));
                } catch (NullPointerException e) {
                    inputBean.setDateofbirth("");
                }

                String serid_audit = "";
                String add1_audit = "";
//                String add2_audit = "";
                String city_audit = "";

                if (inputBean.getServiceid() == null || inputBean.getServiceid().isEmpty()) {
                    serid_audit = "--";
                } else {
                    serid_audit = inputBean.getServiceid();
                }
                if (inputBean.getAddress1() == null || inputBean.getAddress1().isEmpty()) {
                    add1_audit = "--";
                } else {
                    add1_audit = inputBean.getAddress1();
                }
//                if (inputBean.getAddress2() == null || inputBean.getAddress2().isEmpty()) {
//                    add2_audit = "--";
//                } else {
//                    add2_audit = inputBean.getAddress2();
//                }
                if (inputBean.getCity() == null || inputBean.getCity().isEmpty()) {
                    city_audit = "--";
                } else {
                    city_audit = inputBean.getCity();
                }

                inputBean.setOldvalue(inputBean.getUsername() + "|" + inputBean.getExpirydate() + "|" + inputBean.getUserrole() + "|"
                        + "admin|" + inputBean.getStatus() + "|" + inputBean.getFullname()
                        + "|" + inputBean.getContactno() + "|" + inputBean.getEmail() + "|" + inputBean.getNic()
                        + "|" + inputBean.getDateofbirth() + "|" + serid_audit + "|" + add1_audit + "|" + city_audit);

            } else {
                inputBean.setMessage("Empty system user id.");

                // set password expiry period (inserted)
//                PasswordPolicyDAO passPolicydao = new PasswordPolicyDAO();
                Calendar cal = Calendar.getInstance();
//                Passwordpolicy passPolicy = passPolicydao.getPasswordPolicyDetails();
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                cal.setTime(CommonDAO.getSystemDateLogin());
//                cal.add(Calendar.DAY_OF_MONTH, passPolicy.getPasswordexpiryperiod());
                inputBean.setExpirydate(formatter.format(cal.getTime()));
                try {
                    inputBean.setStatus(CommonVarList.STATUS_ACTIVE);
                } catch (NullPointerException e) {
                    inputBean.setStatus("");
                }

            }
        } catch (Exception ex) {
            inputBean.setMessage("System user Management " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "find";
    }

    public Object getModel() {
        return inputBean;
    }

    public boolean checkAccess(String method, String userRole) {

        boolean status = false;
        String page = PageVarList.SYSTEM_USER;
        String task = null;

        if ("view".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("list".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("add".equals(method)) {
            task = TaskVarList.ADD_TASK;
        } else if ("delete".equals(method)) {
            task = TaskVarList.DELETE_TASK;
        } else if ("find".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("findDualAuthUsers".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("update".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        } else if ("delete".equals(method)) {
            task = TaskVarList.DELETE_TASK;
        } else if ("changePassword".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        } else if ("updateChangePassword".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        } else if ("viewpopup".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("detail".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        }//newly changed
        else if ("activate".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        }
        if ("execute".equals(method)) {
            status = true;
        } else {
            HttpServletRequest request = ServletActionContext.getRequest();
            status = new Common().checkMethodAccess(task, page, userRole, request);
        }
        return status;
    }

    public String viewpopup() {
        String result = "viewpopup";
        System.out.println("called SystemUser : ViewPopup");
        try {
            if (this.applyUserPrivileges()) {
                CommonDAO dao = new CommonDAO();
                SystemUserDAO sysdao = new SystemUserDAO();
                PasswordPolicyDAO passPolicydao = new PasswordPolicyDAO();
                Passwordpolicy passPolicy = passPolicydao.getPasswordPolicyDetails();
//                MsUserParam userparam = null;
//                userparam = sysdao.setTooltip("PWTOOLTIP");
                inputBean.setPwtooltip(passPolicydao.generateToolTipMessage(passPolicy));
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
//                inputBean.setUserroleList(dao.getUserRoleListByStatus(CommonVarList.STATUS_ACTIVE));
//                inputBean.setUserroleList(dao.getUserRoleListByStatus(CommonVarList.STATUS_ACTIVE, CommonVarList.SYS_MERCHANT));
                 inputBean.setUserroleList(dao.getUserRoleList(CommonVarList.STATUS_ACTIVE));
            } else {
                result = "loginpage";
            }

            HttpSession session = ServletActionContext.getRequest().getSession(false);
            if (session.getAttribute(SessionVarlist.MIN_PASSWORD_CHANGE_PERIOD) != null && session.getAttribute(SessionVarlist.ONLY_SHOW_ONTIME) != null) {
                if ((Integer) session.getAttribute(SessionVarlist.ONLY_SHOW_ONTIME) == 0) {
                    session.setAttribute(SessionVarlist.ONLY_SHOW_ONTIME, 1);
                    addActionError((String) session.getAttribute(SessionVarlist.MIN_PASSWORD_CHANGE_PERIOD));
                }
            }

        } catch (Exception e) {
            addActionError("System user " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, e);
        }
        return result;
    }
    //start newly chnged
    public String activate() {
        System.out.println("called UserManagementAction : activate");
        String message = null;
        String retType = "activate";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            SystemUserDAO dao = new SystemUserDAO();
            message = this.validateInputs();
            if (message.isEmpty()) {
                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.SYSTEM_USER, SectionVarList.USERMANAGEMENT, "User Name " + inputBean.getUsername() + " Updated", null);
                message = dao.activateUser(inputBean, audit);
                if (message.isEmpty()) {
                    message = "User " + MessageVarList.COMMON_SUCC_ACTIVATE;
                }
                inputBean.setMessage(message);
            } else {
                addActionError(message);
            }

        } catch (Exception e) {
            Logger.getLogger(TaskAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(MessageVarList.COMMON_ERROR_ACTIVATE);
        }
        return retType;
    }

    //end newly changed
    private String validateInputs() throws Exception {

        String message = "";
        try {
            if (inputBean.getUsername() == null || inputBean.getUsername().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_USERNAME;
            } else if (inputBean.getNic() == null || inputBean.getNic().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_NIC;
//            } else if (inputBean.getPassword() == null || inputBean.getPassword().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_PASSWORD;
//            } else if (!inputBean.getPassword().equals(inputBean.getConfirmpassword())) {
//                message = MessageVarList.SYSUSER_MGT_PASSWORD_MISSMATCH;
//            } else if (inputBean.getExpirydate() == null || inputBean.getExpirydate().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_EXPIRYDATE;
            } else if (inputBean.getUserrole() == null || inputBean.getUserrole().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_USERROLE;
//            } else if (inputBean.getDualauthuser() == null || inputBean.getDualauthuser().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_DUALAUTHUSER;
            } else if (inputBean.getStatus() == null || inputBean.getStatus().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_STATUS;
            } else if (inputBean.getFullname() == null || inputBean.getFullname().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_FULLNAME;
//            } else if (inputBean.getServiceid() == null || inputBean.getServiceid().trim().isEmpty()) {
                //                message = MessageVarList.SYSUSER_MGT_EMPTY_SERVICEID;
//            } else if (inputBean.getAddress1() == null || inputBean.getAddress1().trim().isEmpty()) {
                //                 message = MessageVarList.SYSUSER_MGT_EMPTY_ADDRESS1;
//            } else if (inputBean.getAddress2() == null || inputBean.getAddress2().trim().isEmpty()) {
                //                message = MessageVarList.SYSUSER_MGT_EMPTY_ADDRESS2;
//            } else if (inputBean.getCity() == null || inputBean.getCity().trim().isEmpty()) {
                //                message = MessageVarList.SYSUSER_MGT_EMPTY_CITY;
            } else if (inputBean.getContactno() == null || inputBean.getContactno().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_COANTACTNO;
            } else if (inputBean.getEmail() == null || inputBean.getEmail().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_EMAIL;
            } else if (!inputBean.getEmail().isEmpty() && !Validation.isValidEmail(inputBean.getEmail())) {
                message = MessageVarList.SYSUSER_MGT_INVALID_EMAIL;
            } 
//            else if (inputBean.getDateofbirth() == null || inputBean.getDateofbirth().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_DATEOFBIRTH;
//            } else if (inputBean.getPassword().equals(inputBean.getConfirmpassword())) {
//                String msg = "";
//                msg = this.checkPolicy(inputBean.getPassword());
//                if (message.equals("")) {
//                    message = msg;
//                }
            //}

        } catch (Exception e) {
            throw e;
        }
        return message;
    }

//    private String checkPolicy(String password) throws Exception {
//        String errorMsg = "";
//        try {
//            SystemUserDAO dao = new SystemUserDAO();
//
//            Passwordpolicy passwordpolicy = dao.getPasswordPolicyDetails();
//            if (passwordpolicy != null) {
//
//                String msg = this.CheckPasswordValidity(password, passwordpolicy);
//
//                if (!msg.equals("")) {
//                    errorMsg = msg;
//                }
//            }
//        } catch (Exception e) {
//            throw e;
//        }
//        return errorMsg;
//    }
//    public String CheckPasswordValidity(String password, Passwordpolicy bean) throws Exception {
//        String msg = "";
//        boolean flag = true;
//        Set<Character> set = new HashSet<Character>();;
//        List<Character> list = new ArrayList<Character>();
//        int x = 0;
//        try {
//
//            if (password.length() < bean.getMinimumlength()) {
//                flag = false;
//                msg = MessageVarList.SYSUSER_PASSWORD_TOO_SHORT + bean.getMinimumlength();
//            } else if (password.length() > bean.getMaximumlength()) {
//                flag = false;
//                msg = MessageVarList.SYSUSER_PASSWORD_TOO_LARGE + bean.getMaximumlength();
//            }
//
//            if (flag) {
//                int digits = 0;
//                int upper = 0;
//                int lower = 0;
//                int special = 0;
//
//                for (int i = 0; i < password.length(); i++) {
//                    char c = password.charAt(i);
//                    list.add(c);
//                    if (Character.isDigit(c)) {
//                        digits++;
//                    } else if (Character.isUpperCase(c)) {
//                        upper++;
//                    } else if (Character.isLowerCase(c)) {
//                        lower++;
//                    } else {
//                        special++;
//                    }
//                }
//
//                if (lower < bean.getMinimumlowercasecharacters().intValue()) {
//                    msg = MessageVarList.SYSUSER_PASSWORD_LESS_LOWER_CASE_CHARACTERS + bean.getMinimumlowercasecharacters();
//                    flag = false;
//                } else if (upper < bean.getMinimumuppercasecharacters().intValue()) {
//                    msg = MessageVarList.SYSUSER_PASSWORD_LESS_UPPER_CASE_CHARACTERS + bean.getMinimumuppercasecharacters();
//                    flag = false;
//                } else if (digits < bean.getMinimumnumericalcharacters().intValue()) {
//                    msg = MessageVarList.SYSUSER_PASSWORD_LESS_NUMERICAL_CHARACTERS + bean.getMinimumnumericalcharacters();
//                    flag = false;
//                } else if (special < bean.getMinimumspecialcharacters().intValue()) {
//                    msg = MessageVarList.SYSUSER_PASSWORD_LESS_SPACIAL_CHARACTERS + bean.getMinimumspecialcharacters();
//                    flag = false;
//                }
//            }
//
//            if (flag) {
//                do {
//                    Character[] rechar = list.toArray(new Character[0]);
//                    list.clear();
//                    set.clear();
//                    for (Character c : rechar) {
//                        if (!set.add(c)) {
//                            list.add(c);
//                        }
//                    }
//                    x++;
//                    if (bean.getRepeatcharactersallow() < x) {
//                        msg = MessageVarList.SYSUSER_PASSWORD_MORE_CHAR_REPEAT + bean.getRepeatcharactersallow();
//                        break;
//                    }
//
//                } while (!list.isEmpty());
//
//            }
//
//        } catch (Exception e) {
//            throw e;
//        }
//        return msg;
//    }
    private String validateUpdateInputs() throws Exception {
        String message = "";
        try {
//            if (inputBean.getExpirydate() == null || inputBean.getExpirydate().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_EXPIRYDATE;
//            } else 
            if (inputBean.getUserrole() == null || inputBean.getUserrole().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_USERROLE;
//            } else if (inputBean.getDualauthuser() == null || inputBean.getDualauthuser().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_DUALAUTHUSER;
            } else if (inputBean.getStatus() == null || inputBean.getStatus().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_STATUS;
            } 
            else if (inputBean.getFullname() == null || inputBean.getFullname().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_FULLNAME;
            //} //            else if (inputBean.getServiceid() == null || inputBean.getServiceid().trim().isEmpty()) {
            //                message = MessageVarList.SYSUSER_MGT_EMPTY_SERVICEID;
            //            } 
            //            else if (inputBean.getAddress1() == null || inputBean.getAddress1().trim().isEmpty()) {
            //                message = MessageVarList.SYSUSER_MGT_EMPTY_ADDRESS1;
            //            } 
            //            else if (inputBean.getAddress2() == null || inputBean.getAddress2().trim().isEmpty()) {
            //                            message = MessageVarList.SYSUSER_MGT_EMPTY_ADDRESS2;
            //                        } 
            //            else if (inputBean.getCity() == null || inputBean.getCity().trim().isEmpty()) {
            //                message = MessageVarList.SYSUSER_MGT_EMPTY_CITY;
                        }
            else if (inputBean.getContactno() == null || inputBean.getContactno().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_COANTACTNO;
            } else if (inputBean.getEmail() == null || inputBean.getEmail().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_EMAIL;
            } else if (!inputBean.getEmail().isEmpty() && !Validation.isValidEmail(inputBean.getEmail().trim())) {
                message = MessageVarList.SYSUSER_MGT_INVALID_EMAIL;
            } else if (inputBean.getNic() == null || inputBean.getNic().trim().isEmpty()) {
                message = MessageVarList.SYSUSER_MGT_EMPTY_NIC;
            }
//            else if (inputBean.getDateofbirth() == null || inputBean.getDateofbirth().trim().isEmpty()) {
//                message = MessageVarList.SYSUSER_MGT_EMPTY_DATEOFBIRTH;
//            }
        } catch (Exception e) {
            throw e;
        }
        return message;
    }

    private String validateChangePasswordInputs() throws Exception {
        String message = "";
        try {
            if (inputBean.getNewpwd() == null || inputBean.getNewpwd().trim().isEmpty()) {
                message = MessageVarList.PASSWORDRESET_EMPTY_PASSWORD;
            } else if (inputBean.getRenewpwd() == null || inputBean.getRenewpwd().trim().isEmpty()) {
                message = MessageVarList.PASSWORDRESET_EMPTY_COM_PASSWORD;
            } else if (!inputBean.getNewpwd().trim().contentEquals(inputBean.getRenewpwd().trim())) {
                message = MessageVarList.PASSWORDRESET_MATCH_PASSWORD;
            }
            if (inputBean.getNewpwd().trim().equals(inputBean.getRenewpwd().trim())) {
                String msg = "";
//                msg = this.checkPolicy(inputBean.getNewpwd().trim());
                if (message.equals("")) {
                    message = msg;
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return message;
    }
    public String detail() {
        System.out.println("called SystemUser: detail");
        System.err.println("detail " + inputBean.getUsername());
        Systemuser user = null;

        try {
            if (inputBean.getUsername() != null && !inputBean.getUsername().isEmpty()) {

                SystemUserDAO dao = new SystemUserDAO();
                CommonDAO commonDAO = new CommonDAO();
                inputBean.setStatusList(commonDAO.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
//                inputBean.setUserroleList(commonDAO.getUserRoleList());
//                inputBean.setUserroleList(commonDAO.getALLUserList(CommonVarList.SYS_MERCHANT));
                inputBean.setUserroleList(commonDAO.getUserRoleList(CommonVarList.STATUS_ACTIVE));

                user = dao.getSystemUserByUserName(inputBean.getUsername());

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                try {
                    inputBean.setUsername(user.getUsername());
                } catch (NullPointerException e) {
                    inputBean.setUsername("");
                }

                try {
                    inputBean.setExpirydate(sdf.format(user.getExpirydate()).substring(0, 10));
                } catch (NullPointerException e) {
                    inputBean.setExpirydate("");
                }

                try {
                    inputBean.setUserrole(user.getUserrole().getUserrolecode());
                } catch (NullPointerException e) {
                    inputBean.setUserrole("");
                }

//                try {
////                    inputBean.setDualauthuser(user.getDualauthuserrole().getUsername());
//                    inputBean.setDualauthuser(user.getDualauthuserrole());
//                } catch (NullPointerException e) {
//                    inputBean.setDualauthuser("");
//                }
                try {
                    inputBean.setStatus(user.getStatus().getStatuscode());
                } catch (NullPointerException e) {
                    inputBean.setStatus("");
                }

                try {
                    inputBean.setFullname(user.getFullname());
                } catch (NullPointerException e) {
                    inputBean.setFullname("");
                }

                try {
                    inputBean.setServiceid(user.getEmpid());
                } catch (NullPointerException e) {
                    inputBean.setServiceid("");
                }

                try {
                    inputBean.setAddress1(user.getAddress());
                } catch (NullPointerException e) {
                    inputBean.setAddress1("");
                }

//                try {
//                    inputBean.setAddress2(user.getAddress2());
//                } catch (NullPointerException e) {
//                    inputBean.setAddress2("");
//                }
                try {
                    inputBean.setCity(user.getCity());
                } catch (NullPointerException e) {
                    inputBean.setCity("");
                }

                try {
                    inputBean.setContactno(user.getMobile());
                } catch (NullPointerException e) {
                    inputBean.setContactno("");
                }

                try {
                    inputBean.setEmail(user.getEmail());
                } catch (NullPointerException e) {
                    inputBean.setEmail("");
                }

                try {
                    inputBean.setNic(user.getNic());
                } catch (NullPointerException e) {
                    inputBean.setNic("");
                }

                try {
                    inputBean.setDateofbirth(sdf.format(user.getDateofbirth()));
                } catch (NullPointerException e) {
                    inputBean.setDateofbirth("");
                }

                String serid_audit = "";
                String add1_audit = "";
//                String add2_audit = "";
                String city_audit = "";

                if (inputBean.getServiceid() == null || inputBean.getServiceid().isEmpty()) {
                    serid_audit = "--";
                } else {
                    serid_audit = inputBean.getServiceid();
                }
                if (inputBean.getAddress1() == null || inputBean.getAddress1().isEmpty()) {
                    add1_audit = "--";
                } else {
                    add1_audit = inputBean.getAddress1();
                }
//                if (inputBean.getAddress2() == null || inputBean.getAddress2().isEmpty()) {
//                    add2_audit = "--";
//                } else {
//                    add2_audit = inputBean.getAddress2();
//                }
                if (inputBean.getCity() == null || inputBean.getCity().isEmpty()) {
                    city_audit = "--";
                } else {
                    city_audit = inputBean.getCity();
                }

                inputBean.setOldvalue(inputBean.getUsername() + "|" + inputBean.getExpirydate() + "|" + inputBean.getUserrole() + "|"
                        + "admin|" + inputBean.getStatus() + "|" + inputBean.getFullname()
                        + "|" + inputBean.getContactno() + "|" + inputBean.getEmail() + "|" + inputBean.getNic()
                        + "|" + inputBean.getDateofbirth() + "|" + serid_audit + "|" + add1_audit + "|" + city_audit);

            } else {
                inputBean.setMessage("Empty ID.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("System user " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SystemUserAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "detail";

    }
}
