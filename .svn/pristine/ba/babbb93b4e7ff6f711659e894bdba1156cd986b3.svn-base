<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="/struts-jquery-tags" prefix="sj"%>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>

        <%@include file="/stylelinks.jspf" %>

        <script type="text/javascript">

            function viewformatter(cellvalue) {
                return "<a href='viewDetailTransactionExplorer.action?transactionid=" + cellvalue + "' title='View Transaction' ><img class='ui-icon ui-icon-newwin' style='display: block;margin-left: auto;margin-right: auto;'/></a>";
            }

            function ShowFileExplorer(fileid) {
                var url = "viewDetailTransactionExplorer.acs?transactionid=" + fileid;
                window.open(url, "View Transaction Explorer", "status = 1, height = 600, width = 1000, resizable = yes, scrollbars=1");
            }

            function searchTxn(param) {

                var fromdate = $('#fromdate').val();
                var todate = $('#todate').val();
                var txnType = $('#txnType').val();
                var tracenumber = $('#tracenumber').val();
                var invoicenumber =$('#invoicenumber').val();
                var amount = $('#amount').val();
                var tid = $('#tid').val();
                var mid = $('#mid').val();
                var responcecode = $('#responcecode').val();
                var hs_txn_cycle_status = $('#hs_txn_cycle_status').val();
                var hs_destination_uri = $('#hs_destination_uri').val();
                var status = $('#status').val();
                var destination_country = $('#destination_country').val();
                var destination_service_id = $('#destination_service_id').val();
                var listnerconfig = $('#listnerconfig').val();
                var currency = $('#currency').val();
                var uritype = $('#uritype').val();
                var sourceofincome = $('#sourceofincome').val();
                var remit = $('#remit').val();
                var bank = $('#bank').val();
                var rrn = $('#rrn').val();

                var txnTypeDes = $("#txnType").find("option:selected").text();
                if (txnTypeDes == "--Select Transaction--") {
                    txnTypeDes = null;
                }
                
                var statusDes = $("#status").find("option:selected").text();
                if (statusDes == "--Select Transaction Decision--") {
                    statusDes = null;
                }
                var responcecodeDes = $("#responcecode").find("option:selected").text();
                if (responcecodeDes == "--Select Response Code--") {
                    responcecodeDes = null;
                }
                var destination_countryDes = $("#destination_country").find("option:selected").text();
                if (destination_countryDes == "--Select Destination Country--") {
                    destination_countryDes = null;
                }
                var destination_service_idDes = $("#destination_service_id").find("option:selected").text();
                if (destination_service_idDes == "--Select Destination Service ID--") {
                    destination_service_idDes = null;
                }
                var listnerconfigDes = $("#listnerconfig").find("option:selected").text();
                if (listnerconfigDes == "--Select Source of Transaction--") {
                    listnerconfigDes = null;
                }
                var currencyDes = $("#currency").find("option:selected").text();
                if (currencyDes == "--Select Transaction Currency--") {
                    currencyDes = null;
                }
                var uritypeDes = $("#uritype").find("option:selected").text();
                if (uritypeDes == "--Select Delivery Method--") {
                    uritypeDes = null;
                }
                var sourceofincomeDes = $("#sourceofincome").find("option:selected").text();
                if (sourceofincomeDes == "--Select Funding Source--") {
                    sourceofincomeDes = null;
                }
                var remitDes = $("#remit").find("option:selected").text();
                if (remitDes == "--Select Purpose of Payment--") {
                    remitDes = null;
                }
                var bankDes = $("#bank").find("option:selected").text();
                if (bankDes == "--Select Bank--") {
                    bankDes = null;
                }
                var load = "no";
                var json = "json";
                $("#gridtable").jqGrid('setGridParam', {postData: {
                        fromdate: fromdate,
                        todate: todate,
                        txntypecode: txnType,
                        txnTypeDes: txnTypeDes,
                        tracenumber: tracenumber,
                        invoiceno: invoicenumber,
                        amount: amount,
                        tid: tid,
                        mid: mid,
                        responcecode: responcecode,
                        load: load,
                        hs_txn_cycle_status: hs_txn_cycle_status,
                        hs_destination_uri: hs_destination_uri,
                        status: status,
                        destination_country: destination_country,
                        destination_service_id: destination_service_id,
                        responcecodeDes: responcecodeDes,
                        statusDes: statusDes,
                        destination_countryDes: destination_countryDes,
                        destination_service_idDes: destination_service_idDes,
                        listnerconfig: listnerconfig,
                        currency: currency,
                        uritype: uritype,
                        sourceofincome: sourceofincome,
                        remit: remit,
                        bank: bank,
                        listnerconfigDes: listnerconfigDes,
                        currencyDes: currencyDes,
                        uritypeDes: uritypeDes,
                        sourceofincomeDes: sourceofincomeDes,
                        remitDes: remitDes,
                        bankDes: bankDes,
                        rrn: rrn,
                        search: param}});

                $("#gridtable").jqGrid('setGridParam', {page: 1, datatype: json});
                jQuery("#gridtable").add()
                jQuery("#gridtable").trigger("reloadGrid");

            }
            ;

            $.subscribe('completetopics', function (event, data) {

                var recors = $("#gridtable").jqGrid('getGridParam', 'records');
                if (recors > 0) {
                    $('#generateButton').button("enable");
                } else {
                    $('#generateButton').button("disable");
                }
            });

            $.subscribe('onbeforetopics', function (event, data) {
                $("#gridtable").jqGrid('setGridParam', {postData: {
                        load: "yes"
                    }});
            });

            function resetAllData() {

                $('#fromdate').val("");
                $('#todate').val("");
                $('#txnType').val("");
                $('#tracenumber').val("");
                $('#invoicenumber').val("");
                $('#amount').val("");
                $('#tid').val("");
                $('#mid').val("");
                $('#responcecode').val("");
                $('#status').val("");
                $('#hs_txn_cycle_status').val("");
                $('#hs_destination_uri').val("");
                $('#destination_country').val("");
                $('#destination_service_id').val("");
                $('#listnerconfig').val("");
                $('#currency').val("");
                $('#uritype').val("");
                $('#sourceofincome').val("");
                $('#remit').val("");
                $('#bank').val("");
                $('#rrn').val("");

                setdate(false);

                $("#gridtable").jqGrid('clearGridData', true);
                searchTxn(false);

            }

            function setdate(parm) {
                var path = window.location.href;
                path = path.indexOf('load=yes');

                if (path == -1) {
                    $("#fromdate").datepicker("setDate", new Date());
                    $("#todate").datepicker("setDate", new Date());
                } else {
                    if (parm) {
                        var json = "json";
                        var load = "yes";
                        $("#gridtable").jqGrid('setGridParam', {postData: {
                                search: false, load: load

                            }});
                        $("#gridtable").jqGrid('setGridParam', {page: 1, datatype: json});
                        jQuery("#gridtable").trigger("reloadGrid");

                    } else {
                        $("#fromdate").datepicker("setDate", new Date());
                        $("#todate").datepicker("setDate", new Date());
                    }
                }
            }


            function todoexel() {
                beforeSubmit();
                $('#reporttype').val("exel");
                form = document.getElementById('tranexpo');
                form.action = 'reportGenerateTransactionExplorer.action';
                form.submit();
            }

            function todo() {
                $('#reporttype').val("pdf");
                form = document.getElementById('tranexpo');
                form.action = 'reportGenerateTransactionExplorer.action';
                form.submit();

            }

            $.subscribe('completetopics', function (event, data) {
                var isexcel = <s:property value="vgenerate"/>;
                var recors = $("#gridtable").jqGrid('getGridParam', 'records');
                if (recors > 0 && isexcel == false) {
                    $('#view').button("enable");
                    $('#view1').button("enable");
                } else {
                    $('#view').button("disable");
                    $('#view1').button("disable");
                }
            });

            $.subscribe('anyerrors', function (event, data) {
            window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
            });


            function beforeSubmit() {
                var statusdes = $("#status").find("option:selected").text();
                var responcecodedes = $("#responcecode").find("option:selected").text();
                var destination_countrydes = $("#destination_country").find("option:selected").text();
                var destination_service_iddes = $("#destination_service_id").find("option:selected").text();
                var listnerconfigdes = $("#listnerconfig").find("option:selected").text();
                var currencydes = $("#currency").find("option:selected").text();
                var uritypedes = $("#uritype").find("option:selected").text();
                var sourceofincomedes = $("#sourceofincome").find("option:selected").text();
                var remitdes = $("#remit").find("option:selected").text();
                var bankdes = $("#bank").find("option:selected").text();
                $('#statusDes').val(statusdes);
                $('#responcecodeDes').val(responcecodedes);
                $('#destination_countryDes').val(destination_countrydes);
                $('#destination_service_idDes').val(destination_service_iddes);
                $('#listnerconfigDes').val(listnerconfigdes);
                $('#currencyDes').val(currencydes);
                $('#uritypeDes').val(uritypedes);
                $('#sourceofincomeDes').val(sourceofincomedes);
                $('#remitDes').val(remitdes);
                $('#bankDes').val(bankdes);
            }

        </script>
        <title></title>
    </head>

    <body onload="setdate(true)">

        <jsp:include page="/header.jsp"/>
        <jsp:include page="/leftmenu.jsp"/>
        <div class="ali-body f-right ali-header-text"> 
            
                            <s:div id="divmsg">
                                <s:actionerror theme="jquery"/>
                                <s:actionmessage theme="jquery"/>
                            </s:div>
                            <s:set var="vgenerate"><s:property value="vgenerate" default="true"/></s:set>
                            <s:set var="vsearch"><s:property value="vsearch" default="true"/></s:set>

                                <div class="ali-form">
                                <s:form id="tranexpo" method="post" action="TransactionExplorer" theme="simple" >

                                    <s:hidden name="reporttype" id="reporttype"></s:hidden>
                                    <s:hidden name="statusDes" id="statusDes"></s:hidden>
                                    <s:hidden name="responcecodeDes" id="responcecodeDes"></s:hidden>
                                    <s:hidden name="destination_service_idDes" id="destination_service_idDes"></s:hidden>
                                    <s:hidden name="destination_countryDes" id="destination_countryDes"></s:hidden>
                                    <s:hidden name="bankDes" id="bankDes"></s:hidden>
                                    <s:hidden name="uritypeDes" id="uritypeDes"></s:hidden>
                                    <s:hidden name="sourceofincomeDes" id="sourceofincomeDes"></s:hidden>
                                    <s:hidden name="remitDes" id="remitDes"></s:hidden>
                                    <s:hidden name="listnerconfigDes" id="listnerconfigDes"></s:hidden>
                                    <s:hidden name="currencyDes" id="currencyDes"></s:hidden>
                                        <div class="row ">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <span style="color: red"></span><label>From Date</label>
                                                    <sj:datepicker  id="fromdate" name="fromdate" readonly="true" changeYear="true" maxDate="d" buttonImageOnly="true" displayFormat="yy-mm-dd"  cssStyle="cursor:auto" value="%{txnSearchdataBean.fromdate}" cssClass="form-control"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>To Date</label>
                                                    <%--<sj:datepicker  id="todate" name="todate" readonly="true" changeYear="true" maxDate="+1d" buttonImageOnly="true" displayFormat="yy-mm-dd" cssClass="mydate" value="%{txnSearchdataBean.todate}" cssClass="form-control"/>--%>
                                                    <sj:datepicker  id="todate" name="todate" readonly="true" changeYear="true" maxDate="d" buttonImageOnly="true" displayFormat="yy-mm-dd"   cssStyle="cursor:auto" value="%{txnSearchdataBean.todate}" cssClass="form-control"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Transaction Type</label>
                                                    <s:select  id="txnType" list="%{txnTypeList}"  name="txnType" headerKey="" headerValue="--Select Transaction--" listKey="typecode" listValue="description" value="%{txnSearchdataBean.txntypecode}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>RRN</label>
                                                    <s:textfield name="rrn" id="rrn" maxLength="12" value="%{txnSearchdataBean.rrn}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                              
                                        
                                    </div>

                                    <div class="row ">
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Response Code</label>
                                                    <s:select  id="responcecode" list="%{responcecodeList}"  name="responcecode" headerKey="" headerValue="--Select Response Code--" listKey="responsecode" listValue="description" value="%{txnSearchdataBean.responcecode}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Trace Number</label>
                                                    <s:textfield name="tracenumber" id="tracenumber" maxLength="12" value="%{txnSearchdataBean.tracenumber}" cssClass="form-control"/>
                                            </div>
                                        </div>   
                                       <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Status</label>
                                                    <s:select  id="status" list="%{statusList}"  name="status" headerKey="" headerValue="--Select Transaction Decision--" listKey="statuscode" listValue="description" value="%{txnSearchdataBean.status}" cssClass="form-control"/>
                                            </div>
                                        </div>

                                       <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Invoice Number</label>
                                                    <s:textfield name="invoicenumber" id="invoicenumber" maxLength="12" value="%{txnSearchdataBean.invoiceno}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                        
                                    </div>
                                    <div class="row ">
                                       <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Amount</label>
                                                    <s:textfield name="amount" id="amount" maxLength="12" value="%{txnSearchdataBean.amount}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Currency</label>
                                                    <s:select  id="currency" list="%{currencyList}"  name="currency" headerKey="" headerValue="--Select Transaction Currency--" listKey="currencycode" listValue="description" value="%{txnSearchdataBean.currency}" cssClass="form-control"/>
                                            </div>
                                        </div>  

                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>TID</label>
                                                    <s:textfield name="tid" id="tid" maxLength="8" value="%{txnSearchdataBean.tid}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>MID</label>
                                                    <s:textfield name="mid" id="mid" maxLength="20" value="%{txnSearchdataBean.mid}" cssClass="form-control"/>
                                            </div>
                                        </div> 
                                    </div>
