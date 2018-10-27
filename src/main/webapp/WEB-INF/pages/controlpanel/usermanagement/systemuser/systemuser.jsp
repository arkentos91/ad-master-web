<%-- 
    Document   : systemuser
    Created on : 08/01/2014, 1:23:02 PM
    Author     : asitha_l
--%>

<%@page import="com.arkentos.util.varlist.CommonVarList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>

        <%@include file="/stylelinks.jspf" %>
        <script type="text/javascript">
            $.subscribe('onclicksearch', function (event, data) {
                $('#message').empty();

                var username = $('#username').val();
                var fullname = $('#fullname').val();
                var email = $('#email').val();
                var contactno = $('#contactno').val();
                var userrole = $('#userrole').val();
                var status = $('#status').val();
                var serviceid = $('#serviceid').val();
                var nic = $('#nic').val();
                var expirydate = $('#expirydate').val();

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        username: username,
                        fullname: fullname,
                        email: email,
                        contactno: contactno,
                        userrole: userrole,
                        status: status,
                        nic: nic,
                        serviceid: serviceid,
                        expirydate: expirydate,
                        search: true
                    }
                });

                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");

            });

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function resetAllData() {
                $('#username').attr('readOnly', false);
                $('#username').val("");
                $("#username").css("color", "black");
                $('#password').val("");
                $('#confirmpassword').val("");
                $('#expirydate').val('${PASSWORDEXPIRYPERIOD}');
                $("#expirydate").css("color", "#858585");
                $('#userrole').val("");
//                $('#dualauthuser').val("");
                $('#status').val("");
                $('#fullname').val("");
                $('#serviceid').val("");
                $('#address1').val("");
                $('#address2').val("");
                $('#city').val("");
                $('#contactno').val("");
                $('#email').val("");
                $('#nic').val("");
                $('#dateofbirth').val("");

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        username: "",
                        fullname: "",
                        email: "",
                        contactno: "",
                        userrole: "",
                        status: "",
                        nic: "",
                        serviceid: "",
                        expirydate: "",
                        search: false
                    }
                });
                jQuery("#gridtable").trigger("reloadGrid");
                $(".hideme").show();
            }

            function changepasswordformatter(cellvalue, options, rowObject) {

                var status = rowObject.status;

                if (status == "Active") {
                    return "<a href='#' title='Change password' onClick='javascript:changepasswordInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-arrowreturnthick-1-s' style='display: block;margin-left: auto;margin-right: auto;'/></a>";

                }

                return("--");
            }

            function changepasswordInit(keyval) {
                $("#changepwddialog").data('username', keyval).dialog('open');
            }

            $.subscribe('openpwdchangetopage', function (event, data) {
                var $led = $("#changepwddialog");
                $led.html("Loading..");
                $led.load("changepasswordSystemUser.action?username=" + $led.data('username'));
            });

            function changepasswordInit_old(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/changePasswordSystemUser',
                    data: {usernameUserrole: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsg').empty();
                        var msg = data.message;
                        if (msg) {
                            alert(data.message);
                        } else {
                            resetAllChagePass();
                            $("#systemuseradd").hide();
                            $("#pwdResetform").show();

                            $('#cusername').val(data.username);
                            $('#cusername').attr('readOnly', true);
                            $('#cuserrole').val(data.userrole);
                            $('#cuserrole').attr('readOnly', true);
                            $('#chusername').val(data.husername);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }


            function editformatter(cellvalue) {
                return "<a href='#/' title='Edit' onClick='javascript:editSystemUserInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editSystemUserInit(keyval) {
                $("#updatedialog").data('username', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("detailSystemUser.action?username=" + $led.data('username'));
            });


            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteSystemUserInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }
            function deleteSystemUserInit(keyval) {
                $('#divmsg').empty();
                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete system user ' + keyval + ' ?');
                return false;
            }

            function deleteSystemUser(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/deleteSystemUser',
                    data: {username: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#deletesuccdialog").dialog('open');
                        $("#deletesuccdialog").html(data.message);

                        resetFieldData();
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }


//            function resetFieldData() {
//                a = $("#addButton").is(':disabled');
//                u = $("#updateButton").is(':disabled');
//
//                $('#username').attr('readOnly', false);
//                $('#username').val("");
//                $("#username").css("color", "black");
//                $('#password').val("");
//                $('#confirmpassword').val("");
//                $('#expirydate').val('${PASSWORDEXPIRYPERIOD}');
//                $("#expirydate").css("color", "#858585");
//                $('#userrole').val("");
////                $('#dualauthuser').val("");
//                $('#status').val("");
//                $('#fullname').val("");
//                $('#serviceid').val("");
//                $('#address1').val("");
//                $('#address2').val("");
//                $('#city').val("");
//                $('#contactno').val("");
//                $('#email').val("");
//                $('#nic').val("");
//                $('#dateofbirth').val("");
//
//                if (a == true && u == true) {
//                    $('#addButton').button("disable");
//                    $('#updateButton').button("disable");
//                } else if (a == true && u == false) {
//                    $('#addButton').button("enable");
//                    $('#updateButton').button("disable");
//                } else if (a == false && u == true) {
//                    $('#addButton').button("enable");
//                    $('#updateButton').button("disable");
//                }
//
//                jQuery("#gridtable").trigger("reloadGrid");
//                $(".hideme").show();
//            }

            function resetFieldData() {

                $("#iusername").val("");
                $("#iserviceid").val("");
                $("#iaddress1").val("");
                $("#ipassword").val("");
                $("#iconfirmpassword").val("");
                $("#idescription").val("");
                $("#inic").val("");
                $("#iuserrole").val("");
                $("#icity").val("");
                $("#idateofbirth").val("");
                $("#icontactno").val("");
                $("#iemail").val("");
                $("#ifullname").val("");
                $("#iexpirydate").val('${PASSWORDEXPIRYPERIOD}');
                $("#istatus").val("");

                $("#cnewpwd").val("");
                $("#crenewpwd").val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                jQuery("#gridtable").trigger("reloadGrid");
            }


            function resetAllChagePass() {
                $('#newpwd').val("");
                $('#renewpwd').val("");
                $('#changepassdivmsg').text("");

                editSystemUser(null);
            }


            function cancelAllData() {
                editSystemUser(null);
            }

            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57) || (k == 13));
            }

            function isNumberserch(evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }


        </script>

        <body>
            <jsp:include page="/header.jsp"/>
            <jsp:include page="/leftmenu.jsp"/>

            <div class="ali-body f-right ali-header-text">
                <s:div id="divmsg">
                    <s:actionerror theme="jquery"/>
                    <s:actionmessage theme="jquery"/>
                </s:div>

                <s:set id="vadd" var="vadd"><s:property value="vadd" default="true"/></s:set>
                <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
                <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
                <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>
                <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>
                <s:set var="vpasswordreset"><s:property value="vpasswordreset" default="true"/></s:set>

                    <div class="ali-form">
                    <s:form cssClass="form" id="systemuseradd" method="post" action="SystemUser" theme="simple" >

                        <s:hidden id="oldvalue" name="oldvalue" ></s:hidden>
                        
                        <s:url var="updateurl" action="UpdateSystemUser"/>

                        <div class="row"> 
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >Username</label>
                                    <s:textfield name="username" id="username" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/> 
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >Full Name</label>
                                    <s:textfield name="fullname" id="fullname" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/> 
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >Service ID</label>
                                    <s:textfield name="serviceid" id="serviceid" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))"/> 
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >NIC</label>
                                    <s:textfield name="nic" id="nic" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/> 
                                </div>
                            </div>
                        </div>
                        <div class="row"> 
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >Email</label>
                                    <s:textfield name="email" id="email" cssClass="form-control" maxLength="128"  onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, '' .))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''.))"/> 
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >Contact Number</label>
                                    <s:textfield name="contactno" id="contactno"  maxLength="11" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return isNumberserch(event)"/>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >User Role</label>
                                    <s:select  id="userrole" list="%{userroleList}"  name="userrole" headerKey="" headerValue="--Select User Role--" listKey="userrolecode" listValue="description" cssClass="form-control"/>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label >Status</label>
                                    <s:select  id="status" list="%{statusList}"  name="status" headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" value="%{status}" disabled="false" cssClass="form-control"/>
                                </div>
                            </div>
                        </div> 
                        <s:url var="addurl" action="viewpopupSystemUser"/>        
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group ali-margin">                                                 
                                    <sj:submit 
                                        button="true"
                                        value="Search" 
                                        href="#"
                                        onClickTopics="onclicksearch"  
                                        targets="message"
                                        id="searchbut"
                                        disabled="#vsearch"
                                        cssClass="btn btn-ali-submit btn-sm" 
                                        />

                                    <sj:submit 
                                        button="true" 
                                        value="Reset" 
                                        name="reset" 
                                        onClick="resetAllData()"
                                        cssClass="btn btn-ali-reset btn-sm"
                                        /> 

                                    <sj:submit 
                                        openDialog="remotedialog"
                                        button="true"
                                        href="%{addurl}"
                                        disabled="#vadd"
                                        value="Add System User"
                                        id="addButton_new"
                                        targets="remotedialog"   
                                        cssClass="btn f-right btn-ali-other btn-sm"
                                        />
                                </div>
                            </div>

                        </div> 
                    </s:form> 

                    <!--end newly changed-->             
                    <sj:dialog 
                        id="deletedialog" 
                        buttons="{ 
                        'OK':function() { deleteSystemUser($(this).data('keyval'));$( this ).dialog( 'close' ); },
                        'Cancel':function() { $( this ).dialog( 'close' );} 
                        }" 
                        autoOpen="false" 
                        modal="true" 
                        title="Delete System User"                            
                        />
                    <!-- Start delete process dialog box -->
                    <sj:dialog 
                        id="deletesuccdialog" 
                        buttons="{
                        'OK':function() { $( this ).dialog( 'close' );}
                        }"  
                        autoOpen="false" 
                        modal="true" 
                        title="Deleting Process." 
                        />

                    <sj:dialog                                     
                        id="updatedialog"                                 
                        autoOpen="false" 
                        modal="true" 
                        position="center"
                        title="Update System User"
                        onOpenTopics="openviewtasktopage" 
                        loadingText="Loading .."
                        width="900"
                        height="450"
                        dialogClass= "dialogclass"
                        />  

                    <sj:dialog                                     
                        id="changepwddialog"                                 
                        autoOpen="false" 
                        modal="true" 
                        title="System User Change Password"
                        onOpenTopics="openpwdchangetopage" 
                        loadingText="Loading .."
                        position="center"                            
                        width="900"
                        height="450"
                        dialogClass= "dialogclass"
                        /> 

                    <sj:dialog                                     
                        id="remotedialog"                                 
                        autoOpen="false" 
                        modal="true" 
                        title="Add System User"                            
                        loadingText="Loading .."                            
                        position="center"                            
                        width="900"
                        height="500"
                        dialogClass= "dialogclass"
                        />

                </div>

                 <div class="ali-table">
                    <s:url var="listurl" action="listSystemUser"/>
                    <s:set var="pcaption">${CURRENTPAGE}</s:set>

                    <sjg:grid
                        id="gridtable"
                        caption="%{pcaption}"
                        dataType="json"
                        href="%{listurl}"
                        pager="true"
                        gridModel="gridModel"
                        rowList="10,15,20"
                        rowNum="10"
                        autowidth="true"
                        rownumbers="true"
                        onCompleteTopics="completetopics"
                        rowTotal="false"
                        viewrecords="true"
                        onErrorTopics="anyerrors"
                        shrinkToFit="false"
                        >
                        <sjg:gridColumn name="username" index="username" title="Edit" width="35" align="center" formatter="editformatter" hidden="#vupdatelink" />
                        <sjg:gridColumn name="username" index="username" title="Delete" width="60" align="center" formatter="deleteformatter" hidden="#vdelete" />
                        <sjg:gridColumn name="username" index="username" title="Change Password"  align="center" formatter="changepasswordformatter" hidden="#vpasswordreset" />
                        <sjg:gridColumn name="username" index="username" title="Username"  sortable="true" />
                        <sjg:gridColumn name="fullname" index="fullname" title="Full Name"  sortable="true"/>
                        <sjg:gridColumn name="nic" index="nic" title="NIC"  sortable="true"/>
                        <sjg:gridColumn name="userrole" index="userrole.description" title="User Role"  sortable="true"/>

                        <sjg:gridColumn name="contactNo" index="mobile" title="Contact No"  sortable="true"/>
                        <sjg:gridColumn name="email" index="email" title="Email"  sortable="true"/>
                        <sjg:gridColumn name="serviceId" index="empid" title="Service ID"  sortable="true"/>

                        <sjg:gridColumn name="status" index="status.description" title="Status"  sortable="true"/>
                        <sjg:gridColumn name="createtime" index="u.createtime" title="Created Time"  sortable="true" />

                    </sjg:grid> 
                </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>