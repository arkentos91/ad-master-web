<%-- 
    Document   : acquirerpromotion
    Created on : Sep 20, 2016, 12:24:13 PM
    Author     : dilanka_w
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

                var codeSearch = $('#codeSearch').val();
                var currencySearch = $('#currencySearch').val();
                var descriptionSearch = $('#descriptionSearch').val();
                var statusSearch = $('#statusSearch').val();

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        codeSearch: codeSearch,
                        currencySearch: currencySearch,
                        descriptionSearch: descriptionSearch,
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
                return "<a href='#' title='Edit' onClick='javascript:editAcquirerPromotionInit(&#34;" + cellvalue + "&#34;,&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteAcquirerPromotionInit(&#34;" + cellvalue + "&#34;,&#34;" + rowObject.currencycode + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editAcquirerPromotionInit(keyval, curr) {
                $("#updatedialog").data('val', {code: keyval, promotioncurrency: curr}).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("DetailAcquirerPromotion.action?code=" + $led.data('val').code + "&promotioncurrency=" + $led.data('val').promotioncurrency);
            });


            function deleteAcquirerPromotionInit(keyval, curr) {
                $('#divmsg').empty();

                $("#deletedialog").data('val', {code: keyval, promotioncurrency: curr}).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete acquirer promotion ' + keyval + ' ?');
                return false;
            }

            function deleteAcquirerPromotion(keyval, curr) {

                var code = keyval;
                var promotioncurrency = curr;
                $.ajax({
                    url: '${pageContext.request.contextPath}/deleteAcquirerPromotion.action',
                    data: {code: code, promotioncurrency: promotioncurrency},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#deletesuccdialog").dialog('open');
                        $("#deletesuccdialog").html(data.message);

                        $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                        $("#gridtable").trigger("reloadGrid");
                        resetFieldData();

                    },
                    error: function (data) {
                        alert("unsuccess");
                        //window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function resetAllData() {

                $('#codeSearch').val("");
                $('#descriptionSearch').val("");
                $('#currencySearch').val("");
                $('#statusSearch').val("");

                $("#gridtable").jqGrid('setGridParam', {
                    postData: {
                        codeSearch: '',
                        currencySearch: '',
                        descriptionSearch: '',
                        statusSearch: '',
                        search: false
                    }
                });

                jQuery("#gridtable").trigger("reloadGrid");

            }


            function resetFieldData() {

                $('#code').val("");
                $('#description').val("");
                $('#status').val("");
                $('#txnType').val("");
                $('#bankAmountType').val("");
                $('#bankAmount').val("");
                $('#merchantAmountType').val("");
                $('#merchantAmount').val("");

                $("#gridtabletxn").jqGrid('setGridParam', {
                    postData: {
                        code: '',
                        description: '',
                        status: '',
                        txnType: '',
                        bankAmountType: '',
                        bankAmount: '',
                        merchantAmountType: '',
                        merchantAmount: '',
                        isAssign: 'clear'
                    }
                });

                $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                $("#gridtable").trigger("reloadGrid");

                $("#gridtabletxn").trigger("reloadGrid");

            }
        </script>
        <title>Acquirer Promotion</title>
    </head>
    <body style="">
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>
        <div class="ali-body f-right ali-header-text"> 

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
            <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>

                <div class="ali-form">
                <s:form id="acquirerpromotionform" method="post" action="AcquirerPromotion" theme="simple" cssClass="form" >
                    <div class="row ">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Acquirer Promotion Code</label>
                                <s:textfield cssClass="form-control" name="codeSearch" id="codeSearch" maxLength="20" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9]/g,''))" />
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Acquirer Promotion Currency</label>
                                <s:select  cssClass="form-control" name="currencySearch" id="currencySearch" list="%{currencyList}"  headerValue="--Select Currency--" headerKey="" listKey="currencycode" listValue="description"/>
                            </div> 
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Description</label>
                                <s:textfield cssClass="form-control" name="descriptionSearch" id="descriptionSearch" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Status</label>
                                <s:select  cssClass="form-control" name="statusSearch" id="statusSearch" list="%{statusList}"  headerValue="--Select Status--" headerKey="" listKey="statuscode" listValue="description"/>
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
                                    onClickTopics="onclicksearch" 
                                    disabled="#vsearch"
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

                                <s:url var="addurl" action="ViewPopupAcquirerPromotion"/>
                                <s:url var="updateurl" action="updateAcquirerPromotion"/>
                                <sj:submit 
                                    openDialog="remotedialog"
                                    button="true"
                                    href="%{addurl}"
                                    disabled="#vadd"
                                    value="Add New Acquirer Promotion"
                                    id="addButton"
                                    targets="remotedialog"   
                                    cssClass="btn f-right btn-ali-other btn-sm"
                                    />
                            </div>
                        </div>
                    </div> 
                </s:form>
            </div>
            <!-- Start add dialog box -->
            <sj:dialog                                     
                id="remotedialog"                                 
                autoOpen="false" 
                modal="true" 
                title="Add Acquirer Promotion"                            
                loadingText="Loading .."                            
                position="center"                            
                width="900"
                height="500"
                dialogClass= "dialogclass"
                />
            <!-- Start update dialog box -->
            <sj:dialog                                     
                id="updatedialog"                                 
                autoOpen="false" 
                modal="true" 
                position="center"
                title="Update Acquirer Promotion"
                onOpenTopics="openviewtasktopage" 
                loadingText="Loading .."
                width="900"
                height="500"
                dialogClass= "dialogclass"
                />

            <%-- Start delete confirm dialog box --%>
            <sj:dialog 
                id="deletedialog" 
                buttons="{ 
                'OK':function() { deleteAcquirerPromotion($(this).data('val').code,$(this).data('val').promotioncurrency);$( this ).dialog( 'close' ); },
                'Cancel':function() { $( this ).dialog( 'close' );} 
                }" 
                autoOpen="false" 
                modal="true" 
                title="Delete Acquirer Promotion"                            
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

            <div class="ali-table" id="tablediv">
                <s:url var="listurl" action="listAcquirerPromotion"/>
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
                    <sjg:gridColumn name="code" index="u.id.code" title="Edit"  width="60" align="center" formatter="editformatter" hidden="#vremovelink" sortable="false" />
                    <sjg:gridColumn name="code" index="u.id.code"  title="Delete" width="60" align="center" formatter="deleteformatter" hidden="#vdelete" sortable="false" /> 
                    <sjg:gridColumn name="code" index="u.id.code"  title="Acquirer Promotion Code"  sortable="true" />
                    <sjg:gridColumn name="promotioncurrency" index="u.id.currencycode"  title="Promotion Currency"  sortable="true" />
                    <sjg:gridColumn name="description" index="u.description" title="Description" sortable="true"/>   
                    <sjg:gridColumn name="status" index="u.status.statuscode" title="Status"  sortable="true"/>
                    <sjg:gridColumn name="createdtime" index="u.createtime" title="Created Time"  sortable="true" />       
                </sjg:grid> 
            </div>
        </div>
    </body>
</html>
