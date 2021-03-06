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

//                $(".hideme1").hide();
//                $(".hideme").show();
            };
            function editformatter(cellvalue, options, rowObject) {
//                a = $("#addButton").is(':disabled');
//                u = $("#updateButton").is(':disabled');



                return "<a href='#' title='Edit' onClick='javascript:editAcquirerRiskProfile(&#34;" + cellvalue + "&#34;,&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
//            return "<a href='#' onClick='javascript:detail(&#34;"+cellvalue+"&#34;,&#34;"+rowObject.mobile+"&#34;)' title='View'><img class='ui-icon ui-icon-newwin' style='display:inline-table;border:none;'/></a>";




            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteAcquirerRiskProfileInit(&#34;" + cellvalue + "&#34;,&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
//                return "<a href='#/' title='Delete' onClick='javascript:deleteAcquirerRiskProfileInit(&#34;" + cellvalue + "&#34;&#44;&#34;" + rowObject.profileCode + "&#34;&#44;&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-trash' style='display:inline-table;border:none;'/></a>";
            }

//            function removeformatter(cellvalue, options, rowObject) {
//                return "<a href='#' title='Remove' onClick='javascript:del(&#34;" + cellvalue + "&#34;&#44;&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-circle-close' style='display:inline-table;border:none;'/></a>"; //               
//
//            }

            function editAcquirerRiskProfile(keyval, curr) {


//                $(".hideme").hide();        

                $.ajax({
                    url: '${pageContext.request.contextPath}/findAcquirerRiskProfile.action',
                    data: {profileCode: keyval, currency: curr},
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

                            $('#currency').val("");
                            $('#currency').prop('disabled', false);
                            $('#description').val("");
                            $('#status').val("");
                            $('#riskprofileType').val("");

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
                            $('#profileCode').attr("readonly", true);
                            $("#profileCode").css("color", "#858585");
                            $('#currency').val(data.currency);
                            $('#currency').prop('disabled', true);

                            $('#description').val(data.description);
                            $('#status').val(data.status);
                            $('#riskprofileType').val(data.riskprofileType);
                            
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

            function deleteAcquirerRiskProfileInit(keyval, curr) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval + "|" + curr).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete acquirer risk profile : ' + keyval + ' ?');
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
//                $('#dailyCount').attr("readonly", true);
//                $('#maxAmount').attr("readonly", true);
//                $('#minAmount').attr("readonly", true);
//                $('#dailyAmount').attr("readonly", true);
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




//                $('#updateButton').button("disable");
//                document.getElementById('updateButton').onclick = null;
//                
//                $('#addButton').button("enable");
//                document.getElementById('addButton').onclick = clickAdd;

                var a = document.getElementById('addButton').onclick;
                var u = document.getElementById('updateButton').onclick;

//                alert(a  + ' '+u);

//                a = $("#addButton").is(':disabled');
//                u = $("#updateButton").is(':disabled');

//                if (a == true && u == true) {
                if (a === null && u === null) {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                    editAcquirerRiskProfile(null);
                } else if (a === null && u) {
//                } else if (a == true && u == false) {
//                    $('#addButton').button("enable");
//                    $('#updateButton').button("disable");

                    $('#currency').prop('disabled', false);
                    $('#profileCode').attr('readonly', false);


                    var code = $('#profileCode').val();
                    var cur = $('#currency').val();
//                    var txntype = $('#txnType').val();

//                    alert( code +' '+cur);

                    $('#currency').prop('disabled', true);
                    $('#profileCode').attr('readonly', true);

                    editAcquirerRiskProfile(code, cur);
                } else if (a && u === null) {
//                } else if (a == false && u == true) {
//                    $('#addButton').button("enable");
//                    $('#updateButton').button("disable");
                    editAcquirerRiskProfile(null);
                }
//                $("#gridtable1").trigger("reloadGrid");
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

//                disableInputs();
                $('#profileCode').val("");
                $('#profileCode').attr("readonly", false);
                $("#profileCode").css("color", "black");
//                $('#posMaxTxnAmount').val("");
//                $('#posMinTxnAmount').val("");
//                $('#p2pMaxTxnAmount').val("");
//                $('#p2pMinTxnAmount').val("");
//                $('#posMaxTxnCountPerDay').val("");
//                $('#posMaxTxnAmountPerDay').val("");
//                $('#p2pMaxTxnCountPerDay').val("");
//                $('#p2pMaxTxnAmountPerDay').val("");




                $('#description').val("");
                $('#dailyCount').val("");

                $('#dailyAmount').val("");


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




//                    loadprofilecode();

                }
                $("#gridtable").trigger("reloadGrid");
//                $("#gridtable1").trigger("reloadGrid");


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
//                            $('#profileCode').val("");
//                            $("#profileCode").css("color", "black");
//                            $('#profileCode').attr("readonly", false);
//                           
//                            $('#dailyCount').val("");
//                             $('#dailyAmount').val("");
//                             $('#currency').val("");
//                             $('#currency').prop('disabled', false);
//                             $('#description').val("");
//                            $('#defaultStatus').val("");

//                            $('#maxAmount').val("");
//                            $('#minAmount').val("");


//                            $('#dailyCount').attr("readonly", true);
//                            $('#maxAmount').attr("readonly", true);
//                            $('#minAmount').attr("readonly", true);
//                            $('#dailyAmount').attr("readonly", true);
//                            $('#currency').prop('disabled', false);
//                            $('#txnType').prop('disabled', false);


//                            $('#posMaxTxnAmount').val("");
//                            $('#posMinTxnAmount').val("");
//                            $('#p2pMaxTxnAmount').val("");
//                            $('#p2pMinTxnAmount').val("");
//                            $('#posMaxTxnCountPerDay').val("");
//                            $('#posMaxTxnAmountPerDay').val("");
//                            $('#p2pMaxTxnCountPerDay').val("");
//                            $('#p2pMaxTxnAmountPerDay').val("");

//                            $('#txnType').val("");
//                            $('#updateButton').button("disable");
//                            $('#addButton').button("enable");
//                            $("#gridtable1").trigger("reloadGrid");
                        }
                        else {

                            $('#profileCode').attr("readonly", false);
                            $('#profileCode').val(data.profileCode);

//                            $("#profileCode").css("color", "#858585");
//                            $('#currency').val(data.currency);
//                            $('#currhiden').val(data.currency);
//                            $('#currency').prop('disabled', true);               

//                            $('#description').val(data.description);
//                            $('#defaultStatus').val(data.defaultStatus);

//                            $('#txnType').val(data.txnType);
//                            $('#txnType').prop('disabled', true);
//                            $('#dailyCount').attr("readonly", false);
//                            $('#maxAmount').attr("readonly", false);
//                            $('#minAmount').attr("readonly", false);
//                            $('#dailyAmount').attr("readonly", false);
//                            $('#dailyCount').val(data.dailyCount);
//                            $('#maxAmount').val(data.maxAmount);
//                            $('#minAmount').val(data.minAmount);
//                            $('#dailyAmount').val(data.dailyAmount);


//                            $('#updateButton').button("enable");
//                            $('#addButton').button("disable");
//                            disableInputs();
//                            $('#divmsg').empty();
//                            $("#gridtable1").trigger("reloadGrid");
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
                editAcquirerRiskProfile(null);
//                disableInputs();
                $('#profileCode').attr("readonly", false);
                $('#currency').attr("readonly", false);
                $("#profileCode").css("color", "black");
//                $("#gridtable1").trigger("reloadGrid");
            }


            function clickaddbutton() {

//                    alert()
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

//                alert(defaultStatus);
                if (defaultStatus === 'YES') {

                    $("#deletedialog1").dialog('open');
                    $("#deletedialog1").html('This will assign as the default acquirer risk profile. Click OK to confirm.');
                }

                else {
                    $("#updateB").click()

//    form = document.getElementById('taskadd');

//                        form.target = '_blank';
//    form.action = 'updateAcquirerRiskProfile';
//    form.target = 'divmsg';
//    form.submit();
//    var x = document.getElementById("myForm").target;

//    alert(x)
//    return true;
//                document.getElementById('theFormID').submit();

                }

            }



            function clickupdatebutton() {

                $("#updateB").click();
//                form = document.getElementById('taskadd');

                //                    form.target = '_blank';
//    form.action = 'updateAcquirerRiskProfile';
//    form.submit();
//    return true;



            }


            window.onload = function () {
                $('#updateButton').button("disable");
                document.getElementById('updateButton').onclick = null;

//                        alert($("#updateButton").is(':disabled'));
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
                                                <td>Risk Profile Code<span style="color: red">*</span></td>
                                                <td><s:textfield name="profileCode" id="profileCode" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" />


                                                <td>Description<span style="color: red">*</span></td>
                                                <td><s:textfield name="description" id="description" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                                                    </td> 

                                            </tr>
                                            <tr>
                                                <td>Status<span style="color: red">*</span></td>
                                                <td><s:select  id="status" list="%{statusList}"  headerValue="--Select Status--" headerKey="" name="status" listKey="statuscode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>

                                                <td>Risk Profile Type<span style="color: red">*</span></td>
                                                <td><s:select  id="riskprofileType" list="%{acquirerRiskprofileTypeList}"  headerValue="--Select Risk Type--" headerKey="" name="riskprofileType" listKey="profileType" listValue="description"  cssStyle="width: 153px"/>
                                                </td>

                                                <td></td>  
                                            </tr>                                         

                                            <tr>
                                                
                                            </tr>



                                            <tr>
                                                <td><span class="mandatoryfield">Mandatory fields are marked with *</span></td>
                                                <td><s:hidden id="oldValue" name="oldValue" ></s:hidden>
                                                    </td>
                                                </tr>



                                                <tr style="display: none; visibility: hidden;">

                                                    <td><s:url var="addurl" action="addAcquirerRiskProfile"/>
                                                    <sj:submit button="true" href="%{addurl}" targets="divmsg" id="addB"/>
                                                    <s:url var="updateurl" action="updateAcquirerRiskProfile"/>
                                                    <sj:submit button="true" href="%{updateurl}" targets="divmsg" id="updateB"/>

                                                </td> <td>





                                                </td>

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


                            <%--                                                        start newly changed
                            <sj:dialog 
                                id="adddialog" 
                                buttons="{ 
                                'OK':function() { AddSection($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Add Section"                            
                                />
                                Start add process dialog box 
                            <sj:dialog 
                                id="addsuccdialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}
                                }"  
                                autoOpen="false" 
                                modal="true" 
                                title="Adding Process." 
                                />
                            end newly changed

                             Start delete confirm dialog box --%>
                            <sj:dialog 
                                id="deletedialog" 
                                buttons="{ 
                                'OK':function() { deleteAcquirerRiskProfile($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete Acquirer Risk Profile"                            
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
                                <s:url var="listurl" action="listAcquirerRiskProfile"/>                            
                                <sjg:grid
                                    id="gridtable"
                                    caption="Acquirer Risk Profile"
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
                                    <sjg:gridColumn name="profilecode" index="profilecode"  title="Risk Profile Code"  sortable="true"/>
                                    <sjg:gridColumn name="description" index="description" title="Description" sortable="true"/>   
                                    <sjg:gridColumn name="status" index="status.description" title="Status" sortable="true"/>   
                                    <sjg:gridColumn name="acquirerRiskprofileType" index="acquirerRiskprofileType.description" title="Risk Profile Type" sortable="true"/>   
                                    
                                    <sjg:gridColumn name="profilecode" index="profilecode" title="Edit" width="60" align="center" formatter="editformatter" />
                                    <sjg:gridColumn name="profilecode" index="profilecode"  title="Delete" width="60" align="center" formatter="deleteformatter"/> 
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
