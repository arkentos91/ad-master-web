<%-- 
    Document   : audit
    Created on : Jan 7, 2014, 1:17:40 PM
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

        <script type="text/javascript">

            function viewformatter(cellvalue) {
                return "<a href='#' title='View' onClick='javascript:viewAuditInit(&#34;" + cellvalue + "&#34;)' title='View Audit Record'><img class='ui-icon ui-icon-newwin' style='display: block;margin-left: auto;margin-right: auto;'/></a>";

            }
            function viewAuditInit(keyval) {
                $("#viewdialog").data('auditId', keyval).dialog('open');
            }
            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#viewdialog");
                $led.html("Loading..");
                $led.load("viewDetailSystemAudit.action?auditId=" + $led.data('auditId'));
            });
            
            function searchAudit(param) {
                var user = $('#user').val();
                var section = $('#section').val();
                var sdblpage = $('#sdblpage').val();
                var task = $('#task').val();
                var fdate = $('#fdate').val();
                var tdate = $('#tdate').val();


                $("#gridtable").jqGrid('setGridParam', {postData: {
                        user: user,
                        section: section,
                        sdblpage: sdblpage,
                        task: task,
                        fdate: fdate,
                        tdate: tdate,
                        search: param
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");
                var isGenerate = <s:property value="vgenerate"/>;
                if (isGenerate == false) {
                    $('#subview').button("enable");
                    $('#subview1').button("enable");
                }
                else {
                    $('#subview').button("disable");
                    $('#subview1').button("disable");
                }
            }
            ;



            function setdate() {
                setTimeout(function () {
                    $("#fdate").datepicker("setDate", new Date());
                    $("#tdate").datepicker("setDate", new Date());
                }, 0);
            }

            function resetAllData() {
                $('#user').val("");
                $('#section').val("");
                $('#sdblpage').val("");
                $('#task').val("");
                $('#fdate').val("");
                $('#tdate').val("");
                $('#divmsg').text("");
                $('#subview').button("disable");
                $('#subview1').button("disable");
                setdate();
                $("#gridtable").jqGrid('setGridParam', {postData: {
                        user: '',
                        section: '',
                        sdblpage: '',
                        task: '',
                        fdate: '',
                        tdate: '',
                        search: false
                    }});

                jQuery("#gridtable").trigger("reloadGrid");

            }

            $.subscribe('completetopics', function (event, data) {

                var isGenerate = <s:property value="vgenerate"/>;
                var recors = $("#gridtable").jqGrid('getGridParam', 'records');
                if (recors > 0 && isGenerate == false) {
                    $('#subview').button("enable");
                    $('#subview1').button("enable");
                }
                else {
                    $('#subview').button("disable");
                    $('#subview1').button("disable");

                }
            });

            $.subscribe('anyerrors', function (event, data) {
//                   alert('status: ' + event.originalEvent.status + '\n\nrequest status: ' +event.originalEvent.request.status+ '\n\nerror: ' + event.originalEvent.error);
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });

            function todoexel() {
                //            window.open();
                $('#reporttype').val("exel");
                form = document.getElementById('auditform');
                //                    form.target = '_blank';
                form.action = 'reportGenerateSystemAudit';
                form.submit();
                $('#subview1').button("disable");
                $('#subview').button("disable");
                //            window.open(form);
            }

            function todo() {
                //            window.open();
                $('#reporttype').val("pdf");
                form = document.getElementById('auditform');
                //                    form.target = '_blank';
                form.action = 'reportGenerateSystemAudit';
                form.submit();
                $('#subview1').button("disable");
                $('#subview').button("disable");
                //            window.open(form);
            }


        </script>
    </head>
    <body onload="setdate()">
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>

        <div class="ali-body f-right ali-header-text">
            <s:div id="divmsg">
                <s:actionerror theme="jquery"/>
                <s:actionmessage theme="jquery"/>
            </s:div>

            <s:set id="vsearch" var="vsearch"><s:property value="vsearch" default="true"/></s:set>
            <s:set id="vviewlink" var="vviewlink"><s:property value="vviewlink" default="true"/></s:set>
            <s:set id="vview" var="vview"><s:property value="vview" default="true"/></s:set>    
            <s:set id="vgenerate" var="vgenerate"><s:property value="vgenerate" default="true"/></s:set>

                <div class="ali-form">
                <s:form id="auditform" method="post" name="auditgen" theme="simple" action="SystemAudit">
                    <s:hidden name="reporttype" id="reporttype"></s:hidden>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>From Date</label>
                                <sj:datepicker cssClass="form-control" id="fdate" name="fdate" readonly="true" maxDate="d" changeYear="true" cssStyle="cursor:auto"
                                               buttonImageOnly="true" displayFormat="yy-mm-dd" yearRange="2000:2200" />
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>To Date</label>
                                <sj:datepicker cssClass="form-control" id="tdate" name="tdate" readonly="true" maxDate="+1d" changeYear="true" cssStyle="cursor:auto"
                                               buttonImageOnly="true" displayFormat="yy-mm-dd" yearRange="2000:2200"/>
                            </div>

                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Section</label>
                                <s:select cssClass="form-control" id="section" list="%{sectionList}" name="section"
                                          headerKey="" headerValue="--Select--"
                                          listKey="sectioncode" listValue="description" />              
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Page</label>
                                <s:select cssClass="form-control" id="sdblpage" list="%{pageList}" name="sdblpage"
                                          headerKey="" headerValue="--Select--"
                                          listKey="pagecode" listValue="description" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Task</label>
                                <s:select cssClass="form-control" id="task" list="%{taskList}" name="task"
                                          headerKey="" headerValue="--Select--"
                                          listKey="taskcode" listValue="description" />
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>User Name</label>
                                <s:select cssClass="form-control" id="user" list="%{userList}" name="user"
                                          headerKey="" headerValue="--Select--"
                                          listKey="username" listValue="username"/>                    
                            </div>

                        </div>

                    </div>
                </s:form>          
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group ali-margin">
                            <sj:submit  
                                value="Search"
                                button="true" 
                                id="searchButton"
                                onclick="searchAudit(true)"
                                disabled="#vsearch" 
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
                                button="true" 
                                value="View PDF" 
                                name="subview" 
                                disabled="#vgenerate"
                                id="subview" 
                                onClick="todo()" 
                                cssClass="btn btn-ali-submit btn-sm"
                                /> 

                            <sj:submit 

                                button="true" 
                                value="View Excel" 
                                name="subview1" 
                                disabled="#vgenerate"
                                id="subview1" 
                                onClick="todoexel()" 
                                cssClass="btn btn-ali-submit btn-sm"
                                /> 
                        </div>
                    </div>
                </div>


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
                <sj:dialog                                     
                    id="viewdialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="View System Audit"
                    onOpenTopics="openviewtasktopage" 
                    loadingText="Loading .."
                    width="900"
                    height="590"
                    dialogClass= "dialogclass"
                    />
            </div>
            <div class="ali-table"> 
                <s:url var="listurl" action="listSystemAudit"/>
                <sjg:grid 
                    id="gridtable"
                    caption="System Audit"
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
                    onErrorTopics="anyerrors">                                    

                    <sjg:gridColumn name="id" title="View" width="40" align="center" formatter="viewformatter" hidden="#vviewlink"/>
                    <sjg:gridColumn name="id" index="systemauditid" title="ID" width="50" sortable="true"/>

                    <sjg:gridColumn name="description" index="description" width="250" title="Description" sortable="true"/>
                    <sjg:gridColumn name="sectionDes" index="sectioncode" title="Section" sortable="true"/>
                    <sjg:gridColumn name="pageDes" index="pagecode" title="Page" sortable="true"/>
                    <sjg:gridColumn name="taskDes" index="taskcode" width="50" title="Task" sortable="true"/>
                    <sjg:gridColumn name="user" index="lastupdateduser" width="50" title="User Name" sortable="true"/>
                    <sjg:gridColumn name="lastUpdatedDate" index="lastupdatedtime" title="Last Updated Time" sortable="true"/>
                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>

    </body>
</html>