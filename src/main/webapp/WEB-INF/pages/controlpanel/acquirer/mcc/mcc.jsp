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
                
                return "<a href='#' title='Edit' onClick='javascript:editMCCInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteMCCInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editMCCInit(keyval) {
                $("#updatedialog").data('mcccode', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {

                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("detailMCC.action?mcccode=" + $led.data('mcccode'));
            });

            function deleteMCCInit(keyval) {
                $('#divmsg').empty();
                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete merchant customer category ' + keyval + ' ?');
                return false;
            }

            function deleteMCC(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteMCC.action',
                    data: {mcccode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#deletesuccdialog").dialog('open');
                        $("#deletesuccdialog").html(data.message);

                        $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                        jQuery("#gridtable").trigger("reloadGrid");
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }
            function refreshMCC() {
                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function resetSearchData() {
                $('#mcccodesearch').val("");
                $('#descriptionsearch').val("");
                $('#statussearch').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_mcccode: '',
                        s_description: '',
                        s_status: '',
                        search: false
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});

                jQuery("#gridtable").trigger("reloadGrid");

            }

            function searchMCC() {
                var mcccode = $('#mcccodesearch').val();
                var name = $('#descriptionsearch').val();
                var status = $('#statussearch').val();

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_mcccode: mcccode,
                        s_description: name,
                        s_status: status,
                        search: true
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});

                jQuery("#gridtable").trigger("reloadGrid");
            }
            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function resetFieldData() {
                $('#mcccode').val("");
                $('#mcccode').attr('readOnly', false);
                $('#description').val("");
                $('#status').val(""); 
 
                $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57) || (k == 13));
            }

        </script>
        <title></title>
    </head>

    <body >
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>
        <div class="ali-body f-right ali-header-text"> 

            <s:div id="divmsg">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>

            <s:set id="vadd" var="vadd"><s:property value="vadd" default="true"/></s:set>
            <s:set id="vsearch" var="vsearch"><s:property value="vsearch" default="true"/></s:set>
            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>
            <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>
     
                <div class="ali-form">
                <s:form id="mccsearch" method="post" cssClass="form" action="MCC" theme="simple" >    

                    <div class="row ">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Merchant Customer Category</label>
                                <s:textfield name="mcccodesearch" id="mcccodesearch"  value="" maxLength="64" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,' '))" onkeypress="return alpha(event)"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Description</label>
                                <s:textfield  name="descriptionsearch" id="descriptionsearch" value="" maxLength="64" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onkeypress="return alpha(event)"/> 
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status </label>
                                <s:select  id="statussearch" list="%{statusList}"  name="statussearch" headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" value="%{status}" disabled="false" cssClass="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12">
                            <div class="form-group ali-margin">                              

                                <sj:submit 
                                    button="true"
                                    value="Search" 
                                    href="#"
                                    disabled="#vsearch"
                                    onClick="searchMCC()"  
                                    targets="message"
                                    id="searchbut"
                                    cssClass="btn btn-ali-submit btn-sm"
                                    />

                                <sj:submit 
                                    button="true" 
                                    id="cancelsearch"
                                    value="Reset" 
                                    onClick="resetSearchData()"
                                    cssClass="btn btn-ali-reset btn-sm"
                                    /> 
                                <s:url var="addurl" action="ViewPopupMCC"/>   
                                <sj:submit                                                      
                                    openDialog="remoteadddialog"
                                    button="true"
                                    href="%{addurl}"
                                    disabled="#vadd"
                                    value="Add New Merchant Customer Category"
                                    id="addButton"
                                    targets="remoteadddialog"   
                                    cssClass="btn f-right btn-ali-other btn-sm"
                                    />
                            </div>  

                        </div>
                    </div>                
                </s:form>                    

                
                <sj:dialog                                     
                    id="remoteadddialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    title="Add Merchant Customer Category"                            
                    loadingText="Loading .."                            
                    position="center"                            
                    width="1000"
                    height="450"
                    dialogClass= "dialogclass"
                    />

                <sj:dialog                                     
                    id="updatedialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="Update Merchant Customer Category"
                    onOpenTopics="openviewtasktopage" 
                    loadingText="Loading .."
                    width="1000"
                    height="450"
                    dialogClass= "dialogclass"
                    />

                <!-- Start delete confirm dialog box -->
                <sj:dialog 
                    id="deletedialog" 
                    buttons="{ 
                    'OK':function() { deleteMCC($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Delete Merchant Customer Category"                            
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
                <s:url var="listurl" action="ListMCC"/>

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
                    <sjg:gridColumn name="mcccode" index="MCC.MCCCODE" title="Edit" width="40" align="center" formatter="editformatter" sortable="false" hidden="#vupdatelink" />
                    <sjg:gridColumn name="mcccode" index="MCC.MCCCODE" title="Delete" width="40" align="center" formatter="deleteformatter" sortable="false" hidden="#vdelete" />  
                    <sjg:gridColumn name="mcccode" index="MCC.MCCCODE" title="Merchant Customer Category"  sortable="true" />
                    <sjg:gridColumn name="description" index="MCC.DESCRIPTION" title="Description"  sortable="true"/>
                    <sjg:gridColumn name="status" index="ST.DESCRIPTION" title="Status"  sortable="true"/>
                    <sjg:gridColumn name="createdtime" index="MT.CREATEDTIME" title="Created Time"  sortable="true"/>

                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>
    </body>
</html>


