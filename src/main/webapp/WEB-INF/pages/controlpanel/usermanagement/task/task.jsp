<%-- 
    Document   : task
    Created on : Jan 3, 2014, 11:09:04 AM
    Author     : chanuka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/stylelinks.jspf" %>
        <script type="text/javascript">
            $.subscribe('onclicksearch', function (event, data) {
                $('#message').empty();

                var taskCodeSearch = $('#taskCodeSearch').val();
                var descriptionSearch = $('#descriptionSearch').val();
//                var sortKeySearch = $('#sortKeySearch').val();
                var statusSearch = $('#statusSearch').val();

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        taskCodeSearch: taskCodeSearch,
                        descriptionSearch: descriptionSearch,
//                        sortKeySearch: sortKeySearch,
                        statusSearch: statusSearch,
                        search: true
                    }
                });

                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");
            });

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editTaskInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteTaskInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editTaskInit(keyval) {
                $("#updatedialog").data('taskCode', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("DetailTask.action?taskCode=" + $led.data('taskCode'));
            });

            function deleteTaskInit(keyval) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete task ' + keyval + ' ?');
                return false;
            }

            function deleteTask(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteTask.action',
                    data: {taskCode: keyval},
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
                $('#taskCodeSearch').val("");
                $('#descriptionSearch').val("");
//                $('#sortKeySearch').val("");
                $('#statusSearch').val("");

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        taskCodeSearch: '',
                        descriptionSearch: '',
//                        sortKeySearch: '',
                        statusSearch: '',
                        search: false
                    }
                });
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function resetFieldData() {

                $('#taskCode').val("");
                $('#description').val("");
//                $('#sortKey').val("");
                $('#status').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
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
                <s:form cssClass="form" id="tasksearch" method="post" action="Task" theme="simple" >
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Task Code </label>
                                <s:textfield cssClass="form-control" name="taskCodeSearch" id="taskCodeSearch" maxLength="6" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Description</label>
                                <s:textfield cssClass="form-control" name="descriptionSearch" id="descriptionSearch" maxLength="64" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status</label>
                                <s:select  cssClass="form-control" name="status" id="statusSearch" list="%{statusList}"   headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" value="%{status}" disabled="false"/>
                            </div>
                        </div>   
                    </div>
                            
                    <s:url var="addurl" action="ViewPopupTask"/>     
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">
                                <sj:submit 
                                    button="true"
                                    value="Search" 
                                    disabled="#vsearch"
                                    href="#"
                                    onClickTopics="onclicksearch"  
                                    targets="message"
                                    id="searchbut"
                                    cssClass="btn btn-ali-submit btn-sm"
                                    />
                                <sj:submit 
                                    button="true" 
                                    value="Reset" 
                                    name="reset" 
                                    onClick="resetAllData()" 
                                    cssClass="btn btn-ali-reset btn-sm"
                                    />
                                <sj:submit 
                                    openDialog="remotedialog"
                                    button="true"
                                    href="%{addurl}"
                                    disabled="#vadd"
                                    value="Add New Task"
                                    id="addButton"
                                    targets="remotedialog"   
                                    cssClass="btn f-right btn-ali-other btn-sm"
                                    />

                            </div>
                        </div>
                    </div>
                </s:form>

                <!-- Start add dialog box -->
                <sj:dialog                                     
                    id="remotedialog"                                 
                    autoOpen="false" 
                    position="center"
                    modal="true" 
                    title="Add Task"                            
                    loadingText="Loading .."                            
                    dialogClass="dialogclass"
                    width="900"
                    height="400"

                    /> 
                <!-- Start update dialog box -->
                <sj:dialog                                     
                    id="updatedialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="Update Task"
                    onOpenTopics="openviewtasktopage" 
                    loadingText="Loading .."
                    width="900"
                    height="400"
                    dialogClass= "dialogclass"
                    />
                <!-- Start delete confirm dialog box -->
                <sj:dialog 
                    id="deletedialog" 
                    buttons="{ 
                    'OK':function() { deleteTask($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Delete Task"                            
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
            </div>
            
            <div class="ali-table">
                <s:url var="listurl" action="ListTask"/>
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
                    <sjg:gridColumn name="taskcode" index="u.taskcode" title="Edit" width="25" align="center" formatter="editformatter" sortable="false" hidden="#vupdatelink" />
                    <sjg:gridColumn name="taskcode" index="u.taskcode" title="Delete" width="40" align="center" formatter="deleteformatter" sortable="false" hidden="#vdelete" />  
                    <sjg:gridColumn name="taskcode" index="u.taskcode" title="Task Code"  sortable="true" />
                    <sjg:gridColumn name="description" index="u.description" title="Description"  sortable="true"/>
                    <sjg:gridColumn name="statuscode" index="u.status.description" title="Status"  sortable="true"/>

                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>