<%-- 
    Document   : headmerchant
    Created on : Jul 12, 2016, 2:44:25 PM
    Author     : samith_k
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

            function generateformatter(cellvalue, options, rowObject) {
                var vst = rowObject.username;
                var chkstatus = rowObject.status;
                if (vst === "--" && chkstatus == "Active") {
                    return "<a href='#/' title='Generate username' onClick='javascript:generateUserPass(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-person' style='display: block;margin-left: auto;margin-right: auto;'/></a>";

                } else {
                    return "--";
                }
            }

            function generateUserPass(keyval) {
                $('#divmsg').empty();
                $("#confirmdialog").data('keyval', keyval).dialog('open');
                $("#confirmdialog").html('Are you sure you want to generate username and password to merchant customer code ' + keyval + ' ?');
                return false;
            }

            function generateMerchant(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/GenerateuserpassMerchantCustomer.action',
                    data: {mid: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#generatesuccdialog").dialog('open');
                        $("#generatesuccdialog").html(data.message);
                        $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                        jQuery("#gridtable").trigger("reloadGrid");
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function generateformatter(cellvalue, options, rowObject) {
                var vst = rowObject.username;
                var chkstatus = rowObject.status;
                if (vst === "--" && chkstatus == "Active") {
                    return "<a href='#/' title='Generate username' onClick='javascript:generateUserPass(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-person' style='display: block;margin-left: auto;margin-right: auto;'/></a>";

                } else {
                    return "--";
                }
            }

            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editMerchantInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteMerchantInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editMerchantInit(keyval) {
                $("#updatedialog").data('mid', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {

                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("detailMerchantCustomer.action?mid=" + $led.data('mid'));
            });

            function deleteMerchantInit(keyval) {
                $('#divmsg').empty();
                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete merchant customer ' + keyval + ' ?');
                return false;
            }

            function deleteMerchant(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteMerchantCustomer.action',
                    data: {mid: keyval},
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
            function refreshMerchantCustomer() {
                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function resetSearchData() {
                $('#midsearch').val("");
                $('#namesearch').val("");
                $('#statussearch').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_mid: '',
                        s_name: '',
                        s_status: '',
                        search: false
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});

                jQuery("#gridtable").trigger("reloadGrid");

            }

            function searchMerchantCustomer() {
                var mid = $('#midsearch').val();
                var name = $('#namesearch').val();
                var status = $('#statussearch').val();

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_mid: mid,
                        s_name: name,
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
                $('#mid').val("");
                $('#mid').attr('readOnly', false);
                $('#name').val("");
                $('#status').val("");
                $('#logoImg').val("");
                $('#logowebImg').val("");
                $('#logoImgFile').val("");
                $('#logowebImgFile').val("");
                $("#logo_add").attr("src", "");
                $("#logoweb_add").attr("src", "");
                $('#conXL').val("");

                $("#newBox option").each(function () {

                    $("#currentBox").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });

                $("#newBoxTran option").each(function () {

                    $("#currentBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });

                $('#newBox').empty();
                $('#newBoxTran').empty();

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
            <s:set id="vupload" var="vupload"><s:property value="vupload" default="true"/></s:set>
            <s:set id="vsearch" var="vsearch"><s:property value="vsearch" default="true"/></s:set>
            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>
            <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>
            <s:set var="vuserpassgen"><s:property value="vuserpassgen" default="true"/></s:set>

                <div class="ali-form">
                <s:form id="merchantsearch" method="post" cssClass="form" action="MerchantCustomer" theme="simple" >    

                    <div class="row ">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Merchant Customer Code</label>
                                <s:textfield name="midsearch" id="midsearch"  value="" maxLength="64" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,' '))" onkeypress="return alpha(event)"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Merchant Customer Name </label>
                                <s:textfield  name="namesearch" id="namesearch" value="" maxLength="64" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onkeypress="return alpha(event)"/> 
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
                                    onClick="searchMerchantCustomer()"  
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
                                <s:url var="addurl" action="ViewPopupMerchantCustomer"/>   
                                <sj:submit                                                      
                                    openDialog="remoteadddialog"
                                    button="true"
                                    href="%{addurl}"
                                    disabled="#vadd"
                                    value="Add New Merchant Customer"
                                    id="addButton"
                                    targets="remoteadddialog"   
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
                    title="Upload Merchant Customer"                            
                    loadingText="Loading .."                            
                    position="center"                            
                    width="650"
                    height="350"
                    dialogClass= "dialogclass"
                    />

                <sj:dialog                                     
                    id="remoteadddialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    title="Add Merchant Customer"                            
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
                    title="Update Merchant Customer"
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
                    'OK':function() { deleteMerchant($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Delete Merchant Customer"                            
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
                <sj:dialog 
                    id="confirmdialog" 
                    buttons="{ 
                    'OK':function() { generateMerchant($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Generate Username and Password "                            
                    />
            </div>

            <div class="ali-table">
                <s:url var="listurl" action="ListMerchantCustomer"/>

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
                    <sjg:gridColumn name="mid" index="MT.MID" title="Edit" width="40" align="center" formatter="editformatter" sortable="false" hidden="#vupdatelink" />
                    <sjg:gridColumn name="mid" index="MT.MID" title="Delete" width="40" align="center" formatter="deleteformatter" sortable="false" hidden="#vdelete" />  
                    <sjg:gridColumn name="mid" index="MT.MID" title="Generate"  width="60" align="center" formatter="generateformatter" hidden="#vuserpassgen" sortable="true" />
                    <sjg:gridColumn name="mid" index="MT.MID" title="Merchant Customer Code"  sortable="true" />
                    <sjg:gridColumn name="name" index="MT.NAME" title="Merchant Customer Name"  sortable="true"/>
                    <sjg:gridColumn name="status" index="ST.DESCRIPTION" title="Status"  sortable="true"/>
                    <sjg:gridColumn name="createdtime" index="MT.CREATE_TIME" title="Created Time"  sortable="true"/>

                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>
    </body>
</html>


