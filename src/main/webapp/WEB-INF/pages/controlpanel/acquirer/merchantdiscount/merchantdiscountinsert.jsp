<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Merchant Customer Category</title>

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

            
            function resetAllDataAdd() {

                $('#mcccode').val("");
                $('#mcccode').attr('readOnly', false);
                $('#description').val("");
                $('#status').val(""); 
                $('#amessage').text(""); 
               

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
                    <s:div id="divmsgadd">
                        <s:actionerror theme="jquery"/>
                        <s:actionmessage theme="jquery"/>
                    </s:div>
                    <s:form id="mccadd" method="post" action="" theme="simple" cssClass="form" enctype="multipart/form-data">

                        <div id="tone" >

                            <div class="row row_popup">
                                <div class="horizontal_line_popup"></div>
                            </div>
                            <div class="row row_popup">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Merchant Customer Category</label>
                                        <s:textfield value="%{mcccode}" cssClass="form-control" name="mcccode" id="mcccode" maxLength="4" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onmouseout="$(this).val($(this).val().replace(/[^0-9]/g, ''))" onkeypress="return alpha(event)"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <span style="color: red">*</span><label >Description</label>
                                        <s:textfield value="%{description}" cssClass="form-control" name="description" id="description" maxLength="40" onkeypress="return alpha(event)"/>
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
                                        name="reset" 
                                        cssClass="btn btn-ali-reset btn-sm"
                                        onClickTopics="resetAddButton"
                                        />                          
                                    <s:url action="AddMCC" var="inserturl"/>
                                    <sj:submit
                                        button="true"
                                        value="Add"
                                        href="%{inserturl}"
                                        onClickTopics=""
                                        targets="divmsgadd"
                                        id="addbtn"
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
