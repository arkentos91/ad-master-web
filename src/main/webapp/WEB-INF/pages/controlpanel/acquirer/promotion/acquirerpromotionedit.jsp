<%-- 
    Document   : acquirerpromotionedit
    Created on : Sep 20, 2016, 12:24:41 PM
    Author     : dilanka_w
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
        <title>Acquirer promotion Edit</title>

        <script>

            //global variables for previous height
            var height_a;
            var height_u;
            $("#min2").hide();
            // maximize popup dialog 
            function maximize(width, height) {
                $(window).scrollTop(0);
                height_a = $("#updatedialog").height();
                //height_u = $("#updatedialog").height();
                //$("#remoteadddialog").height($(window).height() - 60);
                $("#updatedialog").height($(window).height() - 60);
                $(".ui-dialog").width($(window).width() - 40);
                $(".ui-dialog").height($(window).height() - 20);
                console.log($(".horizontal_line_popup").width());
                $("#gridtabletxnedit").jqGrid('setGridWidth', $(".ui-dialog").width() - 44);//set grid size
                $(".ui-dialog").center();
                $("#max2").hide();
                $("#min2").show();
            }
            // reset to previous popup dialog
            function resetwindow() {
                $(window).scrollTop(0);
                //$("#remoteadddialog").height(height_a);
                $("#updatedialog").height(height_a);
                $(".ui-dialog").width("900");
                $(".ui-dialog").height("590");
                $("#gridtabletxnedit").jqGrid('setGridWidth', $(".ui-dialog").width() - 44);//reset grid size
                $(".ui-dialog").center();
                $("#max2").show();
                $("#min2").hide();
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


            function removeformatterupdate(cellvalue, options, rowObject) {
                return "<a href='#' title='Delete' onClick='javascript:removeAcquirerPromotionInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editformatterupdate(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editAcquirerPromotionTxnEdit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editAcquirerPromotionTxnEdit(keyval) {

                $.ajax({
                    url: '${pageContext.request.contextPath}/findAssignAcquirerPromotion.action',
                    data: {txnType: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#txnTypeedit').val(data.txnType);
                            $('#txnTypeedit').attr('disabled', true);
                            $('#bankAmountTypeedit').val(data.bankAmountType);
                            $('#bankAmountedit').val(data.bankAmount);
                            $('#merchantAmountTypeedit').val(data.merchantAmountType);
                            $('#merchantAmountedit').val(data.merchantAmount);
                            $('#amessageedit').text("");
                        }
                        else {
                            $('#txnTypeedit').val(data.txnType);
                            $('#txnTypeedit').attr('disabled', true);
                            $('#bankAmountTypeedit').val(data.bankAmountType);
                            $('#bankAmountedit').val(data.bankAmount);
                            $('#merchantAmountTypeedit').val(data.merchantAmountType);
                            $('#merchantAmountedit').val(data.merchantAmount);

                            $('#assignbtnedit').hide();
                            $('#assignbtnhiddenedit').show();
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function removeAcquirerPromotionInit(keyval) {

                $("#gridtabletxnedit").jqGrid('setGridParam', {postData: {
                        txnType: keyval,
                        isAssign: 'remove'
                    }});

                $("#gridtabletxnedit").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxnedit").trigger("reloadGrid");
            }

            $.subscribe('anyerrorsremove', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function cancelDataEdit() {

                var code = $('#codeedit').val();
                var promotioncurrency = $('#currencycodeedit').val();
                editAcquirerPromotionEdit(code, promotioncurrency);
            }

            function assignAcquirerPromotionEdit() {

                $('#amessageedit').empty();
                var codeedit = $('#codeedit').val();
                var descriptionedit = $('#descriptionedit').val();
                var statusedit = $('#statusedit').val();
                var txnTypeedit = $('#txnTypeedit').val();
                var bankAmountTypeedit = $('#bankAmountTypeedit').val();
                var bankAmountedit = $('#bankAmountedit').val();
                var merchantAmountTypeedit = $('#merchantAmountTypeedit').val();
                var promotioncurrency = $('#currencycodeedit').val();
                var merchantAmountedit = $('#merchantAmountedit').val();

                $("#gridtabletxnedit").jqGrid('setGridParam', {postData: {
                        code: codeedit,
                        promotioncurrency: promotioncurrency,
                        description: descriptionedit,
                        status: statusedit,
                        txnType: txnTypeedit,
                        bankAmountType: bankAmountTypeedit,
                        bankAmount: bankAmountedit,
                        merchantAmountType: merchantAmountTypeedit,
                        merchantAmount: merchantAmountedit,
                        isAssign: 'assign'
                    }
                });


                $("#gridtabletxnedit").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxnedit").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setMessageAcquirerPromotion.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#amessageedit').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");

                        } else {
                            $('#txnTypeedit').val("");
                            $('#bankAmountTypeedit').val("");
                            $('#bankAmountedit').val("");
                            $('#merchantAmountTypeedit').val("");
                            $('#merchantAmountedit').val("");
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function assignAcquirerPromotionEditUpdate() {

                var codeedit = $('#codeedit').val();
                var promotioncurrency = $('#currencycodeedit').val();
                var descriptionedit = $('#descriptionedit').val();
                var statusedit = $('#statusedit').val();
                var txnTypeedit = $('#txnTypeedit').val();
                var bankAmountTypeedit = $('#bankAmountTypeedit').val();
                var bankAmountedit = $('#bankAmountedit').val();
                var merchantAmountTypeedit = $('#merchantAmountTypeedit').val();
                var merchantAmountedit = $('#merchantAmountedit').val();

                $("#gridtabletxnedit").jqGrid('setGridParam', {postData: {
                        code: codeedit,
                        promotioncurrency: promotioncurrency,
                        description: descriptionedit,
                        status: statusedit,
                        txnType: txnTypeedit,
                        bankAmountType: bankAmountTypeedit,
                        bankAmount: bankAmountedit,
                        merchantAmountType: merchantAmountTypeedit,
                        merchantAmount: merchantAmountedit,
                        isAssign: 'update'
                    }});

                $("#gridtabletxnedit").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtabletxnedit").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setMessageAcquirerPromotion.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#amessageedit').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");
                            $('#assignbtnedit').hide();
                            $('#assignbtnhiddenedit').show();
                        } else {
                            $('#txnTypeedit').prop('disabled', false);
                            $('#txnTypeedit').val("");
                            $('#bankAmountTypeedit').val("");
                            $('#bankAmountedit').val("");
                            $('#merchantAmountTypeedit').val("");
                            $('#merchantAmountedit').val("");

                            $('#amessageedit').empty();

                            $('#assignbtnedit').show();
                            $('#assignbtnhiddenedit').hide();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function editAcquirerPromotionEdit(keyval, promotioncurrency) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findAcquirerPromotion.action',
                    data: {code: keyval, promotioncurrency: promotioncurrency},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {

                            $('#codeedit').val("");
                            $('#descriptionedit').val("");
                            $('#promotioncurrencyedit').val("");
                            $('#currencycodeedit').val("");
                            $('#statusedit').val("");

                            $('#txnTypeedit').val("");
                            $('#bankAmountTypeedit').val("");
                            $('#bankAmountedit').val("");
                            $('#merchantAmountTypeedit').val("");
                            $('#merchantAmountedit').val();

                            $('#amessageedit').text("");
                        }
                        else {

                            $('#codeedit').val(data.code);
                            $('#descriptionedit').val(data.description);
                            $('#promotioncurrencyedit').val(data.promotioncurrency);
                            $('#currencycodeedit').val(data.promotioncurrency);
                            $('#statusedit').val(data.status);

                            $('#assignbtnedit').show();
                            $('#assignbtnhiddenedit').hide();

                            $('#txnTypeedit').val("");
                            $('#txnTypeedit').attr('disabled', false);
                            $('#bankAmountTypeedit').val("");
                            $('#bankAmountedit').val("");
                            $('#merchantAmountTypeedit').val("");
                            $('#merchantAmountedit').val("");

                            $('#amessageedit').text("");

                            $("#gridtabletxnedit").jqGrid('setGridParam', {postData: {
                                    txnType: '',
                                    isAssign: 'init'
                                }});

                            $("#gridtabletxnedit").jqGrid('setGridParam', {page: 1});
                            jQuery("#gridtabletxnedit").trigger("reloadGrid");
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function checkBankAmount(key) {

                var bankAmountType = $('#bankAmountTypeedit').val();

                if ((bankAmountType == "PER") && (key != null || key != "")) {
                    var x = parseFloat(key);
                    if (isNaN(x) || x < 0 || x > 100) {
                        // value is out of range
                        //alert("******* value is out of range " + key);
                        $('#bankAmountedit').val("");
                    } else {
                        //alert("hip hip huree bank");
                    }
                }
            }

            function checkMerchantAmount(key) {

                var merchantAmountType = $('#merchantAmountTypeedit').val();

                if ((merchantAmountType == "PER") && (key != null || key != "")) {
                    var x = parseFloat(key);
                    if (isNaN(x) || x < 0 || x > 100) {
                        // value is out of range
                        //alert("******* value is out of range " + key);
                        $('#merchantAmountedit').val("");
                    } else {
                        //alert("hip hip huree merchant");
                    }
                }

            }

            function checkBankAmountByType(key) {

                var bankAmount = $('#bankAmountedit').val();

                if ((key == "PER") && (bankAmount != null || bankAmount != "")) {
                    var x = parseFloat(bankAmount);
                    if (isNaN(x) || x < 0 || x > 100) {
                        // value is out of range
                        //alert("******* value is out of range " + key);
                        $('#bankAmountedit').val("");
                    } else {
                        //alert("hip hip huree bank");
                    }
                }
            }

            function checkMerchantAmountByType(key) {

                var merchantAmount = $('#merchantAmountedit').val();

                if ((key == "PER") && (merchantAmount != null || merchantAmount != "")) {
                    var x = parseFloat(merchantAmount);
                    if (isNaN(x) || x < 0 || x > 100) {
                        // value is out of range
                        //alert("******* value is out of range " + key);
                        $('#merchantAmountedit').val("");
                    } else {
                        //alert("hip hip huree merchant");
                    }
                }

            }
            function formatNumber(num) {
                var renum = num.replace(/[^0-9]/g, '');
                return renum.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
            }
            function formatPercentage(num) {
                var renum = num.replace(/[^0-9.]/g, '');
                if (renum.length > 0) {
                    return renum + "%";
                }
            }

            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k >= 48 && k <= 57));
            }

            function alphaamount(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;

                return ((k >= 48 && k <= 57) || k == 46);
            }

            function clearamount1() {
                $('#bankAmountedit').prop('value', "");
            }
            function clearamount2() {
                $('#merchantAmountedit').prop('value', "");
            }

            function flatORpercentage1(key) {
                var r1 = $('#bankAmountTypeedit').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#bankAmountedit').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#bankAmountedit').prop('maxLength', "7");
                    sval = formatPercentage(key);

                }
                return sval;
            }
            function flatORpercentage2(key) {
                var r1 = $('#merchantAmountTypeedit').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#merchantAmountedit').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#merchantAmountedit').prop('maxLength', "7");
                    sval = formatPercentage(key);

                }
                return sval;
            }
        </script>
    </head>

    <body>
        <div class="ali-modal">
            <!--maximize and minimize buttons-->
            <div class="col-sm-12">
                <div style="text-align: right">
                    <sj:submit 
                        id="max2"
                        button="true" 
                        value="Maximize" 
                        onClick="maximize()"
                        onClickTopics="Maximize"
                        cssStyle="height: 16px;padding: 1px;width: 55px;font-size: 11px;background: orange;color: white;border-color: gray;"
                        />                          
                    <sj:submit 
                        id="min2"
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
                    <s:div id="amessageedit">
                        <s:actionerror theme="jquery"/>
                        <s:actionmessage theme="jquery"/>
                    </s:div>
                    <s:form id="acquirerpromotionedit" method="post" action="AcquirerPromotion" theme="simple" cssClass="form">
                        <div class="row row_popup">  
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label >Acquirer Promotion Code</label>
                                    <s:textfield cssClass="form-control" name="code" id="codeedit" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" readonly="true"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Risk Profile Currency</label>
                                    <s:select id="promotioncurrencyedit" list="%{currencyList}"  headerValue="--Select Currency--" headerKey="" name="currency" listKey="currencycode" listValue="description" cssClass="form-control" disabled="true" value="%{promotioncurrency}"/>     
                                    <s:hidden id="currencycodeedit" name="promotioncurrency"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label >Description</label>
                                    <s:textfield cssClass="form-control" name="description" id="descriptionedit" maxLength="256" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label >Status</label>
                                    <s:select cssClass="form-control" id="statusedit" list="%{statusList}"  headerValue="--Select Status--" headerKey="" name="status" listKey="statuscode" listValue="description"/>
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
                                    <s:select  id="txnTypeedit" name="txnType" list="%{txnTypeList}"  headerValue="-- Select Transaction Type --" headerKey="" listKey="typecode" listValue="description"  cssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Bank Amount Type</label>
                                    <s:select  id="bankAmountTypeedit" name="bankAmountType" list="%{amountType}" 
                                               headerValue="-- Select Bank Amount Type --" headerKey="" listKey="code" 
                                               listValue="description"  cssClass="form-control" 
                                               onchange="clearamount1()" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label >Bank Amount</label>
                                    <s:textfield cssClass="form-control" name="bankAmount" id="bankAmountedit" maxLength="10" 
                                                 onkeyup="$(this).val(flatORpercentage1($(this).val()))" 
                                                 onmouseout="$(this).val(flatORpercentage1($(this).val()))" 
                                                 onkeypress="return alphaamount(event)"/>
                                </div> 
                            </div>
                        </div>
                        <div class="row row_popup">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label>Merchant Amount Type</label>
                                    <s:select  id="merchantAmountTypeedit" list="%{amountType}"  name="merchantAmountType"  
                                               headerValue="--Select Merchant Amount Type--" headerKey="" listKey="code" 
                                               listValue="description"  cssClass="form-control" 
                                               onchange="clearamount2()" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <span style="color: red">*</span><label >Merchant Amount</label>
                                    <s:textfield id="merchantAmountedit" name="merchantAmount"  cssClass="form-control"  maxLength="10"  
                                                 onkeyup="$(this).val(flatORpercentage2($(this).val()))" 
                                                 onmouseout="$(this).val(flatORpercentage2($(this).val()))" 
                                                 onkeypress="return alphaamount(event)"/>
                                </div> 
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group ali-margin f-right">
                                    <sj:submit
                                        button="true"
                                        value="Assign"
                                        id="assignbtnhiddenedit"
                                        onClick="assignAcquirerPromotionEditUpdate()"
                                        cssClass="btn btn-ali-submit btn-sm" 
                                        cssStyle="display:none"                            
                                        />
                                    <sj:submit
                                        button="true"
                                        value="Assign"
                                        id="assignbtnedit"
                                        onClick="assignAcquirerPromotionEdit()"
                                        cssClass="btn btn-ali-submit btn-sm"           
                                        />
                                </div>
                            </div>
                        </div>
                        <div class="row row_popup" style="padding-top: 10px;">   </div>
                        <div id="tablediv">
                            <s:url var="listurl" action="assignAcquirerPromotion"/>
                            <s:set var="pcaption">${CURRENTPAGE}</s:set>

                            <sjg:grid
                                id="gridtabletxnedit"
                                caption="%{pcaption}"
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
                                <sjg:gridColumn name="bankAmountType" index="bankAmountType" title="Bank Amount Type" sortable="false" hidden="true"/>
                                <sjg:gridColumn name="bankAmountTypeDes" index="bankAmountTypeDes" title="Bank Amount Type" sortable="false"/>
                                <sjg:gridColumn name="bankAmount" index="bankAmount" title="Bank Amount" align="right" sortable="false"/>
                                <sjg:gridColumn name="merchantAmountType" index="merchantAmountType" title="Merchant Amount Type" sortable="false" hidden="true"/>
                                <sjg:gridColumn name="merchantAmountTypeDes" index="merchantAmountTypeDes" title="Merchant Amount Type" sortable="false"/>
                                <sjg:gridColumn name="merchantAmount" index="merchantAmount" title="Merchant Amount" align="right" sortable="false"/>
                                <sjg:gridColumn name="txnType" index="txnType" title="Edit" width="60" align="center" formatter="editformatterupdate" hidden="#vremovelink" sortable="false"/>
                                <sjg:gridColumn name="txnType" index="txnType"  title="Delete" width="60" align="center" formatter="removeformatterupdate" hidden="#vdelete" sortable="false"/> 
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
                                        onClick="cancelDataEdit()"
                                        name="reset" 
                                        cssClass="btn btn-ali-reset btn-sm"
                                        onClickTopics="resetAddButton"
                                        />                          
                                    <s:url action="updateAcquirerPromotion" var="updateturl"/>
                                    <sj:submit
                                        button="true"
                                        value="Update"
                                        href="%{updateturl}"
                                        targets="amessageedit"
                                        id="updateButtonedit"
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
