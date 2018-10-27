<%-- 
    Document   : acquirerriskprofile
    Created on : Feb 3, 2016, 12:51:08 PM
    Author     : pivithuru_l
--%>

<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="com.arkentos.util.varlist.CommonVarList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>

        <%@include file="/stylelinks.jspf" %>

        <script type="text/javascript">

            window.onload = function () {
                $("#profileCode").css("color", "black");
            };
            function editformatter(cellvalue, options, rowObject) { 
                
                return "<a href='#' title='Edit' onClick='javascript:editAcquirerRiskProfileTxn(&#34;" + cellvalue + "&#34;,&#34;" + rowObject.txnType + "&#34;,&#34;" + rowObject.currency + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteAcquirerRiskProfileTxnInit(&#34;" + cellvalue + "&#34;,&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
           }

            function editAcquirerRiskProfileTxn(keyval, txntype,currency) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findAcquirerRiskProfileTxn.action',
                    data: {profileCode: keyval, txnType: txntype,currency:currency},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsg').empty();
                        var msg = data.message;
                        if (msg) {

                            $(".hideme1").hide();
                            $('#profileCode').val("");
                            $("#profileCode").css("color", "black");
                            $('#profileCode').attr("readonly", false);

                            $('#txnType').val("");
                            $("#txnType").css("color", "black");
                            $('#txnType').attr("readonly", false);
                            
                            $('#currency').val("");
                            
                            $('#dailyCount').val("");
                            $('#maxAmount').val("");
                            $('#minAmount').val("");
                            $('#dailyAmount').val("");

                            $('#updateButton').button("disable");
                            document.getElementById('updateButton').onclick = null;

                            $('#addButton').button("enable");
                            document.getElementById('addButton').onclick = clickAdd;

                            $('#oldValue').val("");
                            $("#gridtable1").trigger("reloadGrid");
                        }
                        else {
                            
                            $(".hideme1").show();
                            $('#profileCode').val(data.profileCode);
                            $("#profileCode").css("color", "#858585");
                            $('#profileCode').prop('disabled', true);
                            $('#txnType').val(data.txnType);
                            $("#txnType").css("color", "#858585");
                            $('#txnType').prop('disabled', true);
                            
                            $('#currency').val(data.currency);
                            $('#description').val(data.description);

                            
                            $('#dailyCount').val(data.dailyCount);
                            $('#maxAmount').val(data.maxAmount);
                            $('#minAmount').val(data.minAmount);
                            $('#dailyAmount').val(data.dailyAmount);

                            $('#updateButton').button("enable");
                            document.getElementById('updateButton').onclick = clickUpdate;
                            $('#addButton').button("disable");
                            document.getElementById('addButton').onclick = null;

                            $('#oldValue').val(data.oldValue);
                            $('#divmsg').empty();
                            $("#gridtable1").trigger("reloadGrid");
                        }
                    },
                    error: function (data) {
                        //                        $("#deleteerrordialog").html("Error occurred while processing.").dialog('open');
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function removeDecimals(input) {
                var output = input | 0;
                return output;
            }

            function deleteAcquirerRiskProfileTxnInit(keyval, curr) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval + "|" + curr).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete Acquirer risk profile transaction : ' + keyval + ' ?');
                return false;
            }
            
            function deleteAcquirerRiskProfile(keyval) {

                var ar = new String(keyval);
                var arr = ar.split("\|");
                var profcode = arr[0];
                var curr = arr[1];

                $.ajax({
                    url: '${pageContext.request.contextPath}/deleteAcquirerRiskProfile.action',
                    data: {profileCode: profcode, currency: curr},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#deletesuccdialog").dialog('open');
                        $("#deletesuccdialog").html(data.message);
                        $("#gridtable").trigger("reloadGrid");
                        resetFieldData();

                    },
                    error: function (data) {
                        alert("unsuccess");
                        //window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function disableInputs() {
                $('#txnType').val("");
                $('#dailyCount').val("");
                $('#maxAmount').val("");
                $('#minAmount').val("");
                $('#dailyAmount').val("");
                $('#assignButton').button("disable");
            }

            function enableInputs() {
//                $('#divmsg').empty();
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

                if ($('#txnType').val() !== "" || $('#currency').val() !== "" && a == false && u == true) {
                    $('#dailyCount').attr("readonly", false);
                    $('#maxAmount').attr("readonly", false);
                    $('#minAmount').attr("readonly", false);
                    $('#dailyAmount').attr("readonly", false);
//                    $('#assignButton').button("enable");

                } else if (a == true && u == false) {
                    var type = $('#txnType').val();
                    $('#dailyCount').attr("readonly", false);
                    $('#maxAmount').attr("readonly", false);
                    $('#minAmount').attr("readonly", false);
                    $('#dailyAmount').attr("readonly", false);
//                    $('#assignButton').button("enable");

//                    $.ajax({
//                        url: '${pageContext.request.contextPath}/loadAcquirerRiskProfile.action',
//                        data: {txnType: type},
//                        dataType: "json",
//                        type: "POST",
//                        success: function(data) {
//                            $("#gridtable1").trigger("reloadGrid");
//                        },
//                        error: function(data) {
//                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
//                        }
//                    });
                }
                if ($('#txnType').val() === "" || $('#currency').val() === "") {
//                    disableInputs();
//                    $('#divmsg').empty();
                }
            }

            function assign() {
                var profileCode = $('#profileCode').val();
                var txnType = $('#txnType').val();
                var dailyCount = $('#dailyCount').val();
                var maxAmount = $('#maxAmount').val();
                var minAmount = $('#minAmount').val();
                var dailyAmount = $('#dailyAmount').val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/assignAcquirerRiskProfile.action',
                    data: {
                        profileCode: profileCode,
                        txnType: txnType,
                        dailyCount: dailyCount,
                        maxAmount: maxAmount,
                        minAmount: minAmount,
                        dailyAmount: dailyAmount
                    },
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        var msg = data.message;
                        if (msg) {
                            $('#divmsg').html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0.3em 0.7em; margin-top: 20px;\"> \n" +
                                    "<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: 0.3em;\"></span>\n" +
                                    "<span>" + msg + "</span></p>\n" +
                                    "</div>");
                            $("#gridtable1").trigger("reloadGrid");
                        } else {
                            disableInputs();
                            $('#divmsg').empty();
                            $("#gridtable1").trigger("reloadGrid");
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function del(keyVal) {
                if (keyVal) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/removeAcquirerRiskProfile.action',
                        data: {txnType: keyVal},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            $("#gridtable1").trigger("reloadGrid");
                        },
                        error: function (data) {
                            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                        }
                    });
                }
            }


            function resetAllData() {

                var a = document.getElementById('addButton').onclick;
                var u = document.getElementById('updateButton').onclick;

                if (a === null && u === null) {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                    editAcquirerRiskProfileTxn(null);
                } else if (a === null && u) {

                    $('#txnType').prop('disabled', false);
                    $('#currency').prop('disabled', false);
                    $('#profileCode').attr('readonly', false);


                    var code = $('#profileCode').val();
                    var txntype = $('#txnType').val();
                    var currency = $('#currency').val();

                    $('#txnType').prop('disabled', true);
                    //$('#currency').prop('disabled', true);
                    $('#profileCode').attr('readonly', true);

                    editAcquirerRiskProfileTxn(code, txntype, currency);
                } else if (a && u === null) {
                    editAcquirerRiskProfileTxn(null);
                }
                $("#gridtable").trigger("reloadGrid");
            }

            function resetFieldData() {


                $('#updateButton').button("disable");
                document.getElementById('updateButton').onclick = null;

                $('#addButton').button("enable");
                document.getElementById('addButton').onclick = clickAdd;

                $(".hideme1").hide();
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

                $('#profileCode').val("");
                $('#profileCode').attr("readonly", false);
                $("#profileCode").css("color", "black");
                
                $('#txnType').val("");
                $('#txnType').attr("readonly", false);
                $("#txnType").css("color", "black");

                $('#description').val("");
                $('#dailyCount').val("");

                $('#dailyAmount').val("");
                
                $('#minAmount').val("");
                $('#maxAmount').val("");


                $('#currency').prop('disabled', false);
//                $('#txnType').prop('disabled', false);
                $('#currency').val("");
                $('#status').val("");
//                $('#txnType').val("");

                if (a == true && u == true) {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                } else if (a == true && u == false) {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                } else if (a == false && u == true) {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");

                }
                $("#gridtable").trigger("reloadGrid");
            }

            function loadprofilecode() {

                $.ajax({
                    url: '${pageContext.request.contextPath}/loadAcquirerRiskProfile.action',
                    data: {},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {

                        var msg = data.message;
                        if (msg) {

                        }
                        else {

                            $('#profileCode').attr("readonly", false);
                            $('#profileCode').val(data.profileCode);

                        }
                    },
                    error: function (data) {
                        //                        $("#deleteerrordialog").html("Error occurred while processing.").dialog('open');

                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });

            }
           
            function cancelAllData() {
                $(".hideme1").hide();
                editAcquirerRiskProfileTxn(null);
                $('#profileCode').attr("readonly", false);
                $('#txnType').attr("readonly", false);
                $("#profileCode").css("color", "black");
            }


            function clickaddbutton() {

                $("#addB").click();
            }

            function clickAdd() {
                var defaultStatus = $('#defaultStatus').val();

                if (defaultStatus === 'YES') {


                    $("#deletedialog2").dialog('open');
                    $("#deletedialog2").html('This will assign as the default acquirer risk profile. Click OK to confirm.');
                } else {

                    $("#addB").click();
                }

            }

            function clickUpdate() {
                var defaultStatus = $('#defaultStatus').val();

                if (defaultStatus === 'YES') {
                    $("#deletedialog1").dialog('open');
                    $("#deletedialog1").html('This will assign as the default acquirer risk profile. Click OK to confirm.');
                }

                else {
                    $("#updateB").click()


                }

            }



            function clickupdatebutton() {

                $("#updateB").click();

            }


            window.onload = function () {
                $('#updateButton').button("disable");
                document.getElementById('updateButton').onclick = null;

//                        alert($("#updateButton").is(':disabled'));
            }
            
            function formatNumber(num) {
                var renum = num.replace(/[^0-9]/g, '');
                return renum.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
            }
            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k >= 48 && k <= 57));
            }




        </script>

        <style type="text/css">

            .hideme1{
                display:none;

            }
        </style>
    </head>

    <!--<body style="" onload="disableInputs()">-->
    <body style="">
        <jsp:include page="/header.jsp"/>

        <div class="main-container">


            <jsp:include page="/leftmenu.jsp"/>

            <div class="main-content">

                <div class="container" style="min-height: 760px;">


                    <!-- start: PAGE NAVIGATION BAR -->
                    <jsp:include page="/navbar.jsp"/>
                    <!-- end: NAVIGATION BAR -->

                    <div class="row">


                        <div id="content1">

                            <s:div id="divmsg">                                
                                <s:actionerror theme="jquery"/>                              
                                <s:actionmessage theme="jquery"/>
                            </s:div>
                            <s:actionerror theme="jquery"/>                              
                            <s:actionmessage theme="jquery"/>

                            <s:set id="vadd" var="vadd"><s:property value="vadd" default="true"/></s:set>
                            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>                            
                            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
                            <s:set var="vremovelink"><s:property value="vremovelink" default="true"/></s:set>
                            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>

                                <!--<onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))">-->

                                <div  id="formstyle">
                                <s:form id="taskadd" method="post" action="AcquirerRiskProfile" theme="simple" > 

                                    <table border="0"  cellpadding="5" class="hideme">

                                        <tbody>

                                            <tr>
                                                <td>Risk Profile Type<span style="color: red">*</span></td>
                                                <td><s:select  id="profileCode" list="%{profileCodeList}"  headerValue="--Select Risk Profile--" headerKey="" name="profileCode" listKey="profilecode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>

                                                <td>Risk Transaction Type<span style="color: red">*</span></td>
                                                <td><s:select  id="txnType" list="%{txnTypeList}"  headerValue="--Select Transaction--" headerKey="" name="txnType" listKey="typecode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>Min Amount<span style="color: red">*</span></td>
                                                <td><s:textfield name="minAmount" id="minAmount" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>

                                                <td>Max Amount<span style="color: red">*</span></td>
                                                <td><s:textfield name="maxAmount" id="maxAmount" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                            </tr>                                         
                                            <tr>
                                                <td>Daily Count<span style="color: red">*</span></td>
                                                <td><s:textfield name="dailyCount" id="dailyCount" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))" />
                                                </td>
                                                
                                                <td>Daily Amount<span style="color: red">*</span></td>
                                                <td><s:textfield name="dailyAmount" id="dailyAmount" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                            </tr>                                         

                                            <tr>
                                                <td>Currency<span style="color: red">*</span></td>
                                                <td><s:select  id="currency" list="%{currencyList}"  headerValue="--Select Currency--" headerKey="" name="currency" listKey="currencycode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>
                                            </tr>



                                            <tr>
                                                <td><span class="mandatoryfield">Mandatory fields are marked with *</span></td>
                                                <td><s:hidden id="oldValue" name="oldValue" ></s:hidden>
                                                    </td>
                                            </tr>



                                                <tr style="display: none; visibility: hidden;">

                                                    <td><s:url var="addurl" action="addAcquirerRiskProfileTxn"/>
                                                    <sj:submit button="true" href="%{addurl}" targets="divmsg" id="addB"/>
                                                    <s:url var="updateurl" action="updateAcquirerRiskProfileTxn"/>
                                                    <sj:submit button="true" href="%{updateurl}" targets="divmsg" id="updateB"/>

                                                </td> 
                                                    <td> </td>

                                            </tr>

                                            <tr>
                                                <td>

                                                </td>
                                                <td>

                                                    <sj:a button="true" id="addButton"  onclick="clickAdd()" disabled="#vadd">Add</sj:a> 

                                                    <sj:a button="true" disabled="true" id="updateButton" onclick="clickUpdate()">Update</sj:a> 


                                                    <sj:submit button="true" type="reset" value="Reset" name="reset" onClick="resetAllData()"  />

                                                    <sj:submit button="true" value="Cancel" name="cancel" onClick="cancelAllData()"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                </td>
                                            </tr>

                                        </tbody>
                                    </table>                                  



                                </s:form>
                            </div>

                            <sj:dialog 
                                id="deletedialog" 
                                buttons="{ 
                                'OK':function() { deleteAcquirerRiskProfileTxn($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete Acquirer Risk Transaction"                            
                                />

                            <sj:dialog 
                                id="deletedialog2" 
                                buttons="{ 
                                'OK':function() { clickaddbutton();$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Confirmation"                            
                                />

                            <sj:dialog 
                                id="deletedialog1" 
                                buttons="{ 
                                'OK':function() { clickupdatebutton();$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Confirmation"                            
                                />
                            <%--
                             Start delete process dialog box 
                            --%>
                            <sj:dialog 
                                id="deletesuccdialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}
                                }"  
                                autoOpen="false" 
                                modal="true" 
                                title="Deleting Process." 
                                />
                            <%--
                             Start delete error dialog box 
                            <sj:dialog 
                                id="deleteerrordialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}                                    
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete error."
                                />--%>

                            <div id="tablediv">
                                <s:url var="listurl" action="listAcquirerRiskProfileTxn"/>                            
                                <sjg:grid
                                    id="gridtable"
                                    caption="Acquirer Risk Profile Transaction"
                                    dataType="json"
                                    href="%{listurl}"
                                    pager="true"
                                    gridModel="gridModel"
                                    rowList="10,15,20"
                                    rowNum="10"
                                    autowidth="true"                                                           
                                    rownumbers="true"
                                    onCompleteTopics="completetopics"
                                    rowTotal="false"
                                    viewrecords="true"
                                    >
                                    <sjg:gridColumn name="profilecode" index="id.profilecode"  title="Risk Profile Code"  sortable="true"/>
                                    <sjg:gridColumn name="txnType" index="id.txntypecode" title="Transaction Type" sortable="true"/>   
                                    <sjg:gridColumn name="currency" index="currency" title="Currency" sortable="true"/>   
                                    <sjg:gridColumn name="minAmount" index="minAmount" title="Minimum Amount" sortable="true"/>   
                                    <sjg:gridColumn name="maxAmount" index="maxAmount" title="Maxmimum Amount" sortable="true"/>   
                                    
                                    <sjg:gridColumn name="profilecode"  index="id.profilecode" title="Edit" width="60" align="center" formatter="editformatter" />
                                    <sjg:gridColumn name="profilecode" index="id.profilecode"  title="Delete" width="60" align="center" formatter="deleteformatter"/> 
                                </sjg:grid> 
                            </div>
                        </div>
                    </div>




                    <!-- end: PAGE CONTENT-->
                </div>
            </div>
            <!-- end: PAGE -->
        </div>
        <!-- end: MAIN CONTAINER -->
        <!-- start: FOOTER -->
        <jsp:include page="/footer.jsp"/>
        <!-- end: FOOTER -->



        <!-- end: BODY -->
    </body>
</html>
