<%-- 
    Document   : login2
    Created on : Jun 21, 2018, 12:02:02 PM
    Author     : prathibha_s
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>

<html>
    <head>
        <title>Dunder Mifflin</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resouces/uinew/assets/image/favicon.ico"/>
        <link href="${pageContext.request.contextPath}/resouces/uinew/assets/css/main.css" rel="stylesheet" />
        <script type="text/javascript">
            
            window.localStorage.removeItem('link');
            window.localStorage.removeItem('sublink');
            
            function encryp() {
                if ($('#password').val() != "") {
                    var ps = $('#password').val();
                    $('#password').val(CryptoJS.MD5(ps));
                }
            }

        </script>
    </head>

    <body>
        <div class="ap-main">
            <div  class="ap-sec1">
                <div class="ap-footer1">
                    <!--Copyright © 2018--> 
                </div>
                <div class="ap-footer2">
                    <!--<a href="http://www.epiclanka.net/">Epic Lanka (pvt) Ltd</a> .All rights reserved.-->
                </div>
            </div>
            <div class="ap-sec2">
                <div class="ap-secmain">
                    <div class="ap-form">
                        <form novalidate="novalidate" action="CheckUserLogin" method="post">
                            <div class="ap-banklogo">
                                <img src="${pageContext.request.contextPath}/resouces/uinew/assets/image/bml.png" width="60" height="auto" alt="logo" />
                            </div>
                            <div class="ap-banktext">
                                <div class="ap-text1">
                                    Dunder Miflfin Paper
                                </div>
                                <div class="ap-text2">
                                    Scranton Branch
                                </div>
                            </div>
                            <div class="ap-username">
                                <div class="ap-usernamelbl">Username</div>
                                <input type="text" name="username" />
                            </div>
                            <div class="ap-password">
                                <div class="ap-passwordlbl">Password</div>
                                <input type="password"  name="password" />
                            </div>
                            <div class="ap-loginbut">
                                <input type="submit" value="Login" class="btn" />
                            </div>
                            <div class="ap-message" style="">
                                <s:if test="hasActionErrors()">
                                    <div class="error-dis" style="padding: 3px 100px;">
                                        <i class="fa fa-remove-sign"> <s:property default="errormessage" value="errormessage"></s:property></i>

                                        </div>
                                </s:if>
                                <s:if test="hasActionMessages()">
                                    <!--<div class="errorHandler alert alert-danger no-display2222">-->
                                    <div class="error-dis"  style="padding: 3px 100px;">
                                        <i class="fa fa-remove-sign">   <s:property default="errormessage" value="errormessage"></s:property></i>
                                            <!--</div>-->
                                        </div>  
                                </s:if>      
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <script src="${pageContext.request.contextPath}/resouces/uinew/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resouces/uinew/assets/js/main.js"></script>
    </body>

</html>