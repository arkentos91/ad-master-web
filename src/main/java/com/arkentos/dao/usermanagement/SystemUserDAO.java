/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.dao.usermanagement;

import com.arkentos.bean.usermanagement.SystemUserDataBean;
import com.arkentos.bean.usermanagement.SystemUserInputBean;
import com.arkentos.dao.common.CommonDAO;
import com.arkentos.util.common.Common;
import com.arkentos.util.common.HibernateInit;
import com.arkentos.util.mapping.Passwordpolicy;
import com.arkentos.util.mapping.Status;
import com.arkentos.util.mapping.Systemaudit;
import com.arkentos.util.mapping.Systemuser;
import com.arkentos.util.mapping.Userrole;
import com.arkentos.util.varlist.CommonVarList;
import com.arkentos.util.varlist.MessageVarList;
import com.arkentos.util.varlist.SessionVarlist;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author jayana_i
 */
public class SystemUserDAO {
    
    private void makeWhereClause(SystemUserInputBean inputBean,Criteria criteria) {
        String where = "1=1";

        if (inputBean.getUsername() != null && !inputBean.getUsername().trim().isEmpty()) {
//            where += " and lower(u.username) like lower('%" + inputBean.getUsername().trim() + "%')";
            criteria.add(Restrictions.like("username", "%"+inputBean.getUsername().trim()+"%"));
        }
        if (inputBean.getServiceid() != null && !inputBean.getServiceid().trim().isEmpty()) {
//            where += " and lower(u.empid) like lower('%" + inputBean.getServiceid().trim() + "%')";
             criteria.add(Restrictions.like("empid", "%"+inputBean.getServiceid().trim()+"%"));
        }
        if (inputBean.getNic() != null && !inputBean.getNic().trim().isEmpty()) {
//            where += " and lower(u.nic) like lower('%" + inputBean.getNic().trim() + "%')";
             criteria.add(Restrictions.like("nic", "%"+inputBean.getNic().trim()+"%"));
        }
        if (inputBean.getContactno() != null && !inputBean.getContactno().trim().isEmpty()) {
//            where += " and lower(u.mobile) like lower('%" + inputBean.getContactno().trim() + "%')";
            criteria.add(Restrictions.like("mobile", "%"+inputBean.getContactno().trim()+"%"));
        }
        if (inputBean.getEmail() != null && !inputBean.getEmail().trim().isEmpty()) {
//            where += " and lower(u.email) like lower('%" + inputBean.getEmail().trim() + "%')";
            criteria.add(Restrictions.like("email", "%"+inputBean.getEmail().trim()+"%"));
        }
        if (inputBean.getStatus() != null && !inputBean.getStatus().trim().isEmpty()) {
//            where += " and u.status.statuscode = '" + inputBean.getStatus().trim() + "'";
            criteria.add(Restrictions.eq("status.statuscode", inputBean.getStatus().trim()));
        }
        if (inputBean.getUserrole() != null && !inputBean.getUserrole().trim().isEmpty()) {
//            where += " and u.userrole.userrolecode = '" + inputBean.getUserrole().trim() + "'";
            criteria.add(Restrictions.eq("userrole.userrolecode", inputBean.getUserrole().trim()));
        }
//        where += " and u.userrole.userrolecode != '" + "MERCH" + "'";
//        where += " and u.userrole.userrolecode != '" + "MERCUS" + "'";

        if (inputBean.getFullname() != null && !inputBean.getFullname().trim().isEmpty()) {
//            where += " and lower(u.fullname) like lower('%" + inputBean.getFullname().trim() + "%')";
            criteria.add(Restrictions.like("fullname", "%"+inputBean.getFullname().trim()+"%"));
        }
//        if (inputBean.getExpirydate()!= null && !inputBean.getExpirydate().trim().isEmpty()) {
//            where += " and lower(u.expirydate) like lower('%" + inputBean.getExpirydate().trim() + "%')";
//        }

//        return where;
    }
    public List<SystemUserDataBean> getSearchList(SystemUserInputBean inputBean, int rows, int from, String sortIndex, String sortOrder) throws Exception {
        List<Systemuser> searchList = null;
        List<SystemUserDataBean> dataBeanList = null;
        Session session = null;
        HttpSession hSession = ServletActionContext.getRequest().getSession(false);
        Systemuser sysUser = ((Systemuser) hSession.getAttribute(SessionVarlist.SYSTEMUSER));
        long fullCount = 0;
        //String where = this.makeWhereClause(inputBean);
        if ("".equals(sortIndex.trim())) {
            sortIndex = null;
        }
        try {
            session = HibernateInit.sessionFactory.openSession();
            session.beginTransaction();
            Criteria criteria = session.createCriteria(Systemuser.class);
            criteria.createAlias("userrole", "userrole");
            criteria.createAlias("status", "status");
            criteria.add(Restrictions.ne("userrole.userrolecode", "MERC")); 
            
            this.makeWhereClause(inputBean,criteria);
            if (sortIndex != null && sortOrder != null) {
                if (sortOrder.equals("asc")) {
                    criteria.addOrder(Order.asc(sortIndex));
                }
                if (sortOrder.equals("desc")) {
                    criteria.addOrder(Order.desc(sortIndex));
                }
            } else {
                criteria.addOrder(Order.desc("createtime"));
            }

            criteria.add(Restrictions.ne("status.statuscode", CommonVarList.STATUS_DELETE));
            criteria.add(Restrictions.ne("username", sysUser.getUsername()));

            fullCount = criteria.list().size();

            criteria.setFirstResult(from);
            criteria.setMaxResults(rows);

            searchList = criteria.list();
            dataBeanList = new ArrayList<SystemUserDataBean>();

            for (Systemuser user : searchList) {

                SystemUserDataBean systemUser = new SystemUserDataBean();

                try {
                    systemUser.setUsername(user.getUsername());
                } catch (NullPointerException npe) {
                    systemUser.setUsername("--");
                }
                try {
                    systemUser.setUserrole(user.getUserrole().getDescription());
                } catch (NullPointerException npe) {
                    systemUser.setUserrole("--");
                }
                try {
                    systemUser.setStatus(user.getStatus().getDescription());
                } catch (NullPointerException npe) {
                    systemUser.setStatus("--");
                }
                try {
                    systemUser.setUsernameUserrole(user.getUsername() + "|" + user.getUserrole().getDescription());
                } catch (NullPointerException npe) {
                    systemUser.setUsernameUserrole("--");
                }

                    try {
                        systemUser.setNic(user.getNic().toString());
                    } catch (NullPointerException e) {
                        systemUser.setNic("--");
                    }

                    try {
                        systemUser.setContactNo(user.getMobile().toString());
                    } catch (NullPointerException e) {
                        systemUser.setContactNo("--");
                    }
                    try {
                        systemUser.setFullname(user.getFullname().toString());
                    } catch (NullPointerException e) {
                        systemUser.setFullname("--");
                    }

                    try {
                        systemUser.setEmail(user.getEmail().toString());
                    } catch (NullPointerException e) {
                        systemUser.setEmail("--");
                    }
                    try {
                        systemUser.setServiceId(user.getEmpid().toString());
                    } catch (NullPointerException e) {
                        systemUser.setServiceId("--");
                    }
                    try {
                        if (user.getCreatetime().toString() != null && !user.getCreatetime().toString().isEmpty()) {
                            systemUser.setCreatetime(user.getCreatetime().toString().substring(0, 19));
                        } else {
                            systemUser.setCreatetime("--");
                        }
                    } catch (NullPointerException e) {
                        systemUser.setCreatetime("--");
                    }

                systemUser.setFullCount(fullCount);

                dataBeanList.add(systemUser);
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

        return dataBeanList;
    }

    //start newly changed
    public String activateUser(SystemUserInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();

            Date sysDate = CommonDAO.getSystemDate(session);

//            User u = (User) session.get(User.class, inputBean.getUsername().trim());
            Systemuser u = this.getSystemUserByUserName2(inputBean.getUsername(), session);
            if (u != null) {

                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                //modified (3/7/2014)
//                u.setPasswordexpirydate(formatter.parse(inputBean.getExpirydate()));

                Userrole ur = new Userrole();
                ur.setUserrolecode(inputBean.getUserrole());
                u.setUserrole(ur);

//                Systemuser dualAuthUSer = new Systemuser();
//                dualAuthUSer.setUsername(inputBean.getDualauthuser());
                u.setDualauthuserrole(inputBean.getDualauthuser());

                //Change status to 'Activate'
                Status status = new Status();
                status.setStatuscode(CommonVarList.STATUS_ACTIVE);
                u.setStatus(status);

                u.setNoofinvlidattempt("0");

                //if 'Active', change noofinvalidattempt to 0
                if ((inputBean.getStatus()).equals(CommonVarList.STATUS_ACTIVE)) {
//                u.setNoofinvlidattempt(0);
                }

                u.setFullname(inputBean.getFullname());
                u.setEmpid(inputBean.getServiceid());
                u.setAddress(inputBean.getAddress1());
//                u.setAddress2(inputBean.getAddress2());
//                u.setCity(inputBean.getCity());
                u.setMobile(inputBean.getContactno());
                u.setEmail(inputBean.getEmail());
//                u.setNic(inputBean.getNic());
//                u.setDateofbirth(formatter.parse(inputBean.getDateofbirth()));

                u.setLastupdatedtime(sysDate);

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
    public String insertSystemUser(SystemUserInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        Calendar cal = Calendar.getInstance();
        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            if (!isSystemUserExist(inputBean.getUsername())) {
                txn = session.beginTransaction();

                Systemuser user = new Systemuser();
                user.setUsername(inputBean.getUsername());
                if (inputBean.getPassword()!= null && !inputBean.getPassword().isEmpty()) {
                  user.setPassword(Common.mpiMd5(inputBean.getPassword()));
                }
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
                Userrole ur = (Userrole) session.get(Userrole.class, inputBean.getUserrole());
                user.setUserrole(ur);
                user.setDualauthuserrole("admin");
//                Status st = (Status) session.get(Status.class, CommonVarList.STATUS_ACTIVE);
                Status st = (Status) session.get(Status.class, inputBean.getStatus());
                user.setStatus(st);
                user.setFullname(inputBean.getFullname());
                user.setEmpid(inputBean.getServiceid());
                user.setAddress(inputBean.getAddress1());
                user.setCity(inputBean.getCity());
                user.setMobile(inputBean.getContactno());
                user.setEmail(inputBean.getEmail());
                user.setNic(inputBean.getNic());
                if (!inputBean.getDateofbirth().isEmpty()) {
                    user.setDateofbirth(formatter2.parse(inputBean.getDateofbirth()));
                }
                user.setNoofinvlidattempt("0");//edited
                String serid_audit = "";
                String add1_audit = "";
                String city_audit = "";

                if (user.getEmpid() == null || user.getEmpid().isEmpty()) {
                    serid_audit = "--";
                } else {
                    serid_audit = user.getEmpid();
                }
                if (user.getAddress() == null || user.getAddress().isEmpty()) {
                    add1_audit = "--";
                } else {
                    add1_audit = user.getAddress();
                }
                if (user.getCity() == null || user.getCity().isEmpty()) {
                    city_audit = "--";
                } else {
                    city_audit = user.getCity();
                }

                String newValue = (inputBean.getUsername())
                        + "|" + serid_audit
                        + "|" + (inputBean.getNic())
                        + "|" + add1_audit
                        + "|" + (user.getUserrole().getDescription())
                        + "|" + city_audit
                        + "|admin|"
                        + (user.getStatus().getDescription())
                        + "|" + (inputBean.getFullname())
                        + "|" + (inputBean.getContactno())
                        + "|" + (inputBean.getEmail())
//                        + "|" + (inputBean.getExpirydate())
                        + "|" + (inputBean.getDateofbirth());

                audit.setNewvalue(newValue);
                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

//                Systemuser lastUpdatedUser = new Systemuser();
//                lastUpdatedUser.setUsername(audit.getLastupdateduser().getUsername());
                user.setLastupdateduser(audit.getLastupdateduser());

                user.setLastupdatedtime(sysDate);
                user.setLoggeddate(sysDate);
                user.setInitialloginstatus("0");
                user.setCreatetime(sysDate);
//                user.setExpirydate(formatter.parse(inputBean.getExpirydate()));
                session.save(audit);
                session.save(user);

                txn.commit();
            } else {

                long count = 0;

                String sqlCount = "select count(username) from Systemuser as u where u.status.statuscode=:statuscode AND u.username=:username";
                Query queryCount = session.createQuery(sqlCount).setString("statuscode", CommonVarList.STATUS_DELETE)
                        .setString("username", inputBean.getUsername().trim());

                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();

                if (count > 0) {
                    message = "$" + inputBean.getUsername().trim();
                } else {
                    message = MessageVarList.COMMON_ALREADY_EXISTS;
                }
//                message = MessageVarList.COMMON_ALREADY_EXISTS;
//                txn = session.beginTransaction();
//
//                User user = this.getSystemUserByUserName2(inputBean.getUsername(), session);
//
//                user.setPassword(Common.mpiMd5(inputBean.getPassword()));
//                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
//                user.setPasswordexpirydate(formatter.parse(inputBean.getExpirydate()));
//
//                Userrole ur = new Userrole();
//                ur.setUserrole(inputBean.getUserrole());
//                user.setUserrole(ur);
//
//                User dualAuthUSer = new User();
//                dualAuthUSer.setUsername(inputBean.getDualauthuser());
//                user.setUserByDualauthuser(dualAuthUSer);
//
//                Status st = new Status();
//                st.setStatuscode(CommonVarList.STATUS_ACTIVE);
//                user.setStatus(st);
//
//                //Status is 'Active', change noofinvalidattempt to 0
//                user.setNoofinvlidattempt(0);
//
//
//                user.setFullname(inputBean.getFullname());
//                user.setServiceid(inputBean.getServiceid());
//                user.setAddress1(inputBean.getAddress1());
//                user.setAddress2(inputBean.getAddress2());
//                user.setCity(inputBean.getCity());
//                user.setContactnumber(inputBean.getContactno());
//                user.setEmailaddress(inputBean.getEmail());
//                user.setNic(inputBean.getNic());
//                user.setDateofbirth(formatter.parse(inputBean.getDateofbirth()));
//
//                audit.setCreatedtime(sysDate);
//                audit.setLastupdatedtime(sysDate);
//
//                User lastUpdatedUser = new User();
//                lastUpdatedUser.setUsername(audit.getUser().getUsername());
//                user.setUserByLastupdateduser(lastUpdatedUser);
//
//                user.setLastupdatedtime(sysDate);
//                session.save(audit);
//                session.update(user);
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
            } catch (Exception e) {
                throw e;
            }
        }
        return message;
    }

    public String insertNewEmplyee(SystemUserInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        Calendar cal = Calendar.getInstance();
        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            if (!isSystemUserExist(inputBean.getUsername())) {
                txn = session.beginTransaction();

                Systemuser user = new Systemuser();
                user.setUsername(inputBean.getUsername());
                if (inputBean.getPassword()!= null && !inputBean.getPassword().isEmpty()) {
                  user.setPassword(Common.mpiMd5(inputBean.getPassword()));
                }
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
                Userrole ur = (Userrole) session.get(Userrole.class, inputBean.getUserrole());
                user.setUserrole(ur);
                user.setDualauthuserrole("admin");
//                Status st = (Status) session.get(Status.class, CommonVarList.STATUS_ACTIVE);
                Status st = (Status) session.get(Status.class, inputBean.getStatus());
                user.setStatus(st);
                user.setFullname(inputBean.getFullname());
                
                user.setMobile(inputBean.getContactno());
                user.setEmail(inputBean.getEmail());
                user.setNic(inputBean.getNic());
 
                user.setNoofinvlidattempt("0");//edited
                String serid_audit = "";
                String add1_audit = "";
                String city_audit = "";

                if (user.getEmpid() == null || user.getEmpid().isEmpty()) {
                    serid_audit = "--";
                } else {
                    serid_audit = user.getEmpid();
                }
                if (user.getAddress() == null || user.getAddress().isEmpty()) {
                    add1_audit = "--";
                } else {
                    add1_audit = user.getAddress();
                }
                if (user.getCity() == null || user.getCity().isEmpty()) {
                    city_audit = "--";
                } else {
                    city_audit = user.getCity();
                }

                String newValue = (inputBean.getUsername())
                        + "|" + serid_audit
                        + "|" + (inputBean.getNic())
                        + "|" + add1_audit
                        + "|" + (user.getUserrole().getDescription())
                        + "|" + city_audit
                        + "|admin|"
                        + (user.getStatus().getDescription())
                        + "|" + (inputBean.getFullname())
                        + "|" + (inputBean.getContactno())
                        + "|" + (inputBean.getEmail())
//                        + "|" + (inputBean.getExpirydate())
                        + "|" + (inputBean.getDateofbirth());

                audit.setNewvalue(newValue);
                audit.setCreatetime(sysDate);
                audit.setLastupdatedtime(sysDate);

//                Systemuser lastUpdatedUser = new Systemuser();
//                lastUpdatedUser.setUsername(audit.getLastupdateduser().getUsername());
                user.setLastupdateduser(audit.getLastupdateduser());

                user.setLastupdatedtime(sysDate);
                user.setLoggeddate(sysDate);
                user.setInitialloginstatus("0");
                user.setCreatetime(sysDate);
//                user.setExpirydate(formatter.parse(inputBean.getExpirydate()));
                session.save(audit);
                session.save(user);

                txn.commit();
            } else {

                long count = 0;

                String sqlCount = "select count(username) from Systemuser as u where u.status.statuscode=:statuscode AND u.username=:username";
                Query queryCount = session.createQuery(sqlCount).setString("statuscode", CommonVarList.STATUS_DELETE)
                        .setString("username", inputBean.getUsername().trim());

                Iterator itCount = queryCount.iterate();
                count = (Long) itCount.next();

                if (count > 0) {
                    message = "$" + inputBean.getUsername().trim();
                } else {
                    message = MessageVarList.COMMON_ALREADY_EXISTS;
                }
//                message = MessageVarList.COMMON_ALREADY_EXISTS;
//                txn = session.beginTransaction();
//
//                User user = this.getSystemUserByUserName2(inputBean.getUsername(), session);
//
//                user.setPassword(Common.mpiMd5(inputBean.getPassword()));
//                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
//                user.setPasswordexpirydate(formatter.parse(inputBean.getExpirydate()));
//
//                Userrole ur = new Userrole();
//                ur.setUserrole(inputBean.getUserrole());
//                user.setUserrole(ur);
//
//                User dualAuthUSer = new User();
//                dualAuthUSer.setUsername(inputBean.getDualauthuser());
//                user.setUserByDualauthuser(dualAuthUSer);
//
//                Status st = new Status();
//                st.setStatuscode(CommonVarList.STATUS_ACTIVE);
//                user.setStatus(st);
//
//                //Status is 'Active', change noofinvalidattempt to 0
//                user.setNoofinvlidattempt(0);
//
//
//                user.setFullname(inputBean.getFullname());
//                user.setServiceid(inputBean.getServiceid());
//                user.setAddress1(inputBean.getAddress1());
//                user.setAddress2(inputBean.getAddress2());
//                user.setCity(inputBean.getCity());
//                user.setContactnumber(inputBean.getContactno());
//                user.setEmailaddress(inputBean.getEmail());
//                user.setNic(inputBean.getNic());
//                user.setDateofbirth(formatter.parse(inputBean.getDateofbirth()));
//
//                audit.setCreatedtime(sysDate);
//                audit.setLastupdatedtime(sysDate);
//
//                User lastUpdatedUser = new User();
//                lastUpdatedUser.setUsername(audit.getUser().getUsername());
//                user.setUserByLastupdateduser(lastUpdatedUser);
//
//                user.setLastupdatedtime(sysDate);
//                session.save(audit);
//                session.update(user);
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
            } catch (Exception e) {
                throw e;
            }
        }
        return message;
    }

    
//    public Passwordpolicy getPasswordPolicyDetails() throws Exception {
//        Passwordpolicy passwordpolicy = null;
//        Session session = null;
//        try {
//            session = HibernateInit.sessionFactory.openSession();
//            session.beginTransaction();
//            Criteria criteria = session.createCriteria(Passwordpolicy.class);
//            passwordpolicy = (Passwordpolicy) criteria.list().get(0);
//
//        } catch (Exception e) {
//            throw e;
//        } finally {
//            try {
//                session.flush();
//                session.close();
//            } catch (Exception e) {
//                throw e;
//            }
//        }
//        return passwordpolicy;
//    }
    private boolean isSystemUserExist(String username) throws Exception {
        List<Systemuser> userList = new ArrayList<Systemuser>();
        Session session = null;
        boolean userCheckStatus = false;
        try {
            session = HibernateInit.sessionFactory.openSession();
            session.beginTransaction();
            Criteria criteria = session.createCriteria(Systemuser.class);
            criteria.add(Restrictions.eq("username", username));
            userList = (List<Systemuser>) criteria.list();

            for (Systemuser user : userList) {
                userCheckStatus = true;
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
        return userCheckStatus;
    }

    public Systemuser getSystemUserByUserName(String username) throws Exception {
        Systemuser user = null;
        Session session = null;
        try {

            session = HibernateInit.sessionFactory.openSession();
            String sql = "from Systemuser as su where su.username=:username";

            Query query = session.createQuery(sql);
            query.setString("username", username);

            user = (Systemuser) query.list().get(0);

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
        return user;
    }

    public Systemuser getSystemUserByUserName2(String username, Session session) throws Exception {//call via update method
        Systemuser user = null;
        try {

            String sql = "from Systemuser as su where su.username=:username";

            Query query = session.createQuery(sql);
            query.setString("username", username);

            user = (Systemuser) query.list().get(0);

        } catch (Exception e) {
            throw e;
        } finally {
            try {
            } catch (Exception e) {
                throw e;
            }
        }
        return user;
    }

//    public void findUsersByUserRole(SystemUserInputBean inputBean, int currUserLevel) throws Exception {
    public void findUsersByUserRole(SystemUserInputBean inputBean, long currUserLevel) throws Exception {
        List<Systemuser> userList = new ArrayList<Systemuser>();
        Session session = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            session.beginTransaction();
            Criteria criteria = session.createCriteria(Systemuser.class);
            criteria.createAlias("userrole", "ur")
                    .createAlias("ur.userlevel", "ul");
            criteria.add(Restrictions.le("ul.levelid", currUserLevel));
            userList = (List<Systemuser>) criteria.list();

            for (Systemuser user : userList) {
                inputBean.getDualAuthUserMap().put(user.getUsername(), user.getUsername());
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

//    public int getCurrUsersUserLevel(String userrole) throws Exception {
    public long getCurrUsersUserLevel(String userrole) throws Exception {
        Session session = null;
        Userrole userRole = null;
//        int userLevel = 8;
        long userLevel = 8;
        try {
            session = HibernateInit.sessionFactory.openSession();
            session.beginTransaction();
            Criteria criteria = session.createCriteria(Userrole.class);
            criteria.add(Restrictions.eq("userrolecode", userrole));
            userRole = (Userrole) criteria.list().get(0);
            userLevel = userRole.getUserlevel().getLevelid();

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
        return userLevel;
    }

    public String updateSystemUser(SystemUserInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        Systemuser user = null;
        try {
            session = HibernateInit.sessionFactory.openSession();
            Date sysDate = CommonDAO.getSystemDate(session);

            txn = session.beginTransaction();

            user = this.getSystemUserByUserName2(inputBean.getUsername(), session);

            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");

            String serid_audit = "";
            String nic_audit = "";
            String add1_audit = "";
            String city_audit = "";
            String dob_audit = "";
            String mobile_audit = "";
            String email_audit = "";
            String fullname_audit = "";
            String expiry_audit = "";

            if (user.getEmpid() == null || user.getEmpid().isEmpty()) {
                serid_audit = "--";
            } else {
                serid_audit = user.getEmpid();
            }
            if (user.getNic()== null || user.getNic().isEmpty()) {
                nic_audit = "--";
            } else {
                nic_audit = user.getNic();
            }
            if (user.getAddress() == null || user.getAddress().isEmpty()) {
                add1_audit = "--";
            } else {
                add1_audit = user.getAddress();
            }
            if (user.getCity() == null || user.getCity().isEmpty()) {
                city_audit = "--";
            } else {
                city_audit = user.getCity();
            }
            if (user.getDateofbirth()== null || user.getDateofbirth().toString().isEmpty()) {
                dob_audit = "--";
            } else {
                dob_audit = user.getDateofbirth().toString();
            }
            if (user.getMobile()== null || user.getMobile().isEmpty()) {
                mobile_audit = "--";
            } else {
                mobile_audit = user.getMobile();
            }
            if (user.getEmail()== null || user.getEmail().isEmpty()) {
                email_audit = "--";
            } else {
                email_audit = user.getEmail();
            }
            if (user.getFullname()== null || user.getFullname().isEmpty()) {
                fullname_audit = "--";
            } else {
                fullname_audit = user.getFullname();
            }
//            if (user.getExpirydate()== null || user.getExpirydate().toString().isEmpty()) {
//                expiry_audit = "--";
//            } else {
//                expiry_audit = user.getExpirydate().toString();
//            }

            String oldValue = user.getUsername()
                    + "|" + serid_audit
                    + "|" + nic_audit
                    + "|" + add1_audit
                    + "|" + user.getUserrole().getDescription()
                    + "|admin|"
                    + "|" + city_audit
                    + "|" + dob_audit
                    + "|" + mobile_audit
                    + user.getStatus().getDescription()
                    + "|" + email_audit
                    + "|" + fullname_audit;
//                    + "|" + expiry_audit;

            user.setDualauthuserrole(inputBean.getDualauthuser());

            user.setDualauthuserrole("admin");
            Userrole ur = (Userrole) session.get(Userrole.class, inputBean.getUserrole());
            user.setUserrole(ur);

            Status st = (Status) session.get(Status.class, inputBean.getStatus());
            user.setStatus(st);

            if ((inputBean.getStatus()).equals(CommonVarList.STATUS_ACTIVE)) {
                user.setNoofinvlidattempt("0");
                user.setLoggeddate(sysDate);
            }

            user.setFullname(inputBean.getFullname().trim());
            user.setEmpid(inputBean.getServiceid().trim());
            user.setAddress(inputBean.getAddress1().trim());
            user.setCity(inputBean.getCity().trim());
            user.setMobile(inputBean.getContactno().trim());
            user.setEmail(inputBean.getEmail().trim());
            user.setNic(inputBean.getNic().trim());
            if (!inputBean.getDateofbirth().isEmpty()) {
                user.setDateofbirth(formatter2.parse(inputBean.getDateofbirth()));
            }

            audit.setCreatetime(sysDate);
            audit.setLastupdatedtime(sysDate);

            Systemuser lastUpdatedUser = new Systemuser();
            lastUpdatedUser.setUsername(audit.getLastupdateduser());
            user.setLastupdateduser(audit.getLastupdateduser());

            user.setLastupdatedtime(sysDate);

            if (user.getEmpid() == null || user.getEmpid().isEmpty()) {
                serid_audit = "--";
            } else {
                serid_audit = user.getEmpid();
            }
            if (user.getNic()== null || user.getNic().isEmpty()) {
                nic_audit = "--";
            } else {
                nic_audit = user.getNic();
            }
            if (user.getAddress() == null || user.getAddress().isEmpty()) {
                add1_audit = "--";
            } else {
                add1_audit = user.getAddress();
            }
            if (user.getCity() == null || user.getCity().isEmpty()) {
                city_audit = "--";
            } else {
                city_audit = user.getCity();
            }
            if (user.getDateofbirth()== null || user.getDateofbirth().toString().isEmpty()) {
                dob_audit = "--";
            } else {
                dob_audit = user.getDateofbirth().toString();
            }
            if (user.getMobile()== null || user.getMobile().isEmpty()) {
                mobile_audit = "--";
            } else {
                mobile_audit = user.getMobile();
            }
            if (user.getEmail()== null || user.getEmail().isEmpty()) {
                email_audit = "--";
            } else {
                email_audit = user.getEmail();
            }
            if (user.getFullname()== null || user.getFullname().isEmpty()) {
                fullname_audit = "--";
            } else {
                fullname_audit = user.getFullname();
            }
//            if (user.getExpirydate()== null || user.getExpirydate().toString().isEmpty()) {
//                expiry_audit = "--";
//            } else {
//                expiry_audit = user.getExpirydate().toString();
//            }
            
             String newValue = user.getUsername()
                    + "|" + serid_audit
                    + "|" + nic_audit
                    + "|" + add1_audit
                    + "|" + user.getUserrole().getDescription()
                    + "|admin|"
                    + "|" + city_audit
                    + "|" + dob_audit
                    + "|" + mobile_audit
                    + user.getStatus().getDescription()
                    + "|" + email_audit
                    + "|" + fullname_audit;
//                    + "|" + expiry_audit;
            audit.setNewvalue(newValue);
            audit.setOldvalue(oldValue);

            session.save(audit);
            session.update(user);

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

    public String deleteSystemUser(SystemUserInputBean inputBean, Systemuser currentUser, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";

        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();

            Date sysDate = CommonDAO.getSystemDate(session);

            Systemuser user = (Systemuser) this.getSystemUserByUserName(inputBean.getUsername());

            // Check whether login user and requested to delete user are same            
            if (user.getUsername().equals(currentUser.getUsername())) {
                message = user.getUsername() + MessageVarList.SYSUSER_DEL_INVALID;
            } else {

                long flag = 0;
                String sql = "select count(systemauditid) from Systemaudit as u where u.lastupdateduser=:user";
                Query query = session.createQuery(sql).setString("user", inputBean.getUsername().trim());
                Iterator itCount1 = query.iterate();
                flag = (Long) itCount1.next();

                if (flag > 0) {
                    message = MessageVarList.COMMON_ALREADY_IN_USE;
                } else {

                    audit.setCreatetime(sysDate);
                    audit.setLastupdatedtime(sysDate);

                    session.save(audit);
                    session.delete(user);

                    txn.commit();
                }
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

    public String updatePasswordReset(SystemUserInputBean inputBean, Systemaudit audit) throws Exception {
        Session session = null;
        Transaction txn = null;
        String message = "";
        try {
            session = HibernateInit.sessionFactory.openSession();
            txn = session.beginTransaction();
            Date sysDate = CommonDAO.getSystemDate(session);

            Systemuser u = (Systemuser) session.get(Systemuser.class, inputBean.getHusername().trim());

            if (u != null) {

                u.setPassword(inputBean.getRenewpwd());
//                Systemuser lastUpdatedUser = new Systemuser();
//                lastUpdatedUser.setUsername(audit.getLastupdateduser().getUsername());
                u.setLastupdateduser(audit.getLastupdateduser());
                u.setLastupdatedtime(sysDate);

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
}
