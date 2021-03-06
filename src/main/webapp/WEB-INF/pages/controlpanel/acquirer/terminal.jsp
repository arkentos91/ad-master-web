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
                $("#code").css("color", "black");
            };
            function editformatter(cellvalue, options, rowObject) {

                return "<a href='#' title='Edit' onClick='javascript:editAcquirerPromotion(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteAcquirerPromotionInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editAcquirerPromotion(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/findAcquirerPromotion.action',
                    data: {code: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsg').empty();
                        var msg = data.message;
                        if (msg) {

                            $(".hideme1").hide();
                            $('#code').val("");
                            $("#code").css("color", "black");
                            $('#code').attr("readonly", false);


                            $('#status').val("");

                            $('#description').val("");
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
                            $('#code').val(data.code);
                            $("#code").css("color", "#858585");
                            $('#code').prop('disabled', true);


                            $('#status').val(data.status);
                            $('#description').val(data.description);



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

            function deleteAcquirerPromotionInit(keyval, curr) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete risk profile : ' + keyval + ' ?');
                return false;
            }

            function deleteAcquirerRiskProfile(keyval) {

                var ar = new String(keyval);
                var arr = ar.split("\|");
                var profcode = arr[0];
                var curr = arr[1];

                $.ajax({
                    url: '${pageContext.request.contextPath}/deleteAcquirerRiskProfile.action',
                    data: {code: profcode, currency: curr},
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
                var code = $('#code').val();
                var txnType = $('#txnType').val();
                var dailyCount = $('#dailyCount').val();
                var maxAmount = $('#maxAmount').val();
                var minAmount = $('#minAmount').val();
                var dailyAmount = $('#dailyAmount').val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/assignAcquirerRiskProfile.action',
                    data: {
                        code: code,
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
                    editAcquirerPromotion(null);
                } else if (a === null && u) {

                    $('#txnType').prop('disabled', false);
                    $('#code').attr('readonly', false);


                    var code = $('#code').val();
                    var txntype = $('#txnType').val();

                    $('#txnType').prop('disabled', true);
                    $('#code').attr('readonly', true);

                    editAcquirerPromotion(code, txntype);
                } else if (a && u === null) {
                    editAcquirerPromotion(null);
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

                $('#code').val("");
                $('#code').attr("readonly", false);
                $("#code").css("color", "black");

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

                            $('#code').attr("readonly", false);
                            $('#code').val(data.code);

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
                editAcquirerPromotion(null);
                $('#code').attr("readonly", false);
                $('#txnType').attr("readonly", false);
                $("#code").css("color", "black");
            }


            function clickaddbutton() {

                $("#addB").click();
            }

            function clickAdd() {
                var defaultStatus = $('#defaultStatus').val();

                if (defaultStatus === 'YES') {


                    $("#deletedialog2").dialog('open');
                    $("#deletedialog2").html('This will assign as the default risk profile. Click OK to confirm.');
                } else {

                    $("#addB").click();
                }

            }

            function clickUpdate() {
                var defaultStatus = $('#defaultStatus').val();

                if (defaultStatus === 'YES') {
                    $("#deletedialog1").dialog('open');
                    $("#deletedialog1").html('This will assign as the default risk profile. Click OK to confirm.');
                }

                else {
                    $("#updateB").click();


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
                                                <td>Terminal ID<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="id" id="id" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Merchant ID<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:select  id="merchantOri" list="%{midList}"  headerValue="--Select Status--" headerKey="" name="merchantOri" listKey="mid" listValue="mid"  cssStyle="width: 153px"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Terminal Name<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="terminalname" id="terminalname" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Serial Number<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="serialno" id="serialno" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td>Manufacturer<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="terminalname" id="terminalname" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Model<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="serialno" id="serialno" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^0-9.]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9.]/g,''))"/>
                                                </td>
                                            </tr>    
                                            <tr>
                                                <td>Status<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:select  id="status" list="%{statusList}"  headerValue="--Select Status--" headerKey="" name="status" listKey="statuscode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Description<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="description" id="description" maxLength="50" />
                                                </td>
                                            </tr>                                         
                                            <tr>
                                                <td>Risk Profile<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:select  id="status" list="%{statusList}"  headerValue="--Select Status--" headerKey="" name="status" listKey="statuscode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>
                                                <td style="width: 60px" ></td>
                                                <td>Mobile<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:textfield name="description" id="description" maxLength="50" />
                                                </td>
                                            </tr>     
                                            <tr>
                                                <td>Terminal Category<span style="color: red">*</span></td>
                                                <td style="width: 50px" ></td>
                                                <td><s:select  id="status" list="%{statusList}"  headerValue="--Select Status--" headerKey="" name="status" listKey="statuscode" listValue="description"  cssStyle="width: 153px"/>
                                                </td>
                                                <td style="width: 60px" ></td>

                                            </tr>  
                                            <tr>   
                                                <tr>
                                                    <td>Assigned Transaction(s)</td>
                                                    <td style="width: 50px" ></td>
                                                    <td>Blocked Transaction(s)</td>
                                                    <td style="width: 100px" ></td>

                                                </tr>
                                                <tr>
                                                    <td style="float: right;"><s:select multiple="true"
                                                              name="currentBox" id="currentBoxadd" list="currentList"									 
                                                              ondblclick="toright()" style="height:120px;min-width:150px;" />
                                                    </td>
                                                    <td style="text-align: center; width: 50px"><sj:a
                                                            id="right" onClick="toright()" button="true"
                                                            style="font-size:10px;width:30px;margin:2px;"> > </sj:a> </br> <sj:a
                                                            id="rightall" onClick="torightall()" button="true"
                                                            style="font-size: 10px;width:30px;margin:2px;"> >> </sj:a></br> <sj:a
                                                            id="left" onClick="toleft()" button="true"
                                                            style="font-size:10px;width:30px;margin:2px;"><</sj:a></br> <sj:a
                                                            id="leftall" onClick="toleftall()" button="true"
                                                            style="font-size:10px;width:30px;margin:2px;"><<</sj:a>
                                                        </td>
                                                        <td style="float: left;"><s:select multiple="true"
                                                              name="newBox" id="newBoxadd" list="newList"										 
                                                              ondblclick="toleft()" style="height:120px; min-width:150px;" />
                                                    </td> 

                                                    <td style="width: 100px" ></td>


                                                </tr>

                                            </tr>



                                            <tr>
                                                <td><span class="mandatoryfield">Mandatory fields are marked with *</span></td>
                                                <td><s:hidden id="oldValue" name="oldValue" ></s:hidden>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> <s:url var="addurl" action="addAcquirerPromotion"/></td>
                                                <td><s:url var="updateurl" action="updateAcquirerPromotion"/> </td>
                                                <td>
                                                    <sj:submit button="true" href="%{addurl}" value="Add"  targets="divmsg" id="addButton"  disabled="#vadd"/>
                                                    <sj:submit button="true" href="%{updateurl}" value="Update" targets="divmsg"   disabled="#vupdatebutt" id="updateButton"/>
                                                    <sj:submit button="true" value="Reset" name="reset" onClick="resetAllData()"  />
                                                    <sj:submit button="true" value="Cancel" name="cancel" onClick="cancelAllData()"  />
                                                </td>
                                            </tr>


                                        </tbody>
                                    </table>                                  



                                </s:form>
                            </div>


                            <sj:dialog 
                                id="deletedialog" 
                                buttons="{ 
                                'OK':function() { deleteAcquirerPromotion($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete Promotion"                            
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
                                <s:url var="listurl" action="listAcquirerPromotion"/>                            
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
                                    <sjg:gridColumn name="code" index="code"  title="Promotion Code"  sortable="true"/>
                                    <sjg:gridColumn name="description" index="description" title="Description" sortable="true"/>   
                                    <sjg:gridColumn name="status" index="status.description" title="Status" sortable="true"/>   

                                    <sjg:gridColumn name="code"  index="code" title="Edit" width="60" align="center" formatter="editformatter" />
                                    <sjg:gridColumn name="code" index="code"  title="Delete" width="60" align="center" formatter="deleteformatter"/> 
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
