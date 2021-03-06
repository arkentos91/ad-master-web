<%-- 
    Document   : headmerchantedit
    Created on : Jul 13, 2016, 9:05:39 AM
    Author     : samith_k
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link rel="stylesheet" href="resouces/css/common/common_popup.css">-->
        <title>Edit Merchant</title>
        <script>

            //global variables for previous height
            var height_r;
            var height_u;
            $("#min2").hide();
            // maximize popup dialog 
            function maximize() {
                $(window).scrollTop(0);
                height_r = $("#remoteadddialog").height();// get sizes
                height_u = $("#updatedialog").height();// get sizes
                $("#remoteadddialog").height($(window).height() - 60);
                $("#updatedialog").height($(window).height() - 60);
                $(".ui-dialog").width($(window).width() - 40);
                $(".ui-dialog").height($(window).height() - 40);
                $(".ui-dialog").center();
                $("#max2").hide();
                $("#min2").show();
            }
            // reset to previous popup dialog
            function resetwindow() {
                $(window).scrollTop(0);
                $("#remoteadddialog").height(height_r);// set sizes
                $("#updatedialog").height(height_u);// set sizes
                $(".ui-dialog").width("1000");
                $(".ui-dialog").height("450");
                $(".ui-dialog").center();
                $("#max2").show();
                $("#min2").hide();
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

            function editMerchant(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindMerchantCustomer.action',
                    data: {mid: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#midedit').val("");
                            $('#midedit').attr('readOnly', false);
                            $('#midedit').val("");
                            $('#nameedit').val("");
                            
                            $('#statusedit').val("");
                            $('#amessageedit').text("");
                            $('#logoImgFile').val("");
                            $('#logowebImgFile').val("");
                            $('#updatebutetabonedit').button("disable");
                        } else {
                            $('#midedit').val(data.mid);
                            $('#midedit').attr('readOnly', true);
                            $('#nameedit').val(data.name);
                            $('#statusedit').val(data.status);
                           
                            $('#logoImgFile').val("");
                            $('#logowebImgFile').val("");
                            $("#logo_edit").attr("src", "data:image/jpeg;base64," + data.editLogoImg);
                            $("#logoweb_edit").attr("src", "data:image/jpeg;base64," + data.editLogowebImg);
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function cancelData() {
                var mid = $('#midedit').val();
                editMerchant(mid);
            }

            function changeLogoEdit() {
                $("#logoImgFile").change(function (event) {
                    var tmppath = URL.createObjectURL(event.target.files[0]);
                    $("#logo_edit").attr("src", tmppath);
                });
            }

            function changeLogowebEdit() {
                $("#logowebImgFile").change(function (event) {
                    var tmppath = URL.createObjectURL(event.target.files[0]);
                    $("#logoweb_edit").attr("src", tmppath);
                });
            }

            function torightedit() {
                $("#currentBoxedit option:selected").each(function () {

                    $("#newBoxeditcur").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function torightTranedit() {
                $("#currentBoxTranedit option:selected").each(function () {

                    $("#newBoxedit").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }


            function toleftedit() {
                $("#newBoxeditcur option:selected").each(function () {

                    $("#currentBoxedit").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }


            function toleftTranedit() {
                $("#newBoxedit option:selected").each(function () {

                    $("#currentBoxTranedit").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function toleftalledit() {
                $("#newBoxeditcur option").each(function () {

                    $("#currentBoxedit").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function toleftallTranedit() {
                $("#newBoxedit option").each(function () {

                    $("#currentBoxTranedit").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }
            function torightalledit() {
                $("#currentBoxedit option").each(function () {

                    $("#newBoxeditcur").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function torightallTranedit() {
                $("#currentBoxTranedit option").each(function () {

                    $("#newBoxedit").append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                    $(this).remove();
                });
            }

            function assignAll() {
                clickAssignedit();
                clickAssignTranedit();

            }
            function clickAssignedit() {

                $('#currentBoxedit option').prop('selected', true);
                $('#newBoxeditcur option').prop('selected', true);
                $("#assignbutedit").click();
            }

            function clickAssignTranedit() {

                $('#currentBoxTranedit option').prop('selected', true);
                $('#newBoxedit option').prop('selected', true);
                $("#assignbutTranedit").click();
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

            function nextDivEdit(key) {

                if (key == 'div1') {
                    $('#etabone').hide();
                    $('#etabtwo').show();
                } else if (key == 'div2') {
                    $('#etabone').hide();
                    $('#etabtwo').hide();
                    $('#etabfour').show();
                }
            }

            function backDivEdit(key) {
                if (key == 'div2') {
                    $('#etabtwo').hide();
                    $('#etabone').show();
                }
                else if (key == 'div4') {
                    $('#etabone').hide();
                    $('#etabtwo').show();
                    $('#etabfour').hide();
                }

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
    <body>
        <div class="ali-modal">
            <div class="col-sm-12">
                <div style="text-align: right">
                    <sj:submit 
                        id="max2"
                        button="true" 
                        value="Maximize" 
                        onClick="maximize()"
                        onClickTopics="Maximize"
                        cssStyle="height: 16px;padding: 1px;width: 55px;font-size: 11px;background: orange;color: white;border-color: gray;"
                        />                          
                    <sj:submit 
                        id="min2"
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
                    <s:div id="amessageedit">
                        <s:actionerror theme="jquery"/>
                        <s:actionmessage theme="jquery"/>
                    </s:div>
                    <s:form id="merchantedit" method="post" action="MerchantCustomer" theme="simple" cssClass="form" enctype="multipart/form-data">

                        <div id="etabone" >

                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Merchant Customer Code</label>
                                        <s:textfield readonly="true" value="%{mid}" cssClass="form-control" name="mid" id="midedit" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Merchant Customer Name</label>
                                        <s:textfield value="%{name}" cssClass="form-control" name="name" id="nameedit" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g,''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Status</label>
                                        <s:select value="%{status}" headerValue="--Select Status--" headerKey="" cssClass="form-control"  id="statusedit" list="%{statusList}"  name="status" listKey="statuscode" listValue="description"/>                  
                                    </div>  
                                </div>
                            </div>
                                   
                            <div class="row row_popup ">
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
                                            onClick="cancelData()"
                                            cssClass="btn btn-ali-reset btn-sm"
                                            />                          
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="efnextbtn"
                                            onclick="nextDivEdit('div1')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div id="etabtwo" hidden="true">
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
                                              name="currentBoxedit" id="currentBoxedit" list="currentListedit"									 
                                              ondblclick="torightedit()" style="height:160px;"/>

                                </div>
                                <div class="col-sm-2 text-center">
                                    <div class="row" style="height: 20px;"></div>
                                    <div class="row">
                                        <sj:a
                                            id="rightedit" 
                                            onClick="torightedit()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="rightalledit" 
                                            onClick="torightalledit()" 
                                            button="true"
                                            style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="leftedit" 
                                            onClick="toleftedit()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="leftalledit" 
                                            onClick="toleftalledit()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <label>Blocked Currency</label>
                                    <s:select cssClass="form-control" multiple="true"
                                              name="newBoxedit" id="newBoxeditcur" list="newListedit"									 
                                              ondblclick="toleftedit()" style="height:160px;" />
                                </div>
                            </div>

                            <div style="display: none; visibility: hidden;">
                                <s:url var="assignurledit" action="AssignCurrencyUpdateMerchantCustomer" />
                                <sj:submit button="true" href="%{assignurledit}" id="assignbutedit"  />

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
                                            id="efbackbtn"
                                            onclick="backDivEdit('div2')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                        <sj:submit
                                            button="true"
                                            value="Next"
                                            href="%{inserturl}"
                                            id="esnextbtn"
                                            onclick="nextDivEdit('div2')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                    </div>


                                </div>
                            </div>
                        </div>

                        <!-- =========================================================================== Tab 3 (Transaction Type)==========================================================           -->

                        <div id="etabfour" hidden="true">
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
                                              name="currentBoxTranedit" id="currentBoxTranedit" list="CurrentListTranedit"									 
                                              ondblclick="torightTranedit()" style="height:160px;"/>

                                </div>
                                <div class="col-sm-2 text-center">
                                    <div class="row" style="height: 20px;"></div>
                                    <div class="row">
                                        <sj:a
                                            id="rightTranedit" 
                                            onClick="torightTranedit()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> > </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="rightallTranedit" 
                                            onClick="torightallTranedit()" 
                                            button="true"
                                            style="font-size: 10px;width:60px;margin:4px;"> >> </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="leftTranedit" 
                                            onClick="toleftTranedit()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> < </sj:a>
                                        </div>
                                        <div class="row">
                                        <sj:a
                                            id="leftallTranedit" 
                                            onClick="toleftallTranedit()" 
                                            button="true"
                                            style="font-size:10px;width:60px;margin:4px;"> << </sj:a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <label>Blocked Transaction(s)</label>
                                    <s:select cssClass="form-control" multiple="true"
                                              name="newBoxTranedit" id="newBoxedit" list="NewListTranedit"									 
                                              ondblclick="toleftTranedit()" style="height:160px;" />
                                </div>
                            </div>

                            <div style="display: none; visibility: hidden;">
                                <s:url var="assignurlTranedit" action="AssignTranUpdateMerchantCustomer" />
                                <sj:submit button="true" href="%{assignurlTranedit}" id="assignbutTranedit"
                                           />
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
                                            id="esbackbtn"
                                            onclick="backDivEdit('div4')"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                        
                                        <s:url action="UpdateMerchantCustomer" var="updateturl"/>
                                        <sj:submit
                                            button="true"
                                            value="Update"
                                            href="%{updateturl}"
                                            targets="amessageedit"
                                            id="updatebutetabonedit"
                                            onclick="assignAll()"
                                            cssClass="btn btn-ali-submit btn-sm"
                                            />                      
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