<!--                                    <div class="row row_1">
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Delivery Method</label>
                                                    <%--<s:select  id="uritype" list="%{uritypeList}"  name="uritype" headerKey="" headerValue="--Select Delivery Method--" listKey="code" listValue="name" value="%{txnSearchdataBean.uritype}" cssClass="form-control"/>--%>
                                            </div>
                                        </div> 
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <span style="color: red"></span><label>Source of Transaction</label>
                                                    <%--<s:select  id="listnerconfig" list="%{listnerconfigList}"  name="listnerconfig" headerKey="" headerValue="--Select Source of Transaction--" listKey="uid" listValue="name" value="%{txnSearchdataBean.listnerconfig}" cssClass="form-control"/>--%>
                                            </div>
                                        </div> 
                                        

                                    </div>-->
                                </s:form>

                                <div class="row ">
                                    <div class="col-sm-12">
                                        <div class="form-group ali-margin">

                                            <sj:submit  value="Search"
                                                        button="true" id="searchButton"
                                                        onclick="searchTxn(true)" disabled="#vsearch" cssClass="form-control btn_normal"
                                                        cssClass="btn btn-ali-submit btn-sm"
                                                        />

                                            <%-- <sj:a button="true" id="reset"
                                                   onclick="resetAllData()" cssClass="form-control btn_normal"
                                                   cssStyle="border-radius: 12px;">Reset</sj:a> --%>

                                            <sj:submit  
                                                button="true" id="reset" value="Reset"
                                                onclick="resetAllData()" 
                                                cssClass="btn btn-ali-reset btn-sm"
                                                />

                                            <sj:submit 
                                                 cssClass="btn btn-ali-other btn-sm"
                                                button="true" 
                                                value="View PDF" 
                                                name="subview" 
                                                disabled="#vgenerate"
                                                id="view" 
                                                onClick="todo()" 
                                                cssStyle="display:none;"
                                                /> 
                                            <sj:submit  value="View Excel"
                                                button="true" id="view1" onclick="todoexel()"  disabled="#vgenerate" 
                                               cssClass="btn btn-ali-other btn-sm"
                                            />
                                        </div>
                                        
                                    </div>
                                </div>

                                <%--</s:form>--%>
                            </div>

                            <div class="ali-table">
                                <s:url var="listurl" action="SearchTransactionExplorer"/>
                                <sjg:grid  
                                    id="gridtable"
                                    caption="Transaction Explorer"
                                    dataType="local"
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
                                    <sjg:gridColumn name="transactionid" index="t.TRANSACTIONID" title="View" width="40" align="center" formatter="viewformatter" hidden="#vviewlink" sortable="false" />
                                    <sjg:gridColumn name="transactionid" index="t.TRANSACTIONID" title="Transaction ID"  sortable="true"/>
                                    <sjg:gridColumn name="txntypecode" index="tt.DESCRIPTION" title="Transaction Type"  sortable="true"/>
                                    <sjg:gridColumn name="rrn" index="t.RRN" title="RRN"  sortable="true"/>
                                    <sjg:gridColumn name="tracenumber" index="t.TRACENUMBER" title="Trace Number"  sortable="true"/>
                                    <sjg:gridColumn name="responcecode" index="rc.DESCRIPTION" title="Response"  sortable="true"/>
                                    <sjg:gridColumn name="status" index="s.DESCRIPTION" title="Status" sortable="true"/> 
                                    
                                    
                                    <sjg:gridColumn name="createtime" index="t.CREATETIME" title="Created Time"  sortable="true"/>
                                    <sjg:gridColumn name="mti" index="t.MTI" title="MTI"  sortable="true"/>
                                    <sjg:gridColumn name="processingcode" index="t.PROCESSINGCODE" title="Processing Code"  sortable="true"/>
                                    <sjg:gridColumn name="localdate" index="t.LOCALDATE" title="Local Date"  sortable="true"/>
                                    <sjg:gridColumn name="localtime" index="t.LOCALTIME" title="Local Time"  sortable="true"/>
                                    <sjg:gridColumn name="invoiceno" index="t.INVOICENO" title="Invoice Number"  sortable="true"/>
                                    <sjg:gridColumn name="amount" index="t.AMOUNT" title="Amount"  sortable="true" align="right"/>
                                    <sjg:gridColumn name="currencycode" index="cu.DESCRIPTION" title="Currency"  sortable="true"/>
                                    <sjg:gridColumn name="tid" index="t.TID" title="TID"  sortable="true"/>
                                    <sjg:gridColumn name="mid" index="t.MID" title="MID"  sortable="true"/>
                                    <sjg:gridColumn name="authcode" index="t.AUTHCODE" title="Auth Code"  sortable="true"/>
                                    <sjg:gridColumn name="qr_url" index="t.QR_URL" title="QR URL"  sortable="true"/>
                                     <sjg:gridColumn name="signature" index="t.SIGNATURE" title="Signature"  sortable="true"/>
                                     <sjg:gridColumn name="eodstatus" index="s.DESCRIPTION" title="EOD Status"  sortable="true"/>
                                    
                                </sjg:grid> 
                            </div>

                        </div>
                    

                <jsp:include page="/footer.jsp"/>

                </body>
                </html>






