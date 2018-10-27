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
            function editCandidate(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findCandidate.action',
                    data: {pageCode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#nic_Edit').val("");
                            $("#nic_Edit").css("color", "black");
                            $('#nic_Edit').attr('readOnly', false);
                            $('#fullnameEdit').val("");
                            $('#mobileEdit').val("");
                            $('#emailEdit').val("");
                            $('#statusEdit').val("");
                            $('#positionEdit').val("");
                            $('#divmsg').text("");
                        }
                        else {
                            $('#nic_Edit').val(data.nic);
                            $('#nic_Edit').attr('readOnly', true);
                            $('#descriptionEdit').val(data.description);
                            $('#fullnameEdit').val(data.fullname);
                            $('#emailEdit').val(data.email);
                            $('#emailEdit').val(data.email);
                            $('#emailEdit').val(data.email);
                            $('#mobileEdit').val(data.mobile); 
                            $('#remarksEdit').val(data.remarks);
                            $('#interviewdateEdit').val(data.interviewdate);
                            $('#statusEdit').attr('readOnly', true);
                            $('#positionEdit').val(data.position);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function cancelData() {
                var pageCode = $('#nic_Edit').val();
                editCandidate(pageCode);
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
                    <s:form id="pageedit" method="post" action="Candidate" theme="simple" cssClass="form" >
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>NIC</label>
                                    <s:textfield value="%{nic}" cssClass="form-control" name="nic" id="nicEdit" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" readonly="true"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Full Name</label>
                                    <s:textfield  value="%{fullname}" cssClass="form-control" name="fullname" id="fullnameEdit" maxLength="30" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Mobile</label>
                                    <s:textfield  value="%{mobile}" cssClass="form-control" name="mobile" id="mobileEdit" maxLength="15" />
                                    <!--<label>(ex: /YourCandidate)</label>-->
                                </div>
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row row_popup">
                            <div class="col-sm-4"> 
                                <div class="form-group">
                                    <label>Position</label>
                                    <s:select cssClass="form-control" name="position" id="positionEdit" headerValue="-- Select Position --" list="%{positionList}"   headerKey="" listKey="key" listValue="value" value="%{position}"/>
                                </div> 
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Status</label>
                                    <s:select value="%{status}" cssClass="form-control" name="status" id="statusEdit" list="%{statusList}"  headerValue="--Select Status--" headerKey="" listKey="statuscode" listValue="description" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Email</label>
                                    <s:textfield  value="%{email}" cssClass="form-control" name="email" id="emailEdit" maxLength="15" />
                                    <!--<label>(ex: /YourCandidate)</label>-->
                                </div>
                            </div>    
                        </div>  
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label >Date of Interview</label>
                                    <sj:datepicker value="%{interviewdate}" cssClass="form-control" id="interviewdateEdit" name="interviewdate" 
                                                   readonly="true"  changeYear="false" buttonImageOnly="true" displayFormat="yy-mm-dd" yearRange="1950:2200" timepicker="true" 
                                                   timepickerFormat="hh:mm"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Remarks</label>
                                    <s:textfield cssClass="form-control" name="remarks" id="remarksEdit" maxLength="50" />
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
                                    <s:url action="updateCandidate" var="updateturl"/>
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


