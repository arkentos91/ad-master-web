<%-- 
    Document   : leftmenu2
    Created on : Jun 21, 2018, 2:24:14 PM
    Author     : prathibha_s
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.arkentos.util.common.SectionComparator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.arkentos.util.varlist.SessionVarlist"%>
<%@page import="com.arkentos.util.mapping.Section"%>
<%@page import="com.arkentos.util.mapping.Page"%>
<!DOCTYPE html>
<html>

    <head>
        <!--<link href="${pageContext.request.contextPath}/resouces/uinew/assets/css/main.css" rel="stylesheet" />-->
        <!--<link href="${pageContext.request.contextPath}/resouces/uinew/assets/css/home.css" rel="stylesheet" />-->
        <!--<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">-->
        <script>
            jQuery(document).ready(function () {
                Main.init();
            });

            $(document).ready(function () {

                $(document).ajaxStart(function () {
                    $.blockUI({css: {
                            border: 'transparent',
                            backgroundColor: 'transparent'
                        },
                        message: '<img height="100" width="100" src="${pageContext.request.contextPath}/resouces/images/loading.gif" />',
                        baseZ: 2000
                    });
                });
                $(document).ajaxStop(function () {
                    $.unblockUI();
                });

            });


//
//            function sectionClick(myid) {
//                $.cookie("selectedsec", myid, {path: "/", expires: 1});
//            }
//
//            function pageClick(myid) {
//                $.cookie("selectedpage", myid, {path: "/", expires: 1});
//
//            }
//
//            jQuery(document).ready(function () {
//                var firPage = ${param.firstpage} + "1";
//
//                if (firPage === "1001") {
//                    $.cookie("selectedpage", 1001, {path: "/", expires: 1});
//                    $.cookie("selectedsec", 1, {path: "/", expires: 1});
//                    var firURL = $("a", '#1001').attr('href');
//                    window.location = firURL;
//                    //window.location= firURL+'?operationMode=STORE';  
//                }
//
//                if (firPage === "01") {
//                    $.cookie("selectedpage", 1001, {path: "/", expires: -1});
//                    $.cookie("selectedsec", 1, {path: "/", expires: -1});
//                }
//
//                var idsec = $.cookie("selectedsec");
//                var idsecval = "#" + idsec;
//                $(idsecval).addClass("active open");
//                //            $(idsecval).addClass("active open"); 
//
//                var id = $.cookie("selectedpage");
//                var idval = "#" + id;
//                $(idval).addClass("active open");
//                //                        $(idval).removeClass("active open");
//
//            });
        </script>
    </head>

    <body>
        <div class="ali-navbar f-left ali-header-text">
            <div class="ali-topdetail">
                <div class="ali-homedetail">
                    <!--<div class="logo"><img src="${pageContext.request.contextPath}/resouces/uinew/assets/image/bml.svg" width="30" height="auto" alt="logo"/></div>-->
                    <div class="text1">Dunder Mifflin Paper</div>
                    <div class="text2">Scranton Branch</div>
                </div>
                <div class="ali-Horizonline"></div>
                <div class="ali-logindetail">
                    <div class="welcome">Welcome,&nbsp; ${SYSTEMUSER.fullname}</div>
                    <div class="role">User Role: ${SYSTEMUSER.userrole.description}</div>
                    <div class="time">Last login date time: ${SYSTEMUSER.loggeddate}</div>
                </div>
                <div class="ali-Horizonline"></div>
            </div>
            <aside class="sidebar-left-collapse">
                <%

                    try {

                        HashMap<Section, List<Page>> sectionPageList = (HashMap<Section, List<Page>>) request.getSession().getAttribute(SessionVarlist.SECTIONPAGELIST);

                        SectionComparator sec1 = new SectionComparator();
                        Set<Section> section = new TreeSet<Section>(sec1);

                        Set<Section> section1 = sectionPageList.keySet();
                        for (Section sec2 : section1) {
                            section.add(sec2);
                        }

                        int secId = 1;
                        int pageId = 1000;

                        out.println("<div class='sidebar-links'>");
                        

                        for (Section sec : section) {

                            out.println("<div id='link_"+secId+"' class='link-default'>");
                            out.println("<a href='#'>"+sec.getDescription()+"</a>");
                            out.println("<ul class='sub-links'>");
                            
                            List<Page> pageList = sectionPageList.get(sec);
                            for (Page pageBean : pageList) {
                                pageId++;
                                out.println("<li id='sublink_"+pageId+"'>");
                                out.println("<a href="+request.getContextPath() + pageBean.getUrl()+">"+pageBean.getDescription()+"</a>");
                                out.println("</li>");
                            }
                            out.println(" </ul>");
                            out.println(" </div>");

                            secId++;
                        }
                        out.println("</div>");

                    } catch (Exception ee) {

                        ee.printStackTrace();
                    }
                %>
            </aside>
        </div>
    </body>
</html>