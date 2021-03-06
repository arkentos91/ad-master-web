/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.dao.usermanagement;

import com.arkentos.bean.usermanagement.UserRolePrivilegeInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.util.common.HibernateInit;
import com.arkentos.util.mapping.Page;
import com.arkentos.util.mapping.Section;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Task;
import com.arkentos.util.mapping.Pagetask;
import com.arkentos.util.mapping.PagetaskId;
import com.arkentos.util.mapping.Userrolesection;
import com.arkentos.util.mapping.UserrolesectionId;
import com.arkentos.util.mapping.Sectionpage;
import com.arkentos.util.mapping.SectionpageId;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.MessageVarList;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author jayana_i
 */
public class UserRolePrivilegeDAO {

    public void findSecByUserRole(UserRolePrivilegeInputBean bean)
            throws Exception {

        String userRole = bean.getUserRole();
        List<Section> newList = new ArrayList<Section>();
        List<Section> currentList = new ArrayList<Section>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql1 = "from Section as t where t.status.statuscode=:statuscode and sectioncode not in (select mp.id.sectioncode from Userrolesection mp where mp.id.userrolecode=:userrole)";
            String sql2 = "from Section as t where t.status.statuscode=:statuscode and sectioncode in (select mp.id.sectioncode from Userrolesection mp where mp.id.userrolecode=:userrole)";

            Query query1 = session.createQuery(sql1)
                    .setString("statuscode", CommonVarList.STATUS_ACTIVE)
                    .setString("userrole", userRole);
            Query query2 = session.createQuery(sql2)
                    .setString("statuscode", CommonVarList.STATUS_ACTIVE)
                    .setString("userrole", userRole);

            newList = (List<Section>) query1.list();
            currentList = (List<Section>) query2.list();

            for (Iterator<Section> it = newList.iterator(); it.hasNext();) {

                Section usersection = it.next();
                bean.getCurrentList().put(usersection.getSectioncode(), usersection.getDescription());
            }

            for (Iterator<Section> it = currentList.iterator(); it.hasNext();) {

                Section usersection = it.next();
                bean.getNewList().put(usersection.getSectioncode(), usersection.getDescription());
            }

        } catch (Exception e) {
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
    }

    public void getPageListBySection(UserRolePrivilegeInputBean inputBean) throws Exception {

        String code = inputBean.getSection();
        String userrole = inputBean.getUserRole();
        List<Page> newList = new ArrayList<Page>();
        List<Page> currentList = new ArrayList<Page>();
        Session session = null;

        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql1 = "from Page as t where t.status.statuscode=:status and t.pagecode not in (select mp.id.pagecode from Sectionpage mp where mp.id.sectioncode=:sectioncode and mp.id.userrolecode=:userrolecode)";
            String sql2 = "from Page as t where t.status.statuscode=:status and t.pagecode in (select mp.id.pagecode from Sectionpage mp where mp.id.sectioncode=:sectioncode and mp.id.userrolecode=:userrolecode)";

            Query query1 = session.createQuery(sql1).setString("status", CommonVarList.STATUS_ACTIVE).setString("sectioncode", code).setString("userrolecode", userrole);
            Query query2 = session.createQuery(sql2).setString("status", CommonVarList.STATUS_ACTIVE).setString("sectioncode", code).setString("userrolecode", userrole);

            newList = (List<Page>) query1.list();
            currentList = (List<Page>) query2.list();

            for (Iterator<Page> it = newList.iterator(); it.hasNext();) {

                
                Page page = it.next();
                inputBean.getCurrentList().put(page.getPagecode(), page.getDescription());
            }

            for (Iterator<Page> it = currentList.iterator(); it.hasNext();) {

                Page page = it.next();
                inputBean.getNewList().put(page.getPagecode(), page.getDescription());
            }

        } catch (Exception e) {
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
    }

