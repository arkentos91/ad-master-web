<%-- 
    Document   : userroleassign
    Created on : Jan 7, 2014, 3:40:26 PM
    Author     : thushanth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title></title>


            <%@include file="/stylelinks.jspf" %>

            <script type="text/javascript">
                window.onload = function () {

                    if ($("#userRole").val() && $("#userRoleDes").val() && $("#Category").val()) {
                        document.getElementById('uRole').innerHTML = $("#userRoleDes").val();

                        if ($("#Category").val() === "Sections") {
                            $(".hideme1").hide();
                            $(".hideme2").hide();
                            $(".la2").hide();
                            $(".la3").hide();
                            //               $(".mandatoryfield").hide();               
                            loadsection($("#userRole").val());

                        } else if ($("#Category").val() === "Pages") {
                            $(".hideme2").hide();
                            $(".la1").hide();
                            $(".la3").hide();

                            if (!$("#section").val()) {
                                document.getElementById('pa').innerHTML = "No Section Selected";
                            }

                            loaddropdownSections($("#userRole").val());

                        } else if ($("#Category").val() === "Operations") {
                            $(".hideme1").hide();
                            $(".la1").hide();
                            $(".la2").hide();

                            if (!$("#page").val()) {
                                document.getElementById('ta').innerHTML = "No Page Selected";
                            }
                            loaddropdownSectionpages($("#userRole").val());
                        }
                    } else {
                        //               alert("Error occured while loading.");
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                };

                function loadsection(key) {

                    $.ajax({
                        url: '${pageContext.request.contextPath}/FindUserRolePrivilege.action',
                        data: {
                            userRole: key
                        },
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $('#divmsg').empty();

                            var msg = data.message;

                            if (msg) {

                                $('#currentBox').empty();
                                $('#newBox').empty();
                                alert(data.message)
                            } else {
                                $('#oldvalue').val(data.oldvalue);
                                $('#newBox').empty();
                                $('#currentBox').empty();

                                $.each(data.newList, function (key, value) {
                                    $('#newBox').append(
                                            $('<option></option>').val(key).html(
                                            value));
                                });
                                $.each(data.currentList, function (key, value) {
                                    $('#currentBox').append(
                                            $('<option></option>').val(key).html(
                                            value));
                                });
                            }
                        },
                        error: function (data) {
                            //                alert("Error occurd while loading.");
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }

                function loaddropdownSections(keyval) {

                    if (!keyval) {
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        $('#section').empty();
                        $('#section').append("<option value=''>--Select Section--</option>");
                        alert("Empty user role ");
                        return;
                    }

                    $.ajax({
                        url: '${pageContext.request.contextPath}/LoadSectionUserRolePrivilege.action',
                        data: {userRole: keyval},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $('#divmsg').empty();
                            var msg = data.message;
                            if (msg) {
                                $('#section').empty();
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                $('#section').append("<option value=''>--Select Section--</option>");
                                alert(data.message)
                            }
                            else {

                                $('#section').empty();
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                $('#section').append("<option value=''>--Select Section--</option>")

                                $.each(data.sectionMap, function (key, value) {
                                    $('#section').append(
                                            $('<option></option>').val(key).html(value)
                                            );
                                });
                            }
                        },
                        error: function (data) {
                            //                        $("#errordialog").html("Error occurred while processing.").dialog('open');
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }


                function loaddropdownSectionpages(keyval) {

                    if (!keyval) {
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        $('#sectionpage').empty();
                        $('#sectionpage').append("<option value=''>--Select Section--</option>");
                        alert("Empty user role ");
                        return;
                    }


                    $.ajax({
                        url: '${pageContext.request.contextPath}/LoadSectionUserRolePrivilege.action',
                        data: {userRole: keyval},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $('#divmsg').empty();
                            var msg = data.message;
                            if (msg) {
                                $('#sectionpage').empty();
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                $('#sectionpage').append("<option value=''>--Select Section--</option>");
                                alert(data.message)
                            }
                            else {

                                $('#sectionpage').empty();
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                $('#sectionpage').append("<option value=''>--Select Section--</option>")

                                $.each(data.sectionMap, function (key, value) {
                                    $('#sectionpage').append(
                                            $('<option></option>').val(key).html(value)
                                            );
                                });
                            }
                        },
                        error: function (data) {
                            //                        $("#errordialog").html("Error occurred while processing.").dialog('open');
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }




                function loadPage(keyval) {
                    var userRole = $('#userRole').val();



                    if ($("#section").val()) {
                        var e = document.getElementById("section");
                        var se = e.options[e.selectedIndex].text;
                        document.getElementById('pa').innerHTML = se + ". ";
                    } else {
                        document.getElementById('pa').innerHTML = "No Section Selected";

                    }

                    if (!keyval && keyval !== "") {
                        //           $('#section').val("");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        alert("Empty section");
                        return;
                    } else if (keyval === "") {
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        logout(false);//logout method
                        return;
                    }



                    if (!userRole) {

                        $('#currentBox').empty();
                        $('#newBox').empty();
                        $('#section').empty();
                        $('#section').append("<option value=''>--Select Section--</option>");
                        alert("Empty user role");
                        return;
                    }

                    $.ajax({
                        url: '${pageContext.request.contextPath}/FindPageUserRolePrivilege.action',
                        data: {section: keyval, userRole: userRole},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $('#divmsg').empty();
                            var msg = data.message;
                            if (msg) {
                                $('#section').val("");
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                alert(data.message)
                            }
                            else {
                                $('#oldvalue').val(data.oldvalue);

                                $('#newBox').empty();
                                $('#currentBox').empty();

                                $.each(data.newList, function (key, value) {
                                    $('#newBox').append(
                                            $('<option></option>').val(key).html(
                                            value));
                                });
                                $.each(data.currentList, function (key, value) {
                                    $('#currentBox').append(
                                            $('<option></option>').val(key).html(
                                            value));
                                });

                            }
                        },
                        error: function (data) {
                            //                        $("#errordialog").html("Error occurred while processing.").dialog('open');
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }

                function loaddropdownPages(keyval) {

                    var userRole = $('#userRole').val();
                    ;


                    if (!$("#sectionpage").val()) {
                        document.getElementById('ta').innerHTML = "No Page Selected";
                    }

                    if (!keyval && keyval !== "") {
                        $('#page').empty();
                        $('#page').append("<option value=''>--Select Page--</option>");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        alert("Empty section ");
                        return;

                    } else if (keyval === "") {
                        $('#page').empty();
                        $('#page').append("<option value=''>--Select Page--</option>");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        return;
                    }

                    if (!userRole) {
                        $('#page').empty();
                        $('#page').append("<option value=''>--Select Page--</option>");
                        $('#sectionpage').empty();
                        $('#sectionpage').append("<option value=''>--Select Section--</option>");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        alert("Empty user role ");
                        return;
                    }

                    $.ajax({
                        url: '${pageContext.request.contextPath}/LoadPageUserRolePrivilege.action',
                        data: {userRole: userRole, sectionpage: keyval},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $('#divmsg').empty();

                            var msg = data.message;

                            if (msg) {
                                $('#page').empty();
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                $('#page').append("<option value=''>--Select Page--</option>");
                                alert(data.message)
                            }
                            else {
                                $('#page').empty();
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                $('#page').append("<option value=''>--Select Page--</option>")

                                $.each(data.pageMap, function (key, value) {
                                    $('#page').append(
                                            $('<option></option>').val(key).html(value)
                                            );
                                });
                            }
                        },
                        error: function (data) {
                            //                        alert("Error occurd while loading.");
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }

                function loadTask(keyval) {

                    var userRole = $('#userRole').val();
                    var section = $('#sectionpage').val();
                    //                var page =  $("#page").val();   

                    if ($("#page").val()) {
                        var e = document.getElementById("page");
                        var pag = e.options[e.selectedIndex].text;
                        document.getElementById('ta').innerHTML = pag + ". ";
                    } else {
                        document.getElementById('ta').innerHTML = "No Page Selected";

                    }

                    if (!keyval && keyval !== "") {
                        //           $('#page').val("");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        alert("Empty page");
                        return;
                    } else if (keyval === "") {
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        logout(false);//logout method
                        return;
                    }

                    if (!section) {
                        //           $('#sectionpage').val("");
                        //           $('#page').val("");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        alert("Empty section");
                        return;
                    } else if (!userRole) {
                        $('#sectionpage').empty();
                        $('#sectionpage').append("<option value=''>--Select Section--</option>");
                        $('#page').empty();
                        $('#page').append("<option value=''>--Select Page--</option>");
                        $('#currentBox').empty();
                        $('#newBox').empty();
                        alert("Empty user role");
                        return;
                    }


                    $.ajax({
                        url: '${pageContext.request.contextPath}/FindTaskUserRolePrivilege.action',
                        data: {userRole: userRole, sectionpage: section, page: keyval},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $('#divmsg').empty();
                            var msg = data.message;

                            if (msg) {
                                $('#page').val("");
                                $('#currentBox').empty();
                                $('#newBox').empty();
                                alert(data.message)
                            }
                            else {
                                $('#oldvalue').val(data.oldvalue);
                                $('#newBox').empty();
                                $('#currentBox').empty();

                                $.each(data.newList, function (key, value) {
                                    $('#newBox').append(
                                            $('<option></option>').val(key).html(
                                            value));
                                });
                                $.each(data.currentList, function (key, value) {
                                    $('#currentBox').append(
                                            $('<option></option>').val(key).html(
                                            value));
                                });

                            }
                        },
                        error: function (data) {
                            //                        alert("Error occurd while loading.");
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }

                function toleft() {
                    $("#newBox option:selected").each(function () {

                        $("#currentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }
                ;
                function toright() {
                    $("#currentBox option:selected").each(function () {

                        $("#newBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }
                function toleftall() {
                    $("#newBox option").each(function () {

                        $("#currentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }
                function torightall() {
                    $("#currentBox option").each(function () {

                        $("#newBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }
                function clickAssign() {

                    $('#currentBox option').prop('selected', true);
                    $('#newBox option').prop('selected', true);
                    $("#assignbut").click();
                }


                function resetFieldData() {

                    if ($("#Category").val() === "Pages") {
                        $("#section").val("");
                        $('#newBox').empty();
                        $('#currentBox').empty();
                        if (!$("#section").val()) {
                            document.getElementById('pa').innerHTML = "No Section Selected";
                        }


                    } else if ($("#Category").val() === "Operations") {
                        $('#newBox').empty();
                        $('#currentBox').empty();
                        $("#sectionpage").val("");
                        $('#page').empty();
                        $('#page').append("<option value=''>--Select Page--</option>");
                        if (!$("#sectionpage").val()) {
                            document.getElementById('ta').innerHTML = "No Page Selected";
                        }
                    }

                }
                function resetAllData() {
                    $('#divmsg').text("");
                    if ($("#Category").val() === "Sections") {
                        loadsection($("#userRole").val());

                    } else if ($("#Category").val() === "Pages") {
                        loadPage($("#section").val());

                    } else if ($("#Category").val() === "Operations") {
                        loadTask($("#page").val());
                    }

                }
                function backToMain() {
                    window.location = "${pageContext.request.contextPath}/ViewUserRolePrivilege.action";
                }

                function logout(param) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/LogOutUserUserRolePrivilege.action',
                        data: {},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {

                        },
                        error: function (data) {
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });

                }
                ;


            </script>
    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>
        
        <div class="ali-body f-right ali-header-text">
            <s:div id="divmsg">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>

            <s:set id="vassign" var="vassign">
                <s:property value="vassign" default="true" />
            </s:set>

            <div class="ali-form">
                <s:form action="UserRolePrivilege" theme="simple" method="post" id="assignform" name="assignform" target="divmsg">

                    <s:hidden id="userRole" name="userRole"/>
                    <s:hidden id="userRoleDes" name="userRoleDes"/>
                    <s:hidden id="Category" name="Category"/>


                    <div class="row">
                        <div class="col-sm-2 ">
                            <div class="form-group">
                                <span style="color: red"></span><label>User Role :</label>
                            </div>
                        </div>
                        <div class="col-sm-3 ">
                            <div class="control-label">
                                <label class="control-label">
                                    <div id="uRole"> </div>
                                </label>    
                            </div>
                        </div>
                    </div>

                    <div class="row row_1">
                        <div class="col-sm-2 hideme1" style="margin-top: 6px;">
                            <div class="form-group" >
                                <span style="color: red">*</span><label>Section :</label>
                            </div>
                        </div>
                        <div class="col-sm-3 hideme1">
                            <div class="form-group">
                                <s:select  id="section" list="sectionMap"  onchange="loadPage(this.value)" name="section" headerKey="" headerValue="--Select Section--" listKey="sectioncode" listValue="description" cssClass="form-control"/>   
                            </div>
                        </div>

                        <div class="col-sm-2 hideme2" style="margin-top: 6px;">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Section :</label>
                            </div>
                        </div>
                        <div class="col-sm-3 hideme2">
                            <div class="form-group">
                                <s:select  id="sectionpage" list="sectionMap"  onchange="loaddropdownPages(this.value)" name="sectionpage" headerKey="" headerValue="--Select Section--" listKey="sectioncode" listValue="description" cssClass="form-control"/> 
                            </div>
                        </div>
                    </div>

                    <div class="row row_1">
                        <div class="col-sm-2 hideme2" style="margin-top: 6px;">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Page :</label>
                            </div>
                        </div>
                        <div class="col-sm-3 hideme2">
                            <div class="form-group">
                                <s:select  id="page" list="pageMap"  name="page" headerKey="" headerValue="--Select Page--" onchange="loadTask(this.value)" listKey="pagecode" listValue="description" cssClass="form-control"/>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row row_popup form-inline la1">
                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="control-label"> Sections </label>
                                
                            </div>
                        </div>
                    </div>
                    <div class="row row_popup form-inline la2">
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label class="control-label">Pages for :</label>
                            </div>
                        </div>
                        <div class="col-sm-10">
                            <div class="form-group">
                                 <label class="control-label"><div id="pa"></div></label>
                                
                            </div>
                        </div>
                    </div>
                    <div class="row row_popup form-inline la3">
                        <div class="col-sm-2">
                            <label class="control-label">Tasks for :</label>
                        </div>
                        <div class="col-sm-10">
                             <label class="control-label">
                                <div id="ta"></div> 
                             </label>
                        </div>
                    </div>

                    


                    <div class="row">
                        <div class="col-sm-10">
                            <div class="col-sm-5">
                                <s:select cssClass="form-control" multiple="true" 
                                          name="currentBox" id="currentBox" list="currentList"									 
                                          ondblclick="toright()" style="height:160px;"/>

                            </div>
                            <div class="col-sm-2 text-center">
                                <div class="row" style="height: 20px;"></div>
                                <div class="row">
                                    <sj:a
                                        id="right" 
                                        onClick="toright()" 
                                        button="true"
                                        style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                                    </div>
                                    <div class="row">
                                    <sj:a
                                        id="rightall" 
                                        onClick="torightall()" 
                                        button="true"
                                        style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                                    </div>
                                    <div class="row">
                                    <sj:a
                                        id="left" 
                                        onClick="toleft()" 
                                        button="true"
                                        style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                                    </div>
                                    <div class="row">
                                    <sj:a
                                        id="leftall" 
                                        onClick="toleftall()" 
                                        button="true"
                                        style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                <s:select cssClass="form-control" multiple="true"
                                          name="newBox" id="newBox" list="newList"									 
                                          ondblclick="toleft()" style="height:160px;" />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <br>
                        <div class="col-sm-9 la2">
                            <label class="control-label">Mandatory fields are marked with <span style="color: red">*</span></label>
                                 
                        </div>
                        <div class="col-sm-9 la3">
                            <label class="control-label">Mandatory fields are marked with <span style="color: red">*</span></label>
                                 
                        </div>
                    </div>        
                         
                            
                    <div style="display: none; visibility: hidden;">
                        <s:url var="assignurl" action="AssignUserRolePrivilege" />
                        <sj:submit button="true" href="%{assignurl}" id="assignbut"
                                   targets="divmsg" />
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">
                                <sj:submit button="true" 
                                           id="backButton" 
                                           value="Back" 
                                           cssClass="btn btn-ali-submit btn-sm"
                                           onClick="backToMain()" 
                                           /> 
                            
                                <sj:a button="true"
                                      id="assignbuta"
                                      onclick="clickAssign()" 
                                      cssClass="btn btn-ali-submit btn-sm"
                                      disabled="#vassign">
                                    Assign
                                </sj:a> 
                                
                                <sj:submit
                                    button="true" value="Reset" name="reset"
                                    onClick="resetAllData()" 
                                    cssClass="btn btn-ali-reset btn-sm"
                                     />
                            </div>
                        </div>
                    </div>
                </s:form>            
            </div>
            <!-- Start error dialog box -->
            <sj:dialog 
                id="errordialog" 
                buttons="{
                'OK':function() { $( this ).dialog( 'close' );}                                    
                }" 
                autoOpen="false" 
                modal="true" 
                title="Error Occured"
                />

        </div>
        <jsp:include page="/footer.jsp"/>
    </body>
</html>
