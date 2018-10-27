/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.action.login;

import com.arkentos.util.varlist.CommonVarList;
import java.util.Hashtable;
import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.NameNotFoundException;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.SizeLimitExceededException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

/**
 *
 * @author jayana_i
 */
public class ValidateUser {

    public static Boolean validateLogin(String username, String password) {
        Hashtable<String, String> env = new Hashtable<String, String>();
        System.setProperty("javax.net.ssl.trustStore", "C:\\Certificate\\ADMIN_SSL\\bml.jks");
        System.setProperty("javax.net.ssl.trustStorePassword", "mobilePay");
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        String base = "DC=bml,DC=com,DC=mv";
        env.put(Context.PROVIDER_URL, "ldaps://192.168.1.7:636");
        // To get rid of the PartialResultException when using Active Directory
        env.put(Context.REFERRAL, "follow");
        // Needed for the Bind (User Authorized to Query the LDAP server) 
        env.put(Context.SECURITY_PROTOCOL, "ssl");
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "CN=mserver,OU=Applications,DC=bml,DC=com,DC=mv");
        env.put(Context.SECURITY_CREDENTIALS, "4Lejt8Q!C*z%EWHt");
        DirContext ctx = null;
        NamingEnumeration<SearchResult> results = null;
        try {
            ctx = new InitialDirContext(env);
            SearchControls controls = new SearchControls();
            controls.setSearchScope(SearchControls.SUBTREE_SCOPE); // Search Entire Subtree
            controls.setCountLimit(1);   //Sets the maximum number of entries to be returned as a result of the search
            controls.setTimeLimit(5000); // Sets the time limit of these SearchControls in milliseconds
            String searchString = "(&(sAMAccountName=" + username + ")(objectClass=user))";
            results = ctx.search("DC=bml,DC=com,DC=mv", searchString, controls);
            if (results.hasMore()) {
                SearchResult result = (SearchResult) results.next();
                Attributes attrs = result.getAttributes();
                Attribute dnAttr = attrs.get("distinguishedName");
                String dn = (String) dnAttr.get();
                // User Exists, Validate the Password
                env.put(Context.SECURITY_PRINCIPAL, dn);
                env.put(Context.SECURITY_CREDENTIALS, password);
                new InitialDirContext(env); // Exception will be thrown on Invalid case
                return true;
            } else {
                return false;
            }
        } catch (AuthenticationException e) { // Invalid Login
            return false;
        } catch (NameNotFoundException e) { // The base context was not found.
            return false;
        } catch (SizeLimitExceededException e) {
            throw new RuntimeException("LDAP Query Limit Exceeded, adjust the query to bring back less records", e);
        } catch (NamingException e) {
//            throw new RuntimeException(e);
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) { /* Do Nothing */ }
            }

            if (ctx != null) {
                try {
                    ctx.close();
                } catch (Exception e) { /* Do Nothing */ }
            }

        }

    }

    public static Boolean validateLogin_(String username, String password) {
        Hashtable<String, String> env = new Hashtable<String, String>();
        System.setProperty("javax.net.ssl.trustStore", "C:\\Users\\Administrator\\Desktop\\ldap\\ldap.jks");
        System.setProperty("javax.net.ssl.trustStorePassword", "changeit");
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        String base = "DC=bml,DC=com,DC=mv";
//	        env.put(Context.PROVIDER_URL, "ldap://192.168.1.100:389");
//        env.put(Context.PROVIDER_URL, "ldaps://192.168.1.100:636/DC=bml,DC=com,DC=mv");
        env.put(Context.PROVIDER_URL, "ldaps://192.168.1.7:636");
        // To get rid of the PartialResultException when using Active Directory
        env.put(Context.REFERRAL, "follow");
        // Needed for the Bind (User Authorized to Query the LDAP server) 
        env.put(Context.SECURITY_PROTOCOL, "ssl");
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
//	        env.put(Context.SECURITY_PRINCIPAL, LDAP_BIND_DN);
        env.put(Context.SECURITY_PRINCIPAL, "CN=mserver,OU=Applications,DC=bml,DC=com,DC=mv");
//        env.put(Context.SECURITY_PRINCIPAL,"mserver");

        env.put(Context.SECURITY_CREDENTIALS, "4Lejt8Q!C*z%EWHt");
//
        DirContext ctx = null;
        NamingEnumeration<SearchResult> results = null;

        try {

            ctx = new InitialDirContext(env);
//            return true;

//jayana
            SearchControls controls = new SearchControls();
            controls.setSearchScope(SearchControls.SUBTREE_SCOPE); // Search Entire Subtree
            controls.setCountLimit(1);   //Sets the maximum number of entries to be returned as a result of the search
            controls.setTimeLimit(5000); // Sets the time limit of these SearchControls in milliseconds
            System.out.println("checked ");
//            String searchString = "(&(objectCategory=user)(sAMAccountName=MobilePayservice))";
//            String searchString = "(&(objectCategory=mserver)(objectClass=user)(sAMAccountName=MobilePayservice))";
//            String searchString = "(&(objectClass=mserver)(sAMAccountName=MobilePayservice))";

//            String searchString = "(&(sAMAccountName=MobilePayservice)(objectClass=user))";
            String searchString = "(&(sAMAccountName=" + username + ")(objectClass=user))";

//            NamingEnumeration answer = ctx.search("","(&(sAMAccountName=MobilePayservice))", controls);
            results = ctx.search("DC=bml,DC=com,DC=mv", searchString, controls);

            System.out.println("checked 1");
            if (results.hasMore()) {
                System.out.println("checked 21");
                SearchResult result = (SearchResult) results.next();
                Attributes attrs = result.getAttributes();

                Attribute dnAttr = attrs.get("distinguishedName");
//                Attribute dnAttr = attrs.get("serverName");
                String dn = (String) dnAttr.get();
                System.out.println("" + dn);
                // User Exists, Validate the Password
                env.put(Context.SECURITY_PRINCIPAL, dn);
                env.put(Context.SECURITY_CREDENTIALS, password);
                new InitialDirContext(env); // Exception will be thrown on Invalid case

                return true;
            } else {
                return false;
            }
        } catch (AuthenticationException e) { // Invalid Login
            return false;
        } catch (NameNotFoundException e) { // The base context was not found.
            return false;
        } catch (SizeLimitExceededException e) {
            throw new RuntimeException("LDAP Query Limit Exceeded, adjust the query to bring back less records", e);
        } catch (NamingException e) {
//            throw new RuntimeException(e);
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) { /* Do Nothing */ }
            }

            if (ctx != null) {
                try {
                    ctx.close();
                } catch (Exception e) { /* Do Nothing */ }
            }

        }

    }

}
