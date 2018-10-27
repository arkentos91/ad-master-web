 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib  uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/stylelinks.jspf" %>
        <title>Candidate Management</title>
        <script type="text/javascript">
            $.subscribe('onclicksearch', function (event, data) {
                $('#message').empty();

                var nic_Search = $('#nic_Search').val();
                var fullname_Search = $('#fullname_Search').val();
                var sortKeySearch = $('#sortKeySearch').val();
                var urlSearch = $('#urlSearch').val();
                var statussearch = $('#statussearch').val();

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        nic_Search: nic_Search,
                        fullname_Search: fullname_Search,
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

            function rejectformatter(cellvalue, options, rowObject) {
                
                return "<a href='#' title='Confirm' onClick='javascript:editCandidateInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-close' style='display: block;margin-left: auto;margin-right: auto;'/></a>";           
            
            }
            function selectformatter(cellvalue, options, rowObject) {
              
                if(rowObject.status==='Short Listed'){
                    return "<a href='#' title='Confirm' onClick='javascript:selectCandidateInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-play' style='display: block;margin-left: auto;margin-right: auto;'/></a>";           
                }else{
                    return "--";
                }
            }
            function hireformatter(cellvalue, options, rowObject) {
                if(rowObject.status==='Selected'){
                    return "<a href='#' title='Confirm' onClick='javascript:hireCandidateInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-play' style='display: block;margin-left: auto;margin-right: auto;'/></a>";           
                }else{
                    return "--";
                }
            }
             
            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editCandidateInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteCandidateInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editCandidateInit(keyval) {
                $("#updatedialog").data('nic', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("DetailCandidate.action?nic=" + $led.data('nic'));
            });

            function deleteCandidateInit(keyval) {
                $('#divmsg').empty();

                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete page ' + keyval + ' ?');
                return false;
            }
            function selectCandidateInit(keyval) {
                $('#divmsg').empty();

                $("#selectdialog").data('keyval', keyval).dialog('open');
                $("#selectdialog").html('Are you sure you want to select cadidate ' + keyval + ' ?');
                return false;
            }
            function hireCandidateInit(keyval) {
                $('#divmsg').empty();

                $("#hiredialog").data('keyval', keyval).dialog('open');
                $("#hiredialog").html('Are you sure you want to hire cadidate ' + keyval + ' ?');
                return false;
            }

            function deleteCandidate(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/deleteCandidate.action',
                    data: {nic: keyval},
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
            function selectCandidate(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/selectCandidate.action',
                    data: {nic: keyval},
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
            
             function hireCandidate(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/hireCandidate.action',
                    data: {nic: keyval},
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

                $('#nic').val("");
                $('#fullname').val("");
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
                <s:form id="pagsearch" method="post" action="Candidate" theme="simple" cssClass="form" >

                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">NIC</label>
                                <s:textfield cssClass="form-control" name="nic_Search" id="nic_Search" maxLength="10" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">Full Name</label>
                                <s:textfield  cssClass="form-control" name="fullname_Search" id="fullname_Search" maxLength="23" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            
                            <div class="form-group">
                                <label >Position</label>
                                <s:select cssClass="form-control" name="position" id="position_Search" headerValue="-- Select Position --" list="%{positionList}"   headerKey="" listKey="key" listValue="value" value="%{position}"/>
                            </div>
                            
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status</label>
                                <s:select cssClass="form-control" name="status" id="statussearch" headerValue="-- Select Status --" list="%{statusList}"   headerKey="" listKey="statuscode" listValue="description" value="%{status}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        
                    </div>

                    <s:url var="addurl" action="ViewPopupCandidate"/>    
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
                                    value="Add New Candidate"
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
                    title="Add Candidate"                            
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
                    title="Update Candidate"
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
                    'OK':function() { deleteCandidate($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    width="400"
                    height="120"
                    title="Delete Candidate"                            
                    />
                <sj:dialog 
                    id="selectdialog" 
                    buttons="{ 
                    'OK':function() { selectCandidate($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    width="400"
                    height="120"
                    title="Select Candidate"                            
                    />
                <sj:dialog 
                    id="hiredialog" 
                    buttons="{ 
                    'OK':function() { hireCandidate($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    width="400"
                    height="120"
                    title="Hire Candidate"                            
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
                <s:url var="listurl" action="listCandidate"/>
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
                    <sjg:gridColumn name="nic" index="u.nic" title="Delete" width="40" align="center" formatter="deleteformatter" sortable="false" hidden="#vdelete" /> 
                    <sjg:gridColumn name="nic" index="u.nic" title="Reject" width="50" align="center" formatter="rejectformatter" sortable="false" hidden="#vupdatelink" />
                     
                    <sjg:gridColumn name="nic" index="u.nic" title="Edit" width="40" align="center" formatter="editformatter" sortable="false" hidden="#vupdatelink" />
                    <%--<sjg:gridColumn name="nic" index="u.nic" title="Short List" width="80" align="center" formatter="shortformatter" sortable="false" hidden="#vupdatelink" />--%>
                    <sjg:gridColumn name="nic" index="u.nic" title="Select" width="80" align="center" formatter="selectformatter" sortable="false" hidden="#vupdatelink" />
                    <sjg:gridColumn name="nic" index="u.nic" title="Hire" width="80" align="center" formatter="hireformatter" sortable="false" hidden="#vupdatelink" />
                    
                    <sjg:gridColumn name="nic" index="u.nic" title="NIC"  sortable="true" />
                    <sjg:gridColumn name="fullname" index="u.description" title="Full Name"  sortable="true"/>
                    <sjg:gridColumn name="status" index="u.status.description" title="Status"  sortable="true"/>
                    <sjg:gridColumn name="position" index="u.position" title="Position"  sortable="true" />
                    <sjg:gridColumn name="mobile" index="u.mobile" title="Mobile"  sortable="true"/>
                    <sjg:gridColumn name="email" index="u.email" title="Email"  sortable="true"/>
                    

                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>