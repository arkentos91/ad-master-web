<%-- 
    Document   : page
    Created on : Jan 7, 2014, 8:46:33 AM
    Author     : chalitha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/stylelinks.jspf" %>
        <title>Page Management</title>
        <script type="text/javascript">
            $.subscribe('onclicksearch', function (event, data) {
                $('#message').empty();

                var pageCodeSearch = $('#pageCodeSearch').val();
                var descriptionSearch = $('#descriptionSearch').val();
                var sortKeySearch = $('#sortKeySearch').val();
                var urlSearch = $('#urlSearch').val();
                var statussearch = $('#statussearch').val();

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        pageCodeSearch: pageCodeSearch,
                        descriptionSearch: descriptionSearch,
                        sortKeySearch: sortKeySearch,
                        urlSearch: urlSearch,
                        statussearch: statussearch,
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
                return "<a href='#' title='Edit' onClick='javascript:editPageInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deletePageInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editPageInit(keyval) {
                $("#updatedialog").data('pageCode', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("DetailPage.action?pageCode=" + $led.data('pageCode'));
            });

            function deletePageInit(keyval) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete page ' + keyval + ' ?');
                return false;
            }

            function deletePage(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/deletePage.action',
                    data: {pageCode: keyval},
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

                $('#pageCodeSearch').val("");
                $('#descriptionSearch').val("");
                $('#sortKeySearch').val("");
                $('#urlSearch').val("");
                $('#statussearch').val("");

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        pageCodeSearch: '',
                        descriptionSearch: '',
                        sortKeySearch: '',
                        urlSearch: '',
                        statussearch: '',
                        search: false
                    }
                });

                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");

            }

            function resetFieldData() {

                $('#pageCode').val("");
                $('#description').val("");
                $('#url').val("");
                $('#sortKey').val("");
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
                <s:form id="pagsearch" method="post" action="Page" theme="simple" cssClass="form" >

                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">Page Code </label>
                                <s:textfield cssClass="form-control" name="pageCodeSearch" id="pageCodeSearch" maxLength="4" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">Description</label>
                                <s:textfield  cssClass="form-control" name="descriptionSearch" id="descriptionSearch" maxLength="23" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">Sort Key </label>
                                <s:textfield  cssClass="form-control" name="sortKeySearch" id="sortKeySearch" maxLength="2" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">URL</label>
                                <s:textfield  cssClass="form-control" name="urlSearch" id="urlSearch" maxLength="128" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status</label>
                                <s:select cssClass="form-control" name="status" id="statussearch" headerValue="-- Select Status --" list="%{statusList}"   headerKey="" listKey="statuscode" listValue="description" value="%{status}"/>
                            </div>
                        </div>
                    </div>

                    <s:url var="addurl" action="ViewPopupPage"/>    
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">
                                <sj:submit 
                                    button="true"
                                    value="Search" 
                                    href="#"
                                    disabled="#vsearch"
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
                                    value="Add New Page"
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
                    modal="true" 
                    title="Add Page"                            
                    loadingText="Loading .."                            
                    position="center"                            
                    width="900"
                    height="450"
                    dialogClass= "dialogclass"
                    />  
                <!-- Start update dialog box -->
                <sj:dialog                                     
                    id="updatedialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="Update Page"
                    onOpenTopics="openviewtasktopage" 
                    loadingText="Loading .."
                    width="900"
                    height="450"
                    dialogClass= "dialogclass"
                    />
                <!-- Start delete confirm dialog box -->
                <sj:dialog 
                    id="deletedialog" 
                    buttons="{ 
                    'OK':function() { deletePage($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Delete Page"                            
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
                <s:url var="listurl" action="listPage"/>
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
                    <sjg:gridColumn name="pageCode" index="u.pagecode" title="Edit" width="25" align="center" formatter="editformatter" sortable="false" hidden="#vupdatelink" />
                    <sjg:gridColumn name="pageCode" index="u.pagecode" title="Delete" width="40" align="center" formatter="deleteformatter" sortable="false" hidden="#vdelete" />  
                    <sjg:gridColumn name="pageCode" index="u.pagecode" title="Page Code"  sortable="true" />
                    <sjg:gridColumn name="description" index="u.description" title="Description"  sortable="true"/>
                    <sjg:gridColumn name="status" index="u.status.description" title="Status"  sortable="true"/>
                    <sjg:gridColumn name="sortKey" index="u.sortkey" title="Sort Key"  sortable="true"/>
                    <sjg:gridColumn name="url" index="u.url" title="URL"  sortable="true"/>
                    <%--<sjg:gridColumn name="createtime" index="u.createtime" title="Created Time"  sortable="true" />--%>

                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>