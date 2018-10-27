/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.usermanagement;

import com.arkentos.bean.usermanagement.SectionBean;
import com.arkentos.bean.usermanagement.SectionInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.dao.usermanagement.SectionDao;
import com.arkentos.dao.usermanagement.SystemAuditDAO;
import com.arkentos.util.common.AccessControlService;
import com.arkentos.util.common.Common;
import static com.arkentos.util.common.Common.checkEmptyorNullString;
import com.arkentos.util.mapping.Section;
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
public class SectionAction extends ActionSupport implements ModelDriven<Object>, AccessControlService {

    SectionInputBean inputBean = new SectionInputBean();

    public Object getModel() {
        return inputBean;
    }

    public SectionAction() {
    }

    public String execute() throws Exception {
        System.out.println("Called Section Action: execute");
        return SUCCESS;
    }

    public String View() {
        String result = "view";

        try {
            if (this.applyUserPrivileges()) {
                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));

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

            System.out.println("called SectionAction: view");

        } catch (Exception e) {
            addActionError("Section " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
        }
        return result;
    }

    //start newly chnged
    public String activate() {
        System.out.println("called SectionAction : activate");
        String message = null;
        String retType = "activate";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            SectionDao dao = new SectionDao();
            message = this.validateInputs();
            if (message.isEmpty()) {
                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.SECTION_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Section code " + inputBean.getSectionCode() + " updated", null);
                message = dao.activateSection(inputBean, audit);
                if (message.isEmpty()) {
                    message = "Section " + MessageVarList.COMMON_SUCC_ACTIVATE;
                }
                inputBean.setMessage(message);
            } else {
                addActionError(message);
            }

        } catch (Exception e) {
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(MessageVarList.COMMON_ERROR_ACTIVATE);
        }
        return retType;
    }

    //end newly changed
    public boolean checkAccess(String method, String userRole) {
        boolean status = false;
        String page = PageVarList.SECTION_MGT_PAGE;
        String section = null;

        if ("View".equals(method)) {
            section = TaskVarList.VIEW_TASK;
        } else if ("List".equals(method)) {
            section = TaskVarList.VIEW_TASK;
        } else if ("Add".equals(method)) {
            section = TaskVarList.ADD_TASK;
        } else if ("Delete".equals(method)) {
            section = TaskVarList.DELETE_TASK;
        } else if ("Find".equals(method)) {
            section = TaskVarList.VIEW_TASK;
        } else if ("ViewPopup".equals(method)) {
            section = TaskVarList.VIEW_TASK;
        } else if ("Update".equals(method)) {
            section = TaskVarList.UPDATE_TASK;
        }//newly changed
        else if ("activate".equals(method)) {
            section = TaskVarList.UPDATE_TASK;
        } else if ("detail".equals(method)) {
            section = TaskVarList.VIEW_TASK;
        }

        if ("execute".equals(method)) {
            status = true;
        } else {
            HttpServletRequest request = ServletActionContext.getRequest();
            status = new Common().checkMethodAccess(section, page, userRole, request);
        }
        return status;
    }

    private boolean applyUserPrivileges() {
        HttpServletRequest request = ServletActionContext.getRequest();
        List<Task> tasklist = new Common().getUserTaskListByPage(PageVarList.SECTION_MGT_PAGE, request);

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

    public String List() {
        System.out.println("called sectionAction: List");
        try {

            int rows = inputBean.getRows();
            int page = inputBean.getPage();
            int to = (rows * page);
            int from = to - rows;
            long records = 0;
            String orderBy = "";
            if (!inputBean.getSidx().isEmpty()) {
                orderBy = " order by " + inputBean.getSidx() + " " + inputBean.getSord();
            }
            SectionDao dao = new SectionDao();
            List<SectionBean> dataList = dao.getSearchList(inputBean, to, from, orderBy);

            /**
             * for search audit
             */
            if (inputBean.isSearch() && from == 0) {

                HttpServletRequest request = ServletActionContext.getRequest();
                String searchParameters = "["
                        + checkEmptyorNullString("Section Code",inputBean.getS_sectioncode())
                        + checkEmptyorNullString("Description" ,inputBean.getS_description())
                        + checkEmptyorNullString("Sort Key", inputBean.getS_sortkey())
                        + checkEmptyorNullString("Status" ,inputBean.getS_status())
                        + "]";

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.SEARCH_TASK, PageVarList.SECTION_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Section management search using " + searchParameters + " parameters ", null);
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
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
            addActionError("Section " + MessageVarList.COMMON_ERROR_PROCESS);
        }
        return "list";
    }

    public String Add() {
        System.out.println("called sectionAction: add");
        String result = "message";

        try {
            HttpServletRequest request = ServletActionContext.getRequest();

            SectionDao dao = new SectionDao();
            String message = this.validateInputs();
            if (message.isEmpty()) {

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.ADD_TASK, PageVarList.SECTION_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Section code " + inputBean.getSectionCode() + " added", null, null, null);
                message = dao.insertSection(inputBean, audit);

                if (message.isEmpty()) {
                    addActionMessage("Section " + MessageVarList.COMMON_SUCC_INSERT);
                } else {
                    addActionError(message);
                }
            } else {
                addActionError(message);
            }

        } catch (Exception e) {
            addActionError("Section " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
        }

        return result;
    }

    private String validateInputs() {
        String message = "";
        String url = "";

        if (inputBean.getSectionCode() == null || inputBean.getSectionCode().trim().isEmpty()) {
            message = MessageVarList.SECTION_CODE_EMPTY;
        } else if (inputBean.getDescription() == null || inputBean.getDescription().trim().isEmpty()) {
            message = MessageVarList.SECTION_DESC_EMPTY;
        } else if (inputBean.getSortKey() == null || inputBean.getSortKey().trim().isEmpty()) {
            message = MessageVarList.SECTION_SORY_KEY_EMPTY;
        } else if (inputBean.getStatus() != null && inputBean.getStatus().isEmpty()) {
            message = MessageVarList.USER_ROLE_MGT_EMPTY_STATUS;
        } else {
            try {
                new Integer(inputBean.getSortKey());
            } catch (Exception e) {
                message = MessageVarList.TASK_MGT_ERROR_SORTKEY_INVALID;
            }
            try {

                CommonDAO dao = new CommonDAO();
                message = dao.getSectionSortKeyCount(inputBean.getSortKey());

            } catch (Exception e) {
                message = MessageVarList.TASK_MGT_ERROR_SORTKEY_INVALID;
            }
        }

        return message;
    }

    private String validateUpdates() {
        String message = "";
        String url = "";

        if (inputBean.getSectionCode() == null || inputBean.getSectionCode().trim().isEmpty()) {
            message = MessageVarList.SECTION_CODE_EMPTY;
        } else if (inputBean.getDescription() == null || inputBean.getDescription().trim().isEmpty()) {
            message = MessageVarList.SECTION_DESC_EMPTY;
        } else if (inputBean.getSortKey() == null || inputBean.getSortKey().trim().isEmpty()) {
            message = MessageVarList.SECTION_SORY_KEY_EMPTY;
        } else if (inputBean.getStatus() != null && inputBean.getStatus().isEmpty()) {
            message = MessageVarList.USER_ROLE_MGT_EMPTY_STATUS;
        } else {

            try {
                new Integer(inputBean.getSortKey());
            } catch (Exception e) {
                message = MessageVarList.TASK_MGT_ERROR_SORTKEY_INVALID;
            }

        }

        return message;
    }

    public String detail() {
        System.out.println("called SectionMgtAction : detail");
        Section tt = null;
        try {
            if (inputBean.getSectionCode() != null && !inputBean.getSectionCode().isEmpty()) {

                SectionDao dao = new SectionDao();
                CommonDAO commonDAO = new CommonDAO();
                inputBean.setStatusList(commonDAO.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));

                tt = dao.findSectionById(inputBean.getSectionCode());

                inputBean.setSectionCode(tt.getSectioncode());
                inputBean.setDescription(tt.getDescription());
                inputBean.setSortKey(tt.getSortkey().toString());
                inputBean.setOldsortkey(tt.getSortkey().toString());
                inputBean.setStatus(tt.getStatus().getStatuscode());

            } else {
                inputBean.setMessage("Empty Section code.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Section code  " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "detail";

    }

    public String Update() {

        System.out.println("called sectionAction : update");
        String retType = "message";

        try {
            if (inputBean.getSectionCode() != null && !inputBean.getSectionCode().isEmpty()) {

                //set username get in hidden fileds
                inputBean.setSectionCode(inputBean.getSectionCode());

                String message = this.validateUpdates();

                if (message.isEmpty()) {

                    HttpServletRequest request = ServletActionContext.getRequest();
                    SectionDao dao = new SectionDao();

                    Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.SECTION_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Section code " + inputBean.getSectionCode() + " updated", null, null, null);
                    message = dao.updateSection(inputBean, audit);

                    if (message.isEmpty()) {
                        addActionMessage("Section " + MessageVarList.COMMON_SUCC_UPDATE);
                    } else {
                        addActionError(message);
                    }

                } else {
                    addActionError(message);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, ex);
            addActionError("Section " + MessageVarList.COMMON_ERROR_UPDATE);
        }
        return retType;
    }

    public String Find() {
        System.out.println("called SectionAction: Find");
        Section section = null;

        try {
            if (inputBean.getSectionCode() != null && !inputBean.getSectionCode().isEmpty()) {

                SectionDao dao = new SectionDao();
                section = dao.findSectionById(inputBean.getSectionCode());

                inputBean.setSectionCode(section.getSectioncode());
                inputBean.setDescription(section.getDescription());
                inputBean.setSortKey(section.getSortkey().toString());
                inputBean.setOldsortkey(section.getSortkey().toString());
                inputBean.setStatus(section.getStatus().getStatuscode());

            } else {
                inputBean.setMessage("Empty section code");
            }

        } catch (Exception e) {
            inputBean.setMessage("Section " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
        }
        return "find";
    }

    public String Delete() {
        System.out.println("called SectionAction: delete");
        String message = null;
        String retType = "delete";

        try {

            HttpServletRequest request = ServletActionContext.getRequest();
            SectionDao dao = new SectionDao();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.SECTION_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Section code " + inputBean.getSectionCode() + " deleted", null);

            message = dao.deleteSection(inputBean, audit);
            if (message.isEmpty()) {
                message = "Section " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);

        } catch (Exception e) {
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage()));
        }
        return retType;
    }

    public String ViewPopup() {
        String result = "viewpopup";
        System.out.println("called AgentAction : ViewPopup");
        try {
            if (this.applyUserPrivileges()) {
                CommonDAO dao = new CommonDAO();
                inputBean.setStatusList(dao.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setDefaultStatus(CommonVarList.STATUS_ACTIVE);

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
            addActionError("Section " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(SectionAction.class.getName()).log(Level.SEVERE, null, e);
        }
        return result;
    }
}
