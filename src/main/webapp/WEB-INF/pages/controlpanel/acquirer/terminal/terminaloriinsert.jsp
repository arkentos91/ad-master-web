<%-- 
    Document   : terminaloriinsert
    Created on : Apr 29, 2016, 11:34:10 AM
    Author     : jayana_i
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="resouces/css/common/common_popup.css">
        <title>Insert Card Product</title>       
        <script>
            
            //global variables for previous height
            var height_a;
            var height_u;
            $("#min").hide();
            // maximize popup dialog 
            function maximize(width, height) {
                $(window).scrollTop(0);
                height_a = $("#remoteadddialog").height();// get sizes
                height_u = $("#updatedialog").height();// get sizes
                $("#remoteadddialog").height($(window).height() - 60);
                $("#updatedialog").height($(window).height() - 60);
                $(".ui-dialog").width($(window).width() - 40);
                $(".ui-dialog").height($(window).height() - 40);
                $(".ui-dialog").center();
                $("#max").hide();
                $("#min").show();
            }
            // reset to previous popup dialog
            function resetwindow() {
                $(window).scrollTop(0);
                $("#remoteadddialog").height(height_a);// set sizes
                $("#updatedialog").height(height_u);// set sizes
                $(".ui-dialog").width("900");
                $(".ui-dialog").height("490");
                $(".ui-dialog").center();
                $("#max").show();
                $("#min").hide();
            }
            //center popup dialog
            jQuery.fn.center = function () {
                this.css("position", "fixed");
                this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) +
                        $(window).scrollTop()) + "px");
                this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) +
                        $(window).scrollLeft()) + "px");
                return this;
            };
            
            
            $(function () {

                $.subscribe('backTopicadd', function (event, data) {
                    var size = '2';
                    var active = '1';

                    $("#localtabs").tabs('option', 'active', active + 1 >= size ? 0 : active - 1);
                    $('#divmsginsert').empty();

                });
            });

            $(function () {

                $.subscribe('nextTopicadd', function (event, data) {
                    var size = '2';
                    var active = '0';
//                  alert(size+" "+active);
                    $("#localtabs").tabs('option', 'active', active + 1 >= size ? 0 : active + 1);
                    $('#divmsginsert').empty();

                });
            });

            function toright() {
                $("#currentBoxadd option:selected").each(function () {

                    $("#newBoxadd").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function toleft() {
                $("#newBoxadd option:selected").each(function () {

                    $("#currentBoxadd").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function TERtoleftall() {
                $("#newBoxadd option").each(function () {

                    $("#currentBoxadd").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function torightall() {
                $("#currentBoxadd option").each(function () {

                    $("#newBoxadd").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function clickAssign() {

                $('#currentBoxadd option').prop('selected', true);
                $('#newBoxadd option').prop('selected', true);
                $("#assignbutinsert").click();
            }

            function resetAllData() {

                $('#id').val("");
                $('#divmsginsert').empty();
                $('#terminalname').val("");
                $('#merchantOri').val("");
                $('#currency').val("");
                $('#mccOri').val("");
                $('#serialno').val("");
                $('#manufacturer').val("");
                $('#model').val("");
                $('#dateinstalled').val("");
                $('#divmsginsert').val("");
            }
            function resetAllData2(){
                $('#acquirerRiskprofile').val("");
                $('#terminalcategory').val("");
                $('#mobile').val("");
            }
            function nextDiv(key) {

                if (key == 'div1') {
                    $('#tone').hide();
                    $('#ttwo').show();
                    $('#tthree').hide();
                } else if (key == 'div2') {
                    $('#tone').hide();
                    $('#ttwo').show();
                    $('#tthree').hide();
                } else if (key == 'div3') {
                    $('#tone').hide();
                    $('#ttwo').hide();
                    $('#tthree').show();
                }
            }

            function backDiv(key) {
                if (key == 'div1') {
                    $('#ttwo').hide();
                    $('#tone').show();
                    $('#tthree').hide();
                } else if (key == 'div2') {
                    $('#tone').hide();
                    $('#ttwo').show();
                    $('#tthree').hide();
                }

            }

            function showmobile(key) {
                if (key == 'POS') {

                    $('#mob_colomn_edit').hide();
                } else if (key == 'MOB') {
                    $('#mob_colomn_edit').show();
                }
            }

            $(document).ready(function () {
                var ter_mode = $('#terminalcategory').val();
                showStatus(ter_mode);
            });

            function showStatus(key) {

                var ter_mode_edit = key;

                if (ter_mode_edit == 'POS') {
                    $('#status').val('ACT');
                    $('#mobile').prop('disabled', true);
                    $('#mob_colomn_edit').hide();
                } else if (ter_mode_edit == 'MOB') {
                    $('#status').val('CINI');
                    $('#mobile').prop('disabled', false);
                    $('#mob_colomn_edit').show();
                }
            }

        </script>

    </head>
    <body >
        <div class="col-sm-12">
            <div style="text-align: right">
                <sj:submit 
                    id="max"
                    button="true" 
                    value="Maximize" 
                    onClick="maximize()"
                    onClickTopics="Maximize"
                    cssStyle="height: 16px;padding: 1px;width: 55px;font-size: 11px;background: orange;color: white;border-color: gray;"
                    />                          
                <sj:submit 
                    id="min"
                    button="true" 
                    value="Minimize" 
                    onClick="resetwindow()"
                    onClickTopics="Minimize"
                    cssStyle="height: 16px;padding: 1px;width: 55px;font-size: 11px;background: orange;color: white;border-color: gray;"
                    />                     
            </div>
        </div>
        <s:div id="divmsginsert">
            <s:actionerror theme="jquery"/>
            <s:actionmessage theme="jquery"/>
        </s:div>

        <s:form id="cardproductadd" method="post"  theme="simple" cssClass="form" enctype="multipart/form-data">   
            
            <div id="tone" > 
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Terminal ID </label>
                            <s:textfield name="id" id="id" maxLength="8" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))" cssClass="form-control"/>
                        </div>
                    </div>

                    <div class="col-sm-4">
                        <div class="form-group" style=" margin-left: 10px; margin-right: 20px; margin-top:  25px;">
                            <s:url var="searchurl" action="checkTIDTerminal"/>
                            <sj:submit 
                                button="true" 
                                value="Check" 
                                name="check" 
                                href="%{searchurl}"
                                cssClass="btn btn-default btn-sm"
                                id="chechbutt"
                                targets="divmsginsert" />

                        </div> 

                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span> <label>Merchant ID</label>
                            <s:select cssClass="form-control" id="merchantOri" list="%{midList}" 
                                      headerValue="-- Select Merchant ID --"  headerKey=""
                                      name="merchantOri" listKey="mid" listValue="mid"  />
                        </div>
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Currency</label>
                            <s:select  id="currency" list="%{currencyList}"  headerValue="--Select Currency--" headerKey="" name="currency" listKey="currencycode" listValue="description" cssClass="form-control"/>
                        </div>
                     </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Terminal Name</label>
                            <s:textfield  name="terminalname" id="terminalname" maxLength="50" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                        </div>
                    </div>        
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span> <label>Serial Number</label>
                            <s:textfield  name="serialno" id="serialno" maxLength="50" tooltip="Display Name should contains [CARD]" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                        </div>
                    </div>
                        
                </div>
                <div class="row row_popup">        
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Manufacturer</label>
                            <s:textfield name="manufacturer" id="manufacturer" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" cssClass="form-control"/>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Model</label>
                            <s:textfield  name="model" id="model" maxLength="50" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z0-9 ]/g,''))"/>
                        </div>
                    </div>        
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Installed Date</label>
                            <sj:datepicker cssClass="form-control" id="dateinstalled" name="dateinstalled" readonly="true" maxDate="d" changeYear="true"
                                           buttonImageOnly="true" displayFormat="yy-mm-dd" yearRange="2000:2200" />

                        </div>
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-9">
                        <div class="form-group">
                            <span class="mandatoryfield">Mandatory fields are marked with *</span>
                        </div>
                    </div>
                    <div class="col-sm-3 text-right">
                        <div class="form-group" style=" margin-left: 10px;margin-right: 0px;">
                            <sj:submit 
                                button="true" 
                                value="Reset" 
                                name="reset" 
                                cssClass="btn btn-default btn-sm"
                                onClick="resetAllData()"
                                />                          
                        </div>
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <s:url action="addTerminal" var="inserturl"/>
                            <sj:submit
                                button="true" 
                                id="nextButtonadd" 
                                value="Next" 
                                href="#" 
                                onclick="nextDiv('div2')"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"

                                />                        
                        </div>
                    </div>
                </div>
            </div> 
            <div id="ttwo" hidden="true">
                <div class="row row_popup">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red"></span><label>Risk Profile</label>
                            <s:select cssClass="form-control" id="acquirerRiskprofile" list="%{acquirerriskprofileList}" 
                                      headerValue="-- Select Risk Profile--"  headerKey=""
                                      name="acquirerRiskprofile" listKey="profilecode" listValue="description"  />
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Status</label>
                            <!s:select cssClass="form-control" id="status" list="%{statusList}" 
                                headerValue="-- Select Status--"  headerKey=""
                                name="status" listKey="statuscode" listValue="description"  />                  

                            <s:select cssClass="form-control" id="status" name="status" list="%{terstatusList}" 
                                      accesskey="" headerValue="-- Select Status--"  headerKey=""  
                                      listKey="key" listValue="value" disabled="true"/>
                        </div>
                    </div>     
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red">*</span><label>Terminal Category</label>
                            <s:select cssClass="form-control" id="terminalcategory" name="terminalcategory" list="%{terminalcategoryList}" 
                                      headerValue="-- Select Terminal Category--"  headerKey=""  listKey="key" listValue="value" onchange="showStatus(value)"/>   
                        </div>
                    </div>
                </div>
                <div class="row row_popup">     
                    <div class="col-sm-4">
                        <div class="form-group">
                            <span style="color: red" id="mob_colomn_edit" hidden="true" >*</span><label>Mobile</label>
                            <s:textfield  name="mobile" id="mobile" maxLength="20" cssClass="form-control" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g,''))"/>
                        </div>
                    </div>
                </div>

                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <span class="mandatoryfield">Mandatory fields are marked with *</span>
                        </div>
                    </div>
                    <div class="col-sm-6 text-right">
                        <div class="form-group" style=" margin-left: 10px;margin-right: 0px;">
                            <sj:submit 
                                button="true" 
                                value="Reset" 
                                name="reset" 
                                cssClass="btn btn-default btn-sm"
                                onClick="resetAllData2()"
                                />                          
                        </div>
                        <div class="form-group" style=" margin-left: 10px;margin-right: 0px;">
                            <sj:submit 
                                button="true" 
                                id="backButton" 
                                value="Back" 
                                href="#" 
                                onclick="backDiv('div1')"
                                cssClass="btn btn-sm active" 

                                />
                        </div>
                        <div class="form-group" style=" margin-left: 0px;margin-right: 10px;">
                            <s:url action="addTerminal" var="inserturl"/>
                            <sj:submit
                                button="true" 
                                id="nextButtonadde" 
                                value="Next" 
                                href="#" 
                                onclick="nextDiv('div3')"
                                cssClass="btn btn-sm active" 
                                cssStyle="background-color: #ada9a9"

                                />                        
                        </div>
                    </div>
                </div>
            </div>
            <div id="tthree" hidden="true">
                <div class="row row_popup">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Transactions  : </label>                    
                        </div>
                    </div>
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup">
                    <div class="col-sm-5">
                        <label>Assigned Transaction(s)</label>
                        <s:select cssClass="form-control" multiple="true" 
                                  name="currentBox" id="currentBoxadd" list="currentList"									 
                                  ondblclick="toright()" style="height:200px;"/>

                    </div>
                    <div class="col-sm-2 text-center">
                        <div class="row" style="height: 20px;"></div>
                        <div class="row">
                            <sj:a
                                id="right" 
                                onClick="toright()" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="rightall" 
                                onClick="torightall()" 
                                button="true"
                                style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="left" 
                                onClick="toleft()" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                            </div>
                            <div class="row">
                            <sj:a
                                id="leftall" 
                                onClick="TERtoleftall()" 
                                button="true"
                                style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <label>Blocked Transaction(s)</label>
                        <s:select cssClass="form-control" multiple="true"
                                  name="newBox" id="newBoxadd" list="newList"									 
                                  ondblclick="toleft()" style="height:200px;" />
                    </div>
                </div>

                <div style="display: none; visibility: hidden;">
                    <s:hidden id="id" name="id"/>
                    <s:hidden id="mid" name="mid"/>
                    <s:url var="assignurl" action="AssignaddTerminal" />
                    <sj:submit button="true" href="%{assignurl}" id="assignbutinsert"
                               targets="divmsginsert" />
                </div>
                <div class="row row_popup">
                    <div class="horizontal_line_popup"></div>
                </div>
                <div class="row row_popup form-inline">
                    <div class="col-sm-8">
                    </div>
                    <div class="col-sm-4  text-right">
                        <div class="form-group" style=" margin-left: 10px;margin-right: 0px;">
                            <sj:submit 
                                button="true" 
                                id="backButtone" 
                                value="Back" 
                                href="#" 
                                onclick="backDiv('div2')"
                                cssClass="btn btn-sm active" 

                                />
                        </div>

                        <div class="form-group" style=" margin-left: 0px;margin-right: 0px;">
                            <sj:submit
                                button="true"
                                id="assignbutainsert"
                                value="Add"
                                onclick="clickAssign()"
                                cssClass="btn btn-default btn-sm" 
                                cssStyle="background-color: #ada9a9; font-style: normal;"
                                disabled="#vassign"/>
                        </div>

                    </div>
                </div>
            </div>
            <%--</sj:tabbedpanel>--%>
        </s:form>
    </body>
</html>

