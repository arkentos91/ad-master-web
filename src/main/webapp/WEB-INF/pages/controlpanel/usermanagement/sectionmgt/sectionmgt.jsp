<%-- 
    Document   : sectionmgt
    Created on : 07/01/2014, 9:45:52 AM
    Author     : jeevan
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

            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editSectionInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteSectionInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editSectionInit(keyval) {
                $("#updatedialog").data('sectionCode', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("detailSection.action?sectionCode=" + $led.data('sectionCode'));
            });

            function deleteSectionInit(keyval) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete section ' + keyval + ' ?');
                return false;
            }

            function deleteSection(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteSection.action',
                    data: {sectionCode: keyval},
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
            function resetAllDataSearch() {
                $('#sectionCodesearch').val("");
                $('#descriptionsearch').val("");
                $('#sortKeysearch').val("");
                $('#statussearch').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_sectioncode: '',
                        s_description: '',
                        s_sortkey: '',
                        s_status: '',
                        search: false
                    }});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function resetFieldData() {

                $('#sectionCode').val("");
                $('#description').val("");
                $('#sortKey').val("");
                $('#status').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function cancelAllData() {
                editSection(null);
            }

            window.onload = function () {
                $("#sectionCodesearch").css("color", "black");
            };

            function searchSection() {
                var sectionCodesearch = $('#sectionCodesearch').val();
                var deascriptionsearch = $('#descriptionsearch').val();
                var sortKeySearch = $('#sortKeysearch').val();
                var statusSearch = $('#statussearch').val();

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_sectioncode: sectionCodesearch,
                        s_description: deascriptionsearch,
                        s_sortkey: sortKeySearch,
                        s_status: statusSearch,
                        search: true
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});

                jQuery("#gridtable").trigger("reloadGrid");
            }

            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });
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
                <s:form cssClass="form" id="sectionsearch" method="post" action="Section" theme="simple" >
                    <div class="row">     
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Section Code </label>
                                <s:textfield name="sectionCodesearch" id="sectionCodesearch" maxLength="6" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Description </label>
                                <s:textfield  name="descriptionsearch" id="descriptionsearch" maxLength="26" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Sort Key </label>
                                <s:textfield  name="sortKeysearch" id="sortKeysearch" maxLength="2" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))"/>
                            </div>
                        </div> 
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status</label>
                                <s:select  cssClass="form-control" name="status" id="statussearch" list="%{statusList}"   headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" value="%{status}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">
                                <sj:submit 
                                    button="true"
                                    value="Search" 
                                    href="#"
                                    disabled="#vsearch"
                                    onClick="searchSection()"  
                                    targets="message"
                                    id="searchbut"
                                    cssClass="btn btn-ali-submit btn-sm"
                                    />                                                

                                <sj:submit 
                                    button="true" 
                                    value="Reset" 
                                    name="cancel" 
                                    id="cancel"
                                    onClick="resetAllDataSearch()"
                                    cssClass="btn btn-ali-reset btn-sm"
                                    />
                                <s:url var="addurl" action="ViewPopupSection"/>
                                <sj:submit 
                                    openDialog="remotedialog"
                                    button="true"
                                    href="%{addurl}"
                                    buttonIcon="ui-icon-newwin" 
                                    disabled="#vadd"
                                    value="Add New Section"
                                    id="addButton"
                                    cssClass="btn f-right btn-ali-other btn-sm"
                                    />
                            </div>
                        </div>
                    </div>
                </s:form>
            </div>
            <sj:dialog                                     
                id="updatedialog"                                 
                autoOpen="false" 
                modal="true" 
                position="center"
                title="Update Section"
                onOpenTopics="openviewtasktopage" 
                loadingText="Loading .."
                width="900"
                height="450"
                dialogClass= "dialogclass"
                />

            <sj:dialog                                     
                id="remotedialog"                                 
                autoOpen="false" 
                modal="true" 
                title="Add Section"                            
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
                'OK':function() { deleteSection($(this).data('keyval'));$( this ).dialog( 'close' ); },
                'Cancel':function() { $( this ).dialog( 'close' );} 
                }" 
                autoOpen="false" 
                modal="true" 
                title="Delete Section"                            
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
            <div class="ali-table">
                <s:url var="listurl" action="ListSection"/>
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
                    <sjg:gridColumn name="sectioncode" index="s.sectioncode" title="Edit" width="25" align="center" sortable="false" formatter="editformatter" hidden="#vupdatelink" />
                    <sjg:gridColumn name="sectioncode" index="s.sectioncode" title="Delete" width="40" align="center" sortable="false" formatter="deleteformatter" hidden="#vdelete" /> 
                    <sjg:gridColumn name="sectioncode" index="s.sectioncode" title="Section Code"  sortable="true" />
                    <sjg:gridColumn name="description" index="s.description" title="Description"  sortable="true"/>                                    
                    <sjg:gridColumn name="sortkey" index="s.sortkey" title="Sort Key"  sortable="true"/>
                    <sjg:gridColumn name="statuscode" index="st.description" title="Status"  sortable="true"/>  
                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>