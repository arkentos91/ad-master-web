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
        <!--<link rel="stylesheet" href="resouces/css/common/common_popup.css">-->
        <title>Insert Merchant</title>

        <script>

            //global variables for previous height
            var height_r;
            var height_u;
            $("#min2").hide();
            // maximize popup dialog 
            function maximize() {
                $(window).scrollTop(0);
                height_r = $("#remoteadddialog").height();// get sizes
                height_u = $("#updatedialog").height();// get sizes
                $("#remoteadddialog").height($(window).height() - 60);
                $("#updatedialog").height($(window).height() - 60);
                $(".ui-dialog").width($(window).width() - 50);
                $(".ui-dialog").height($(window).height() - 10);
                $(".ui-dialog").center();
                $("#max2").hide();
                $("#min2").show();
            }
            // reset to previous popup dialog
            function resetwindow() {
                $(window).scrollTop(0);
                $("#remoteadddialog").height(height_r);// set sizes
                $("#updatedialog").height(height_u);// set sizes
                $(".ui-dialog").width("900");
                $(".ui-dialog").height("550");
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
            //---------------------------------update(may 2nd 2018)--------------------------------
            function removeformatterupdate(cellvalue, options, rowObject) {
                return "<a href='#' title='Delete' onClick='javascript:removeCommisionInitEdit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editformatterupdate(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editCommisionEdit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editCommisionEdit(keyval) {

                $.ajax({
                    url: '${pageContext.request.contextPath}/findCommisionMerchantMgt.action',
                    data: {currency: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {

                            $('#currencyedit').prop('disabled', true);
                            $('#currencyedit').val(data.currency);
                            $('#flatPercentageNormaledit').val(data.flatPercentageNormal);
                            $('#amountNormaledit').val(data.amountNormal);
                            $('#amessageedit').text("");
                        }
                        else {
                            $('#currencyedit').prop('disabled', true);
                            $('#currencyedit').val(data.currency);
                            $('#flatPercentageNormaledit').val(data.flatPercentageNormal);
                            $('#amountNormaledit').val(data.amountNormal);
                            $('#assignbtnedit').hide();
                            $('#assignbtnhiddenedit').show();
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function removeCommisionInitEdit(keyval) {

                $("#gridtableCommisionedit").jqGrid('setGridParam', {postData: {
                        currency: keyval,
                        isAssign: 'remove'
                    }});

                $("#gridtableCommisionedit").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommisionedit").trigger("reloadGrid");
            }

            $.subscribe('anyerrorsremove', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function assignMerchCurrEdit() {

                $('#amessageedit').empty();
                var currency = $('#currencyedit').val();
                var flatPercentageNormal = $('#flatPercentageNormaledit').val();
                var amountNormal = $('#amountNormaledit').val();

                $("#gridtableCommisionedit").jqGrid('setGridParam', {postData: {
                        currency: currency,
                        flatPercentageNormal: flatPercentageNormal,
                        amountNormal: amountNormal,
                        isAssign: 'assign'
                    }
                });


                $("#gridtableCommisionedit").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommisionedit").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setMessageMerchantMgt.action',
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
                            $('#currencyedit').val("");
                            $('#flatPercentageNormaledit').val("");
                            $('#amountNormaledit').val("");
                            $('#amessageedit').empty();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function assignMerchCurrUpdateEdit() {

                var currency = $('#currencyedit').val();
                var flatPercentageNormal = $('#flatPercentageNormaledit').val();
                var amountNormal = $('#amountNormaledit').val();

                $("#gridtableCommisionedit").jqGrid('setGridParam', {postData: {
                        currency: currency,
                        flatPercentageNormal: flatPercentageNormal,
                        amountNormal: amountNormal,
                        isAssign: 'update'
                    }});

                $("#gridtableCommisionedit").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtableCommisionedit").trigger("reloadGrid");

                $.ajax({
                    url: '${pageContext.request.contextPath}/setMessageMerchantMgt.action',
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
                            $('#currencyedit').prop('disabled', false);
                            $('#currencyedit').val("");
                            $('#flatPercentageNormaledit').val("");
                            $('#amountNormaledit').val("");
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

            //------------------------------end--------------------
            function editMerchant(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindMerchantMgt.action',
                    data: {merchantcode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;

                        if (msg) {
                            $('#merchantcodeedit').val("");
                            $('#merchantCustomeredit').val("");
                            $('#descriptionedit').val("");
                            $('#longitudeedit').val("");
                            $('#latitudeedit').val("");
                            $('#statusedit').val("");
                            $('#commisionedit').val("");
                            $('#promotionedit').val("");
                            $('#addressedit').val("");
                            $('#topupaccedit').val("");
                            $('#posaccedit').val("");
                            $('#riskProfileedit').val("");
                            $('#mobileedit').val("");
                            $('#email1edit').val("");



                            $('#legalnameedit').val("");
                            $('#merchantCustCategoryedit').val("");
                            $('#amessageedit').text("");

                            $('#accountTypeCashInedit').val("");
                            $('#incomeExpenseCashInedit').val("");
                            $('#flatPercentageCashInedit').val("");
                            $('#amountCashInedit').val("");

                            $('#accountTypeCashOutedit').val("");
                            $('#incomeExpenseCashOutedit').val("");
                            $('#flatPercentageCashOutedit').val("");
                            $('#amountCashOutedit').val("");

                            $('#accountTypeNormaledit').val("");
                            $('#incomeExpenseNormaledit').val("");
                            $('#flatPercentageNormaledit').val("");
                            $('#amountNormaledit').val("");

                            $('#incomeExpenseCashOutDeb').val("");
                            $('#flatPercentageCashOutDeb').val("");
                            $('#amountCashOutDeb').val("");

                            $('#incomeExpenseNormal').val("");
                            $('#flatPercentageNormal').val("");
                            $('#amountNormal').val("");

                            $('#incomeExpenseNormalDeb').val("");
                            $('#flatPercentageNormalDeb').val("");
                            $('#amountNormalDeb').val("");

                        } else {

                            $('#merchantcodeedit').val(data.merchantcode);
                            $('#merchantCustomeredit').val(data.merchantCustomer);
                            $('#descriptionedit').val(data.description);
                            $('#longitudeedit').val(data.longitude);
                            $('#latitudeedit').val(data.latitude);
                            $('#statusedit').val(data.status);
                            $('#commisionedit').val(data.commision);
                            $('#promotionedit').val(data.promotion);
                            $('#addressedit').val(data.address);
                            $('#riskProfileedit').val(data.riskProfile);
                            $('#mobileedit').val(data.mobile);
                            $('#email1edit').val(data.email1);



                            $('#legalnameedit').val(data.legalname);
                            $('#merchantCustCategoryedit').val(data.merchantCustCategory);

                            $('#posaccedit').val(data.posacc);
                            $('#topupaccedit').val(data.topupacc);

                            $('#enewBox').empty();
                            $('#ecurrentBox').empty();

                            $.each(data.currencyNewList, function (key, value) {
                                $('#enewBox').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });
                            $.each(data.currencyCurrentList, function (key, value) {
                                $('#ecurrentBox').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });

                            $('#emnewBox').empty();
                            $('#emcurrentBox').empty();

                            $.each(data.mccNewList, function (key, value) {
                                $('#emnewBox').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });
                            $.each(data.mccCurrentList, function (key, value) {
                                $('#emcurrentBox').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });

                            $('#etnewBox').empty();
                            $('#etcurrentBox').empty();

                            $.each(data.transactionNewList, function (key, value) {
                                $('#etnewBox').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });
                            $.each(data.transactionCurrentList, function (key, value) {
                                $('#etcurrentBox').append(
                                        $('<option></option>').val(key).html(
                                        value));
                            });



                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            $(document).ready(function () {
                var ter_mode_edit = $('#accounttypeedit').val();
                getAccounttypefields(ter_mode_edit);
            });

            function editMerchantTab2(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindMerchantMgt.action',
                    data: {merchantcode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;

                        if (msg) {


                            $('#posaccedit').val("");
                            $('#contact1edit').val("");
                            $('#contact2edit').val("");
                            $('#email1edit').val("");
                            $('#email2edit').val("");
                            $('#accounttypeedit').val("");
                            $('#accountnumberedit').val("");
                            $('#paymenttypeedit').val("");
                            $('#banknameedit').val("");
                            $('#branchcodeedit').val("");
                            $('#branchedit').val("");



                        } else {


                            $('#contact1edit').val(data.contact1);
                            $('#contact2edit').val(data.contact2);
                            $('#email1edit').val(data.email1);
                            $('#email2edit').val(data.email2);

                            $('#accountnumberedit').val(data.accountnumber);
                            $('#accounttypeedit').val(data.accounttype);
                            if (data.accounttype == "YES") {
                                $('#paymenttypeedit').val(data.paymenttype);

                                $('#banknameedit').prop('disabled', true);
                                $('#banknameedit').prop('value', '');

                                $('#branchcodeedit').prop('disabled', true);
                                $('#branchcodeedit').prop('value', '');

                                $('#branchedit').prop('disabled', true);
                                $('#branchedit').prop('value', '');

                                $('#paymenttypeedit').prop('disabled', false);
                            }
                            else if (data.accounttype == "NO") {
                                $('#banknameedit').val(data.bankname);
                                $('#banknameedit').prop('disabled', false);
                                $('#branchcodeedit').val(data.branchcode);
                                $('#branchcodeedit').prop('disabled', false);
                                $('#branchedit').val(data.branch);
                                $('#branchedit').prop('disabled', false);

                                $('#paymenttypeedit').prop('disabled', true);
                                $('#paymenttypeedit').prop('value', '');
                            }




                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function editMerchantTxn(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindTxnMerchantMgt.action',
                    data: {merchantcode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;

                        if (msg) {
                            $('#currencyedit').val("");
                            $('#flatPercentageNormaledit').val("");
                            $('#amountNormaledit').val("");
                            $('#amessageedit').empty();
//                            $('#merchantcodeedit').val("");
//
//                            $('#incomeExpenseCashInedit').val("");
//                            $('#flatPercentageCashInedit').val("");
//                            $('#amountCashInedit').val("");
//
//                            $('#incomeExpenseCashIneditDeb').val("");
//                            $('#flatPercentageCashIneditDeb').val("");
//                            $('#amountCashIneditDeb').val("");
//
//                            $('#incomeExpenseCashOutedit').val("");
//                            $('#flatPercentageCashOutedit').val("");
//                            $('#amountCashOutedit').val("");
//
//                            $('#incomeExpenseCashOuteditDeb').val("");
//                            $('#flatPercentageCashOuteditDeb').val("");
//                            $('#amountCashOuteditDeb').val("");
//
//                            $('#incomeExpenseNormaledit').val("");
//                            $('#flatPercentageNormaledit').val("");
//                            $('#amountNormaledit').val("");
//
//                            $('#incomeExpenseNormaleditDeb').val("");
//                            $('#flatPercentageNormaleditDeb').val("");
//                            $('#amountNormaleditDeb').val("");

                        } else {
                            $('#currencyedit').prop('disabled', false);
                            $('#currencyedit').val("");
                            $('#flatPercentageNormaledit').val("");
                            $('#amountNormaledit').val("");
                            $('#amessageedit').empty();

                            $('#assignbtnedit').show();
                            $('#assignbtnhiddenedit').hide();
                            $("#gridtableCommisionedit").jqGrid('setGridParam', {postData: {
                                    currency: '',
                                    isAssign: 'init'
                                }});

                            $("#gridtableCommisionedit").jqGrid('setGridParam', {page: 1});
                            jQuery("#gridtableCommisionedit").trigger("reloadGrid");
//                            $('#merchantcodeedit').val(data.merchantcode);
//                            $('#incomeExpenseCashInedit').val(data.incomeExpenseCashInedit);
//                            $('#flatPercentageCashInedit').val(data.flatPercentageCashInedit);
//                            $('#amountCashInedit').val(data.amountCashInedit);
//
//                            $('#incomeExpenseCashIneditDeb').val(data.incomeExpenseCashIneditDeb);
//                            $('#flatPercentageCashIneditDeb').val(data.flatPercentageCashIneditDeb);
//                            $('#amountCashIneditDeb').val(data.amountCashIneditDeb);
//
//                            $('#incomeExpenseCashOutedit').val(data.incomeExpenseCashOutedit);
//                            $('#flatPercentageCashOutedit').val(data.flatPercentageCashOutedit);
//                            $('#amountCashOutedit').val(data.amountCashOutedit);
//
//                            $('#incomeExpenseCashOuteditDeb').val(data.incomeExpenseCashOuteditDeb);
//                            $('#flatPercentageCashOuteditDeb').val(data.flatPercentageCashOuteditDeb);
//                            $('#amountCashOuteditDeb').val(data.amountCashOuteditDeb);
//
//                            $('#incomeExpenseNormaledit').val(data.incomeExpenseNormaledit);
//                            $('#flatPercentageNormaledit').val(data.flatPercentageNormaledit);
//                            $('#amountNormaledit').val(data.amountNormaledit);
//
//                            $('#incomeExpenseNormaleditDeb').val(data.incomeExpenseNormaleditDeb);
//                            $('#flatPercentageNormaleditDeb').val(data.flatPercentageNormaleditDeb);
//                            $('#amountNormaleditDeb').val(data.amountNormaleditDeb);

                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function cancelData(key) {
                var merchantcode = $('#merchantcodeedit').val();
                if (key == 'TAB1') {
                    editMerchant(merchantcode);
                } else if (key == 'TAB2') {
                    editMerchantTab2(merchantcode);
                }

            }

            function cancelDataTxn() {
                var merchantcode = $('#merchantcodeedit').val();
                editMerchantTxn(merchantcode);
            }

            function nextDivEdit(key) {

                if (key == 'div1') {
//                    $('#tone').hide();
//                    $('#tthree').show();
//                    $('#ttwo').show();
                    alert("huh ?");
                } else if (key == 'div2') {
                    $('#etone').hide();
                    $('#ettwo').show();
                    $('#etthree').hide();
                    $('#etfour').hide();
                    $('#etfive').hide();
                } else if (key == 'div3') {
                    $('#etone').hide();
                    $('#ettwo').hide();
                    $('#etthree').show();
                    $('#etfour').hide();
                    $('#etfive').hide();
                } else if (key == 'div4') {
                    $('#etone').hide();
                    $('#ettwo').hide();
                    $('#etthree').hide();
                    $('#etfour').show();
                    $('#etfive').hide();
                } else if (key == 'div5') {
                    $('#etone').hide();
                    $('#ettwo').hide();
                    $('#etthree').hide();
                    $('#etfour').hide();
                    $('#etfive').show();
                }
            }



            function backDivEdit(key) {
                if (key == 'div1') {
                    $('#etone').show();
                    $('#ettwo').hide();
                    $('#etthree').hide();
                    $('#etfour').hide();
                    $('#etfive').hide();
                } else if (key == 'div2') {
                    $('#etone').hide();
                    $('#ettwo').show();
                    $('#etthree').hide();
                    $('#etfour').hide();
                    $('#etfive').hide();
                } else if (key == 'div3') {
                    $('#etone').hide();
                    $('#ettwo').hide();
                    $('#etthree').show();
                    $('#etfour').hide();
                    $('#etfive').hide();
                } else if (key == 'div4') {
                    $('#etone').hide();
                    $('#ettwo').hide();
                    $('#etthree').hide();
                    $('#etfour').show();
                    $('#etfive').hide();
                }

            }

            function toleftEdit(key) {

                if (key == 'currency') {
                    $("#enewBox option:selected").each(function () {

                        $("#ecurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#emnewBox option:selected").each(function () {

                        $("#emcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#etnewBox option:selected").each(function () {

                        $("#etcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }

            }

            function torightEdit(key) {

                if (key == 'currency') {
                    $("#ecurrentBox option:selected").each(function () {

                        $("#enewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#emcurrentBox option:selected").each(function () {

                        $("#emnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#etcurrentBox option:selected").each(function () {

                        $("#etnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }

            }

            function toleftall(ee) {


            }

            function toleftallEdit(key) {

                if (key == 'currency') {
                    $("#enewBox option").each(function () {

                        $("#ecurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#emnewBox option").each(function () {

                        $("#emcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#etnewBox option").each(function () {

                        $("#etcurrentBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }


            }

            function torightallEdit(key) {

                if (key == 'currency') {
                    $("#ecurrentBox option").each(function () {

                        $("#enewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'mcc') {
                    $("#emcurrentBox option").each(function () {

                        $("#emnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                } else if (key == 'transaction') {
                    $("#etcurrentBox option").each(function () {

                        $("#etnewBox").append($('<option>', {
                            value: $(this).val(),
                            text: $(this).text()
                        }));
                        $(this).remove();
                    });
                }

            }

            function clickEdit() {
                //for currency
                $('#enewBox option').prop('selected', true);
                //for mcc
                $('#emnewBox option').prop('selected', true);
                //for transaction
                $('#etnewBox option').prop('selected', true);

                $("#editbtn").click();
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
                var merchantid = $('#merchantcodeedit').val();

                if (ter_mode_edit == 'YES') {
                    $('#banknameedit').prop('disabled', true);
                    $('#branchcodeedit').prop('disabled', true);
                    $('#branchedit').prop('disabled', true);
                    $('#paymenttypeedit').prop('disabled', false);
                    onchangefindpayment(merchantid);
                    $('#banknameedit').prop('value', '');
                    $('#branchcodeedit').prop('value', '');
                    $('#branchedit').prop('value', '');

                } else if (ter_mode_edit == 'NO') {
                    onchangefindnonntb(merchantid);
                    $('#banknameedit').prop('disabled', false);
                    $('#branchcodeedit').prop('disabled', false);
                    $('#branchedit').prop('disabled', false);
                    $('#paymenttypeedit').prop('disabled', true);
                    $('#paymenttypeedit').prop('value', '');
                }
            }

            function onchangefindpayment(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindMerchantMgt.action',
                    data: {merchantcode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#paymenttypeedit').val("");
                        } else {
                            $('#paymenttypeedit').val(data.paymenttype);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function onchangefindnonntb(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindMerchantMgt.action',
                    data: {merchantcode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#paymenttypeedit').val("");
                        } else {
                            $('#banknameedit').val(data.bankname);
                            $('#branchcodeedit').val(data.branchcode);
                            $('#branchedit').val(data.branch);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function flatORpercentage1(key) {
                var r1 = $('#flatPercentageCashInedit').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashInedit').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashInedit').prop('maxLength', "7");

                    sval = formatPercentage(key);

                }
                return sval;
            }

            function flatORpercentage2(key) {
                var r1 = $('#flatPercentageCashIneditDeb').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashIneditDeb').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashIneditDeb').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage3(key) {
                var r1 = $('#flatPercentageCashOutedit').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashOutedit').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashOutedit').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage4(key) {
                var r1 = $('#flatPercentageCashOuteditDeb').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountCashOuteditDeb').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountCashOuteditDeb').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage5(key) {
                var r1 = $('#flatPercentageNormaledit').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountNormaledit').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountNormaledit').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function flatORpercentage6(key) {
                var r1 = $('#flatPercentageNormaleditDeb').val();
                var sval;
                if (r1 == "FLAT") {
                    $('#amountNormaleditDeb').prop('maxLength', "8");
                    sval = formatNumber(key);
                } else if (r1 == "PER") {
                    $('#amountNormaleditDeb').prop('maxLength', "7");
                    sval = formatPercentage(key);
                }
                return sval;
            }

            function clearamount1() {
                $('#amountCashInedit').prop('value', "");
            }
            function clearamount2() {
                $('#amountCashIneditDeb').prop('value', "");
            }
            function clearamount3() {
                $('#amountCashOutedit').prop('value', "");
            }
            function clearamount4() {
                $('#amountCashOuteditDeb').prop('value', "");
            }
            function clearamount5() {
                $('#amountNormaledit').prop('value', "");
            }
            function clearamount6() {
                $('#amountNormaleditDeb').prop('value', "");
            }
        </script>  
        <style>
            #etthree select ,
            #etthree input[type=text] {
                height: 27px
                    //padding: 1px;
            }
            #etthree .horizontal_line_popup{
                margin: 2px;
            }
        </style>
    </head>
    <body>
        <div class="ali-modal">
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
            <div class="ali-modal-body">
                <div class="ali-form">
                    <s:div id="amessageedit">
                        <s:actionerror theme="jquery"/>
                        <s:actionmessage theme="jquery"/>
                    </s:div>
                    <s:form id="merchantedit" method="post" action="MerchantMgt" theme="simple" cssClass="form" >

                        <div id="etone">
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Merchant ID</label>
                                        <s:textfield name="merchantcode" id="merchantcodeedit" cssClass="form-control"  maxLength="15"  readonly="true"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Description</label>
                                        <s:textfield name="description" id="descriptionedit" cssClass="form-control"  maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>    


                            </div>

                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Merchant Customer Name </label>
                                        <s:select name="merchantCustomer" id="merchantCustomeredit" list="%{merchantCustomerList}"   headerValue="--Select Merchant Customer--" cssClass="form-control" headerKey=""  listKey="mid" listValue="name"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label >Acquirer Risk Profile</label>
                                            <s:select name="riskProfile" id="riskProfileedit" list="%{riskProfileList}"   headerKey=""  headerValue="--Select Acquirer Risk Profile--" listKey="profilecode" listValue="description" cssClass="form-control"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Status</label>
                                        <s:select name="status" id="statusedit" headerValue="--Select Status--" headerKey="" cssClass="form-control"   list="%{statusList}"   listKey="statuscode" listValue="description"/>                  
                                    </div>
                                </div>    


                            </div>           
                            <div class="row row_popup"> 
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Merchant Category Code</label>
                                        <s:select  id="merchantCustCategoryedit" name="merchantCustCategory" headerValue="--Select MCC--" headerKey="" cssClass="form-control" list="%{mccOriList}"  listKey="mcccode" listValue="mccdes"/> 
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label>Acquirer Promotion </label>
                                            <s:select name="promotion" id="promotionedit" headerValue="--Select Acquirer Promotion--" headerKey="" cssClass="form-control"   list="%{promotionList}"   listKey="code" listValue="description"/>                  
                                    </div>
                                </div>    
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Address</label>
                                        <s:textarea name="address" id="addressedit" maxLength="255" cssClass="form-control"  onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9.,/' ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9.,/' ]/g,''))"/>
                                    </div>  
                                </div>    
                            </div>
                            <div class="row row_popup">


                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label >Mobile</label>
                                        <s:textfield name="mobile" id="mobileedit" cssClass="form-control"  maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return alpha(event)"/>
                                    </div>  
                                </div> 
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <!--<span style="color: red"></span><label>POS Account </label>-->
                                        <!s:textfield  cssClass="form-control" name="posacc" id="posaccedit" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onkeypress="return alpha(event)"/>                 
                                    </div>
                                </div>
                                <!--                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <span style="color: red">*</span><label >Legal Name</label>
                                <%--<s:textfield name="legalname" id="legalnameedit" cssClass="form-control"  maxLength="120" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onkeypress="return alpha(event)"/>--%>
                            </div>
                        </div> -->
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label >Email</label>
                                            <s:textfield name="email1" id="email1edit" cssClass="form-control" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onkeypress="return alphaemail(event)"/>
                                    </div>  
                                </div>
                            </div>
                            <!--                <div class="row row_popup">
                                                <div class="col-sm-4">
                                                    <div class="form-group">
                                                        <span style="color: red">*</span><label >Longitude</label>   
                            <%--<s:textfield name="longitude" id="longitudeedit" cssClass="form-control"  maxLength="64" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" />--%>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label >Latitude</label>   
                            <%--<s:textfield name="latitude" id="latitudeedit" cssClass="form-control"  maxLength="64" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" />--%>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label >Email 1</label>
                            <%--<s:textfield name="email1" id="email1edit" cssClass="form-control" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onkeypress="return alphaemail(event)"/>--%>
                    </div>  
                </div>
            </div>-->

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
                                            onClick="cancelData('TAB1')"
                                            cssClass="btn btn-ali-reset btn-sm"
                                            />                          
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="efnextbtn"
                                            onclick="nextDivEdit('div3')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="ettwo" hidden="true">
                            <div class="row row_popup">    

                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label >Contact Number 1</label>
                                            <s:textfield name="contact1" id="contact1edit" cssClass="form-control"  maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return alpha(event)"/>
                                    </div>  
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label >Contact Number 2</label>
                                            <s:textfield name="contact2" id="contact2edit" cssClass="form-control"  maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" onkeypress="return alpha(event)"/>
                                    </div>  
                                </div>
                            </div>
                            <div class="row row_popup">    
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label >Email 2</label>
                                            <s:textfield name="email2" id="email1edit" cssClass="form-control" maxLength="255" onkeyup="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9a-zA-Z@._]/g,''))" onkeypress="return alphaemail(event)"/>
                                    </div>  
                                </div>    

                            </div>
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Bank Name </label>
                                        <s:textfield  cssClass="form-control" name="bankname" id="banknameedit" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Branch Code</label>
                                        <s:textfield  cssClass="form-control" name="branchcode" id="branchcodeedit" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Branch Name</label>
                                        <s:textfield  cssClass="form-control" name="branch" id="branchedit" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g, ''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>    
                            </div>    

                            <div class="row row_popup">
                                <div class="horizontal_line_popup" style=" margin-top:  90px;">

                                </div>
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
                                            value="Back"
                                            href="%{inserturl}"
                                            id="etbackbtnee"
                                            onclick="backDivEdit('div1')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                        <sj:submit 
                                            button="true" 
                                            value="Reset" 
                                            onClick="cancelData('TAB2')"
                                            cssClass="btn btn-ali-reset btn-sm"
                                            />                          
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="efnextbtnee"
                                            onclick="nextDivEdit('div3')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>
                            </div>
                        </div>            

                        <div id="etthree" hidden="true">
                            <div class="row row_popup">

                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Currency</label>
                                        <s:select  id="currencyedit" list="%{currencyList}"  headerValue="--Select Currency--" headerKey="" name="currency" listKey="currencycode" listValue="description" cssClass="form-control"/>
                                    </div>
                                </div>  

                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Flat/Percentage</label>
                                        <s:select  id="flatPercentageNormaledit"  name="flatPercentageNormal"  onchange="clearamount5()"
                                                   list="%{flatPercentageTypeList}"  headerValue="--Select Flat/Percentage--" headerKey="" listKey="code" listValue="description"  cssClass="form-control"  />                
                                    </div>
                                </div> 
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Amount</label>
                                        <s:textfield id="amountNormaledit" name="amountNormal" maxLength="8" cssClass="form-control" 
                                                     onkeyup="$(this).val(flatORpercentage5($(this).val()))" 
                                                     onmouseout="$(this).val(flatORpercentage5($(this).val()))" 
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
                                            id="assignbtnedit"
                                            onClick="assignMerchCurrEdit()"
                                            cssClass="btn btn-ali-submit btn-sm"             
                                            />
                                        <sj:submit
                                            button="true"
                                            value="Assign"
                                            id="assignbtnhiddenedit"
                                            onClick="assignMerchCurrUpdateEdit()"
                                            cssClass="btn btn-ali-submit btn-sm" 
                                            cssStyle="display:none"                            
                                            />
                                    </div>
                                </div>
                            </div>
                            <div id="tablediv">
                                <s:url var="listurl" action="assignMerchantMgt"/>
                                <sjg:grid
                                    id="gridtableCommisionedit"
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
                                    <sjg:gridColumn name="currencyCode" index="currencyCode" title="Edit" width="25" align="center" sortable="false" formatter="editformatterupdate" hidden="false"/>
                                    <sjg:gridColumn name="currencyCode" index="currencyCode" title="Delete" width="40" align="center" sortable="false" formatter="removeformatterupdate" hidden="false"/> 
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
                                            onClick="cancelDataTxn()"
                                            cssClass="btn btn-ali-reset btn-sm"
                                            />                          
                                        <sj:submit
                                            button="true"
                                            value="Back"
                                            href="%{inserturl}"
                                            id="backbtn4edit"
                                            onclick="backDivEdit('div1')"
                                            cssClass="btn btn-ali-submit btn-sm"  
                                            />                        
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="nextbtn4edit"
                                            onclick="nextDivEdit('div4')"
                                            cssClass="btn btn-ali-submit btn-sm"  
                                            />                        
                                    </div>
                                </div>
                            </div>

                        </div>            

                        <div id="etfour" hidden="true">
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
                                              name="currentBox" id="ecurrentBox" list="currencyCurrentList"									 
                                              ondblclick="torightEdit('currency')" style="height:160px;"/>

                                </div>
                                <div class="col-sm-2 text-center">
                                    <div class="row" style="height: 20px;"></div>
                                    <div class="row">
                                        <sj:a
                                            id="eright" 
                                            onClick="torightEdit('currency')" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="erightall" 
                                            onClick="torightallEdit('currency')" 
                                            button="true"
                                            style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="eleft" 
                                            onClick="toleftEdit('currency')" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="eleftall" 
                                            onClick="toleftallEdit('currency')" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <label>Blocked Currency</label>
                                    <s:select cssClass="form-control" multiple="true"
                                              name="newBox" id="enewBox" list="currencyNewList"									 
                                              ondblclick="toleftEdit('currency')" style="height:160px;" />
                                </div>
                            </div>
                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row ">
                                <div class="col-sm-6">
                                    <!--<div class="ali-mandatory-field">Mandatory fields are marked with <span>*</span></div>-->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group ali-margin f-right">
                                        <sj:submit
                                            button="true"
                                            value="Back"
                                            href="%{inserturl}"
                                            id="efbackbtn"
                                            onclick="backDivEdit('div3')"
                                            cssClass="btn btn-ali-submit btn-sm" 
                                            />                        
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="esnextbtn"
                                            onclick="nextDivEdit('div5')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="etfive" hidden="true">
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
                                              name="tcurrentBox" id="etcurrentBox" list="transactionCurrentList"									 
                                              ondblclick="torightEdit('transaction')" style="height:160px;"/>

                                </div>
                                <div class="col-sm-2 text-center">
                                    <div class="row" style="height: 20px;"></div>
                                    <div class="row">
                                        <sj:a
                                            id="etright" 
                                            onClick="torightEdit('transaction')" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="etrightall" 
                                            onClick="torightallEdit('transaction')" 
                                            button="true"
                                            style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="etleft" 
                                            onClick="toleftEdit('transaction')" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="etleftall" 
                                            onClick="toleftallEdit('transaction')" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <label>Blocked Transaction(s)</label>
                                    <s:select cssClass="form-control" multiple="true"
                                              name="tnewBox" id="etnewBox" list="transactionNewList"									 
                                              ondblclick="toleftEdit('transaction')" style="height:160px;" />
                                </div>
                            </div>
                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row ">
                                <div class="col-sm-6">
                                    <!--<div class="ali-mandatory-field">Mandatory fields are marked with <span>*</span></div>-->
                                </div>
                            </div>
                            <div class="row"> 
                                <div style="display: none; visibility: hidden;">
                                    <s:url action="UpdateMerchantMgt" var="updateturl"/>
                                    <sj:submit button="true" href="%{updateturl}" id="editbtn"
                                               targets="amessageedit" />
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group ali-margin f-right">
                                        <sj:submit
                                            button="true"
                                            value="Back"
                                            href="%{inserturl}"
                                            id="etbackbtn"
                                            onclick="backDivEdit('div4')"
                                            cssClass="btn btn-ali-submit btn-sm" 
                                            />                        

                                        <sj:submit
                                            button="true"
                                            value="Update"
                                            onclick="clickEdit()"
                                            id="editbtntmp"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>
                            </div>
                        </div>

                    </s:form>
                </div>
            </div>
        </div>     
    </body>
</html>
