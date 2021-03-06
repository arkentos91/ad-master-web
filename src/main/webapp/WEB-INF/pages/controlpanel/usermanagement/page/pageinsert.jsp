<%-- 
    Document   : pageinsert
    Created on : Jul 18, 2016, 10:56:14 AM
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
            $.subscribe('resetAddButton', function (event, data) {
                $('#pageCode').val("");
                $('#description').val("");
                $('#url').val("");
                $('#sortKey').val("");
                $('#status').val("");
                $('#amessage').empty();
            });
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
                    <s:form id="pageadd" method="post" action="Page" theme="simple" cssClass="form" >
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label class="control-label">Page Code </label>
                                    <s:textfield cssClass="form-control" name="pageCode" id="pageCode" maxLength="4" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Description</label>
                                    <s:textfield cssClass="form-control" name="description" id="description" maxLength="30" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>URL</label>
                                    <s:textfield cssClass="form-control" name="url" id="url" maxLength="128" />
                                    <label>(ex: /YourPage)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Sort Key </label>
                                    <s:textfield cssClass="form-control" name="sortKey" id="sortKey" maxLength="2" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Status</label>
                                    <s:select cssClass="form-control" id="status" list="%{statusList}"  headerValue="--Select Status--" headerKey="" name="status" listKey="statuscode" listValue="description" />
                                </div>
                            </div>
                        </div>  
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="ali-mandatory-field">Mandatory fields are marked with <span>*</span></div>
                            </div>
                        </div>
                        <s:url action="addPage" var="inserturl"/>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group ali-margin f-right">
                                    <sj:submit 
                                        button="true" 
                                        value="Reset" 
                                        name="reset" 
                                        cssClass="btn btn-ali-reset btn-sm"
                                        onClickTopics="resetAddButton"
                                        />    

                                    <sj:submit
                                        button="true"
                                        value="Add"
                                        href="%{inserturl}"
                                        onClickTopics=""
                                        targets="amessage"
                                        id="addbtn"
                                        cssClass="btn btn-ali-submit btn-sm"             
                                        />   
                                </div>
                            </div>
                        </div>
                    </s:form>
                </div>
            </div>
        </div>
    </body>
</html>

