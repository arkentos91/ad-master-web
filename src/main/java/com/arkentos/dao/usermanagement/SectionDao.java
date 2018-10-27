package com.arkentos.dao.usermanagement;

import com.arkentos.bean.usermanagement.SectionBean;
import com.arkentos.bean.usermanagement.SectionInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.util.common.HibernateInit;
import com.arkentos.util.mapping.Section;
import com.arkentos.util.mapping.Status;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Userrolesection;
import com.arkentos.util.mapping.Sectionpage;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.MessageVarList;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author jayana_i
 */
public class SectionDao {

    public List<SectionBean> getSearchList(SectionInputBean inputBean, int max, int first, String orderBy) throws Exception {
        List<SectionBean> dataList = new ArrayList<SectionBean>();

        Session session = null;

        try {

            if (orderBy.equals("") || orderBy == null) {
                orderBy = "";
            }
            String where = this.makeWhereClause(inputBean);
            long count = 0;

            session = HibernateInit.sessionFactory.openSession();

            String sqlCount = "select count(sectioncode) from Section as u where " + where;
            System.out.println("-------"+sqlCount);
            Query queryCount = session.createQuery(sqlCount);

            Iterator itCount = queryCount.iterate();
            count = (Long) itCount.next();

            if (count > 0) {
                String sqlSearch = "from Section u where u.status!=:statuscode and " +where+" "+ orderBy;
                Query querySearch = session.createQuery(sqlSearch).setString("statuscode", CommonVarList.STATUS_DELETE);
                querySearch.setMaxResults(max);
                querySearch.setFirstResult(first);

                Iterator it = querySearch.iterate();
                while (it.hasNext()) {
                    SectionBean sdblSection = new SectionBean();
                    Section section = (Section) it.next();

                    try {
                        sdblSection.setSectioncode(section.getSectioncode());
                    } catch (NullPointerException e) {
                        sdblSection.setSectioncode("--");
                    }

                    try {
                        sdblSection.setDescription(section.getDescription());
                    } catch (NullPointerException e) {
                        sdblSection.setDescription("--");
                    }

                    try {
                        sdblSection.setStatuscode(section.getStatus().getDescription());
                    } catch (NullPointerException e) {
                        sdblSection.setStatuscode("--");
                    }

                    try {
                        sdblSection.setSortkey(section.getSortkey().toString());
                    } catch (Exception e) {
                        sdblSection.setSortkey("--");
                    }

                    sdblSection.setFullCount(count);

                    dataList.add(sdblSection);
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

    public String insertSection(SectionInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";

        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            if ((Section) session.get(Section.class, inputBean.getSectionCode().trim()) == null) {
                txn = session.beginTransaction();

                Section section = new Section();
                section.setSectioncode(inputBean.getSectionCode().trim());
                section.setDescription(inputBean.getDescription().trim());
                section.setSortkey(new Byte(inputBean.getSortKey().trim()));
//
                Status st = new Status();
                st.setStatuscode(inputBean.getStatus());
                section.setStatus(st);

//                section.setCreatetime(sysDate);
//                section.setLastupdatedtime(sysDate);
//                section.setUser(audit.getUser());
                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

                session.save(audit);
                session.save(section);

                txn.commit();

            } else {

                long count = 0;

                String sqlCount = "select count(sectioncode) from Section as u where u.status=:statuscode AND u.sectioncode=:sectioncode ";
                Query queryCount = session.createQuery(sqlCount).setString("statuscode", CommonVarList.STATUS_DELETE)
                        .setString("sectioncode", inputBean.getSectionCode().trim());

                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();

                if (count > 0) {
                    message = "$" + inputBean.getSectionCode().trim();
                } else {
                    message = MessageVarList.COMMON_ALREADY_EXISTS;
                }

//                message = MessageVarList.COMMON_ALREADY_EXISTS;
//                Section u = (Section) session.get(Section.class, inputBean.getSectionCode().trim());
//                txn = session.beginTransaction();
//                u.setDescription(inputBean.getDescription());
//                u.setSortkey(new Integer(inputBean.getSortKey()));
//
//                Status st = new Status();
//                st.setStatuscode(CommonVarList.STATUS_ACTIVE);                
//                u.setStatus(st);
//                
//                u.setUser(audit.getUser());
//                u.setLastupdatedtime(sysDate);
//
//                audit.setCreatedtime(sysDate);
//                audit.setLastupdatedtime(sysDate);
//
//                session.save(audit);
//                session.update(u);
//                
//                txn.commit();
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
            } catch (HibernateException e) {
                throw e;
            }
        }
        return message;
    }

    //start newly changed
    public String activateSection(SectionInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();

            Date sysDate = CommonDAO.getSystemDate(session);

            Section u = (Section) session.get(Section.class, inputBean.getSectionCode().trim());
            if (u != null) {

                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

                u.setDescription(inputBean.getDescription().trim());
                u.setSortkey(new Byte(inputBean.getSortKey().trim()));

                //Change status to 'Activate'
                Status status = new Status();
                status.setStatuscode(CommonVarList.STATUS_ACTIVE);
                u.setStatus(status);

//                u.setUser(audit.getUser());
//                u.setLastupdatedtime(sysDate);
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

    //end newly changed
    public Section findSectionById(String sectionCode) throws Exception {
        Section section = null;
        Session session = null;

        try {

            session = HibernateInit.sessionFactory.openSession();

            String sql = "from Section as u where u.sectioncode=:sectioncode";
            Query query = session.createQuery(sql).setString("sectioncode", sectionCode);
            section = (Section) query.list().get(0);

        } catch (Exception e) {
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (HibernateException e) {
                throw e;
            }
        }
        return section;
    }

    public String deleteSection(SectionInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Section u = (Section) session.get(Section.class, inputBean.getSectionCode().trim());

            if (u != null) {

                long count = 0;
                long count2 = 0;

                String sqlCount = "select count(sectioncode) from Userrolesection as u where u.section.sectioncode=:sectioncode ";
                Query queryCount = session.createQuery(sqlCount).setString("sectioncode", inputBean.getSectionCode().trim());

                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();

                if (count > 0) {
                    message = MessageVarList.COMMON_NOT_DELETE;
                } else {
                    String sqlCount2 = "select count(sectioncode) from Sectionpage as u where u.section.sectioncode=:sectioncode ";
                    Query queryCount2 = session.createQuery(sqlCount2).setString("sectioncode", inputBean.getSectionCode().trim());

                    Iterator itCount2 = queryCount2.iterate();
                    count2 = (Long) itCount2.next();
                    if (count2 > 0) {
                        message = MessageVarList.COMMON_NOT_DELETE;
                    } else {
                        audit.setCreatetime(sysDate);
                        audit.setLastupdatedtime(sysDate);

                        session.save(audit);
                        session.delete(u);
                        txn.commit();
                    }
                }

//                String sql = "from Userrolesection as u where u.section.sectioncode=:sectioncode";
//                Query query = session.createQuery(sql).setString("sectioncode", inputBean.getSectionCode());
//                Userrolesection urs = (Userrolesection) query.list().get(0);
//                String sql2 = "from Usersectionpage as u where u.section.sectioncode=:sectioncode";
//                Query query2 = session.createQuery(sql2).setString("sectioncode", inputBean.getSectionCode());
//                Usersectionpage usp = (Usersectionpage) query2.list().get(0);
                //Change status to 'Delete'
//                Status status = new Status();
//                status.setStatuscode(CommonVarList.STATUS_DELETE);
//                u.setStatus(status);
//
//                u.setUser(audit.getUser());
//                u.setLastupdatedtime(sysDate);
//                session.update(u);
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

//    public String updateSection(SectionInputBean inputBean, Systemaudit audit, String statusVal) throws Exception {
    public String updateSection(SectionInputBean inputBean, Systemaudit audit) throws Exception {

        Session session = null;
        Transaction txn = null;
        String message = "";

        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Section u = (Section) session.get(Section.class, inputBean.getSectionCode().trim());

            if (u != null) {

                u.setDescription(inputBean.getDescription().trim());

                Status st = new Status();
                st.setStatuscode(inputBean.getStatus());
                u.setStatus(st);

//                u.setUser(audit.getUser());
//                u.setLastupdatedtime(sysDate);
                Status newst = (Status) session.get(Status.class, inputBean.getStatus());

                String newV = inputBean.getSectionCode() + "|" + inputBean.getDescription() + "|" + inputBean.getSortKey() + "|" + newst.getDescription();
                audit.setNewvalue(newV);

                Status oldst = (Status) session.get(Status.class, u.getStatus().getStatuscode());

//                String oldv = (u.getSectioncode() + "|" + u.getDescription() + "|" + u.getSortkey() + "|" + oldst.getDescription());
                audit.setOldvalue(inputBean.getOldvalue());
                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);
               
                if (inputBean.getSortKey().equals(u.getSortkey().toString())) {
                    u.setSortkey(new Byte(inputBean.getSortKey().trim()));
                    session.save(audit);
                    session.update(u);
                } else {
                    CommonDAO dao = new CommonDAO();
                    message = dao.getSectionSortKeyCount(inputBean.getSortKey());
                    if (message.isEmpty() && message.equals("")) {
                        u.setSortkey(new Byte(inputBean.getSortKey().trim()));
                        session.save(audit);
                        session.update(u);
                    } else {

                    }
                }

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
    private String makeWhereClause(SectionInputBean inputBean) throws Exception {

        String where = "1=1";

        if ((inputBean.getS_sectioncode() == null || inputBean.getS_sectioncode().isEmpty())
                && (inputBean.getS_description() == null || inputBean.getS_description().isEmpty())
                && (inputBean.getS_sortkey() == null || inputBean.getS_sortkey().isEmpty())
                && (inputBean.getS_status() == null || inputBean.getS_status().isEmpty())) {

        } else {

            if (inputBean.getS_sectioncode() != null && !inputBean.getS_sectioncode().isEmpty()) {
                where += " and lower(u.sectioncode) like lower('%" + inputBean.getS_sectioncode() + "%')";
            }
            if (inputBean.getS_description() != null && !inputBean.getS_description().isEmpty()) {
                where += " and lower(u.description) like lower('%" + inputBean.getS_description() + "%')";
            }
            if (inputBean.getS_sortkey() != null && !inputBean.getS_sortkey().isEmpty()) {
                where += " and u.sortkey like '%" + inputBean.getS_sortkey() + "%'";
            }
            if (inputBean.getS_status() != null && !inputBean.getS_status().isEmpty()) {
                where += " and u.status.statuscode='" + inputBean.getS_status() + "'";
            }
        }

        return where;
    }
}
