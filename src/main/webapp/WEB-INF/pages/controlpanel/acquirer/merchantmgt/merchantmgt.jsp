<%-- 
    Document   : merchantmgt
    Created on : Jul 9, 2016, 1:42:14 PM
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

            function resetattemptformatter(cellvalue, options, rowObject) {
                var vst = rowObject.resetattempt;
                if (vst === "0") {
                    return "--";
                } else {
                    return "<a href='#/' title='Reset Attempt Count' onClick='javascript:resetAttempCount(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-arrowreturnthick-1-n' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
                }
            }

            function refreshMerchant() {
                $("#gridtable").jqGrid('setGridParam', {page: 1});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function generateformatter(cellvalue, options, rowObject) {
                var vst = rowObject.username;
                var chkstatus = rowObject.status;

                if (vst === "--" && chkstatus === "Active") {
                    return "<a href='#/' title='Generate username' onClick='javascript:generateUserPass(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-person' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
                } else {
                    return "--";
                }
            }

            function viewformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='View' onClick='javascript:viewMerchantInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-newwin' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function editformatter(cellvalue, options, rowObject) {
                return "<a href='#' title='Edit' onClick='javascript:editMerchantInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-pencil' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function deleteformatter(cellvalue, options, rowObject) {
                return "<a href='#/' title='Delete' onClick='javascript:deleteMerchantInit(&#34;" + cellvalue + "&#34;)'><img class='ui-icon ui-icon-trash' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function viewMerchantInit(keyval) {
                $("#viewdialog").data('merchantcode', keyval).dialog('open');
            }

            $.subscribe('openviewmerchantdetails', function (event, data) {
                var $led = $("#viewdialog");
                $led.html("Loading..");
                $led.load("MoreDetailMerchantMgt.action?merchantcode=" + $led.data('merchantcode'));
            });

            function editMerchantInit(keyval) {
                keyval = keyval.trim();
                $("#updatedialog").data('merchantcode', keyval).dialog('open');
            }

            $.subscribe('openviewtasktopage', function (event, data) {
                var $led = $("#updatedialog");
                $led.html("Loading..");
                $led.load("detailMerchantMgt.action?merchantcode=" + $led.data('merchantcode'));
            });

            function deleteMerchantInit(keyval) {
                $('#divmsg').empty();
                $("#deletedialog").data('keyval', keyval).dialog('open');
                $("#deletedialog").html('Are you sure you want to delete Merchant ' + keyval + ' ?');
                return false;
            }

            function resetAttempCount(keyval) {
                $('#divmsg').empty();
                $("#confirmdialogresetattemp").data('keyval', keyval).dialog('open');
                $("#confirmdialogresetattemp").html('Are you sure you want to reset attempt count of merchant ID ' + keyval + ' ?');
                return false;
            }

            function generateUserPass(keyval) {
                $('#divmsg').empty();
                $("#confirmdialog").data('keyval', keyval).dialog('open');
                $("#confirmdialog").html('Are you sure you want to generate username and password to merchant ID ' + keyval + ' ?');
                return false;
            }

            function generateMerchant(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/GenerateuserpassMerchantMgt.action',
                    data: {merchantcode: keyval},
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

            function resetAttCount(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/ResetattempMerchantMgt.action',
                    data: {merchantcode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $("#resetsuccdialog").dialog('open');
                        $("#resetsuccdialog").html(data.message);
                        $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                        jQuery("#gridtable").trigger("reloadGrid");
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function deleteMerchant(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/DeleteMerchantMgt.action',
                    data: {merchantcode: keyval},
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

            function resetAllData() {

                $('#merchantcodesearch').val("");
                $('#mobilesearch').val("");
                $('#merchantCustomersearch').val("");
                $('#descriptionsearch').val("");
                $('#statussearch').val("");
                $('#mccsearch').val("");
                $('#commisionsearch').val("");
                $('#promotionsearch').val("");
                $('#riskProfilesearch').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_merchantCode: '',
                        s_merchantCustomer: '',
                        s_description: '',
                        s_status: '',
                        s_mcc: '',
                        s_commision: '',
                        s_promotion: '',
                        s_mobile: '',
                        s_riskProfile: '',
                        search: false
                    }});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function cancelMerchantData() {
                editMerchant(null);
            }

            function searchMerchant() {
                var merchantcodesearch = $('#merchantcodesearch').val();
                var merchantCustomersearch = $('#merchantCustomersearch').val();
                var descriptionsearch = $('#descriptionsearch').val();
                var statussearch = $('#statussearch').val();
                var mccsearch = $('#mccsearch').val();
                var commisionsearch = $('#commisionsearch').val();
                var promotionsearch = $('#promotionsearch').val();
                var riskProfilesearch = $('#riskProfilesearch').val();
                var mobilesearch = $('#mobilesearch').val();

                $("#gridtable").jqGrid('setGridParam', {postData: {
                        s_merchantCode: merchantcodesearch,
                        s_merchantCustomer: merchantCustomersearch,
                        s_description: descriptionsearch,
                        s_status: statussearch,
                        s_mcc: mccsearch,
                        s_commision: commisionsearch,
                        s_promotion: promotionsearch,
                        s_riskProfile: riskProfilesearch,
                        s_mobile: mobilesearch,
                        search: true
                    }});

                $("#gridtable").jqGrid('setGridParam', {page: 1});

                jQuery("#gridtable").trigger("reloadGrid");
            }
            $.subscribe('anyerrors', function (event, data) {
                window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });


            function resetFieldData() {

                $('#merchantCustomer').val("");
                $('#merchantcode').attr('readOnly', false);
                $('#merchantcode').val("");
                $('#description').val("");
                $('#latitude').val("");
                $('#status').val("");
                $('#commision').val("");
                $('#promotion').val("");
                $('#longitude').val("");
                $('#address').val("");
                $('#mobile').val("");
                $('#riskProfile').val("");
                $('#topupacc').val("");
                $('#posacc').val("");
                $('#contact1').val("");
                $('#contact2').val("");
                $('#email1').val("");
                $('#email2').val("");

                $('#accounttype').val("");
                $('#accountnumber').val("");
                $('#paymenttype').val("");
                $('#bankname').val("");
                $('#branchcode').val("");
                $('#branch').val("");

                $('#legalname').val("");
                $('#merchantCustCategory').val("");

                $('#accountTypeCashIn').val("");
                $('#incomeExpenseCashIn').val("");
                $('#flatPercentageCashIn').val("");
                $('#amountCashIn').val("");

                $('#accountTypeCashOut').val("");
                $('#incomeExpenseCashOut').val("");
                $('#flatPercentageCashOut').val("");
                $('#amountCashOut').val("");

                $('#accountTypeNormal').val("");
                $('#incomeExpenseNormal').val("");
                $('#flatPercentageNormal').val("");
                $('#amountNormal').val("");

                $('#accountTypeCashInDeb').val("");
                $('#incomeExpenseCashInDeb').val("");
                $('#flatPercentageCashInDeb').val("");
                $('#amountCashInDeb').val("");

                $('#accountTypeCashOuDebt').val("");
                $('#incomeExpenseCashOutDeb').val("");
                $('#flatPercentageCashOutDeb').val("");
                $('#amountCashOutDeb').val("");

                $('#accountTypeNormalDeb').val("");
                $('#incomeExpenseNormalDeb').val("");
                $('#flatPercentageNormalDeb').val("");
                $('#amountNormalDeb').val("");

                toleftall('currency');
                toleftall('mcc');
                toleftall('transaction');

                $('#conXL').val("");

                $("#gridtable").jqGrid('setGridParam', {postData: {search: false}});
                jQuery("#gridtable").trigger("reloadGrid");
            }

            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57) || (k == 13));
            }


        </script>
        <style>
            th.ui-th-column div{
                white-space:normal !important;
                height:auto !important;
                padding:2px; 
            }
        </style>
        <title>Merchant Management</title>
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
            <s:set id="vupload" var="vupload"><s:property value="vupload" default="true"/></s:set>
            <s:set var="vupdatebutt"><s:property value="vupdatebutt" default="true"/></s:set>
            <s:set var="vupdatelink"><s:property value="vupdatelink" default="true"/></s:set>
            <s:set var="vdelete"><s:property value="vdelete" default="true"/></s:set>
            <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>
            <s:set var="vreset"><s:property value="vreset" default="true"/></s:set>
            <s:set var="vuserpassgen"><s:property value="vuserpassgen" default="true"/></s:set>

                <div class="ali-form">
                <s:form id="merchantsearch" method="post" cssClass="form" action="MerchantMgt" theme="simple" >    


                    <div class="row "> 
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Merchant ID</label>
                                <s:textfield  name="merchantcode" id="merchantcodesearch" value="" maxLength="20"  cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onkeypress="return alpha(event)" /> 
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Description </label>
                                <s:textfield  name="description" id="descriptionsearch" value="" maxLength="64"  cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onkeypress="return alpha(event)"/> 
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Merchant Customer Name</label>
                                <s:select name="merchantCustomer" id="merchantCustomersearch" list="%{merchantCustomerList}"   headerValue="--Select Merchant Customer--" cssClass="form-control" headerKey=""  listKey="mid" listValue="name"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Status </label>
                                <s:select  name="statussearch" id="statussearch" list="%{statusList}"   headerKey=""  headerValue="--Select Status--" listKey="statuscode" listValue="description" value="%{status}" disabled="false" cssClass="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Acquirer Risk Profile</label>
                                <s:select  name="riskProfile" id="riskProfilesearch" list="%{riskProfileList}"   headerKey=""  headerValue="--Select Acquirer Risk Profile--" listKey="profilecode" listValue="description" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Mobile</label>
                                <s:textfield  name="mobile" id="mobilesearch" maxLength="10"  cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onkeypress="return alpha(event)"/> 
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Acquirer Promotion </label>
                                <s:select  name="promotionsearch" id="promotionsearch" list="%{promotionList}"   
                                           headerKey=""  headerValue="--Select Acquirer Promotion--" 
                                           listKey="code" listValue="description" value="%{promotion}" 
                                           disabled="false" cssClass="form-control"/>
                            </div>
                        </div> 
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label >Merchant Category Code</label>
                                <s:select  id="mccsearch" name="mccsearch" headerValue="--Select MCC--" 
                                           headerKey="" cssClass="form-control" list="%{mccOriList}"  
                                           listKey="mcccode" listValue="mccdes"
                                           /> 
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
                                    onClick="searchMerchant()"  
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
                                <div style="display: none;">
                                    <s:url var="addurl" action="ViewPopupaddMerchantMgt"/>   
                                    <sj:submit                                                      
                                        openDialog="remoteadddialog"
                                        button="true"
                                        href="%{addurl}"
                                        disabled="#vadd"
                                        value="Add New Merchant"
                                        id="addButton"
                                        hidden="true"
                                        targets="remoteadddialog"   
                                        cssClass="btn f-right btn-ali-other btn-sm"

                                        />
                                </div>

                            </div>
                        </div>
                    </div>                
                </s:form>   

                <!-- Start view dialog box -->
                <sj:dialog                                     
                    id="viewdialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="View Merchant"
                    onOpenTopics="openviewmerchantdetails" 
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
                    title="Upload Merchant"                            
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
                    title="Add Merchant"                            
                    loadingText="Loading .."                            
                    position="center"                            
                    dialogClass="dialogclass"
                    width="900"
                    height="550"
                    />

                <sj:dialog                                     
                    id="updatedialog"                                 
                    autoOpen="false" 
                    modal="true" 
                    position="center"
                    title="Update Merchant"
                    onOpenTopics="openviewtasktopage" 
                    loadingText="Loading .."
                    width="900"
                    height="550"
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
                    title="Delete Merchant "                            
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

                <sj:dialog 
                    id="confirmdialogresetattemp" 
                    buttons="{ 
                    'OK':function() { resetAttCount($(this).data('keyval'));$( this ).dialog( 'close' ); },
                    'Cancel':function() { $( this ).dialog( 'close' );} 
                    }" 
                    autoOpen="false" 
                    modal="true" 
                    title="Reset Attempt Count "                            
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
                    id="generatesuccdialog" 
                    buttons="{
                    'OK':function() { $( this ).dialog( 'close' );}
                    }"  
                    autoOpen="false" 
                    modal="true" 
                    title="Generating Process." 
                    />
                <sj:dialog 
                    id="resetsuccdialog" 
                    buttons="{
                    'OK':function() { $( this ).dialog( 'close' );}
                    }"  
                    autoOpen="false" 
                    modal="true" 
                    title="Resetting Attempt Count Process." 
                    />
            </div>

            <div class="ali-table">
                <s:url var="listurl" action="ListMerchantMgt"/>
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
                    shrinkToFit="false"
                    onErrorTopics="anyerrors"
                    >
                    <sjg:gridColumn name="merchantcode" index="u.mid" title="Edit" width="40" align="center" formatter="editformatter" hidden="#vupdatelink" sortable="true" />
                    <sjg:gridColumn name="merchantcode" index="u.mid" title="Delete" width="40" align="center" formatter="deleteformatter" hidden="#vdelete" sortable="true"  />  
                    <sjg:gridColumn name="merchantcode" index="u.mid" title="Reset Attempt Count"  width="80" align="center" formatter="resetattemptformatter" hidden="#vreset" sortable="true" />
                    <sjg:gridColumn name="merchantcode" index="u.mid" title="Generate"  width="60" align="center" formatter="generateformatter" hidden="#vuserpassgen" sortable="true" />
                    <sjg:gridColumn name="merchantcode" index="u.mid" title="Merchant ID"  sortable="true" />
                    <sjg:gridColumn name="description" index="u.description" title="Description"  sortable="true"/>
                    <sjg:gridColumn name="username" index="u.username" title="User Name"  sortable="true"/>
                    <sjg:gridColumn name="attemptcount" index="u.attemptcount" align="center" title="Attempt Count" width="100" sortable="true"/>
                    <sjg:gridColumn name="merchantCustomer" index="u.mercustomersOri.name" title="Merchant Customer Name"  sortable="true"/>
                    <sjg:gridColumn name="mcc" index="u.mcc" title="Merchant Category Code"  sortable="true"/>
                    <sjg:gridColumn name="riskprofile" index="u.acquirerRiskprofile.description" title="Risk Profile"  sortable="true"/> 
                    <sjg:gridColumn name="promotion" index="u.promotionprofile.description" title="Promotion"  sortable="true"/>
                    <%--<sjg:gridColumn name="latitude" index="u.latitude" title="Latitude"  sortable="true" width="60"/>--%>
                    <%--<sjg:gridColumn name="longitude" index="u.longitude" title="Longitude"  sortable="true" width="60"/>--%>
                    <sjg:gridColumn name="address" index="u.address" title="Address"  sortable="true"/>                                                                        
                    <sjg:gridColumn name="status" index="u.status.description" title="Status"  sortable="true"/>                                   
                    <sjg:gridColumn name="mobile" index="u.mobile" title="Mobile"  sortable="true"/>
                    <%--<sjg:gridColumn name="posacc" index="u.posacc" title="POS Account"  sortable="true"/>--%>                                
                    <sjg:gridColumn name="createdtime" index="u.createTime" title="Created Time"  sortable="true"/>                                   

                </sjg:grid> 
            </div>
        </div>
        <jsp:include page="/footer.jsp"/>
    </body>
</html>


