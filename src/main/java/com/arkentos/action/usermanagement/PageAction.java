/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.usermanagement;

import com.arkentos.bean.usermanagement.PageBean;
import com.arkentos.bean.usermanagement.PageInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.dao.usermanagement.PageDAO;
import com.arkentos.dao.usermanagement.SystemAuditDAO;
import com.arkentos.util.common.AccessControlService;
import com.arkentos.util.common.Common;
import static com.arkentos.util.common.Common.checkEmptyorNullString;
import com.arkentos.util.common.Validation;
import com.arkentos.util.mapping.Page;
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
public class PageAction extends ActionSupport implements ModelDriven<Object>, AccessControlService {

    PageInputBean inputBean = new PageInputBean();

    public Object getModel() {
        return inputBean;
    }

    public String execute() {
        System.out.println("called PageAction : execute");
        return SUCCESS;
    }

    public String view() {

        String result = "view";
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

            System.out.println("called PageAction :view");

        } catch (Exception ex) {
            addActionError("Page " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String ViewPopup() {

        String result = "viewpopup";
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

            System.out.println("called PageAction :viewpopup");

        } catch (Exception ex) {
            addActionError("Page " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public String add() {
        System.out.println("called PageAction : add");
        String result = "message";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            PageDAO dao = new PageDAO();
            String message = this.validateInputs();

            if (message.isEmpty()) {

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.ADD_TASK, PageVarList.PAGE_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Page code " + inputBean.getPageCode() + " added", null, null, null);
                message = dao.insertPage(inputBean, audit);

                if (message.isEmpty()) {
                    addActionMessage("Page " + MessageVarList.COMMON_SUCC_INSERT);
                } else {
                    addActionError(message);
                }
            } else {
                addActionError(message);
            }

        } catch (Exception ex) {
            addActionError("Page " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    //start newly changed
    public String activate() {
        System.out.println("called PageAction : activate");
        String message = null;
        String retType = "activate";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            PageDAO dao = new PageDAO();
            message = this.validateInputs();
            if (message.isEmpty()) {
                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.PAGE_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Page code " + inputBean.getPageCode() + " updated", null);
                message = dao.activatePage(inputBean, audit);
                if (message.isEmpty()) {
                    message = "Page " + MessageVarList.COMMON_SUCC_ACTIVATE;
                }
                inputBean.setMessage(message);
            } else {
                addActionError(message);
            }

        } catch (Exception e) {
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(MessageVarList.COMMON_ERROR_ACTIVATE);
        }
        return retType;
    }

    //end newly changed
    public String update() {

        System.out.println("called PageAction : update");
        String retType = "message";

        try {
            if (inputBean.getPageCode() != null && !inputBean.getPageCode().isEmpty()) {

                //set username get in hidden fileds
                inputBean.setPageCode(inputBean.getPageCode());

                String message = this.validateUpdates();

                if (message.isEmpty()) {

                    HttpServletRequest request = ServletActionContext.getRequest();
                    PageDAO dao = new PageDAO();

                    Systemaudit audit = Common.makeAudittrace(request, TaskVarList.UPDATE_TASK, PageVarList.PAGE_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Page code " + inputBean.getPageCode() + " updated", null, null, null);
                    message = dao.updatePage(inputBean, audit);

                    if (message.isEmpty()) {
                        addActionMessage("Page " + MessageVarList.COMMON_SUCC_UPDATE);
                    } else {
                        addActionError(message);
                    }

                } else {
                    addActionError(message);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, ex);
            addActionError("Page " + MessageVarList.COMMON_ERROR_UPDATE);
        }
        return retType;
    }

    public String delete() {
        System.out.println("called PageAction : Delete");
        String message = null;
        String retType = "delete";
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            PageDAO dao = new PageDAO();
            Systemaudit audit = Common.makeAudittrace(request, TaskVarList.DELETE_TASK, PageVarList.PAGE_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Page code " + inputBean.getPageCode() + " deleted", null);
            message = dao.deletePage(inputBean, audit);
            if (message.isEmpty()) {
                message = "Page " + MessageVarList.COMMON_SUCC_DELETE;
            }
            inputBean.setMessage(message);
        } catch (Exception e) {
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, e);
            inputBean.setMessage(OracleMessage.getMessege(e.getMessage()));
//            inputBean.setMessage(MessageVarList.COMMON_ERROR_DELETE);
        }
        return retType;
    }

    public String find() {
        System.out.println("called PageAction: find");
        Page Page = null;
        try {
            if (inputBean.getPageCode() != null && !inputBean.getPageCode().isEmpty()) {

                PageDAO dao = new PageDAO();

                Page = dao.findPageById(inputBean.getPageCode());

                inputBean.setPageCode(Page.getPagecode());
                inputBean.setDescription(Page.getDescription());
                inputBean.setSortKey(Page.getSortkey().toString());
                inputBean.setStatus(Page.getStatus().getStatuscode());
                inputBean.setUrl(Page.getUrl());

            } else {
                inputBean.setMessage("Empty Page code.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Page " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "find";

    }

    public String Detail() {
        System.out.println("called PageAction: detail");
        Page Page = null;
        try {
            if (inputBean.getPageCode() != null && !inputBean.getPageCode().isEmpty()) {

                PageDAO dao = new PageDAO();
                CommonDAO commonDAO = new CommonDAO();
                inputBean.setStatusList(commonDAO.getDefultStatusList(CommonVarList.STATUS_CATEGORY_GENERAL));
                inputBean.setDefaultStatus(CommonVarList.STATUS_ACTIVE);

                Page = dao.findPageById(inputBean.getPageCode());

                inputBean.setPageCode(Page.getPagecode());
                inputBean.setDescription(Page.getDescription());
                inputBean.setSortKey(Page.getSortkey().toString());
                inputBean.setStatus(Page.getStatus().getStatuscode());
                inputBean.setUrl(Page.getUrl());

            } else {
                inputBean.setMessage("Empty Page code.");
            }
        } catch (Exception ex) {
            inputBean.setMessage("Page " + MessageVarList.COMMON_ERROR_PROCESS);
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "detail";

    }

    public String list() {
        System.out.println("called PageAction: List");
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
            PageDAO dao = new PageDAO();
            List<PageBean> dataList = dao.getSearchList(inputBean, rows, from, orderBy);

            /**
             * for search audit
             */
            if (inputBean.isSearch() && from == 0) {

                HttpServletRequest request = ServletActionContext.getRequest();

                String searchParameters = "["
                        + checkEmptyorNullString("Page Code", inputBean.getPageCodeSearch())
                        + checkEmptyorNullString("Description", inputBean.getDescriptionSearch())
                        + checkEmptyorNullString("Sort Key", inputBean.getSortKeySearch())
                        + checkEmptyorNullString("URL", inputBean.getUrlSearch())
                        + checkEmptyorNullString("Status", inputBean.getStatussearch())
                        + "]";

                Systemaudit audit = Common.makeAudittrace(request, TaskVarList.SEARCH_TASK, PageVarList.PAGE_MGT_PAGE, SectionVarList.USERMANAGEMENT, "Page management search using " + searchParameters + " parameters ", null);
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
            Logger.getLogger(PageAction.class.getName()).log(Level.SEVERE, null, e);
            addActionError(MessageVarList.COMMON_ERROR_PROCESS + " Page");
        }
        return "list";
    }

    private String validateInputs() {
        String message = "";
        if (inputBean.getPageCode() == null || inputBean.getPageCode().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_PAGE_CODE;
        } else if(!Validation.isSpecailCharacter(inputBean.getPageCode())){
            message = MessageVarList.PAGE_MGT_ERROR_PAGE_CODE_INVALID;
        } else if (inputBean.getDescription() == null || inputBean.getDescription().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_DESCRIPTION;
        } else if (!Validation.isSpecailCharacter(inputBean.getDescription())) {
            message = MessageVarList.PAGE_MGT_ERROR_DESC_INVALID;
        } else if (inputBean.getUrl() == null || inputBean.getUrl().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_URL;
        } else if (!inputBean.getUrl().startsWith("/")) {
            message = MessageVarList.PAGE_MGT_ERROR_URL_INVALID;
        } else if (inputBean.getSortKey() == null || inputBean.getSortKey().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_SORTKEY;
        } else {
            try {
                new Integer(inputBean.getSortKey());
            } catch (Exception e) {
                message = MessageVarList.PAGE_MGT_ERROR_SORTKEY_INVALID;
            }
            try {
                CommonDAO dao = new CommonDAO();
                message = dao.getPageSortKeyCount(inputBean.getSortKey());

            } catch (Exception e) {
                message = MessageVarList.PAGE_MGT_ERROR_SORT_KEY_ALREADY_EXSITS;
            }
        }
        if(message.isEmpty()){
            if (inputBean.getStatus() != null && inputBean.getStatus().isEmpty()) {
                message = MessageVarList.PAGE_MGT_EMPTY_STATUS;
            }
        }
        return message;
    }

    private String validateUpdates() {
        String message = "";
        if (inputBean.getPageCode() == null || inputBean.getPageCode().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_PAGE_CODE;
        } else if(!Validation.isSpecailCharacter(inputBean.getPageCode())){
            message = MessageVarList.PAGE_MGT_ERROR_PAGE_CODE_INVALID;
        } else if (inputBean.getDescription() == null || inputBean.getDescription().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_DESCRIPTION;
        } else if (!Validation.isSpecailCharacter(inputBean.getDescription())) {
            message = MessageVarList.PAGE_MGT_ERROR_DESC_INVALID;
        } else if (inputBean.getUrl() == null || inputBean.getUrl().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_URL;
        } else if (!inputBean.getUrl().startsWith("/")) {
            message = MessageVarList.PAGE_MGT_ERROR_URL_INVALID;
        } else if (inputBean.getSortKey() == null || inputBean.getSortKey().trim().isEmpty()) {
            message = MessageVarList.PAGE_MGT_EMPTY_SORTKEY;
        } else {
            try {
                new Integer(inputBean.getSortKey());
            } catch (Exception e) {
                message = MessageVarList.PAGE_MGT_ERROR_SORTKEY_INVALID;
            }
        }
        if(message.isEmpty()){
            if (inputBean.getStatus() != null && inputBean.getStatus().isEmpty()) {
                message = MessageVarList.PAGE_MGT_EMPTY_STATUS;
            }
        }
//                try {
//                    Page task = null;
//                    PageDAO pDao = new PageDAO();
//                    task = pDao.findPageById(inputBean.getPageCode());
//
//                    inputBean.setOldsortKey(task.getSortkey().toString());
//
//                    System.err.println("Old " + inputBean.getOldsortKey());
//                    System.err.println("New " + inputBean.getSortKey());
//
//                    if (inputBean.getSortKey().equals(inputBean.getOldsortKey())) {
//                        CommonDAO dao = new CommonDAO();
//                        message = dao.getPageSortKeyCountUpdate(inputBean.getSortKey(), inputBean.getOldsortKey());
//                        
//                    } else {
//                        
//                        message = MessageVarList.TASK_MGT_SORTKEY_ALREADY_EXSISTS;
//                    }
//                } catch (Exception e) {
//                    message = MessageVarList.PAGE_MGT_ERROR_SORTKEY_INVALID;
//                }
//                try {
//                    Page task = null;
//                    PageDAO pDao = new PageDAO();
//                    task = pDao.findPageById(inputBean.getPageCode());
//
//                    inputBean.setOldsortKey(task.getSortkey().toString());
//
//                    System.err.println("Old " + inputBean.getOldsortKey());
//                    System.err.println("New " + inputBean.getSortKey());
//
//                    if (inputBean.getSortKey().equals(inputBean.getOldsortKey())) {
//                        CommonDAO dao = new CommonDAO();
//                        message = dao.getPageSortKeyCountUpdate(inputBean.getSortKey(), inputBean.getOldsortKey());
//                        
//                    } else {
//                        message = MessageVarList.TASK_MGT_SORTKEY_ALREADY_EXSISTS;
//                    }
//                } catch (Exception e) {
//                    message = MessageVarList.PAGE_MGT_ERROR_SORTKEY_INVALID;
//                }
//            }
//        }
        return message;
    }

    private boolean applyUserPrivileges() {
        HttpServletRequest request = ServletActionContext.getRequest();
        List<Task> tasklist = new Common().getUserTaskListByPage(PageVarList.PAGE_MGT_PAGE, request);

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
//                } else if (task.getTaskcode().toString().equalsIgnoreCase(TaskVarList.LOGIN_TASK)) {
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
        String page = PageVarList.PAGE_MGT_PAGE;
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
            //start newly changed
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
