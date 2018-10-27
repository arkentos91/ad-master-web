<%-- 
    Document   : merchantmgtinsert
    Created on : Jul 10, 2016, 5:48:00 PM
    Author     : samith_k
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="resouces/css/common/common_popup.css">

        <title>Insert Merchant</title>

        <script >

            //global variables for previous height
            var height_a;
            var height_u;
            $("#min").hide();
            // maximize popup dialog 
            function maximize(width, height) {
                $(window).scrollTop(0);
                height_a = $("#remoteadddialog").height();// get sizes
                height_u = $("#updatedialog").height();// get sizes
                $("#remoteadddialog").height($(window).height() - 60);
                $("#updatedialog").height($(window).height() - 60);
                $(".ui-dialog").width($(window).width() - 50);
                $(".ui-dialog").height($(window).height() - 10);
                $(".ui-dialog").center();
                $("#max").hide();
                $("#min").show();
            }
            // reset to previous popup dialog
            function resetwindow() {
                $(window).scrollTop(0);
                $("#remoteadddialog").height(height_a);// set sizes
                $("#updatedialog").height(height_u);// set sizes
                $(".ui-dialog").width("900");
                $(".ui-dialog").height("550");
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
            //---------------------------------update(may 2nd 2018)--------------------------------
             function removeformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Delete' onClick='javascript:removeCommisionInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }
            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editCommision(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function removeCommisionInit(keyval) {
                $("#gridtableCommision").jqGrid('setGridParam', {postData: {
                        currency: keyval,
                        isAssign: 'remove'
                    }});
                $("#gridtableCommision").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommision").trigger("reloadGrid");
            }

            $.subscribe('anyerrorsremove', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });
            
            function editCommision(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findCommisionMerchantMgt.action',
                    data: {currency: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessage').empty();
                        var msg = data.message;
                        if (msg) {

                            $('#currency').prop('disabled', true);
                            $('#currency').val(data.currency);
                            $('#flatPercentageNormal').val(data.flatPercentageNormal);
                            $('#amountNormal').val(data.amountNormal);
                            $('#amessage').text("");
                        }
                        else {
                            $('#currency').prop('disabled', true);
                            $('#currency').val(data.currency);
                            $('#flatPercentageNormal').val(data.flatPercentageNormal);
                            $('#amountNormal').val(data.amountNormal);
                            $('#assignbtn').hide();
                            $('#assignbtnhidden').show();
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }
             function assignMerchCurr() {

                var currency = $('#currency').val();
                var flatPercentageNormal = $('#flatPercentageNormal').val();
                var amountNormal = $('#amountNormal').val();

                $("#gridtableCommision").jqGrid('setGridParam', {postData: {
                        currency: currency,
                        flatPercentageNormal: flatPercentageNormal,
                        amountNormal: amountNormal,
                        isAssign: 'assign'
                    }});

                $("#gridtableCommision").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommision").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setMessageMerchantMgt.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#amessage').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");
                        } else {
                            $('#currency').val("");
                            $('#flatPercentageNormal').val("");
                            $('#amountNormal').val("");
                            $('#amessage').empty();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function assignMerchCurrUpdate() {
                var currency = $('#currency').val();
                var flatPercentageNormal = $('#flatPercentageNormal').val();
                var amountNormal = $('#amountNormal').val();

                $("#gridtableCommision").jqGrid('setGridParam', {postData: {
                        currency: currency,
                        flatPercentageNormal: flatPercentageNormal,
                        amountNormal: amountNormal,
                        isAssign: 'update'
                    }});

                $("#gridtableCommision").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommision").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setMessageMerchantMgt.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#amessage').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");
                            $('#assignbtn').hide();
                            $('#assignbtnhidden').show();
                        } else {
                            $('#currency').prop('disabled', false);
                            $('#currency').val("");
                            $('#flatPercentageNormal').val("");
                            $('#amountNormal').val("");
                            $('#amessage').empty();
                            $('#assignbtn').show();
                            $('#assignbtnhidden').hide();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }
            //--------------------------------------------end--------------------------
            function resetAllDataInsert() {
                $('#merchantCustomer').val("");
                $('#merchantcode').attr('readOnly', false);
                $('#merchantcode').val("");
                $('#description').val("");
                $('#latitude').val("");
                $('#status').val("");
                $('#commision').val("");
                $('#promotion').val("");
                $('#longitude').val("");
                $('#address').val("");
                $('#topupacc').val("");
                $('#posacc').val("");
                $('#riskProfile').val("");
                $('#mobile').val("");
                $('#contact1').val("");
                $('#contact2').val("");
                $('#email1').val("");
                $('#email2').val("");

                $('#accounttype').val("");
                $('#accountnumber').val("");
                $('#paymenttype').val("");
                $('#bankname').val("");
                $('#branchcode').val("");
                $('#branch').val("");

                $('#legalname').val("");
                $('#merchantCustCategory').val("");
                $('#incomeExpenseCashIn').val("");
                $('#flatPercentageCashIn').val("");
                $('#amountCashIn').val("");

                $('#incomeExpenseCashInDeb').val("");
                $('#flatPercentageCashInDeb').val("");
                $('#amountCashInDeb').val("");

                $('#incomeExpenseCashOut').val("");
                $('#flatPercentageCashOut').val("");
                $('#amountCashOut').val("");


                $('#incomeExpenseCashOutDeb').val("");
                $('#flatPercentageCashOutDeb').val("");
                $('#amountCashOutDeb').val("");

                $('#incomeExpenseNormal').val("");
                $('#flatPercentageNormal').val("");
                $('#amountNormal').val("");

                $('#incomeExpenseNormalDeb').val("");
                $('#flatPercentageNormalDeb').val("");
                $('#amountNormalDeb').val("");

                //for currency
                $('#newBox').empty();
                $('#currentBox').empty();
                //for mcc
                $('#mnewBox').empty();
                $('#mcurrentBox').empty();
                //for transaction
                $('#tnewBox').empty();
                $('#tcurrentBox').empty();

                $('#amessage').text("");
            }

            function resetAllDataInsertTab1() {
                $('#merchantCustomer').val("");
                $('#merchantcode').attr('readOnly', false);
                $('#merchantcode').val("");
                $('#description').val("");
                $('#latitude').val("");
                $('#status').val("");
                $('#commision').val("");
                $('#promotion').val("");
                $('#longitude').val("");
                $('#address').val("");
                $('#topupacc').val("");
                $('#posacc').val("");
                $('#riskProfile').val("");
                $('#mobile').val("");
                $('#legalname').val("");
                $('#merchantCustCategory').val("");
                $('#email1').val("");
                
                $('#amessage').text("");
            }

            function resetAllDataInsertTab2() {


                $('#contact1').val("");
                $('#contact2').val("");
                $('#email1').val("");
                $('#email2').val("");

                $('#accounttype').val("");
                $('#accountnumber').val("");
                $('#paymenttype').val("");
                $('#bankname').val("");
                $('#branchcode').val("");
                $('#branch').val("");


                $('#amessage').text("");
            }

            function resetAllDataInsertTxn() {
                $('#currency').prop('disabled', false);
                $('#currency').val("");
                $('#flatPercentageNormal').val("");
                $('#amountNormal').val("");
                $('#amessage').empty();
                $('#assignbtn').show();
                $('#assignbtnhidden').hide();
//                $('#incomeExpenseCashIn').val("");
//                $('#flatPercentageCashIn').val("");
//                $('#amountCashIn').val("");
//
//                $('#incomeExpenseCashInDeb').val("");
//                $('#flatPercentageCashInDeb').val("");
//                $('#amountCashInDeb').val("");
//
//                $('#incomeExpenseCashOut').val("");
//                $('#flatPercentageCashOut').val("");
//                $('#amountCashOut').val("");
//
//                $('#incomeExpenseCashOutDeb').val("");
//                $('#flatPercentageCashOutDeb').val("");
//                $('#amountCashOutDeb').val("");
//
//                $('#incomeExpenseNormal').val("");
//                $('#flatPercentageNormal').val("");
//                $('#amountNormal').val("");
//
//                $('#incomeExpenseNormalDeb').val("");
//                $('#flatPercentageNormalDeb').val("");
//                $('#amountNormalDeb').val("");
                 $("#gridtableCommision").jqGrid('setGridParam', {postData: {
                        currency: '',
                        flatPercentageNormal: '',
                        amountNormal: '',
                        isAssign: 'clear'
                    }});
                $("#gridtableCommision").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommision").trigger("reloadGrid");
                $('#amessage').text("");
            }

            function nextDiv(key) {

                if (key == 'div1') {
//                    $('#tone').hide();
//                    $('#tthree').show();
//                    $('#ttwo').show();
                } else if (key == 'div2') {
                    $('#tone').hide();
                    $('#ttwo').show();
                    $('#tthree').hide();
                    $('#tfour').hide();
                    $('#tfive').hide();
                } else if (key == 'div3') {
                    $('#tone').hide();
                    $('#ttwo').hide();
                    $('#tthree').show();
                    $('#tfour').hide();
                    $('#tfive').hide();
                } else if (key == 'div4') {
                    $('#tone').hide();
                    $('#ttwo').hide();
                    $('#tthree').hide();
                    $('#tfour').show();
                    $('#tfive').hide();
                } else if (key == 'div5') {
                    $('#tone').hide();
                    $('#ttwo').hide();
                    $('#tthree').hide();
                    $('#tfour').hide();
                    $('#tfive').show();
                }
            }

            function backDiv(key) {
                if (key == 'div1') {
                    $('#tone').show();
                    $('#ttwo').hide();
                    $('#tthree').hide();
                    $('#tfour').hide();
                    $('#tfive').hide();
                } else if (key == 'div2') {
                    $('#tone').hide();
                    $('#ttwo').show();
                    $('#tthree').hide();
                    $('#tfour').hide();
                    $('#tfive').hide();
                } else if (key == 'div3') {
                    $('#tone').hide();
                    $('#ttwo').hide();
                    $('#tthree').show();
                    $('#tfour').hide();
                    $('#tfive').hide();
                } else if (key == 'div4') {
                    $('#tone').hide();
                    $('#ttwo').hide();
                    $('#tthree').hide();
                    $('#tfour').show();
                    $('#tfive').hide();
                }

            }

            function toleft(key) {

                if (key == 'currency') {
                    $("#newBox option:selected").each(function () {

                        $("#currentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#mnewBox option:selected").each(function () {

                        $("#mcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#tnewBox option:selected").each(function () {

                        $("#tcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }

            }

            function toright(key) {

                if (key == 'currency') {
                    $("#currentBox option:selected").each(function () {

                        $("#newBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#mcurrentBox option:selected").each(function () {

                        $("#mnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#tcurrentBox option:selected").each(function () {

                        $("#tnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }

            }

            function toleftall(key) {

                if (key == 'currency') {
                    $("#newBox option").each(function () {

                        $("#currentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#mnewBox option").each(function () {

                        $("#mcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#tnewBox option").each(function () {

                        $("#tcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }


            }

            function torightall(key) {

                if (key == 'currency') {
                    $("#currentBox option").each(function () {

                        $("#newBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#mcurrentBox option").each(function () {

                        $("#mnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#tcurrentBox option").each(function () {

                        $("#tnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }

            }

            function clickAdd() {
                //for currency
                $('#newBox option').prop('selected', true);
                //for mcc
                $('#mnewBox option').prop('selected', true);
                //for transaction
                $('#tnewBox option').prop('selected', true);

                $("#addbtn").click();
                $('#currentBox option').prop('selected', true);
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

            function alphaamount(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;

                return ((k >= 48 && k <= 57) || k == 46);
            }

            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57) || (k == 13));
            }

            function alphaemail(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 63 && k < 91) || (k == 95) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 46 && k != 47 && k <= 57) || (k == 13));
            }

            function getAccounttypefields(key) {

                var ter_mode_edit = key;

                if (ter_mode_edit == 'YES') {
                    $('#bankname').prop('disabled', true);
                    $('#branchcode').prop('disabled', true);
                    $('#branch').prop('disabled', true);
                    $('#paymenttype').prop('disabled', false);
                } else if (ter_mode_edit == 'NO') {
                    $('#bankname').prop('disabled', false);
                    $('#branchcode').prop('disabled', false);
                    $('#branch').prop('disabled', false);
                    $('#paymenttype').prop('disabled', true);
                }
            }
            function flatORpercentage1(key) {
                var r1 = $('#flatPercentageCashIn').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashIn').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashIn').prop('maxLength', "7");

                    sval = formatPercentage(key);

                }
                return sval;
            }

            function flatORpercentage2(key) {
                var r1 = $('#flatPercentageCashInDeb').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashInDeb').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashInDeb').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage3(key) {
                var r1 = $('#flatPercentageCashOut').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashOut').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashOut').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage4(key) {
                var r1 = $('#flatPercentageCashOutDeb').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashOutDeb').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashOutDeb').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage5(key) {
                var r1 = $('#flatPercentageNormal').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountNormal').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountNormal').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage6(key) {
                var r1 = $('#flatPercentageNormalDeb').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountNormalDeb').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountNormalDeb').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function clearamount1() {
                $('#amountCashIn').prop('value', "");
            }
            function clearamount2() {
                $('#amountCashInDeb').prop('value', "");
            }
            function clearamount3() {
                $('#amountCashOut').prop('value', "");
            }
            function clearamount4() {
                $('#amountCashOutDeb').prop('value', "");
            }
            function clearamount5() {
                $('#amountNormal').prop('value', "");
            }
            function clearamount6() {
                $('#amountNormalDeb').prop('value', "");
            }

        </script>
        <style>
            #tthree select ,
            #tthree input[type="text"] {
                height: 27px
                //padding: 1px;
            }
            #tthree .horizontal_line_popup{
                margin: 2px;
            }
        </style>
    </head>
    <body>
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
        <s:div id="amessage">
            <s:actionerror theme="jquery"/>
            <s:actionmessage theme="jquery"/>
        </s:div>

        <s:form id="merchantadd" method="post" action="" theme="simple" cssClass="form" >

            <div id="tone">
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Merchant ID</label>
                            <s:textfield  cssClass="form-control" name="merchantcode" id="merchantcode" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onkeypress="return alpha(event)"/>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group" style=" margin-left: 10px; margin-right: 20px; margin-top:  25px;">
                            <s:url var="searchurl" action="checkMIDMerchantMgt"/>
                            <sj:submit 
                                button="true" 
                                value="Check" 
                                name="check" 
                                href="%{searchurl}"
                                cssClass="btn btn-default btn-sm"
                                id="chechbutt"
                                targets="amessage" />

                        </div>    
                    </div> 
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Description</label>
                            <s:textfield  cssClass="form-control" name="description" id="description" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/>
                        </div>
                    </div>        


                </div>

                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Merchant Customer Name </label>
                            <s:select name="merchantCustomer" id="merchantCustomer" list="%{merchantCustomerList}"   headerValue="--Select Merchant Customer--" cssClass="form-control" headerKey=""  listKey="mid" listValue="name" />
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Acquirer Risk Profile</label>
                                <s:select  id="riskProfile" list="%{riskProfileList}"  name="riskProfile" headerKey=""  headerValue="--Select Acquirer Risk Profile--" listKey="profilecode" listValue="description" cssClass="form-control"/>
                        </div>
                    </div>    
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Status</label>
                            <s:select headerValue="--Select Status--" headerKey="" cssClass="form-control"  id="status" list="%{statusList}"  name="status" listKey="statuscode" listValue="description"/>                  
                        </div>
                    </div>

                </div>   
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Merchant Category Code</label>
                            <s:select  id="merchantCustCategory" name="merchantCustCategory" headerValue="--Select MCC--" headerKey="" cssClass="form-control" list="%{mccOriList}"  listKey="mcccode" listValue="mccdes"/> 
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label>Acquirer Promotion </label>
                                <s:select headerValue="--Select Acquirer Promotion--" headerKey="" cssClass="form-control"  id="promotion" list="%{promotionList}"  name="promotion" listKey="code" listValue="description"/>                  
                        </div>
                    </div>    
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Address</label>
                            <s:textarea  cssClass="form-control" name="address" id="address" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9.,/' ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9.,/' ]/g,''))"/>
                        </div>               
                    </div>    


                </div>
                <div class="row row_popup">



                    <div class="col-sm-4">
                        <div class="form-group">
                            <label >Mobile</label>
                            <s:textfield name="mobile" id="mobile" cssClass="form-control" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return alpha(event)"/>
                        </div>  
                    </div> 
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>POS Account </label>
                            <s:textfield  cssClass="form-control" name="posacc" id="posacc" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onkeypress="return alpha(event)"/>                 
                        </div>
                    </div>   
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Email </label>
                                <s:textfield name="email1" id="email1" cssClass="form-control" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onkeypress="return alphaemail(event)"/>
                        </div>  
                    </div>
<!--                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Legal Name</label>
                            <%--<s:textfield name="legalname" id="legalname" cssClass="form-control"  maxLength="120" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/>--%>
                        </div>
                    </div>-->
                </div>
<!--                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Longitude</label>   
                            <%--<s:textfield cssClass="form-control" name="longitude" id="longitude" maxLength="64" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" />--%>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Latitude</label>   
                            <%--<s:textfield cssClass="form-control" name="latitude" id="latitude" maxLength="64" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" />--%>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Email </label>
                                <%--<s:textfield name="email1" id="email1" cssClass="form-control" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onkeypress="return alphaemail(event)"/>--%>
                        </div>  
                    </div>
                </div>-->



                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-9">
                        <div class="form-group">
                            <span class="mandatoryfield">Mandatory fields are marked with *</span>
                        </div>
                    </div>
                    <div class="col-sm-3 text-right">
                        <div class="form-group" style=" margin-left: 10px;margin-right: 10px;">
                            <sj:submit 
                                button="true" 
                                value="Reset" 
                                onClick="resetAllDataInsertTab1()"
                                cssClass="btn btn-default btn-sm"
                                />                          
                        </div>                       
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Next"
                                href="%{inserturl}"
                                id="nextbtn1add"
                                onclick="nextDiv('div3')"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"
                                />                        
                        </div>
                    </div>
                </div>
            </div>

            <div id="ttwo" hidden="true">

                <div class="row row_popup">    

                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Contact Number 1</label>
                                <s:textfield name="contact1" id="contact1" cssClass="form-control" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return alpha(event)"/>
                        </div>  
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Contact Number 2</label>
                                <s:textfield name="contact2" id="contact2" cssClass="form-control" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return alpha(event)"/>
                        </div>  
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Email 2</label>
                                <s:textfield name="email2" id="email2" cssClass="form-control" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onkeypress="return alphaemail(event)"/>
                        </div>  
                    </div>    
                </div>
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Bank Name</label>
                            <s:textfield  cssClass="form-control" name="bankname" id="bankname" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onkeypress="return alpha(event)"/>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Branch Code</label>
                            <s:textfield  cssClass="form-control" name="branchcode" id="branchcode" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Branch Name</label>
                            <s:textfield  cssClass="form-control" name="branch" id="branch" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onkeypress="return alpha(event)"/>
                        </div>
                    </div>    
                </div>        
                <div class="row row_popup">
                    <div class="horizontal_line_popup" style=" margin-top:  90px;">

                    </div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <span class="mandatoryfield">Mandatory fields are marked with *</span>
                        </div>
                    </div>
                    <div class="col-sm-4 text-right">
                        <div class="form-group" style=" margin-left: 10px;margin-right: 10px;">
                            <sj:submit 
                                button="true"
                                value="Back"
                                href="%{inserturl}"
                                id="backbtn4addee"
                                onclick="backDiv('div1')"
                                cssClass="btn btn-sm active" 
                                />                        
                        </div>
                        <div class="form-group" style=" margin-left: 10px;margin-right: 10px;">
                            <sj:submit 
                                button="true" 
                                value="Reset" 
                                onClick="resetAllDataInsertTab2()"
                                cssClass="btn btn-default btn-sm"
                                />                          
                        </div>                       
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Next"
                                href="%{inserturl}"
                                id="nextbtn1addee"
                                onclick="nextDiv('div3')"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"
                                />                        
                        </div>
                    </div>
                </div>
            </div>            

            <div id="tthree" hidden="true">
                <div class="row row_popup">
                      
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Currency</label>
                           <s:select  id="currency" list="%{currencyList}"  headerValue="--Select Currency--" headerKey="" name="currency" listKey="currencycode" listValue="description" cssClass="form-control"/>
                        </div>
                    </div>  

                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Flat/Percentage</label>
                            <s:select  id="flatPercentageNormal"  name="flatPercentageNormal"  onchange="clearamount5()"
                                       list="%{flatPercentageTypeList}"  headerValue="--Select Flat/Percentage--" headerKey="" listKey="code" listValue="description"  cssClass="form-control"  />                
                        </div>
                    </div> 
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Amount</label>
                            <s:textfield id="amountNormal" name="amountNormal" maxLength="8" cssClass="form-control" 
                                         onkeyup="$(this).val(flatORpercentage5($(this).val()))" 
                                         onmouseout="$(this).val(flatORpercentage5($(this).val()))" 
                                         onkeypress="return alphaamount(event)"/>              
                        </div>
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="col-sm-8">

                    </div>
                    <div class="col-sm-4 text-right">

                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Assign"
                                id="assignbtn"
                                onClick="assignMerchCurr()"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"            
                                />
                        </div>
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Assign"
                                id="assignbtnhidden"
                                onClick="assignMerchCurrUpdate()"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9;display:none"                            
                                />
                        </div>
                    </div>
                </div>
                <div id="tablediv">
                    <s:url var="listurl" action="assignMerchantMgt"/>
                    <sjg:grid
                        id="gridtableCommision"
                        caption="Merchant Management Commision"
                        dataType="json"
                        href="%{listurl}"
                        pager="true"
                        gridModel="gridModelCommision"
                        rowList="10,15,20"
                        targets="amessage"
                        rowNum="10"
                        autowidth="true"
                        rownumbers="true"
                        onCompleteTopics="completetopics"
                        rowTotal="false"
                        viewrecords="true"
                        shrinkToFit="true"
                        >
                        <sjg:gridColumn name="currencyCode" index="currencyCode" title="Currency Code"  sortable="false" hidden="true"/>
                        <sjg:gridColumn name="currencyDes" index="currencyDes" title="Currency" width="250" sortable="false"/>
                        <sjg:gridColumn name="flatPercentageDes" index="flatPercentageDes" width="245" title="Flat/Percentage" sortable="false"/>
                        <sjg:gridColumn name="amount" index="amount" title="Amount" width="245" sortable="false"/>
                        <sjg:gridColumn name="currencyCode" index="currencyCode" title="Edit" width="25" align="center" sortable="false" formatter="editformatter" hidden="false"/>
                        <sjg:gridColumn name="currencyCode" index="currencyCode" title="Delete" width="40" align="center" sortable="false" formatter="removeformatter" hidden="false"/> 
                    </sjg:grid> 
                </div>        
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <span class="mandatoryfield">Mandatory fields are marked with *</span>
                        </div>
                    </div>
                    <div class="col-sm-4 text-right">
                        
                        <div class="form-group" style=" margin-left: 10px;margin-right: 10px;">
                            <sj:submit 
                                button="true" 
                                value="Reset" 
                                onClick="resetAllDataInsertTxn()"
                                cssClass="btn btn-default btn-sm"
                                />                          
                        </div>

                        <div class="form-group" style=" margin-left: 10px;margin-right: 10px;">
                            <sj:submit 
                                button="true"
                                value="Back"
                                href="%{inserturl}"
                                id="backbtn4add"
                                onclick="backDiv('div1')"
                                cssClass="btn btn-sm active" 
                                />                        
                        </div> 

                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Next"
                                href="%{inserturl}"
                                id="nextbtn4add"
                                onclick="nextDiv('div4')"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"
                                />                        
                        </div>
                    </div>
                </div>

            </div>

            <div id="tfour" hidden="true">
                <div class="row row_popup">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <span style="color: red"></span><label>Currency  : </label>                    
                        </div>
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup">
                    <div class="col-sm-5">
                        <label>Assigned Currency</label>
                        <s:select cssClass="form-control" multiple="true" 
                                  name="currentBox" id="currentBox" list="currencyCurrentList"									 
                                  ondblclick="toright('currency')" style="height:160px;"/>

                    </div>
                    <div class="col-sm-2 text-center">
                        <div class="row" style="height: 20px;"></div>
                        <div class="row">
                            <sj:a
                                id="right" 
                                onClick="toright('currency')" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="rightall" 
                                onClick="torightall('currency')" 
                                button="true"
                                style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="left" 
                                onClick="toleft('currency')" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="leftall" 
                                onClick="toleftall('currency')" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <label>Blocked Currency</label>
                        <s:select cssClass="form-control" multiple="true"
                                  name="newBox" id="newBox" list="currencyNewList"									 
                                  ondblclick="toleft('currency')" style="height:160px;" />
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-9">
                        <div class="form-group">
                            <span class="mandatoryfield"></span>
                        </div>
                    </div>
                    <div class="col-sm-3 text-right">
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Back"
                                href="%{inserturl}"
                                id="backbtn1add"
                                onclick="backDiv('div3')"
                                cssClass="btn btn-sm active" 
                                />                        
                        </div>
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Next"
                                href="%{inserturl}"
                                id="nextbtn2add"
                                onclick="nextDiv('div5')"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"
                                />                        
                        </div>
                    </div>
                </div>
            </div>    

            <div id="tfive" hidden="true">
                <div class="row row_popup">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <span style="color: red"></span><label>Transactions : </label>                    
                        </div>
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup">
                    <div class="col-sm-5">
                        <label>Assigned Transaction(s)</label>
                        <s:select cssClass="form-control" multiple="true" 
                                  name="tcurrentBox" id="tcurrentBox" list="transactionCurrentList"									 
                                  ondblclick="toright('transaction')" style="height:160px;"/>

                    </div>
                    <div class="col-sm-2 text-center">
                        <div class="row" style="height: 20px;"></div>
                        <div class="row">
                            <sj:a
                                id="tright" 
                                onClick="toright('transaction')" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="trightall" 
                                onClick="torightall('transaction')" 
                                button="true"
                                style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="tleft" 
                                onClick="toleft('transaction')" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="tleftall" 
                                onClick="toleftall('transaction')" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <label>Blocked Transaction(s)</label>
                        <s:select cssClass="form-control" multiple="true"
                                  name="tnewBox" id="tnewBox" list="transactionNewList"									 
                                  ondblclick="toleft('transaction')" style="height:160px;" />
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-9">
                        <div class="form-group">
                            <span class="mandatoryfield"></span>
                        </div>
                    </div>
                    <div style="display: none; visibility: hidden;">
                        <s:url action="AddMerchantMgt" var="hrinserturl"/>
                        <sj:submit button="true" href="%{hrinserturl}" id="addbtn"
                                   targets="amessage" />
                    </div>
                    <div class="col-sm-3 text-right">
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <sj:submit
                                button="true"
                                value="Back"
                                href="%{inserturl}"
                                id="backbtn3add"
                                onclick="backDiv('div4')"
                                cssClass="btn btn-sm active" 
                                />                        
                        </div>
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">

                            <sj:submit
                                button="true"
                                value="Add"
                                onclick="clickAdd()"
                                id="addbtntmp"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"
                                />                        
                        </div>
                    </div>
                </div>
            </div>
        </s:form>
    </body>
</html>
