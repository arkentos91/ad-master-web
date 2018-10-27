<%-- 
    Document   : headmerchantinsert
    Created on : Jul 13, 2016, 11:26:52 AM
    Author     : samith_k
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Merchant</title>

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
                $(".ui-dialog").width("1000");
                $(".ui-dialog").height("450");
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

            function nextDiv(key) {

                if (key == 'div1') {
                    $('#tone').hide();
                    $('#ttwo').show();
                } else if (key == 'div2') {
                    $('#tone').hide();//main
                    $('#ttwo').hide();//cur
                    $('#tfour').show(); //tra
                }
            }
            function backDiv(key) {
                if (key == 'div2') {
                    $('#ttwo').hide();
                    $('#tone').show();
                }
                else if (key == 'div4') {
                    $('#tone').hide();
                    $('#ttwo').show();
                    $('#tfour').hide();
                }

            }

            function resetAllDataAdd() {

                $('#mid').val("");
                $('#mid').attr('readOnly', false);
                $('#name').val("");
                $('#status').val("");
                $('#amessage').text("");
                $('#conXL').val("");
                $('#conXL').text('');
                $('#logoImg').val("");
                $('#logowebImg').val("");
                $("#logo_add").attr("src", "");
                $("#logoweb_add").attr("src", "");
                MCtoleftall();
                MCtoleftallTran();


            }

            function EraseDiv() {

                $('#amessage').text("");

            }

            function changeLogo() {
                $("#logoImg").change(function (event) {
                    var tmppath = URL.createObjectURL(event.target.files[0]);
                    $("#logo_add").attr("src", tmppath);
                });
            }
            function changeLogoWeb() {
                $("#logowebImg").change(function (event) {
                    var tmppath = URL.createObjectURL(event.target.files[0]);
                    $("#logoweb_add").attr("src", tmppath);
                });
            }
            function toright() {
                $("#currentBox option:selected").each(function () {

                    $("#newBox").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function torightTran() {
                $("#currentBoxTran option:selected").each(function () {

                    $("#newBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function toleft() {
                $("#newBox option:selected").each(function () {

                    $("#currentBox").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function toleftTran() {
                $("#newBoxTran option:selected").each(function () {

                    $("#currentBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function toleftall() {
                $("#newBox option").each(function () {

                    $("#currentBox").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function MCtoleftallTran() {
                $("#newBoxTran option").each(function () {

                    $("#currentBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function torightall() {
                $("#currentBox option").each(function () {

                    $("#newBox").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function torightallTran() {
                $("#currentBoxTran option").each(function () {

                    $("#newBoxTran").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function clickAssignAdd() {

                $('#currentBox option').prop('selected', true);
                $('#newBox option').prop('selected', true);
                $("#assignbutAdd").click();
            }
            function clickAssign() {

                $('#currentBox option').prop('selected', true);
                $('#newBox option').prop('selected', true);
                $("#assignbut").click();
            }

            function clickAssignTran() {

                $('#currentBoxTran option').prop('selected', true);
                $('#newBoxTran option').prop('selected', true);
                $("#assignbutTran").click();

            }

            function resetAllData() {
                $('#divmsg').text("");
            }

            function clickAddMchantCus() {

                $('#newBox option').prop('selected', true);
                $('#newBoxTran option').prop('selected', true);
                EraseDiv();
                $("#addbtnMerCus").click();
            }

            function alpha(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57) || (k == 13));
            }
            function alphaemail(e) {
                var k;
                document.all ? k = e.keyCode : k = e.which;
                return ((k > 63 && k < 91) || (k == 95) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 46 && k != 47 && k <= 57) || (k == 13));
            }
        </script>    
        <style>
            .image{
                height:100px;
                width: 100px;
                border-color: gray;
                border-width: 1px;
                border-style: solid;
                margin-left: 5px;
                margin-right: 5px;
                border-radius: 10px;
                padding: 5px;
            }
        </style>
    </head>
    <body >
        <div class="ali-modal">
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
            <div class="ali-modal-body">
                <div class="ali-form">    
                    <s:div id="amessage">
                        <s:actionerror theme="jquery"/>
                        <s:actionmessage theme="jquery"/>
                    </s:div>

                    <s:set id="vassign" var="vassign">
                        <s:property value="vassignAdd" default="false" />
                        <s:property value="vassignTran" default="false" />
                        <s:property value="vassignMcc" default="false" />
                    </s:set>

                    <s:form id="headmerchantadd" method="post" action="" theme="simple" cssClass="form" enctype="multipart/form-data">



                        <!-- =========================================================================== Tab 1 ==========================================================           -->

                        <div id="tone" >

                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Merchant Customer Code</label>
                                        <s:textfield value="%{mid}" cssClass="form-control" name="mid" id="mid" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Merchant Customer Name</label>
                                        <s:textfield value="%{name}" cssClass="form-control" name="name" id="name" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g,''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Status</label>
                                        <s:select value="%{status}" headerValue="--Select Status--" headerKey="" cssClass="form-control"  id="status" list="%{statusList}"  name="status" listKey="statuscode" listValue="description"/>                  
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row ">
                                <div class="col-sm-6">
                                    <div class="ali-mandatory-field">Mandatory fields are marked with <span>*</span></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group ali-margin f-right">
                                        <sj:submit 
                                            button="true" 
                                            value="Reset" 
                                            onClick="resetAllDataAdd()"
                                            cssClass="btn btn-ali-reset btn-sm"
                                            />                          
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="nextbtn3"
                                            onclick="nextDiv('div1')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>
                            </div>
                        </div>    

                        <!-- =========================================================================== Tab 2 (Currency)==========================================================           -->


                        <div id="ttwo" hidden="true">
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label > Currency :</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>

                            <div class="row row_popup">

                                <div class="col-sm-5">
                                    <label>Assigned Currency</label>
                                    <s:select cssClass="form-control" multiple="true" 
                                              name="currentBox" id="currentBox" list="currentList"									 
                                              ondblclick="toright()" style="height:160px;"/>

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
                                            onClick="toleftall()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <label>Blocked Currency</label>
                                    <s:select cssClass="form-control" multiple="true"
                                              name="newBox" id="newBox" list="newList"									 
                                              ondblclick="toleft()" style="height:160px;" />
                                </div>
                            </div>

                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row ">
                                <div class="col-sm-6">
                                    <!--<div class="ali-mandatory-field"></div>-->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group ali-margin f-right">
                                        <sj:submit
                                            button="true"
                                            value="Back"
                                            href="%{inserturl}"
                                            id="backbtn1"
                                            onclick="backDiv('div2')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="nextbtn1"
                                            onclick="nextDiv('div2')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- =========================================================================== Tab 3 (Transaction Type)==========================================================           -->

                        <div id="tfour" hidden="true">
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red"></span><label > Transactions :</label>
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
                                              name="currentBoxTran" id="currentBoxTran" list="CurrentListTran"									 
                                              ondblclick="torightTran()" style="height:160px;"/>

                                </div>
                                <div class="col-sm-2 text-center">
                                    <div class="row" style="height: 20px;"></div>
                                    <div class="row">
                                        <sj:a
                                            id="rightTran" 
                                            onClick="torightTran()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="rightallTran" 
                                            onClick="torightallTran()" 
                                            button="true"
                                            style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="leftTran" 
                                            onClick="toleftTran()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="leftallTran" 
                                            onClick="MCtoleftallTran()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <label>Blocked Transaction(s)</label>  
                                    <s:select cssClass="form-control" multiple="true"
                                              name="newBoxTran" id="newBoxTran" list="NewListTran"									 
                                              ondblclick="toleftTran()" style="height:160px;" />
                                </div>
                            </div>

                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row ">
                                <div class="col-sm-6">
                                    <!--<div class="ali-mandatory-field"></div>-->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group ali-margin f-right">
                                        <sj:submit
                                            button="true"
                                            value="Back"
                                            href="%{inserturl}"
                                            id="backbtn2"
                                            onclick="backDiv('div4')"
                                            cssClass="btn btn-ali-submit btn-sm" 
                                            />          
                                        <sj:submit
                                            button="true"
                                            value="Add"
                                            onclick="clickAddMchantCus()"
                                            id="addbtntmp"
                                            cssClass="btn btn-sm active" 
                                            cssClass="btn btn-ali-submit btn-sm" 
                                            />                        
                                    </div>
                                    <div style="display: none; visibility: hidden;">
                                        <s:url action="AddMerchantCustomer" var="inserturl"/>
                                        <sj:submit button="true" href="%{inserturl}" id="addbtnMerCus" targets="amessage" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- =========================================================================== Tab 3 (Merchant Customer Category) ==========================================================           -->                            
                    </s:form>
                </div>
            </div>
        </div>
    </body>
</html>
