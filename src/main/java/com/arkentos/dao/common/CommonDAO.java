/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.dao.common;

import com.arkentos.util.common.HibernateInit;
import com.arkentos.util.mapping.Hrcandidate;
import com.arkentos.util.mapping.Page;
import com.arkentos.util.mapping.ResponseCodes;
import com.arkentos.util.mapping.Section;
import com.arkentos.util.mapping.Status;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Systemuser;
import com.arkentos.util.mapping.Task;
import com.arkentos.util.mapping.Userlevel;
import com.arkentos.util.mapping.Userrole;
import com.arkentos.util.varlist.CommonVarList;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import com.arkentos.util.varlist.MessageVarList;

/**
 *
 * @author jayana_i
 */
public class CommonDAO {

    //get system date from database
    public static Date getSystemDate(Session session) throws Exception {
        Date sysDateTime = null;
        try {

            String sql = "SELECT NOW()";
            Query query = session.createSQLQuery(sql);
            List l = query.list();
            sysDateTime = (Date) l.get(0);
//            sysDateTime = Timestamp.valueOf(stime);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
        }
        return sysDateTime;
    }

    public static Date getSystemDateLogin() throws Exception {
        Date sysDateTime = null;
        Session session = null;
        try {

            session = HibernateInit.sessionFactory.openSession();
            String sql = "SELECT NOW()";
            Query query = session.createSQLQuery(sql);
            List l = query.list();
            sysDateTime = (Date) l.get(0);
//            sysDateTime = Timestamp.valueOf(stime);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return sysDateTime;
    }

    public static String getSystemTime() throws Exception {
        String sysDateTime = null;
        Session session = null;
        try {

            session = HibernateInit.sessionFactory.openSession();
            String sql = "SELECT NOW()";
            Query query = session.createSQLQuery(sql);
            List l = query.list();
            sysDateTime = (String) l.get(0);
//            sysDateTime = Timestamp.valueOf(stime);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return sysDateTime;
    }

    public Page getPageDescription(String pageCode) throws Exception {

        Page pageBean = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Page as s where s.pagecode =:pagecode";
            Query query = session.createQuery(sql).setString("pagecode", pageCode);
            pageBean = (Page) query.list().get(0);

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
        return pageBean;
    }

    public Section getSectionOfPage(String pageCode, String userRole)
            throws Exception {

        Section sectionBean = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "select s.section from Sectionpage as s where s.id.pagecode =:pagecode and s.id.userrolecode=:userrolecode ";
            Query query = session.createQuery(sql)
                    .setString("pagecode", pageCode)
                    .setString("userrolecode", userRole);
            sectionBean = (Section) query.list().get(0);

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
        return sectionBean;
    }

    // get status list
    public List<Status> getDefultStatusList(String statusCode) throws Exception {

        List<Status> statusList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Status as s where s.statuscategory.categorycode=:statuscategorycode order by Upper(s.description) asc";
            Query query = session.createQuery(sql).setString(
                    "statuscategorycode", statusCode);
            statusList = query.list();
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
        return statusList;
    }

    


    public List<Status> getCusWalStatusList(String statusCode)
            throws Exception {

        List<Status> statusList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Status as s where s.statuscategory.categorycode=:statuscategorycode";
            Query query = session.createQuery(sql).setString(
                    "statuscategorycode", statusCode);
            statusList = query.list();

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
        return statusList;
    }


    public List<Userrole> getUserRoleList(String statusCode)
            throws Exception {

        List<Userrole> userroleList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Userrole as s where s.status.statuscode =:statuscode";
            Query query = session.createQuery(sql).setString(
                    "statuscode", statusCode);
            userroleList = query.list();

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
        return userroleList;
    }


    public boolean getBooleanVal(Integer val) {
        if (val == 1) {
            return true;
        } else {
            return false;
        }
    }


    public List<Userrole> getUserRoleList() throws Exception {

        List<Userrole> userroleList = new ArrayList<Userrole>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Userrole";
            Query query = session.createQuery(sql);
            userroleList = query.list();

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
        return userroleList;
    }

    public List<Userlevel> getUserLevelList() throws Exception {
        List<Userlevel> userLevelList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Userlevel as u";
            Query query = session.createQuery(sql);
            userLevelList = query.list();
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
        return userLevelList;
    }

    public List<Systemuser> getUserList() throws Exception {
        // TODO Auto-generated method stub

        List<Systemuser> userRoleList = new ArrayList<Systemuser>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Systemuser u order by u.username asc";
            Query query = session.createQuery(sql);
            userRoleList = query.list();

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
        return userRoleList;
    }

    public List<Section> getSectionList() throws Exception {
        List<Section> sectionList = new ArrayList<Section>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String hql = "from Section s order by s.description asc ";
            Query query = session.createQuery(hql);
            sectionList = query.list();

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

    public String getSectionSortKeyCount(String sortkey) throws Exception {

        String des = "";
//        boolean sortkey_valid;
        long count;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Section as s where s.sortkey =:sortkey";
            Query query = session.createQuery(sql).setString("sortkey", sortkey);
            count = query.list().size();
            if (count == 0) {
                des = "";
            } else {

                des = MessageVarList.SECTION_SORT_KEY_ALREADY_EXISTS;
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
        return des;
    }

    public List<Page> getPageList() throws Exception {
        List<Page> pageList = new ArrayList<Page>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String hql = "from Page p order by p.description asc";
            Query query = session.createQuery(hql);
            pageList = query.list();

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

    public List<Task> getTaskList() throws Exception {
        List<Task> taskList = new ArrayList<Task>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String hql = "from Task t order by t.description asc";
            Query query = session.createQuery(hql);
            taskList = query.list();

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
        return taskList;
    }

    public List<Status> getSmsAlertStatusList(String statusCategory) throws Exception {
        List<Status> statusList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            session.beginTransaction();
            Criteria criteria = session.createCriteria(Status.class);
            criteria.add(Restrictions.eq("statuscategory.categorycode", statusCategory));
            statusList = (List<Status>) criteria.list();

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
        return statusList;
    }

    // use JNDI for connection
    public static Connection getConnection() throws Exception {
        Connection con = null;
        try {
            InitialContext context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup(CommonVarList.JNDI_REPORT_CONNECTION);
            con = dataSource.getConnection();
        } catch (Exception e) {
            throw e;
        }
        return con;
    }

    public String getStatusByprefix(String srefix) throws Exception {
        Status st = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            st = (Status) session.get(Status.class, srefix);
        } catch (Exception he) {
            throw he;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return st.getDescription();
    }
    
    public static String getFullnamebyNIC(String nic) throws Exception {
        Hrcandidate st = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            st = (Hrcandidate) session.get(Hrcandidate.class, nic);
        } catch (Exception he) {
            throw he;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return st.getFullname();
    }

    public String getSectionByprefix(String appprefix) throws Exception {
        Section sec = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            sec = (Section) session.get(Section.class, appprefix);
        } catch (Exception he) {
            throw he;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return sec.getDescription();
    }

    public static String saveAudit(Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            txn = session.beginTransaction();
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



    public String getMaxIdServiceDetails() throws Exception {
        String id;
        long count = 0;
        Session session = null;

        try {
            session = HibernateInit.sessionFactory.openSession();
            String sqlCount = "select count(id) from Servicedetails";
            Query queryCount = session.createQuery(sqlCount);
            Iterator itCount = queryCount.iterate();
            count = (Long) itCount.next();
            if (count > 0) {
                String sqlquery = "select max(id) from Servicedetails";
                Query query = session.createQuery(sqlquery);
                int val = (Integer.parseInt((query.list().get(0)).toString()) + 1);
                id = Integer.toString(val);
            } else {
                id = "1";
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return id;
    }

    public String getMaxIdVsfConfig() throws Exception {
        String id;
        long count = 0;
        Session session = null;

        try {
            session = HibernateInit.sessionFactory.openSession();
            String sqlCount = "select count(id) from Vsfconfigurationprofile";
            Query queryCount = session.createQuery(sqlCount);
            Iterator itCount = queryCount.iterate();
            count = (Long) itCount.next();
            if (count > 0) {
                String sqlquery = "select max(id) from Vsfconfigurationprofile";
                Query query = session.createQuery(sqlquery);
                int val = (Integer.parseInt((query.list().get(0)).toString()) + 1);
                id = Integer.toString(val);
            } else {
                id = "1";
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return id;
    }

    public String setStringYN(Integer num) {
        if (num == 1) {
            return "Yes";
        } else {
            return "No";
        }
    }

    public String getSwitchIP() throws Exception {
        String val = "";
        Session session = null;

        try {
            session = HibernateInit.sessionFactory.openSession();

            String sqlquery = "select PARAM_VALUE from USER_PARAM where PARAM_CODE='SWITCH_IP'";
            Query query = session.createSQLQuery(sqlquery);
            val = (query.list().get(0)).toString();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            val = "";
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return val;
    }
    
    public String getMidfromUsername(String username) throws Exception {
        String val = "";
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sqlquery = "SELECT MID FROM MERCHANT_ORI WHERE USER_NAME IN ( SELECT USERNAME FROM SYSTEMUSER where USERNAME='"+username+"')";
            Query query = session.createSQLQuery(sqlquery);
            val = (query.list().get(0)).toString();
        } catch (Exception e) {
            val = "";
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return val;
    }

    public String getSwitchPort() throws Exception {
        String val = "";
        Session session = null;

        try {
            session = HibernateInit.sessionFactory.openSession();

            String sqlquery = "select PARAM_VALUE from USER_PARAM where PARAM_CODE='SWITCH_PORT'";
            Query query = session.createSQLQuery(sqlquery);
            val = (query.list().get(0)).toString();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            val = "";
            throw e;
        } finally {
            try {
                session.flush();
                session.close();
            } catch (Exception e) {
                throw e;
            }
        }
        return val;
    }

    public String getPageSortKeyCount(String sortkey) throws Exception {

        String des = "";
//        boolean sortkey_valid;
        long count;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Page as s where s.sortkey =:sortkey";
            Query query = session.createQuery(sql).setString("sortkey", sortkey);
            count = query.list().size();
            if (count == 0) {
                des = "";
            } else {

                des = MessageVarList.PAGE_MGT_ERROR_SORT_KEY_ALREADY_EXSITS;
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
        return des;
    }

    public List<Hrcandidate> getCandidateList(String status)  throws Exception {

        List<Hrcandidate> statusList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Hrcandidate as s where s.status=:status order by Upper(s.fullname) asc";
            Query query = session.createQuery(sql).setString(
                    "status", status);
            statusList = query.list();
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
        return statusList;
    }
    
    public List<Hrcandidate> getCandidateList()  throws Exception {

        List<Hrcandidate> statusList = null;
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Hrcandidate as s order by Upper(s.fullname) asc";
            Query query = session.createQuery(sql) ;
            statusList = query.list();
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
        return statusList;
    }
    
    
}
