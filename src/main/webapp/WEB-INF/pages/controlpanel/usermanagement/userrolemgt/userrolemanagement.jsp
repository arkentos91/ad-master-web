<%-- 
    Document   : userrolemanagement
    Created on : 6 Jan, 2014, 5:05:11 PM
    Author     : asela
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <%@include file="/stylelinks.jspf" %>
        <title>User Role Management</title>
        <script type="text/javascript">

            function editformatter(cellvalue, options, rowObject) {
                a = $("#addButton").is(':disabled');
                u = $("#updateButton").is(':disabled');
                return "<a href='#' title='Edit' onClick='javascript:editUserRoleInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteUserRoleInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editUserRoleInit(keyval) {
                $("#updatedialog").data('userRoleCode', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("detailUserRole.action?userRoleCode=" + $led.data('userRoleCode'));
            });

            function deleteUserRoleInit(keyval) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete user role ' + keyval + ' ?');
                return false;
            }

            function deleteUserRole(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteUserRole.action',
                    data: {userRoleCode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#deletesuccdialog").dialog('open');
                        $("#deletesuccdialog").html(data.message);
                        resetFieldDataSearch();
                        //                        jQuery("#gridtable").trigger("reloadGrid");                      
                    },
                    error: function (data) {
//                        $("#deleteerrordialog").dialog('open');
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }
            //            var a =  $("#addButton").is(':disabled');
            //            var u =  $("#updateButton").is(':disabled');  


            window.onload = function () {
                $("#userRoleCode").css("color", "black");
            };

            function resetFieldDataSearch() {
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function resetAllDataSearch() {
                $('#userRoleCodesearch').val("");
                $('#descriptionsearch').val("");
                $('#statusSearch').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_userrolecode: '',
                        s_description: '',
                        s_status: '',
                        search: false
                    }});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function searchUserRole() {
                var userRoleCodesearch = $('#userRoleCodesearch').val();
                var deascriptionsearch = $('#descriptionsearch').val();
                var statusSearch = $('#statusSearch').val();

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_userrolecode: userRoleCodesearch,
                        s_description: deascriptionsearch,
                        s_status: statusSearch,
                        search: true
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});

                jQuery("#gridtable").trigger("reloadGrid");
            }

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function resetFieldData() {

                $('#userRoleCode').val("");
                $('#userRoleCode').attr('readOnly', false);
                $("#userRoleCode").css("color", "black");
                $('#description').val("");
                $('#status').val("");

                jQuery("#gridtable").trigger("reloadGrid");
            }

        </script>
    </head>

    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>

        <div class="ali-body f-right ali-header-text">
            <s:div id="divmsg">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>

            <s:set id="vadd" var="vadd"><s:property value="vadd" default="true"/></s:set>
            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>
            <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>

                <div class="ali-form">
                <s:form cssClass="form" id="main" method="post" action="UserRole" theme="simple" >
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >User Role Code </label>
                                <s:textfield name="userRoleCodesearch" id="userRoleCodesearch" cssClass="form-control" maxLength="6" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Description </label>
                                <s:textfield name="descriptionsearch" id="descriptionsearch" cssClass="form-control"  maxLength="64" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/> 
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status</label>
                                <s:select  cssClass="form-control" name="status" id="statusSearch" list="%{statusList}"   headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" value="%{status}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">
                                <s:url var="addurl" action="ViewPopupUserRole"/>   
                                <sj:submit 
                                    button="true"
                                    value="Search" 
                                    href="#"
                                    disabled="#vsearch"
                                    onclick="searchUserRole()" 
                                    targets="message"
                                    id="searchbut"
                                     cssClass="btn btn-ali-submit btn-sm"
                                    />

                                <sj:submit 
                                    button="true" 
                                    value="Reset" 
                                    name="reset"
                                    id="resetbut"
                                    onClick="resetAllDataSearch()" 
                                     cssClass="btn btn-ali-reset btn-sm"
                                    /> 

                                <sj:submit                                                      
                                    openDialog="remotedialog"
                                    button="true"
                                    href="%{addurl}"
                                    disabled="#vadd"
                                    value="Add New User Role"
                                    id="addButton"
                                    targets="remotedialog"   
                                    cssClass="btn f-right btn-ali-other btn-sm"
                                    />
                            </div>
                        </div>
                    </div>
                </s:form>

                <sj:dialog                                     
                    id="updatedialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="Update User Role"
                    onOpenTopics="openviewtasktopage" 
                    loadingText="Loading .."
                    width="900"
                    height="450"
                    dialogClass= "dialogclass"
                    />

                <!-- Start add dialog box -->
                <sj:dialog                                     
                    id="remotedialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    title="Add User Role"                            
                    loadingText="Loading .."                            
                    position="center"                            
                    width="900"
                    height="450"
                    dialogClass= "dialogclass"
                    />
                <!-- Start delete confirm dialog box -->
                <sj:dialog 
                    id="deletedialog" 
                    buttons="{ 
                    'OK':function() { deleteUserRole($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Delete User Role"                            
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

            </div>

            <div class="ali-table">
                <s:url var="listurl" action="ListUserRole"/>
                <s:set var="pcaption">${CURRENTPAGE}</s:set>

                <sjg:grid
                    id="gridtable"
                    caption="%{pcaption}"
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
                    onErrorTopics="anyerrors"
                    >
                    <sjg:gridColumn name="userRoleCode" index="u.userrole" title="Edit" width="25" align="center"  formatter="editformatter" hidden="#vupdatelink" />
                    <sjg:gridColumn name="userRoleCode" index="u.userrole" title="Delete" width="40" align="center"  formatter="deleteformatter" hidden="#vdelete" />  
                    <sjg:gridColumn name="userRoleCode" index="ur.userrolecode" title="User Role Code"   />
                    <sjg:gridColumn name="description" index="ur.description" title="Description"  />
                    <%--<sjg:gridColumn name="userRoleLevel" index="ul.description" title="User Role Level"  sortable="true"/>--%>
                    <sjg:gridColumn name="status" index="st.description" title="Status"  />
                    <%--<sjg:gridColumn name="createtime" index="ur.createdtime" title="Created Time"   />--%> 
                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>