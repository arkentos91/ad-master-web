/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.hrmanagement;

import com.arkentos.bean.hrmanagement.CandidateBean;
import com.arkentos.bean.hrmanagement.CandidateInputBean; 
import com.arkentos.bean.hrmanagement.MapBean;
import com.arkentos.bean.usermanagement.SystemUserInputBean;
import com.arkentos.dao.common.CommonDAO; 
import com.arkentos.dao.hrmanagement.CandidateDAO;
import com.arkentos.dao.usermanagement.SystemAuditDAO;
import com.arkentos.dao.usermanagement.SystemUserDAO;
import com.arkentos.util.common.AccessControlService;
import com.arkentos.util.common.Common;
import com.arkentos.util.common.Validation;
import com.arkentos.util.mapping.Hrcandidate;
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
import java.util.ArrayList;
import java.util.HashMap;
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
public class CandidateAction extends ActionSupport implements ModelDriven<Object>, AccessControlService {

    CandidateInputBean inputBean = new CandidateInputBean();

    public Object getModel() {
        return inputBean;
    }

    public String execute() {
        System.out.println("called CandidateAction : execute");
        return SUCCESS;
    }

    public String view() {
        System.out.println("called CandidateAction :view");
        String result = "view";
        try {
            if (this.applyUserPrivileges()) {

                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_INTERVIEW));
                inputBean.setDefaultStatus(CommonVarList.STATUS_SHORTLIST);
                inputBean.setPositionList(this.getJobPositionList());
              

            } else {
                result = "loginpage";
            }
 
        } catch (Exception ex) {
            addActionError("Candidate " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String ViewPopup() {

        String result = "viewpopup";
        try {
            if (this.applyUserPrivileges()) {

                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_INTERVIEW));
                inputBean.setDefaultStatus(CommonVarList.STATUS_SHORTLIST);
                inputBean.setPositionList(this.getJobPositionList());
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

            System.out.println("called CandidateAction :viewpopup");

        } catch (Exception ex) {
            addActionError("Candidate " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String add() {
        System.out.println("called CandidateAction : add");
        String result = "message";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            CandidateDAO dao = new CandidateDAO();
            String message = this.validateInputs();

            if (message.isEmpty()) {

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.ADD_TASK, PageVarList.CANDIDATE_PAGE, SectionVarList.HRM_SECTION, "Candidate code " + inputBean.getNic() + " added", null, null, null);
                message = dao.insert_data(inputBean, audit);

                if (message.isEmpty()) {
                    addActionMessage("Candidate " + MessageVarList.COMMON_SUCC_INSERT);
                } else {
                    addActionError(message);
                }
            } else {
                addActionError(message);
            }

        } catch (Exception ex) {
            addActionError("Candidate " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String update() {

        System.out.println("called CandidateAction : update");
        String retType = "message";

        try {
            if (inputBean.getNic()!= null && !inputBean.getNic().isEmpty()) {

                String message = this.validateInputs();

                if (message.isEmpty()) {

                    HttpServletRequest request = ServletActionContext.getRequest();
                    CandidateDAO dao = new CandidateDAO();

                    Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.CANDIDATE_PAGE, SectionVarList.HRM_SECTION, "Candidate code " + inputBean.getNic() + " updated", null, null, null);
                    message = dao.update_data(inputBean, audit);

                    if (message.isEmpty()) {
                        addActionMessage("Candidate " + MessageVarList.COMMON_SUCC_UPDATE);
                    } else {
                        addActionError(message);
                    }

                } else {
                    addActionError(message);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, ex);
            addActionError("Candidate " + MessageVarList.COMMON_ERROR_UPDATE);
        }
        return retType;
    }

    public String delete() {
        System.out.println("called CandidateAction : Delete");
        String message = null;
        String retType = "delete";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            CandidateDAO dao = new CandidateDAO();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.CANDIDATE_PAGE, SectionVarList.HRM_SECTION, "Candidate code " + inputBean.getNic() + " deleted", null);
            message = dao.delete_data(inputBean, audit);
            if (message.isEmpty()) {
                message = "Candidate " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);
        } catch (Exception e) {
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage())); 
        }
        return retType;
    }
    
    public String select() {
        System.out.println("called CandidateAction : select");
        String message = null;
        String retType = "select";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            CandidateDAO dao = new CandidateDAO();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.CANDIDATE_PAGE, SectionVarList.HRM_SECTION, "Candidate code " + inputBean.getNic() + " deleted", null);
            inputBean.setStatus("SELECT");
            message = dao.update_data_status(inputBean, audit);
            if (message.isEmpty()) {
                message = "Candidate " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);
        } catch (Exception e) {
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage())); 
        }
        return retType;
    }

    public String hire() {
        System.out.println("called CandidateAction : hire");
        String message = null;
        String retType = "hire";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            CandidateDAO dao = new CandidateDAO();
            SystemUserDAO sysdao=new SystemUserDAO();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.CANDIDATE_PAGE, SectionVarList.HRM_SECTION, "Candidate code " + inputBean.getNic() + " deleted", null);
           SystemUserInputBean inputbean=new SystemUserInputBean();
           inputbean.setUsername(inputBean.getNic());
           inputbean.setFullname(inputBean.getFullname());
           inputbean.setContactno(inputBean.getMobile()); 
           inputbean.setEmail(inputBean.getEmail()); 
           inputbean.setStatus("ACT"); 
           inputbean.setUserrole("NUSR"); 
           inputbean.setDateofbirth("2000-01-01"); 
           
            message = sysdao.insertNewEmplyee(inputbean, audit);
            if (message.isEmpty()) {
                message = dao.delete_data(inputBean, audit);
                message = "Candidate " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);
        } catch (Exception e) {
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage())); 
        }
        return retType;
    }

    
    public String find() {
        System.out.println("called CandidateAction: find");
        Hrcandidate map = null;
        try {
            if (inputBean.getNic() != null && !inputBean.getNic().isEmpty()) {

                CandidateDAO dao = new CandidateDAO();

                map = dao.find_data_ById(inputBean.getNic());

                inputBean.setNic(map.getNic());
                inputBean.setFullname(map.getFullname());
                inputBean.setPosition(map.getPosition());
                inputBean.setStatus(map.getStatus().getStatuscode());
                inputBean.setEmail(map.getEmail());
                inputBean.setAddress(map.getAddress());
                inputBean.setMobile(map.getMobile());
                inputBean.setInterviewdate(map.getInterviewdate().toString());
                inputBean.setRemarks(map.getRemarks());
            } else {
                inputBean.setMessage("Empty Candidate code.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Candidate " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "find";

    }

    public String Detail() {
        System.out.println("called CandidateAction: detail");
        Hrcandidate map = null;
        try {
            if (inputBean.getNic() != null && !inputBean.getNic().isEmpty()) {

                CandidateDAO dao = new CandidateDAO();
                CommonDAO commonDAO = new CommonDAO();
                inputBean.setStatusList(commonDAO.getDefultStatusList(CommonVarList.STATUS_CATEGORY_INTERVIEW));
                inputBean.setDefaultStatus(CommonVarList.STATUS_SHORTLIST);
                 inputBean.setPositionList(this.getJobPositionList());
                 
                map = dao.find_data_ById(inputBean.getNic());

                inputBean.setNic(map.getNic());
                inputBean.setFullname(map.getFullname());
                inputBean.setPosition(map.getPosition());
                inputBean.setStatus(map.getStatus().getStatuscode());
                inputBean.setEmail(map.getEmail());
                inputBean.setAddress(map.getAddress());
                inputBean.setMobile(map.getMobile());
                inputBean.setInterviewdate(map.getInterviewdate().toString());
                inputBean.setRemarks(map.getRemarks());
                

            } else {
                inputBean.setMessage("Empty NIC");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Candidate " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "detail";

    }

    public String list() {
        System.out.println("called CandidateAction: List");
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
            CandidateDAO dao = new CandidateDAO();
            List<CandidateBean> dataList = dao.getSearchList(inputBean, rows, from, orderBy);
 
            if (inputBean.isSearch() && from == 0) {

                HttpServletRequest request = ServletActionContext.getRequest();

//                String searchParameters = "["
//                        + checkEmptyorNullString("Candidate Code", inputBean.getNicSearch())
//                        + checkEmptyorNullString("Description", inputBean.getDescriptionSearch())
//                        + checkEmptyorNullString("Sort Key", inputBean.getSortKeySearch())
//                        + checkEmptyorNullString("URL", inputBean.getUrlSearch())
//                        + checkEmptyorNullString("Status", inputBean.getStatussearch())
//                        + "]";

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.SEARCH_TASK, PageVarList.CANDIDATE_PAGE, SectionVarList.HRM_SECTION, "Candidate management search using " + "" + " parameters ", null);
                SystemAuditDAO sysdao = new SystemAuditDAO();
                sysdao.saveAudit(audit);
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
            Logger.getLogger(CandidateAction.class.getName()).log(Level.SEVERE, null, e);
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
        } else if (inputBean.getFullname()== null || inputBean.getFullname().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_DESCRIPTION;
        }  else if (inputBean.getInterviewdate()== null || inputBean.getInterviewdate().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_DESCRIPTION;
        }  
        
        return message;
    }

    private boolean applyUserPrivileges() {
        HttpServletRequest request = ServletActionContext.getRequest();
        List<Task> tasklist = new Common().getUserTaskListByPage(PageVarList.CANDIDATE_PAGE, request);

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
        String page = PageVarList.CANDIDATE_PAGE;
        String task = null;
        if ("view".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("list".equals(method)) {
            task = TaskVarList.VIEW_TASK;
        } else if ("add".equals(method)) {
            task = TaskVarList.ADD_TASK;
        } else if ("delete".equals(method)) {
            task = TaskVarList.DELETE_TASK;
        } else if ("select".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
        }else if ("hire".equals(method)) {
            task = TaskVarList.UPDATE_TASK;
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
    
    private List<MapBean> getJobPositionList() {
        List<MapBean> positionList = new ArrayList<MapBean>();

        MapBean job = new MapBean();
        job.setKey("SALES");
        job.setValue("Sales Representative");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("SALEJ");
        job.setValue("Junior Sales Representative");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("HUMRE");
        job.setValue("HR Representative");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("RECEP");
        job.setValue("Secretory/Receptionist");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("ACCOU");
        job.setValue("Accountant");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("WAREH");
        job.setValue("Warehouse Foreman");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("WSTAF");
        job.setValue("Warehouse Staff");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("CUSTO");
        job.setValue("Customer Service Representative");
        positionList.add(job);
        
        job = new MapBean();
        job.setKey("SUPPL");
        job.setValue("Purchasing/Supplier Representative");
        positionList.add(job);


        return positionList;
    }
    
}
