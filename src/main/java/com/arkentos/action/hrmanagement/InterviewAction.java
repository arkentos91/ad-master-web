/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.hrmanagement;

import com.arkentos.bean.hrmanagement.InterviewBean;
import com.arkentos.bean.hrmanagement.InterviewInputBean; 
import com.arkentos.dao.common.CommonDAO; 
import com.arkentos.dao.hrmanagement.InterviewDAO;
import com.arkentos.util.common.AccessControlService;
import com.arkentos.util.common.Common;
import com.arkentos.util.common.Validation;
import com.arkentos.util.mapping.Hrinterview;
import com.arkentos.util.mapping.Systemaudit;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author jayana_i
 */
public class InterviewAction extends ActionSupport implements ModelDriven<Object>, AccessControlService {

    InterviewInputBean inputBean = new InterviewInputBean();

    public Object getModel() {
        return inputBean;
    }

    public String execute() {
        System.out.println("called InterviewAction : execute");
        return SUCCESS;
    }

    public String view() {

        String result = "view";
        try {
            if (this.applyUserPrivileges()) {

                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setCandidateList(dao.getCandidateList(CommonVarList.STATUS_SHORTLIST));
                inputBean.setInterviewUserList(dao.getUserList());
                

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

            System.out.println("called InterviewAction :view");

        } catch (Exception ex) {
            addActionError("Interview " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String ViewPopup() {

        String result = "viewpopup";
        try {
            if (this.applyUserPrivileges()) {

                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setCandidateList(dao.getCandidateList(CommonVarList.STATUS_SHORTLIST));
                inputBean.setInterviewUserList(dao.getUserList());

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

            System.out.println("called InterviewAction :viewpopup");

        } catch (Exception ex) {
            addActionError("Interview " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String add() {
        System.out.println("called InterviewAction : add");
        String result = "message";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            InterviewDAO dao = new InterviewDAO();
            String message = this.validateInputs();
            message="";
            if (message.isEmpty()) {

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.ADD_TASK, PageVarList.INTERVIEW_PAGE, SectionVarList.HRM_SECTION, "Interview code " + inputBean.getNic() + " added", null, null, null);
                message = dao.insert_data(inputBean, audit);

                if (message.isEmpty()) {
                    addActionMessage("Interview " + MessageVarList.COMMON_SUCC_INSERT);
                } else {
                    addActionError(message);
                }
            } else {
                addActionError(message);
            }

        } catch (Exception ex) {
            addActionError("Interview " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }


    public String update() {

        System.out.println("called InterviewAction : update");
        String retType = "message";

        try {
            if (inputBean.getNic()!= null && !inputBean.getNic().isEmpty()) {

                String message = this.validateInputs();

                if (message.isEmpty()) {

                    HttpServletRequest request = ServletActionContext.getRequest();
                    InterviewDAO dao = new InterviewDAO();

                    Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.INTERVIEW_PAGE, SectionVarList.HRM_SECTION, "Interview code " + inputBean.getNic() + " updated", null, null, null);
                    message = dao.update_data(inputBean, audit);

                    if (message.isEmpty()) {
                        addActionMessage("Interview " + MessageVarList.COMMON_SUCC_UPDATE);
                    } else {
                        addActionError(message);
                    }

                } else {
                    addActionError(message);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, ex);
            addActionError("Interview " + MessageVarList.COMMON_ERROR_UPDATE);
        }
        return retType;
    }

    public String delete() {
        System.out.println("called InterviewAction : Delete");
        String message = null;
        String retType = "delete";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            InterviewDAO dao = new InterviewDAO();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.INTERVIEW_PAGE, SectionVarList.HRM_SECTION, "Interview code " + inputBean.getNic() + " deleted", null);
            message = dao.delete_data(inputBean, audit);
            if (message.isEmpty()) {
                message = "Interview " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);
        } catch (Exception e) {
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage())); 
        }
        return retType;
    }

    public String find() {
        System.out.println("called InterviewAction: find");
        Hrinterview map = null;
        try {
            if (inputBean.getNic() != null && !inputBean.getNic().isEmpty()) {

                InterviewDAO dao = new InterviewDAO();

                map = dao.find_data_ById(inputBean.getNic());

                
                inputBean.setNic(map.getNic());
                inputBean.setInterviewdate(map.getInterviewdate().toString());
                inputBean.setInterviewedby_Search(map.getInterviewedby().getUsername());
                inputBean.setInterviewstatus(map.getInterviewstatus().getStatuscode());
                
                inputBean.setStatus(map.getStatus().getStatuscode());
                inputBean.setApprovedby(map.getApprovedby().getUsername());
                inputBean.setRemarks(map.getRemarks());

            } else {
                inputBean.setMessage("Empty Interview code.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Interview " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "find";

    }

    public String Detail() {
        System.out.println("called InterviewAction: detail");
        Hrinterview map = null;
        try {
            if (inputBean.getNic() != null && !inputBean.getNic().isEmpty()) {

                InterviewDAO intdao = new InterviewDAO();
                CommonDAO dao = new CommonDAO(); 
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setCandidateList(dao.getCandidateList());
                inputBean.setInterviewUserList(dao.getUserList());

                map = intdao.find_data_ById(inputBean.getNic());

                inputBean.setNic(map.getNic());
                inputBean.setInterviewdate(map.getInterviewdate().toString());
                inputBean.setInterviewedby(map.getInterviewedby().getUsername());
                inputBean.setInterviewstatus(map.getInterviewstatus().getStatuscode());
                
//                inputBean.setStatus(map.getStatus().getStatuscode());
//                inputBean.setApprovedby(map.getApprovedby().getUsername());
                inputBean.setRemarks(map.getRemarks());
                

            } else {
                inputBean.setMessage("Empty Interview code.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Interview " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "detail";

    }

    public String list() {
        System.out.println("called InterviewAction: List");
        try {
            //if (inputBean.isSearch()) {

            int rows = inputBean.getRows();
            int page = inputBean.getPage();
            int to = (rows * page);
            int from = to - rows;
            long records = 0;
            String orderBy = "";
            if (!inputBean.getSidx().isEmpty()) {
                orderBy = " order by " + inputBean.getSidx() + " " + inputBean.getSord();
            }
            InterviewDAO dao = new InterviewDAO();
            List<InterviewBean> dataList = dao.getSearchList(inputBean, rows, from, orderBy);
 
            if (inputBean.isSearch() && from == 0) {

                HttpServletRequest request = ServletActionContext.getRequest();

//                String searchParameters = "["
//                        + checkEmptyorNullString("Interview Code", inputBean.getNicSearch())
//                        + checkEmptyorNullString("Description", inputBean.getDescriptionSearch())
//                        + checkEmptyorNullString("Sort Key", inputBean.getSortKeySearch())
//                        + checkEmptyorNullString("URL", inputBean.getUrlSearch())
//                        + checkEmptyorNullString("Status", inputBean.getStatussearch())
//                        + "]";

//                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.SEARCH_TASK, PageVarList.INTERVIEW_PAGE, SectionVarList.HRM_SECTION, "Interview management search using " + "" + " parameters ", null);
//                SystemAuditDAO sysdao = new SystemAuditDAO();
//                sysdao.saveAudit(audit);
            }

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
            Logger.getLogger(InterviewAction.class.getName()).log(Level.SEVERE, null, e);
            addActionError(MessageVarList.COMMON_ERROR_PROCESS + " Page");
        }
        return "list";
    }

    private String validateInputs() {
        String message = "";
        if (inputBean.getNic() == null || inputBean.getNic().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_PAGE_CODE;
        } else if(!Validation.isSpecailCharacter(inputBean.getNic())){
            message = MessageVarList.PAGE_MGT_ERROR_PAGE_CODE_INVALID;
        } else if (inputBean.getInterviewedby()== null || inputBean.getInterviewedby().trim().isEmpty()) {
//            message = MessageVarList.PAGE_MGT_EMPTY_DESCRIPTION;
        }  
        
        return message;
    }


    private boolean applyUserPrivileges() {
        HttpServletRequest request = ServletActionContext.getRequest();
        List<Task> tasklist = new Common().getUserTaskListByPage(PageVarList.INTERVIEW_PAGE, request);

        inputBean.setVadd(true);
        inputBean.setVdelete(true);
        inputBean.setVupdatelink(true);
        inputBean.setVsearch(true);

        if (tasklist != null && tasklist.size() > 0) {
            for (Task task : tasklist) {
                if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.ADD_TASK)) {
                    inputBean.setVadd(false);
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.DELETE_TASK)) {
                    inputBean.setVdelete(false); 
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.UPDATE_TASK)) {
                    inputBean.setVupdatelink(false);
                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.SEARCH_TASK)) {
                    inputBean.setVsearch(false);
                }
            }
        }
        inputBean.setVupdatebutt(true);

        return true;
    }

    public boolean checkAccess(String method, String userRole) {
        boolean status = false;
        String page = PageVarList.INTERVIEW_PAGE;
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
        } else if ("update".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        } else if ("activate".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        } else if ("Detail".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("ViewPopup".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        }
        if ("execute".equals(method)) {
            status = true;
        } else {
            HttpServletRequest request = ServletActionContext.getRequest();
            status = new Common().checkMethodAccess(task, page, userRole, request);
        }
        return status;
    }
}
