<%-- 
    Document   : header2
    Created on : Jun 21, 2018, 3:04:03 PM
    Author     : prathibha_s
--%>

<div class="ali-header ali-fixed-header">
    <div class="ali-breadcrumb">
        <h> ${CURRENTSECTION}</h> 
            <% if (session.getAttribute("CURRENTSECTION") != null && !session.getAttribute("CURRENTSECTION").equals("")) {%>
        >
        <% }%>
        <h>${CURRENTPAGE}</h>
    </div>
    <div class="ali-header-passchange f-right">
        <a href="LogoutUserLogin.action?"><i class="material-icons">power_settings_new</i></a>
    </div>
</div>