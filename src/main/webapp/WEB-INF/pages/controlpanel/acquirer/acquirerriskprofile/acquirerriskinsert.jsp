<%-- 
    Document   : acquirerriskinsert
    Created on : Mar 30, 2018, 1:26:53 PM
    Author     : sivaganesan_t
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html>
<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link rel="stylesheet" href="resouces/css/common/common_popup.css">-->
        <title>Insert Acquirer Risk Profile</title>  

        <script type="text/javascript">

            function removeformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Delete' onClick='javascript:removeAcquirerRiskInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }
            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:edittxnAcquirerRisk(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function removeAcquirerRiskInit(keyval) {
                $("#gridtabletxn").jqGrid('setGridParam', {postData: {
                        transactiontype: keyval,
                        isAssign: 'remove'
                    }});
                $("#gridtabletxn").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxn").trigger("reloadGrid");
            }

            $.subscribe('anyerrorsremove', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function edittxnAcquirerRisk(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findtxnAcquirerRiskProfile.action',
                    data: {transactiontype: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsgadd').empty();
                        var msg = data.message;
                        if (msg) {

                            $('#transactiontype').prop('disabled', true);
                            $('#transactiontype').val(data.transactiontype);
                            $('#daillyCount').val(data.daillyCount);
                            $('#daillyAmount').val(data.daillyAmount);
                            $('#maxAmount').val(data.maxAmount);
                            $('#minAmount').val(data.minAmount);
                            $('#divmsgadd').text("");
                        }
                        else {
                            $('#transactiontype').prop('disabled', true);
                            $('#transactiontype').val(data.transactiontype);
                            $('#daillyCount').val(data.daillyCount);
                            $('#daillyAmount').val(data.daillyAmount);
                            $('#maxAmount').val(data.maxAmount);
                            $('#minAmount').val(data.minAmount);
                            $('#assignbtn').hide();
                            $('#assignbtnhidden').show();
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function assignTxnRisk() {

                var transactiontype = $('#transactiontype').val();
                var daillyCount = $('#daillyCount').val();
                var daillyAmount = $('#daillyAmount').val();
                var maxAmount = $('#maxAmount').val();
                var minAmount = $('#minAmount').val();
                var profileCode = $('#profileCode').val();
                var description = $('#description').val();
                var status = $('#status').val();
                var riskprofileType = $('#riskprofileType').val();
                var riskprofilecurrency = $('#riskprofilecurrency').val();

                $("#gridtabletxn").jqGrid('setGridParam', {postData: {
                        profileCode: profileCode,
                        description: description,
                        riskprofilecurrency: riskprofilecurrency,
                        status: status,
                        riskprofileType: riskprofileType,
                        transactiontype: transactiontype,
                        daillyCount: daillyCount,
                        daillyAmount: daillyAmount,
                        maxAmount: maxAmount,
                        minAmount: minAmount,
                        isAssign: 'assign'
                    }});

                $("#gridtabletxn").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxn").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setmessageAcquirerRiskProfile.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#divmsgadd').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");
                        } else {
                            $('#transactiontype').val("");
                            $('#daillyCount').val("");
                            $('#daillyAmount').val("");
                            $('#maxAmount').val("");
                            $('#minAmount').val("");
                            $('#divmsgadd').empty();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function assignTxnRiskUpdate() {
                var transactiontype = $('#transactiontype').val();
                var daillyCount = $('#daillyCount').val();
                var daillyAmount = $('#daillyAmount').val();
                var maxAmount = $('#maxAmount').val();
                var minAmount = $('#minAmount').val();
                var profileCode = $('#profileCode').val();
                var description = $('#description').val();
                var status = $('#status').val();
                var riskprofilecurrency = $('#riskprofilecurrency').val();
                var riskprofileType = $('#riskprofileType').val();

                $("#gridtabletxn").jqGrid('setGridParam', {postData: {
                        profileCode: profileCode,
                        description: description,
                        riskprofilecurrency: riskprofilecurrency,
                        status: status,
                        riskprofileType: riskprofileType,
                        transactiontype: transactiontype,
                        daillyCount: daillyCount,
                        daillyAmount: daillyAmount,
                        maxAmount: maxAmount,
                        minAmount: minAmount,
                        isAssign: 'update'
                    }});

                $("#gridtabletxn").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxn").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setmessageAcquirerRiskProfile.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#divmsgadd').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");
                            $('#assignbtn').hide();
                            $('#assignbtnhidden').show();
                        } else {
                            $('#transactiontype').prop('disabled', false);
                            $('#transactiontype').val("");
                            $('#transactiontype').val("");
                            $('#daillyCount').val("");
                            $('#daillyAmount').val("");
                            $('#maxAmount').val("");
                            $('#minAmount').val("");
                            $('#divmsgadd').empty();
                            $('#assignbtn').show();
                            $('#assignbtnhidden').hide();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function resetAllData() {
                $('#profileCode').val("");
                $('#profileCode').attr('readOnly', false);
                $('#description').val("");
                $('#status').val("");
                $('#riskprofilecurrency').val("");
                $('#divmsgadd').text("");
                $('#riskprofileType').val("");
                $('#transactiontype').prop('disabled', false);
                $('#transactiontype').val("");
                $('#daillyCount').val("");
                $('#daillyAmount').val("");
                $('#maxAmount').val("");
                $('#minAmount').val("");
                $("#gridtabletxn").jqGrid('setGridParam', {postData: {
                        transactiontype: '',
                        daillyCount: '',
                        daillyAmount: '',
                        maxAmount: '',
                        minAmount: '',
                        isAssign: 'clear'
                    }});
                $("#gridtabletxn").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxn").trigger("reloadGrid");
            }


            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });
            function formatNumber(num) {
                var renum = num.replace(/[^0-9]/g, '');
                return renum.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
            }
            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k >= 48 && k <= 57));
            }

            //global variables for previous height
            var height_a;
            var height_u;
            $("#min").hide();
            // maximize popup dialog 
            function maximize(width, height) {
                $(window).scrollTop(0);
                height_a = $("#remotedialog").height();
                height_u = $("#updatedialog").height();
                $("#remotedialog").height($(window).height() - 60);
                $("#updatedialog").height($(window).height() - 60);
                $(".ui-dialog").width($(window).width() - 40);
                $(".ui-dialog").height($(window).height() - 20);
                $("#gridtabletxn").jqGrid('setGridWidth', $(".ui-dialog").width() - 44); //set grid size
                $(".ui-dialog").center();
                $("#max").hide();
                $("#min").show();
            }
            // reset to previous popup dialog
            function resetwindow() {
                $(window).scrollTop(0);
                $("#remotedialog").height(height_a);
                $("#updatedialog").height(height_u);
                $(".ui-dialog").width("900");
                $(".ui-dialog").height("590");
                $("#gridtabletxn").jqGrid('setGridWidth', $(".ui-dialog").width() - 44); //reset grid size
                $(".ui-dialog").center();
                $("#max").show();
                $("#min").hide();
            }
            //center popup dialog
            jQuery.fn.center = function () {
                this.css("position", "fixed");
                this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) +
                        $(window).scrollTop()) + "px");
                this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) +
                        $(window).scrollLeft()) + "px");
                return this;
            };

        </script>

    </head>

    <body>
        <div class="ali-modal">
            <!--maximize and minimize buttons-->
            <div class="col-sm-12">
                <div style="text-align: right">
                    <sj:submit 
                        id="max"
                        button="true" 
                        value="Maximize" 
                        onClick="maximize()"
                        onClickTopics="Maximize"
                        cssStyle="height: 16px;padding: 1px;width: 55px;font-size: 11px;background: orange;color: white;border-color: gray;"
                        />                          
                    <sj:submit 
                        id="min"
                        button="true" 
                        value="Minimize" 
                        onClick="resetwindow()"
                        onClickTopics="Minimize"
                        cssStyle="height: 16px;padding: 1px;width: 55px;font-size: 11px;background: orange;color: white;border-color: gray;"
                        />                     
                </div>
            </div>
            <!---------->
            <div class="ali-modal-body">
                <div class="ali-form">
                    <s:div id="divmsgadd">
                        <s:actionerror theme="jquery"/>
                        <s:actionmessage theme="jquery"/>
                    </s:div>
                    <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>

                    <s:form id="acquirerriskprofileadd" method="post" action="AcquirerRisk" theme="simple">

                        <div class="row row_popup"> 
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Risk Profile Code</label>
                                    <s:textfield name="profileCode" id="profileCode" maxLength="4" cssClass="form-control" />                    
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Description</label>
                                    <s:textfield  name="description" id="description" maxLength="50" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))"/>
                                </div>                                      
                            </div> 

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Risk Profile Type</label>
                                    <s:select  id="riskprofileType" list="%{acquirerRiskprofileTypeList}"  name="riskprofileType"  headerValue="--Select Risk Profile Type--" headerKey="" listKey="profileType" listValue="description"  cssClass="form-control"/>
                                </div>
                            </div>     
                        </div>
                        <div class="row row_popup">    

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Status</label>
                                    <s:select value="%{status}" headerValue="--Select Status--" headerKey="" cssClass="form-control"  id="status" list="%{statusList}"  name="status" listKey="statuscode" listValue="description"/>                  
                                </div>
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="horizontal_line_popup"></div>
                        </div>
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Transaction Type</label>
                                    <s:select  id="transactiontype" list="%{transactiontypeList}"  name="transactiontype"  headerValue="--Select Transaction Type--" headerKey="" listKey="typecode" listValue="description"  cssClass="form-control"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Min Amount</label>
                                    <s:textfield name="minAmount" id="minAmount" maxLength="20" cssClass="form-control" 
                                                 onkeyup="$(this).val(formatNumber($(this).val()))" 
                                                 onmouseout="$(this).val(formatNumber($(this).val()))" 
                                                 onkeypress="return alpha(event)"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Max Amount</label>
                                    <s:textfield  name="maxAmount" id="maxAmount" maxLength="20" cssClass="form-control" 
                                                  onkeyup="$(this).val(formatNumber($(this).val()))" 
                                                  onmouseout="$(this).val(formatNumber($(this).val()))" 
                                                  onkeypress="return alpha(event)"/>
                                </div>                                      
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Daily Count</label>
                                    <s:textfield name="daillyCount" id="daillyCount" maxLength="20" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))"/>                    
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Daily Amount</label>
                                    <s:textfield  name="daillyAmount" id="daillyAmount" maxLength="20" cssClass="form-control"
                                                  onkeyup="$(this).val(formatNumber($(this).val()))" 
                                                  onmouseout="$(this).val(formatNumber($(this).val()))" 
                                                  onkeypress="return alpha(event)"/>
                                </div>                                      
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group ali-margin f-right">
                                    <sj:submit
                                        button="true"
                                        value="Assign"
                                        id="assignbtn"
                                        onClick="assignTxnRisk()"
                                        cssClass="btn btn-ali-submit btn-sm"          
                                        />
                                    <sj:submit
                                        button="true"
                                        value="Assign"
                                        id="assignbtnhidden"
                                        onClick="assignTxnRiskUpdate()"
                                        cssClass="btn btn-ali-submit btn-sm"
                                        cssStyle="display:none"                             
                                        />
                                </div>
                            </div>
                        </div>
                        <div id="tablediv">
                            <s:url var="listurl" action="assignAcquirerRiskProfile"/>
                            <sjg:grid
                                id="gridtabletxn"
                                caption="Acquirer Risk Profile Transaction"
                                dataType="json"
                                href="%{listurl}"
                                pager="true"
                                gridModel="gridModelTxn"
                                rowList="10,15,20"
                                targets="divmsgadd"
                                rowNum="10"
                                autowidth="true"
                                rownumbers="true"
                                onCompleteTopics="completetopics"
                                rowTotal="false"
                                viewrecords="true"
                                shrinkToFit="true"
                                >
                                <sjg:gridColumn name="txnType" index="txnType" title="Transaction Type"  sortable="false" hidden="true"/>
                                <sjg:gridColumn name="txnTypeDes" index="txnTypeDes" title="Transaction Type" sortable="false"/>
                                <sjg:gridColumn name="minAmount" index="minAmount" title="Min Amount"  sortable="false"/>
                                <sjg:gridColumn name="maxAmount" index="maxAmount" title="Max Amount"  sortable="false"/>
                                <sjg:gridColumn name="dailyCount" index="dailyAmount" title="Daily Count"  sortable="false"/>
                                <sjg:gridColumn name="dailyAmount" index="dailyAmount" title="Daily Amount"  sortable="false"/>
                                <sjg:gridColumn name="txnType" index="txnType" title="Edit" width="25" align="center" sortable="false" formatter="editformatter" hidden="#vupdatelink"/>
                                <sjg:gridColumn name="txnType" index="txnType" title="Delete" width="40" align="center" sortable="false" formatter="removeformatter" hidden="#vdelete"/> 
                            </sjg:grid> 
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
                                        onClick="resetAllData()"
                                        name="reset" 
                                        cssClass="btn btn-ali-reset btn-sm"
                                        onClickTopics="resetAddButton"
                                        />                          
                                    <s:url action="addAcquirerRiskProfile" var="inserturl"/>
                                    <sj:submit
                                        button="true"
                                        value="Add"
                                        href="%{inserturl}"
                                        onClickTopics=""
                                        targets="divmsgadd"
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
