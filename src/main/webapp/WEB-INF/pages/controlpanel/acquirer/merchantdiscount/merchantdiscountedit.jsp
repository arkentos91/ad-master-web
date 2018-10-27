 
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

            function editMCC(keyval) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/FindMCC.action',
                    data: {mcccode: keyval},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#amessageedit').empty();
                        var msg = data.message;
                        if (msg) {
                            $('#mcccodeedit').val("");
                            $('#mcccodeedit').attr('readOnly', false);
                            $('#mcccodeedit').val("");
                            $('#descriptionedit').val("");
                            
                            $('#statusedit').val("");
                            $('#amessageedit').text("");
                           
                            $('#updatebutetabonedit').button("disable");
                        } else {
                            $('#mcccodeedit').val(data.mcccode);
                            $('#mcccodeedit').attr('readOnly', true);
                            $('#descriptionedit').val(data.description);
                            $('#statusedit').val(data.status);
                            
                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }

            function cancelData() {
                var mcccode = $('#mcccodeedit').val();
                editMCC(mcccode);
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
                    <s:form id="mccedit" method="post" action="MCC" theme="simple" cssClass="form" enctype="multipart/form-data">

                        <div id="etabone" >

                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>Merchant Customer Category</label>
                                        <s:textfield readonly="true" value="%{mcccode}" cssClass="form-control" name="mcccode" id="mcccodeedit" maxLength="15" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Merchant Customer Name</label>
                                        <s:textfield value="%{description}" cssClass="form-control" name="description" id="descriptionedit" maxLength="50" onkeyup="$(this).val($(this).val().replace(/[^a-zA-Z ]/g,''))" onmouseout="$(this).val($(this).val().replace(/[^a-zA-Z ]/g,''))" onkeypress="return alpha(event)"/>
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
                                    name="reset" 
                                    cssClass="btn btn-ali-reset btn-sm"
                                    onClickTopics="resetAddButton"
                                    />                          
                                <s:url action="UpdateMCC" var="updateturl"/>
                                <sj:submit
                                    button="true"
                                    value="Update"
                                    href="%{updateturl}"
                                    targets="amessageedit"
                                    id="updateButtonedit"
                                    cssClass="btn btn-ali-submit btn-sm"
                                    />   
                            </div>                       
                        </div>
                    </div>
                        </div>
                        </s:form>
                </div>
            </div>
        </div>
    </body>
</html>

