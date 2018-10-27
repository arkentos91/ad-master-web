
<%@page import="com.arkentos.util.varlist.SessionVarlist"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>
<!--<!DOCTYPE html>-->

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <sj:head jqueryui="true" jquerytheme="mytheme" customBasepath="resouces/themes"/>   
        <jsp:include page="/stylelinks.jspf"/>

    </head>


    <body style="">
        <!-- start: HEADER -->
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp">              
            <jsp:param name="firstpage" value="100" />
        </jsp:include>

        <div class="ali-body f-right ali-header-text">

        </div>

        <jsp:include page="/footer.jsp"/>
    </body>
</html>