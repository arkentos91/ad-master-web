<%-- 
    Document   : eodconfiguration
    Created on : Jun 11, 2018, 2:19:42 PM
    Author     : sivaganesan_t
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/stylelinks.jspf" %>
        <title>EOD Configuration</title>
        <script>
            function resetFieldData() {

            }
            function editSystemUser(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findEODConfiguration.action',
                    data: {id: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsg').empty();
                        var msg = data.message;
                        if (msg) {
                            //                                                        alert(data.message)
                            $('#id').attr('readOnly', false);
                            $('#id').val("");
                            $('#alipaysettlementfile').val("");
                            $('#merchantsettlementfile').val("");
                            $('#txnamounttolerance').val("");
                            $('#txnadaystolerance').val("");
                            $('#bmlBankCode').val("");
                            $('#eodlogpath').val("");
                            $('#branchid').val("");

                        } else {
//                            $('#oldvalue').val(data.oldvalue);
                            $('#id').val(data.id);
                            $('#id').attr('readOnly', true);
                            $('#alipaysettlementfile').val(data.alipaysettlementfile);
                            $('#merchantsettlementfile').val(data.merchantsettlementfile);
                            $('#txnamounttolerance').val(data.txnamounttolerance);
                            $('#txnadaystolerance').val(data.txnadaystolerance);
                            $('#bmlBankCode').val(data.bmlBankCode);
                            $('#eodlogpath').val(data.eodlogpath);
                            $('#branchid').val(data.branchid);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }
            function cancelData() {
                var id = $('#id').val();
                editSystemUser(id);
            }
        </script>
    </head>
    <body style="">
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>
        <div class="ali-body f-right ali-header-text">

            <s:div id="divmsg">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>

            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>

                <div class="ali-form">
                <s:form id="configupdate" method="post" action="EODConfiguration" theme="simple" cssClass="form" >
                    <div class="row ">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>ID </label>

                                <s:textfield cssClass="form-control" name="id" id="id" maxLength="4" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" readonly="true" />

                                <s:hidden name="oldvalue"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Alipay Settlement File Path</label>
                                <s:textfield  cssClass="form-control" name="alipaysettlementfile" id="alipaysettlementfile" maxLength="128" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Merchant Settlement File Path</label>
                                <s:textfield  cssClass="form-control" name="merchantsettlementfile" id="merchantsettlementfile" maxLength="128"/>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Txn Amount Tolerance </label>
                                <s:textfield cssClass="form-control" name="txnamounttolerance" id="txnamounttolerance" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Txn Days Tolerance </label>
                                <s:textfield cssClass="form-control" name="txnadaystolerance" id="txnadaystolerance" maxLength="3" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>BML Bank Code</label>
                                <s:textfield cssClass="form-control" name="bmlBankCode" id="bmlBankCode" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))"/>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>EOD Log Path</label>
                                <s:textfield cssClass="form-control" name="eodlogpath" id="eodlogpath" maxLength="128"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <span style="color: red">*</span><label>Branch ID</label>
                                <s:textfield cssClass="form-control" name="branchid" id="branchid" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))"/>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-8">
                            <label class="control-label" >Mandatory fields are marked with </label><span style="color: red">*</span>
                            
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">
                                <sj:submit 
                                    button="true" 
                                    value="Reset" 
                                    onClick="cancelData()"
                                    cssClass="btn btn-ali-reset btn-sm"
                                    />                          

                                <s:url action="updateEODConfiguration" var="updateturl"/>
                                <sj:submit
                                    button="true"
                                    value="Update"
                                    href="%{updateturl}"
                                    disabled="#vupdatebutt"
                                    targets="divmsg"
                                    id="updateButton"
                                    cssClass="btn btn-ali-submit btn-sm"
                                    />  
                            </div>
                        </div>
                    </div>
                </s:form>
            </div>
        </div>
    </body>
</html>
