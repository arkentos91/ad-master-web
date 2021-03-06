<%-- 
    Document   : responsecodes
    Created on : Jun 21, 2017, 12:23:06 PM
    Author     : jayana_i
--%>

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
                $("#responsecode").css("color", "black");
            }

            function editformatter(cellvalue, options, rowObject) {
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');
                return "<a href='#' title='Edit' onClick='javascript:editResponseCodes(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteResponseCodesInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }


            function editResponseCodes(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindResponseCodes.action',
                    data: {responsecode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divmsg').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#responsecode').val("");
                            $('#responsecode').attr('readOnly', false);
                            $("#responsecode").css("color", "black");
                            $('#description').val("");
                            $('#end_user_msg').val("");
                            $('#status').val('<s:property value="defaultStatus" />');
//                            $('#status').prop('disabled', true);

                            $('#divmsg').text("");
                            $('#updateButton').button("disable");

                            var startStatus = <s:property value="vadd" />;
                            if (startStatus) {
                                $('#addButton').button("disable");
                            } else {
                                $('#addButton').button("enable");
                            }
                        }
                        else {
                            $('#oldvalue').val(data.oldvalue);
                            $('#responsecode').val(data.responsecode);
                            $('#responsecode').attr('readOnly', true);
                            $("#responsecode").css("color", "#858585");
                            $('#description').val(data.description);
                            $('#end_user_msg').val(data.end_user_msg);
//                            $('#status').prop('disabled', false);
                            $('#status').val(data.status);



                            $('#addButton').button("disable");
                            $('#updateButton').button("enable");
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function deleteResponseCodesInit(keyval) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete response code ' + keyval + ' ?');
                return false;
            }

            function deleteResponseCodes(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteResponseCodes.action',
                    data: {responsecode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#deletesuccdialog").dialog('open');
                        $("#deletesuccdialog").html(data.message);
                        resetFieldData();
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function resetAllData() {
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

                if (a == true && u == true) {
                    editResponseCodes(null);

                } else if (a == true && u == false) {
                    var responsecode = $('#responsecode').val();
                    $('#responsecode').attr('readOnly', true);
                    editResponseCodes(responsecode);
                } else if (a == false && u == true) {
                    editResponseCodes(null);
                }
            }

            function resetFieldData() {

                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');

                var startStatus = '<s:property value="vadd" />'
                $('#responsecode').val("");
                $('#responsecode').attr('readOnly', false);
                $("#responsecode").css("color", "black");
                $('#description').val("");
                $('#end_user_msg').val("");
                $('#status').val('<s:property value="defaultStatus" />');
//                $('#status').prop('disabled', true);


                if (a == true && u == true) {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                } else if (a == true && u == false && startStatus == 'false') {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                } else if (a == true && u == false && startStatus == 'true') {
                    $('#addButton').button("disable");
                    $('#updateButton').button("disable");
                } else if (a == false && u == true) {
                    $('#addButton').button("enable");
                    $('#updateButton').button("disable");
                }
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function cancelAllData() {
                editResponseCodes(null);
            }
        </script>

    </head>

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

                            <s:set id="vadd" var="vadd"><s:property value="vadd" default="true"/></s:set>
                            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
                            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
                            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>

                                <div id="formstyle">
                                <s:form id="responsecodesadd" method="post" action="ResponseCodes" theme="simple" >
                                    <s:hidden id="oldvalue" name="oldvalue" ></s:hidden>

                                        <div class="row row_1">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <span style="color: red">*</span><label>Code</label>
                                                <s:textfield cssClass="form-control" name="responsecode" id="responsecode" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g, ''))"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red">*</span><label>Name</label>
                                                <s:textfield cssClass="form-control" name="description" id="description" maxLength="128" />
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red">*</span><label>End User Message</label>
                                                <s:textfield cssClass="form-control" name="end_user_msg" id="end_user_msg" maxLength="128" />
                                            </div>
                                        </div>
                                    </div> 
                                    <s:url var="addurl" action="AddResponseCodes"/>
                                    <s:url var="updateurl" action="UpdateResponseCodes"/>
                                    <div class="row row_popup form-inline">
                                        <div class="col-sm-9">
                                            <div class="form-group">
                                                <span class="mandatoryfield">Mandatory fields are marked with *</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row row_1 form-inline">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <sj:submit button="true" href="%{addurl}" value="Add" targets="divmsg" id="addButton"  disabled="#vadd"
                                                           cssClass="form-control btn_normal"
                                                           cssStyle="border-radius: 12px;background-color:#969595;color:white;"/>
                                            </div>
                                            <div class="form-group">
                                                <sj:submit button="true" href="%{updateurl}" value="Update" targets="divmsg"   disabled="#vupdatebutt" id="updateButton"
                                                           cssClass="form-control btn_normal"
                                                           cssStyle="border-radius: 12px;background-color:#969595;color:white;"/>
                                            </div>
                                            <div class="form-group">
                                                <sj:submit button="true" value="Reset" name="reset" onClick="resetAllData()" 
                                                           cssClass="form-control btn_normal"
                                                           cssStyle="border-radius: 12px;"/>
                                            </div>
                                            <div class="form-group">
                                                <sj:submit button="true" value="Cancel" name="cancel" onClick="cancelAllData()"
                                                           cssClass="form-control btn_normal"
                                                           cssStyle="border-radius: 12px;"/>
                                            </div>

                                        </div>
                                    </div>

                                </s:form>
                            </div>

                            <!-- Start delete confirm dialog box -->
                            <sj:dialog 
                                id="deletedialog" 
                                buttons="{ 
                                'OK':function() { deleteResponseCodes($(this).data('keyval'));$( this ).dialog( 'close' ); },
                                'Cancel':function() { $( this ).dialog( 'close' );} 
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete Response Codes"                            
                                />
                            <!-- Start delete process dialog box -->
                            <sj:dialog 
                                id="deletesuccdialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}
                                }"  
                                autoOpen="false" 
                                modal="true" 
                                title="Deleting Process." 
                                />
                            <!-- Start delete error dialog box -->
                            <sj:dialog 
                                id="deleteerrordialog" 
                                buttons="{
                                'OK':function() { $( this ).dialog( 'close' );}                                    
                                }" 
                                autoOpen="false" 
                                modal="true" 
                                title="Delete error."
                                />                          

                            <div id="tablediv">
                                <s:url var="listurl" action="ListResponseCodes"/>
                                <sjg:grid
                                    id="gridtable"
                                    caption="Response Codes"
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
                                    <sjg:gridColumn name="responsecode" index="u.responsecode" title="Edit" width="25" sortable="false" align="center" formatter="editformatter" hidden="#vupdatelink"/>
                                    <sjg:gridColumn name="responsecode" index="u.responsecode" title="Delete" width="25" sortable="false" align="center" formatter="deleteformatter" hidden="#vdelete"/>  
                                    <sjg:gridColumn name="responsecode" index="u.responsecode" title="Code"  sortable="true"/>
                                    <sjg:gridColumn name="description" index="u.description" title="Description"  sortable="true"/>
                                    <sjg:gridColumn name="end_user_msg" index="u.end_user_msg" title="End User Message"  sortable="true"/>
                                    <%--<sjg:gridColumn name="OTPReqStatus" index="u.otpRequired" title="OTP Required Status"  sortable="true"/>--%>
                                    <%--<sjg:gridColumn name="riskReqStatus" index="u.riskRequired" title="Risk Required Status"  sortable="true"/>--%>
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