    public void findTask(UserRolePrivilegeInputBean bean) throws Exception {

        List<Task> currentList = new ArrayList<Task>();
        List<Task> newList = new ArrayList<Task>();

        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql1 = "from Task as t where t.status.statuscode=:status and t.taskcode in ( select pt.id.taskcode from Pagetask as pt where pt.id.userrolecode=:userrolecode and pt.id.pagecode=:pagecode) ";
            String sql2 = "from Task as t where t.status.statuscode=:status and t.taskcode not in ( select pt.id.taskcode from Pagetask as pt where pt.id.userrolecode=:userrolecode and pt.id.pagecode=:pagecode) ";

            Query query1 = session.createQuery(sql1).setString("status", CommonVarList.STATUS_ACTIVE).setString("userrolecode", bean.getUserRole()).setString("pagecode", bean.getPage());
            Query query2 = session.createQuery(sql2).setString("status", CommonVarList.STATUS_ACTIVE).setString("userrolecode", bean.getUserRole()).setString("pagecode", bean.getPage());

            currentList = (List<Task>) query1.list();
            newList = (List<Task>) query2.list();

            for (Iterator<Task> it = currentList.iterator(); it.hasNext();) {

                Task mpitask = it.next();
                bean.getNewList().put(mpitask.getTaskcode(), mpitask.getDescription());
            }
            for (Iterator<Task> it = newList.iterator(); it.hasNext();) {

                Task mpitask = it.next();
                bean.getCurrentList().put(mpitask.getTaskcode(), mpitask.getDescription());
            }


        } catch (Exception e) {
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
    }

    public List<Section> getSectionListByUserRole(String userRole) throws Exception {
        List<Section> sectionList = new ArrayList<Section>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql = "from Section as t where t.status.statuscode=:status and sectioncode in (select mp.id.sectioncode from Userrolesection mp where mp.id.userrolecode=:userrolecode)";
            Query query = session.createQuery(sql).setString("status", CommonVarList.STATUS_ACTIVE).setString("userrolecode", userRole);
            sectionList = (List<Section>) query.list();

        } catch (Exception e) {
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return sectionList;
    }

    public List<Page> findpageByUserRoleSection(UserRolePrivilegeInputBean bean) throws Exception {

        List<Page> pageList = new ArrayList<Page>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql1 = "from Page as p where p.status.statuscode=:status and p.pagecode in (select sp.id.pagecode from Sectionpage as sp where sp.id.userrolecode=:userrolecode and sp.id.sectioncode=:sectioncode)";

            Query query1 = session.createQuery(sql1).setString("status", CommonVarList.STATUS_ACTIVE).setString("userrolecode", bean.getUserRole()).setString("sectioncode", bean.getSectionpage());

            pageList = (List<Page>) query1.list();


        } catch (Exception e) {
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return pageList;
    }

    public String assignSection(UserRolePrivilegeInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        UserrolesectionId userrolesectionid = null;
        long count=0;
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);
            Userrolesection userrolesection = null;


            String sql = "from Userrolesection as u where u.id.userrolecode=:userrolecode";
            Query query = session.createQuery(sql).setString("userrolecode", inputBean.getUserRole());
            List<Userrolesection> userRoleList = query.list();
            List<String> newBoxHas = inputBean.getNewBox();
//            int count = userRoleList.size();

            for (Userrolesection mr : userRoleList) {

                if (newBoxHas.contains(mr.getId().getSectioncode())) {

                    mr.setLastupdatedtime(sysDate);
                    mr.setLastupdateduser(audit.getLastupdateduser());
                    session.update(mr);

                    newBoxHas.remove(mr.getId().getSectioncode());
                } else {
                    
                // check whether any pages were assigned to the section
                String sql2 = "select count(userrolecode) from Sectionpage as pt where pt.id.userrolecode =:userrolecode and pt.id.sectioncode =:sectioncode";
                Query query2 = session.createQuery(sql2).setString("userrolecode", inputBean.getUserRole()).setString("sectioncode", mr.getId().getSectioncode());       
                Iterator itCount = query2.iterate();
                count = (Long) itCount.next();    
                
                if(count>0){
                    message =MessageVarList.USER_ROLE_PRI_SEC_DEPEND;
                    return message;
                }else{
                    session.delete(mr);
                    session.flush();
                }
                }
            }

            for (String sections : newBoxHas) {

                userrolesection = new Userrolesection();
                userrolesectionid = new UserrolesectionId();
                userrolesectionid.setUserrolecode(inputBean.getUserRole());
                userrolesectionid.setSectioncode(sections);
                userrolesection.setId(userrolesectionid);
                userrolesection.setCreatetime(sysDate);
                userrolesection.setLastupdatedtime(sysDate);
                userrolesection.setLastupdateduser(audit.getLastupdateduser());
                session.save(userrolesection);
            }

