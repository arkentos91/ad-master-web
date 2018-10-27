/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.dao.hrmanagement;

import com.arkentos.bean.hrmanagement.CandidateBean;
import com.arkentos.bean.hrmanagement.CandidateInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.util.common.Common;
import com.arkentos.util.common.HibernateInit;
import com.arkentos.util.mapping.Hrcandidate;
import com.arkentos.util.mapping.Status;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Systemuser;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.MessageVarList;
import com.arkentos.util.varlist.SessionVarlist;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
public class CandidateDAO {

    public String insert_data(CandidateInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            if ((Hrcandidate) session.get(Hrcandidate.class, inputBean.getNic().trim()) == null) {
                txn = session.beginTransaction();
                Hrcandidate a = new Hrcandidate();

                a.setNic(inputBean.getNic().trim());
                a.setFullname(inputBean.getFullname());
                a.setPosition(inputBean.getPosition());
                a.setMobile(inputBean.getMobile());
                a.setEmail(inputBean.getEmail());
                a.setAddress(inputBean.getAddress());

                Status st = new Status();
                st.setStatuscode(CommonVarList.STATUS_SHORTLIST);
                a.setStatus(st);

                a.setRemarks(inputBean.getRemarks());
                
                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

                System.out.println(inputBean.getInterviewdate());
                a.setInterviewdate(Common.StringDateTimeToDate(inputBean.getInterviewdate()));
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

    public String update_data(CandidateInputBean inputBean, Systemaudit audit) throws Exception {

        Session session = null;
        Transaction txn = null;
        String message = "";

        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Hrcandidate u = (Hrcandidate) session.get(Hrcandidate.class, inputBean.getNic().trim());

            if (u != null) {

                u.setNic(inputBean.getNic().trim());
                u.setFullname(inputBean.getFullname().trim());
                u.setPosition(inputBean.getPosition());
                u.setMobile(inputBean.getMobile());
                u.setEmail(inputBean.getEmail());
                u.setAddress(inputBean.getAddress());

                Status st = new Status();
                st.setStatuscode(inputBean.getStatus());
                u.setStatus(st);

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
    
    public String update_data_status(CandidateInputBean inputBean, Systemaudit audit) throws Exception {

        Session session = null;
        Transaction txn = null;
        String message = "";

        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Hrcandidate u = (Hrcandidate) session.get(Hrcandidate.class, inputBean.getNic().trim());

            if (u != null) {

                Status st = new Status();
                st.setStatuscode(inputBean.getStatus());
                u.setStatus(st);

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

    public String delete_data(CandidateInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Hrcandidate d = (Hrcandidate) session.get(Hrcandidate.class, inputBean.getNic().trim());
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

    public Hrcandidate find_data_ById(String nic) throws Exception {
        Hrcandidate candiate = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();

            String sql = "from Hrcandidate as u where u.nic=:nic";
            Query query = session.createQuery(sql).setString("nic", nic);
            candiate = (Hrcandidate) query.list().get(0);

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

    public List<CandidateBean> getSearchList(CandidateInputBean inputBean, int max, int first, String orderBy) throws Exception {

        List<CandidateBean> dataList = new ArrayList<CandidateBean>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
           

            long count = 0;
            String where = this.makeWhereClause(inputBean);

            String sqlCount = "select count(nic) from Hrcandidate as u where " + where;
            Query queryCount = session.createQuery(sqlCount);
            Iterator itCount = queryCount.iterate();
            count = (Long) itCount.next();

            if (count > 0) {

                String sqlSearch = "from Hrcandidate u where u.status!=:statuscode and " + where + " " + orderBy;
                Query querySearch = session.createQuery(sqlSearch).setString("statuscode", CommonVarList.STATUS_DELETE);
                querySearch.setMaxResults(max);
                querySearch.setFirstResult(first);

                Iterator it = querySearch.iterate();

                while (it.hasNext()) {

                    CandidateBean bean = new CandidateBean();
                    Hrcandidate candiate = (Hrcandidate) it.next();

                    try {
                        bean.setNic(candiate.getNic());
                    } catch (NullPointerException npe) {
                        bean.setNic("--");
                    }
                    try {
                        bean.setFullname(candiate.getFullname());
                    } catch (NullPointerException npe) {
                        bean.setFullname("--");
                    }
                    try {
                        bean.setStatus(candiate.getStatus().getDescription());
                    } catch (NullPointerException npe) {
                        bean.setStatus("--");
                    }
                    try {
                        bean.setMobile(candiate.getMobile());
                    } catch (NullPointerException npe) {
                        bean.setMobile("--");
                    }
                    try {
                        bean.setEmail(candiate.getEmail());
                    } catch (NullPointerException npe) {
                        bean.setEmail("--");
                    }

                    try {
                        bean.setPosition(getJobPositionLDescription(candiate.getPosition()));
                    } catch (NullPointerException npe) {
                        bean.setPosition("--");
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

    private String makeWhereClause(CandidateInputBean inputBean) {
        String where = "1=1";

        if (inputBean.getNic_Search() != null && !inputBean.getNic_Search().isEmpty()) {
            where += " and lower(u.nic) like lower('%" + inputBean.getNic_Search() + "%')";
        }
        if (inputBean.getFullname_Search() != null && !inputBean.getFullname_Search().isEmpty()) {
            where += " and lower(u.fullname) like lower('%" + inputBean.getFullname_Search() + "%')";
        }

        if (inputBean.getStatussearch() != null && !inputBean.getStatussearch().isEmpty()) {
            where += " and u.status.statuscode = '" + inputBean.getStatussearch() + "'";
        }
        return where;
    }

    private static String getJobPositionLDescription(String key) {

        HashMap<String, String> userLevel = new HashMap<String, String>();
        userLevel.put("SALES", "Sales Representative");
        userLevel.put("SALEJ", "Junior Sales Representative");
        userLevel.put("HUMRE", "HR Representative");
        userLevel.put("RECEP", "Secretory/Receptionist");
        userLevel.put("SUPPL", "Purchasing/Supplier Representative");
        userLevel.put("CUSTO", "Customer Service Representative");
        userLevel.put("WAREH", "Warehouse Foreman");
        userLevel.put("WSTAF", "Warehouse Staff");
        userLevel.put("ACCOU", "Accountant");

        return userLevel.get(key);
    }
}
