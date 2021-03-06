<%-- 
    Document   : userrolemanagementinsert
    Created on : Jul 14, 2016, 9:29:07 AM
    Author     : samith_k
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add User Role</title>

        <script>
            function resetAllDataAdd() {

                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

                var startStatus = '<s:property value="vadd" />'
                $('#userRoleCode').val("");
                $('#userRoleCode').attr('readOnly', false);
                $("#userRoleCode").css("color", "black");
                $('#description').val("");
//                $('#userRoleLevel').val("");
//                $('#userRoleLevel').prop('disabled', false);
                $('#status').val("");
                //$('#status').prop('disabled', true);
                $('#amessage').text("");
                //               alert(" 2nd alert add status " + a  +" and updated stauts " + u);
                if (a == true && u == true) {
                    //                   alert("call 1st");
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                } else if (a == true && u == false && startStatus == 'false') {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                } else if (a == true && u == false && startStatus == 'true') {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                } else if (a == false && u == true) {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                }
                jQuery("#gridtable").trigger("reloadGrid");
            }




        </script>
    </head>
    <body>
        <div class="ali-modal">
            <s:div id="amessage">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>
            <div class="ali-modal-body">
                <div class="ali-form">
                    <s:form cssClass="form" id="userroleadd" method="post" action="UserRole" theme="simple" >
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label >User Role Code</label>
                                    <s:textfield value="%{userRoleCode}" name="userRoleCode" id="userRoleCode" cssClass="form-control" maxLength="4" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Description </label>
                                    <s:textfield  value="%{description}" name="description" id="description" maxLength="64" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Status </label>
                                    <s:select  value="%{status}" id="status" list="%{statusList}"  headerKey="" headerValue="--Select Status--" cssClass="form-control" name="status" listKey="statuscode" listValue="description"/>
                                </div>
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row ">
                            <div class="col-sm-6">
                                <div class="ali-mandatory-field">Mandatory fields are marked with <span>*</span></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group ali-margin f-right">
                                    <sj:submit 
                                        button="true" 
                                        value="Reset"
                                        id="canclebtn"
                                        onClick="resetAllDataAdd()"
                                        cssClass="btn btn-ali-reset btn-sm"
                                        />                          
                                    <s:url action="AddUserRole" var="inserturl"/>
                                    <sj:submit
                                        button="true"
                                        value="Add"
                                        href="%{inserturl}"
                                        targets="amessage"
                                        id="addbtn"
                                        cssClass="btn btn-ali-submit btn-sm"
                                        />                        
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>        
        </s:form>

    </body>
</html>
