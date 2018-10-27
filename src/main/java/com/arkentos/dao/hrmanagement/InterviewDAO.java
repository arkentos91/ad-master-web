/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.dao.hrmanagement;

import com.arkentos.bean.hrmanagement.InterviewBean;
import com.arkentos.bean.hrmanagement.InterviewInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.util.common.Common;
import com.arkentos.util.common.HibernateInit;
import com.arkentos.util.mapping.Hrcandidate;
import com.arkentos.util.mapping.Hrinterview;
import com.arkentos.util.mapping.Status;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Systemuser;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.MessageVarList;
import com.arkentos.util.varlist.SessionVarlist;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author jayana_i
 */
public class InterviewDAO {

    public String insert_data(InterviewInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            if ((Hrinterview) session.get(Hrinterview.class, inputBean.getNic().trim()) == null) {
                txn = session.beginTransaction();
                Hrinterview a = new Hrinterview();
                System.err.println(inputBean.getInterviewdate());

                a.setNic(inputBean.getNic());
                a.setInterviewdate(Common.StringtoDateTime(inputBean.getInterviewdate()));

                Systemuser ius = new Systemuser();
                ius.setUsername(inputBean.getInterviewedby());
                a.setInterviewedby(ius);

                Status status = new Status();
                status.setStatuscode("SHEDU");
                a.setInterviewstatus(status);

                Hrcandidate candidate = (Hrcandidate) session.get(Hrcandidate.class, inputBean.getNic().trim());
                candidate.setStatus(status);

                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

                session.update(candidate);

                session.save(audit);
                session.save(a);

                txn.commit();
            } else {

                message = MessageVarList.COMMON_ALREADY_EXISTS;

            }

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

    public String update_data(InterviewInputBean inputBean, Systemaudit audit) throws Exception {

        Session session = null;
        Transaction txn = null;
        String message = "";

        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Hrinterview u = (Hrinterview) session.get(Hrinterview.class, inputBean.getNic().trim());

            if (u != null) {

                u.setNic(inputBean.getNic());
                u.setInterviewdate(Common.specialStringtoDate(inputBean.getInterviewdate()));

//                Systemuser ius = new Systemuser();
//                ius.setUsername(inputBean.getInterviewedby());
//                u.setInterviewedby(ius);

                Status intstatus = new Status();
                intstatus.setStatuscode(inputBean.getStatus());
                u.setInterviewstatus(intstatus);

                Systemuser aus = new Systemuser();
                aus.setUsername("admin");
                u.setInterviewedby(aus);
                u.setRemarks(inputBean.getRemarks());

                Status status = new Status();
                status.setStatuscode(inputBean.getStatus());
                u.setInterviewstatus(status);

                audit.setOldvalue(inputBean.getOldvalue());

                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

                session.save(audit);
                session.update(u);

                txn.commit();
            } else {
                message = MessageVarList.COMMON_NOT_EXISTS;
            }
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

    public String delete_data(InterviewInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Hrinterview d = (Hrinterview) session.get(Hrinterview.class, inputBean.getNic().trim());
            if (d != null) {

                long count = 0;

                String sqlCount = "select count(pagecode) from Sectionpage as u where u.page.pagecode=:pagecode ";
                Query queryCount = session.createQuery(sqlCount).setString("pagecode", inputBean.getNic().trim());

                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();

                if (count > 0) {
                    message = MessageVarList.COMMON_NOT_DELETE;
                } else {
                    String sqlCount2 = "select count(pagecode) from Pagetask as u where u.page.pagecode=:pagecode ";
                    Query queryCount2 = session.createQuery(sqlCount2).setString("pagecode", inputBean.getNic().trim());

                    Iterator itCount2 = queryCount2.iterate();
                    count = (Long) itCount2.next();
                    if (count > 0) {
                        message = MessageVarList.COMMON_NOT_DELETE;
                    } else {
                        audit.setCreatetime(sysDate);
                        audit.setLastupdatedtime(sysDate);

                        session.save(audit);
                        session.delete(d);
                        txn.commit();
                    }
                }

            } else {
                message = MessageVarList.COMMON_NOT_EXISTS;
            }
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

    public Hrinterview find_data_ById(String nic) throws Exception {
        Hrinterview candiate = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql = "from Hrinterview as u where u.nic=:nic";
            Query query = session.createQuery(sql).setString("nic", nic);
            candiate = (Hrinterview) query.list().get(0);

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
        return candiate;

    }

    public List<InterviewBean> getSearchList(InterviewInputBean inputBean, int max, int first, String orderBy) throws Exception {

        List<InterviewBean> dataList = new ArrayList<InterviewBean>();
        Session session = null;
        try {

            long count = 0;
            String where = this.makeWhereClause(inputBean);

            session = HibernateInit.sessionFactory.openSession();

            HttpServletRequest request = ServletActionContext.getRequest();
            HttpSession httpsession = request.getSession(false);
            Systemuser sysUser = (Systemuser) httpsession.getAttribute(SessionVarlist.SYSTEMUSER);

            if (sysUser.getUserrole().getUserrolecode().equals("HRRE") || sysUser.getUserrole().getUserrolecode().equals("ADM")) {
                String sqlCount = "select count(nic) from Hrinterview as u where " + where;
                Query queryCount = session.createQuery(sqlCount);
                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();
            } else {
                String sqlCount = "select count(nic) from Hrinterview as u where u.interviewedby.username=:interviewedby and " + where;
                Query queryCount = session.createQuery(sqlCount).setString("interviewedby", sysUser.getUsername());
                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();
            }

            if (count > 0) {
                String sqlSearch;
                Query querySearch;
                if (sysUser.getUserrole().getUserrolecode().equals("HRRE") || sysUser.getUserrole().getUserrolecode().equals("ADM")) {
                    sqlSearch = "from Hrinterview u where " + where + " " + orderBy;
                    querySearch = session.createQuery(sqlSearch);
                } else {
                    sqlSearch = "from Hrinterview u where u.interviewedby.username=:interviewedby and " + where + " " + orderBy;
                    querySearch = session.createQuery(sqlSearch).setString("interviewedby", sysUser.getUsername());
                }

                querySearch.setMaxResults(max);
                querySearch.setFirstResult(first);
                Iterator it = querySearch.iterate();

                while (it.hasNext()) {

                    InterviewBean bean = new InterviewBean();
                    Hrinterview candiate = (Hrinterview) it.next();

                    try {
                        bean.setNic(candiate.getNic());
                    } catch (NullPointerException npe) {
                        bean.setNic("--");
                    }
                    try {
                        bean.setFullname(CommonDAO.getFullnamebyNIC(candiate.getNic()));
                    } catch (NullPointerException npe) {
                        bean.setFullname("--");
                    }

                    try {
                        bean.setInterviewdate(candiate.getInterviewdate().toGMTString());
                    } catch (NullPointerException npe) {
                        bean.setInterviewdate("--");
                    }

                    try {
                        bean.setInterviewedby(candiate.getInterviewedby().getFullname());
                    } catch (NullPointerException npe) {
                        bean.setNic("--");
                    }

                    try {
                        bean.setInterviewstatus(candiate.getInterviewstatus().getDescription());
                    } catch (NullPointerException npe) {
                        bean.setInterviewstatus("--");
                    }

                    try {
                        bean.setStatus(candiate.getStatus().getDescription());
                    } catch (NullPointerException npe) {
                        bean.setStatus("--");
                    }

                    bean.setFullCount(count);

                    dataList.add(bean);
                }
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
        return dataList;
    }

    private String makeWhereClause(InterviewInputBean inputBean) {
        String where = "1=1";

        if (inputBean.getNic_Search() != null && !inputBean.getNic_Search().isEmpty()) {
            where += " and lower(u.nic) like lower('%" + inputBean.getNic_Search() + "%')";
        }
        if (inputBean.getInterviewstatus() != null && !inputBean.getInterviewstatus().isEmpty()) {
            where += " and lower(u.fullname) like lower('%" + inputBean.getInterviewstatus() + "%')";
        }

        if (inputBean.getStatussearch() != null && !inputBean.getStatussearch().isEmpty()) {
            where += " and u.status.statuscode = '" + inputBean.getStatussearch() + "'";
        }
        return where;
    }
}
