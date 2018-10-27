<%-- 
    Document   : systemuser
    Created on : 08/01/2014, 1:23:02 PM
    Author     : asitha_l
--%>

<%@page import="org.apache.struts2.ServletActionContext"%>
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

            // start newly changed
            function duplicatedadd(keyval) {
                $('#divmsg').empty();

                $("#adddialog").data('keyval', keyval).dialog('open');
                $("#adddialog").html('User already exists. Do you want to Activate merchant user : ' + keyval + ' ?');
                return false;
            }

            function editformatter(cellvalue) {
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');
                return "<a href='#' title='Edit' onClick='javascript:editMerchantCustomer(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                
                return "<a href='#/' title='Delete' onClick='javascript:deleteMerchantCustomerInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }


            function editMerchantCustomer(key) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findMerchantCustomer',
                    data: {mid: key},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsg').empty();
                        var msg = data.message;
                        if (msg) {

                            $('#newBox').empty();
                            $('#currentBox').empty();
                            $('#newBoxTran').empty();
                            $('#currentBoxTran').empty();

                            $('#mid').val("");
                            $('#mid').attr('readOnly', false);

                            $('#username').val("");

                            $('#status').val("");
                            $('#name').val("");
                            $('#email1').val("");
//                            $('#email2').val("");

                            $(".hideme").show();
                            $('#divmsg').text("");
                            $('#updateButton').button("disable");

                            var startStatus = <s:property value="vadd" />;
                            if (startStatus) {
                                $('#addButton').button("disable");
                            } else {
                                $('#addButton').button("enable");
                            }

                        }
                        else {
                            $('#oldvalue').val(data.oldvalue);
                            $('#newBox').empty();
                            $('#currentBox').empty();
                            $('#newBoxTran').empty();
                            $('#currentBoxTran').empty();

                            $('#mid').val(data.mid);
                            $('#mid').attr('readOnly', true);
                            $(".hideme").hide();

                            $('#username').val(data.username);
                            $('#status').val(data.status);
                            $('#status').prop("disabled", false);
                            $('#name').val(data.name);
                            $('#email1').val(data.email1);
//                            $('#email2').val(data.email2);

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

                            $.each(data.newListTran, function (key, value) {
                                $('#newBoxTran').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });
                            $.each(data.currentListTran, function (key, value) {
                                $('#currentBoxTran').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });

                            $('#addButton').button("disable");
                            $('#updateButton').button("enable");
                        }

                    },
                    error: function (data) {
                        //                        $("#deleteerrordialog").html("Error occurred while processing.").dialog('open');
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function deleteMerchantCustomerInit(keyval) {
                $('#divmsg').empty();
                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete merchant customer ' + keyval + ' ?');
                return false;
            }

            function deleteMerchantCustomer(keyval) {
//                alert(keyval);
                $.ajax({
                    url: '${pageContext.request.contextPath}/deleteMerchantCustomer',
                    data: {mid: keyval},
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

            function resetAllData() {
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

                if (a == true && u == true) {
                    editMerchantCustomer(null);
                    window.location = "${pageContext.request.contextPath}/viewMerchantCustomer.action?";
                    //                    $('#username').attr('readOnly',false);
                    //                    $('#username').val("");
                    //                    $('#password').val("");
                    //                    $('#confirmpassword').val("");
                    //                    $('#expirydate').val("");
                    //                    $('#userrole').val("");
                    //                    $('#dualauthuser').val("");
                    //                    $('#status').val("");
                    //                    $('#fullname').val("");
                    //                    $('#serviceid').val("");                                    
                    //                    $('#address1').val("");
                    //                    $('#address2').val("");
                    //                    $('#city').val("");
                    //                    $('#contactno').val("");
                    //                    $('#email').val("");
                    //                    $('#nic').val("");
                    //                    $('#dateofbirth').val("");   
                    //                    $(".hideme").show();
                    //                    $('#divmsg').text("");
                    //                    $('#addButton').button("disable");
                    //                    $('#updateButton').button("disable");
                } else if (a == true && u == false) {
                    var username = $('#username').val();
                    $('#username').attr('readOnly', true);
                    editMerchantCustomer(username);
                } else if (a == false && u == true) {
                    editMerchantCustomer(null);
                    window.location = "${pageContext.request.contextPath}/viewMerchantCustomer.action?";
                    //                    $('#username').attr('readOnly',false);
                    //                    $('#username').val("");
                    //                    $('#password').val("");
                    //                    $('#confirmpassword').val("");
                    //                    $('#expirydate').val("");
                    //                    $('#userrole').val("");
//                                        $('#dualauthuser').val("");
                    //                    $('#status').val("");
                    //                    $('#fullname').val("");
                    //                    $('#serviceid').val("");                                    
                    //                    $('#address1').val("");
                    //                    $('#address2').val("");
                    //                    $('#city').val("");
                    //                    $('#contactno').val("");
                    //                    $('#email').val("");
                    //                    $('#nic').val("");
                    //                    $('#dateofbirth').val("");    
                    //                    $(".hideme").show();
                    //                    $('#divmsg').text("");
                    //                    $('#addButton').button("enable");
                    //                    $('#updateButton').button("disable");  
                }
            }

            function resetFieldData() {
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

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

                if (a == true && u == true) {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                } else if (a == true && u == false) {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                } else if (a == false && u == true) {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                }

                jQuery("#gridtable").trigger("reloadGrid");
                $(".hideme").show();
            }


            function backToMain() {
                $('#pwdResetform').hide();
                $('#systemuseradd').show();
            }

            function cancelAllData() {
                editMerchantCustomer(null);
            }

            window.onload = function () {
                $("#username").css("color", "black");
                $("#expirydate").css("color", "#858585");
                $('#status').val("ACT");
            };


            function toright() {
                $("#currentBox option:selected").each(function () {

                    $("#newBox").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
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
            function torightall() {
                $("#currentBox option").each(function () {

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
            function clickAssignAdd() {

                $('#currentBox option').prop('selected', true);
                $('#newBox option').prop('selected', true);
                $("#assignbutAdd").click();
            }
            function clickAssign() {

                $('#currentBox option').prop('selected', true);
                $('#newBox option').prop('selected', true);
                $("#assignbut").click();
            }

            function torightTran() {
                $("#currentBoxTran option:selected").each(function () {

                    $("#newBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function toleftTran() {
                $("#newBoxTran option:selected").each(function () {

                    $("#currentBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function toleftallTran() {
                $("#newBoxTran option").each(function () {

                    $("#currentBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function torightallTran() {
                $("#currentBoxTran option").each(function () {

                    $("#newBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function clickAddMchantCus() {

                $('#newBox option').prop('selected', true);
                $('#newBoxTran option').prop('selected', true);
//                EraseDiv();
                $("#addbtnMerCus").click();
            }

        </script>

    </head>

    <body style="">
        <jsp:include page="/header.jsp"/>

        <div class="main-container">

            <jsp:include page="/leftmenu.jsp"/>

            <div class="main-content">

                <div class="container" style="min-height: 760px;">

                    <!-- start: PAGE NAVIGATION BAR -->
                    <jsp:include page="/navbar.jsp"/>
                    <!-- end: NAVIGATION BAR -->

                    <div class="row">

                        <div id="content1">

                            <s:div id="divmsg">

                                <s:actionerror theme="jquery"/>
                                <s:actionmessage theme="jquery"/>
                            </s:div>

                            <s:set id="vadd" var="vadd"><s:property value="vadd" default="true"/></s:set>
                            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
                            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
                            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>

                                <div id="formstyle">
                                <s:form id="systemuseradd" method="post" action="MerchantCustomer" theme="simple" >

                                    <table border="0" cellpadding="5">

                                        <tbody>

                                            <tr>
                                                <td>Merchant Customer Code<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="mid" id="mid" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Merchant Customer Name</td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield  name="username" id="username" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))"/>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>Status <span style="color: red"></span></td>
                                                <td style="width: 50px" ></td>
                                                <td>
                                                    <s:select  id="status" list="%{statusList}"  name="status" headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" cssStyle="width: 153px"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Email 1<span style="color: red"></span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield  name="email1" id="email1" maxLength="20" />
                                                </td>

                                            </tr> 
                                            <tr><td> <br> </td> </tr>
                                            <tr>    

                                                        <tr>
                                                            <td>Currency List</td>
                                                            <td style="width: 50px" ></td>
                                                            <td>Assigned Currency List</td>
                                                            <td style="width: 100px" ></td>
                                                            <td>Assigned Transaction(s)</td>
                                                            <td style="width: 50px" ></td>
                                                            <td>Blocked Transaction(s)</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="float: right;"><s:select multiple="true"
                                                                      name="currentBox" id="currentBox" list="currentList"									 
                                                                      ondblclick="toright()" style="height:120px;min-width:150px;" />
                                                            </td>
                                                            <td style="text-align: center; width: 50px"><sj:a
                                                                    id="right" onClick="toright()" button="true"
                                                                    style="font-size:10px;width:30px;margin:2px;"> > </sj:a> </br> <sj:a
                                                                    id="rightall" onClick="torightall()" button="true"
                                                                    style="font-size: 10px;width:30px;margin:2px;"> >> </sj:a></br> <sj:a
                                                                    id="left" onClick="toleft()" button="true"
                                                                    style="font-size:10px;width:30px;margin:2px;"><</sj:a></br> <sj:a
                                                                    id="leftall" onClick="toleftall()" button="true"
                                                                    style="font-size:10px;width:30px;margin:2px;"><<</sj:a>
                                                                </td>
                                                                <td style="float: left;"><s:select multiple="true"
                                                                      name="newBox" id="newBox" list="newList"									 
                                                                      ondblclick="toleft()" style="height:120px; min-width:150px;" />
                                                            </td> 

                                                            <td style="width: 100px" ></td>

                                                            <td style="float: right;"><s:select multiple="true"
                                                                      name="currentBoxTran" id="currentBoxTran" list="CurrentListTran"									 
                                                                      ondblclick="torightTran()" style="height:120px;min-width:150px;" />
                                                            </td>
                                                            <td style="text-align: center; width: 50px"><sj:a
                                                                    id="rightTran" onClick="torightTran()" button="true"
                                                                    style="font-size:10px;width:30px;margin:2px;"> > </sj:a> </br> <sj:a
                                                                    id="rightallTran" onClick="torightallTran()" button="true"
                                                                    style="font-size: 10px;width:30px;margin:2px;"> >> </sj:a></br> <sj:a
                                                                    id="leftTran" onClick="toleftTran()" button="true"
                                                                    style="font-size:10px;width:30px;margin:2px;"><</sj:a></br> <sj:a
                                                                    id="leftallTran" onClick="toleftallTran()" button="true"
                                                                    style="font-size:10px;width:30px;margin:2px;"><<</sj:a>
                                                                </td>
                                                                <td style="float: left;"><s:select multiple="true"
                                                                      name="newBoxTran" id="newBoxTran" list="NewListTran"									 
                                                                      ondblclick="toleftTran()" style="height:120px; min-width:150px;" />
                                                            </td> 
                                                        </tr>
                                                        <tr style="display: none; visibility: hidden;">
                                                            <td><s:url var="assignurl" action="AssignUserRolePrivilege" />
                                                                <sj:submit button="true" href="%{assignurl}" id="assignbut"
                                                                           targets="divmsg" /></td>
                                                        </tr>

                                            </tr>

                                            
                                            <tr>
                                                <td><span class="mandatoryfield">Mandatory fields are marked with *</span></td>
                                                <td><s:hidden id="oldvalue" name="oldvalue" ></s:hidden>
                                                    </td>
                                            </tr>
                                                
                                            <tr>
                                                    <td> <!s:url var="addurl" action="addMerchantCustomer"/>
                                                    <s:url var="updateurl" action="updateMerchantCustomer"/> </td>
                                                <td>
                                                    <div style="display: none; visibility: hidden;">
                                                        <s:url action="addMerchantCustomer" var="addurl"/>
                                                        <sj:submit button="true" href="%{addurl}" id="addbtnMerCus"  targets="divmsg"/>
                                                    </div>
                                                </td>

                                                <td>

                                                    <sj:submit button="true" href="%{addurl}" value="Add" onclick="clickAddMchantCus()" targets="divmsg" id="addButton"  disabled="#vadd"/>

                                                    <sj:submit button="true" href="%{updateurl}" value="Update" targets="divmsg"   disabled="#vupdatebutt" id="updateButton"/>

                                                    <sj:submit button="true" value="Reset" name="reset" onClick="resetAllData()"  />

                                                    <sj:submit button="true" value="Cancel" name="cancel" onClick="cancelAllData()"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table> 
                                </s:form>  
                            </div>           
                            <!--start newly changed-->
                            <sj:dialog 
                                id="adddialog" 
                                buttons="{ 
                                'OK':function() { AddUser($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Add User"                            
                                />
                            <!-- Start add process dialog box -->
                            <sj:dialog 
                                id="addsuccdialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}
                                }"  
                                autoOpen="false" 
                                modal="true" 
                                title="Adding Process." 
                                />
                            <!--end newly changed-->             

                            <!-- Start delete confirm dialog box -->
                            <sj:dialog 
                                id="deletedialog" 
                                buttons="{ 
                                'OK':function() { deleteMerchantCustomer($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete Merchant Customer"                            
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
                            <!-- Start delete error dialog box -->
                            <sj:dialog 
                                id="deleteerrordialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}                                    
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete error."
                                />

                            <div id="tablediv">
                                <s:url var="listurl" action="listMerchantCustomer"/>
                                <sjg:grid
                                    id="gridtable"
                                    caption="Merchant User Management"
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
                                    >
                                    <sjg:gridColumn name="mid" index="mid" title="MID"  sortable="true"/>
                                    <sjg:gridColumn name="username" index="username" title="User Name"  sortable="true"/>
                                    <sjg:gridColumn name="status" index="status.description" title="Status"  sortable="true"/>
                                    <sjg:gridColumn name="mid" index="mid" title="Edit" width="25" align="center" formatter="editformatter" hidden="#vupdatelink"/>
                                    <sjg:gridColumn name="mid" index="mid" title="Delete" width="40" align="center" formatter="deleteformatter"/>
                                    <%--<sjg:gridColumn name="usernameUserrole" index="username" title="Password Reset" width="60" align="center" formatter="changepasswordformatter"/>--%>
                                </sjg:grid> 
                            </div> 





                        </div>                                                     

                    </div>

                </div>

                <!-- end: PAGE CONTENT-->
            </div>
            <!--        </div>-->
            <!-- end: PAGE -->
        </div>
        <!-- end: MAIN CONTAINER -->
        <!-- start: FOOTER -->
        <jsp:include page="/footer.jsp"/>
        <!-- end: FOOTER -->



        <!-- end: BODY -->
    </body>
</html>