            audit.setCreatetime(sysDate);
            audit.setLastupdatedtime(sysDate);
            session.save(audit);
            txn.commit();

        } catch (Exception e) {
            if (txn != null) {
                txn.rollback();
            }
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return message;
    }

    public String assignSectionPages(UserRolePrivilegeInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        long count=0;
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);
            Sectionpage pt = null;

            String sql = "from Sectionpage as pt where pt.id.userrolecode =:userrolecode and pt.id.sectioncode =:sectioncode";
            Query query = session.createQuery(sql).setString("userrolecode", inputBean.getUserRole()).setString("sectioncode", inputBean.getSection());

            List<Sectionpage> sectionPageList = query.list();
            List<String> assignPageCodeList = inputBean.getNewBox();

            for (Sectionpage pst : sectionPageList) {

                if (assignPageCodeList.contains(pst.getId().getPagecode())) {

                    pst.setLastupdatedtime(sysDate);
                    pst.setLastupdateduser(audit.getLastupdateduser());
                    session.update(pst);

                    assignPageCodeList.remove(pst.getId().getPagecode());

                } else {
                    
                // check whether any tasks were assigned to the page
                String sql2 = "select count(userrolecode) from Pagetask as pt where pt.id.userrolecode =:userrolecode and pt.id.pagecode =:pagecode ";
                Query query2 = session.createQuery(sql2).setString("userrolecode", inputBean.getUserRole()).setString("pagecode", pst.getId().getPagecode());       
                Iterator itCount = query2.iterate();
                count = (Long) itCount.next();    
                
                if(count>0){
                    message =MessageVarList.USER_ROLE_PRI_PAGE_DEPEND;
                    return message;
                }else{

                    session.delete(pst);
                    session.flush();
                }
                }
            }

            for (String pageCode : assignPageCodeList) {

                pt = new Sectionpage();
//                SectionpageId ptId = new SectionpageId(pageCode, inputBean.getSection(), inputBean.getUserRole());
                SectionpageId ptId = new SectionpageId(inputBean.getUserRole(), inputBean.getSection(), pageCode);
                pt.setId(ptId);
                pt.setCreatetime(sysDate);
                pt.setLastupdatedtime(sysDate);
                pt.setLastupdateduser(audit.getLastupdateduser());
                session.save(pt);

            }

            audit.setCreatetime(sysDate);
            audit.setLastupdatedtime(sysDate);

            session.save(audit);
            txn.commit();

        } catch (Exception e) {
            if (txn != null) {
                txn.rollback();
            }
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return message;
    }

    public String assignTask(UserRolePrivilegeInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            String sql = "from Pagetask as pt where pt.id.userrolecode =:userrolecode and pt.id.pagecode =:pagecode ";
            Query query = session.createQuery(sql).setString("userrolecode", inputBean.getUserRole()).setString("pagecode", inputBean.getPage());

            List<Pagetask> userSectionList = query.list();
            List<String> currSectionCodeList = inputBean.getNewBox();

            for (Pagetask pt : userSectionList) {

                if (currSectionCodeList.contains(pt.getId().getTaskcode().toString())) {

                    pt.setLastupdatedtime(sysDate);
                    pt.setLastupdateduser(audit.getLastupdateduser());
                    session.update(pt);

                    currSectionCodeList.remove(pt.getId().getTaskcode().toString());

                } else {

                    session.delete(pt);
                    session.flush();
                }
            }

            for (String taskcode : currSectionCodeList) {

                PagetaskId ptId = new PagetaskId(inputBean.getUserRole(), inputBean.getPage(), taskcode);
//                PagetaskId ptId = new PagetaskId(inputBean.getPage(), taskcode, inputBean.getUserRole());

                Pagetask pt = new Pagetask();
                pt.setId(ptId);
                pt.setCreatetime(sysDate);
                pt.setLastupdatedtime(sysDate);
                pt.setLastupdateduser(audit.getLastupdateduser());
                session.save(pt);

            }

            audit.setCreatetime(sysDate);
            audit.setLastupdatedtime(sysDate);

            session.save(audit);
            txn.commit();

        } catch (Exception e) {
            if (txn != null) {
                txn.rollback();
            }
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return message;
    }
}
