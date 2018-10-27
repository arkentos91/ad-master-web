<%-- 
    Document   : pageedit
    Created on : Jul 18, 2016, 10:55:53 AM
    Author     : dilanka_w
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Task</title> 
        <script type="text/javascript">
            function editPage(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findPage.action',
                    data: {pageCode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#pageCodeEdit').val("");
                            $("#pageCodeEdit").css("color", "black");
                            $('#pageCodeEdit').attr('readOnly', false);
                            $('#descriptionEdit').val("");
                            $('#sortKeyEdit').val("");
                            $('#statusEdit').val("");
                            $('#urlEdit').val("");
                            $('#divmsg').text("");
                        }
                        else {
                            $('#pageCodeEdit').val(data.pageCode);
                            $('#pageCodeEdit').attr('readOnly', true);
                            $('#descriptionEdit').val(data.description);
                            $('#urlEdit').val(data.url);
                            $('#statusEdit').val(data.status);
                            $('#statusEdit').attr('readOnly', true);
                            $('#sortKeyEdit').val(data.sortKey);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function cancelData() {
                var pageCode = $('#pageCodeEdit').val();
                editPage(pageCode);
            }

        </script>
    </head>
    <body>
        <div class="ali-modal">
            <s:div id="amessageedit">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>
            <div class="ali-modal-body">
                <div class="ali-form">
                    <s:form id="pageedit" method="post" action="Page" theme="simple" cssClass="form" >
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Page Code </label>
                                    <s:textfield value="%{pageCode}" cssClass="form-control" name="pageCode" id="pageCodeEdit" maxLength="4" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" readonly="true"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Description</label>
                                    <s:textfield  value="%{description}" cssClass="form-control" name="description" id="descriptionEdit" maxLength="30" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>URL</label>
                                    <s:textfield  value="%{url}" cssClass="form-control" name="url" id="urlEdit" maxLength="128" />
                                    <label>(ex: /YourPage)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Sort Key </label>
                                    <s:textfield  value="%{sortKey}" cssClass="form-control" name="sortKey" id="sortKeyEdit" maxLength="2" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Status</label>
                                    <s:select value="%{status}" cssClass="form-control" name="status" id="statusEdit" list="%{statusList}"  headerValue="--Select Status--" headerKey="" listKey="statuscode" listValue="description" />
                                </div>
                            </div>
                        </div>  
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row row_popup ">
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
                                        onClick="cancelData()"
                                        cssClass="btn btn-ali-reset btn-sm"
                                        />                                
                                    <s:url action="updatePage" var="updateturl"/>
                                    <sj:submit
                                        button="true"
                                        value="Update"
                                        href="%{updateturl}"
                                        targets="amessageedit"
                                        id="updateButton"
                                        cssClass="btn btn-ali-submit btn-sm"
                                        />  
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </s:form>
        </div>
    </body>
</html>


