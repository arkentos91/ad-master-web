<%-- 
    Document   : welcomepage
    Created on : Jun 6, 2014, 1:45:39 PM
    Author     : thushanth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 

        <title>Arkentos - Dunder Mifflin</title>

        <%@include file="/stylelinks.jspf" %>
    </head>
    <script type="text/javascript">
        
        //        window.onload=function(){
        //           var pathArray = window.location.pathname.split( '//' );
        //        var version= pathArray[0];
        //        version=version.replace(/\//g, "");
        //
        //        document.getElementById("versionno").innerHTML=version;
        ////        alert(secondLevelLocation);
        //        }
        
        
        
        function myFunction() {
            window.open("${pageContext.request.contextPath}/login.jsp", "MsgWindow", "width=1350, height=660,scrollbars=1,resizable=yes");
        }
        
    </script>
    <style>
        img.displayed{
            display: block;
            margin-left: auto;
            margin-right: auto;
            margin-top: auto;
            margin-bottom: auto;
              
        }
        </style>
        <body>

                    <img class="displayed" alt="welcome image" height="438" src="resouces/images/welcome_new.png" width="1313" usemap="#loginmap" />
                    <map name="loginmap">
                        <area shape="rect" coords="360,140,950,285" alt="text" onclick="myFunction()" href="#"  >
                    </map>

    </body>
</html>
