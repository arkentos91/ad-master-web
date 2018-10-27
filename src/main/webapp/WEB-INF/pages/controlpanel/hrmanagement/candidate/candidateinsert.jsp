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
                $('#interviewdate').val("");
                $('#remarks').val("");
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
                    <s:form id="pageadd" method="post" action="Candidate" theme="simple" cssClass="form" >
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label class="control-label">NIC</label>
                                    <s:textfield cssClass="form-control" name="nic" id="nic" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Full Name</label>
                                    <s:textfield cssClass="form-control" name="fullname" id="fullname" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4"> 
                                <div class="form-group">
                                    <label>Position</label>
                                    <s:select cssClass="form-control" name="position" id="position_Search" headerValue="-- Select Position --" list="%{positionList}"   headerKey="" listKey="key" listValue="value" value="%{position}"/>
                                </div> 
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Mobile</label>
                                    <s:textfield cssClass="form-control" name="mobile" id="mobile" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Email</label>
                                    <s:textfield cssClass="form-control" name="email" id="email" maxLength="50" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label >Date of Interview</label>
                                    <sj:datepicker value="%{interviewdate}" cssClass="form-control" id="iinterviewdate" name="interviewdate" 
                                                   readonly="true"  changeYear="false" buttonImageOnly="true" displayFormat="yy-mm-dd" yearRange="1950:2200" timepicker="true" 
                                                   timepickerFormat="hh:mm"/>
                                </div>
                            </div>
                        </div>  
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Remarks</label>
                                    <s:textfield cssClass="form-control" name="remarks" id="remarks" maxLength="50" />
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
                        <s:url action="addCandidate" var="inserturl"/>
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

