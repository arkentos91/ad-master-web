<%-- 
    Document   : merchantview
    Created on : Sep 9, 2016, 8:06:30 PM
    Author     : dilanka_w
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="resouces/css/common/common_popup.css">
        <link rel="stylesheet" href="resouces/css/cropper.css"/>
        <link rel="stylesheet" href="resouces/css/main_1.css"/>
        <script src="resouces/js/cropper.js"></script>
        <script src="resouces/js/mmv.js"></script>
        <title>View Merchant More Details </title>
        <style>
            .kycImageview{
                margin-left: 45px;
                margin-top: 28px;
                border: 1px solid gray;
                width: 327px;
                height: 327px;
                padding: 0;
                box-shadow: 0 0 1px black;
            }
        </style>
        <script>
            var idtmp = '<s:property value="identityCopyImg"/>';
            var idbacktmp = '<s:property value="identityCopyBackImg"/>';
            var selfietmp = '<s:property value="selfieImg"/>';

            if (idtmp == "") {
                $('#identityCopy').attr('src', 'resouces/images/emptyImg.png');
            }
            if (idbacktmp == "") {
                $('#idCopyBack').attr('src', 'resouces/images/emptyImg.png');
            }
            if (selfietmp == "") {
                $('#userImage').attr('src', 'resouces/images/emptyImg.png');
            }

            var identityCopyImg;
            var identityCopyBackImg;
            var selfieImg;

            function ImgZoom() {

                var merchantcode = $('#midView').val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/getImageSRCMerchantMgt.action',
                    data: {merchantcode: merchantcode},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        identityCopyImg = data.identityCopyImg;
                        identityCopyBackImg = data.identityCopyBackImg;
                        selfieImg = data.selfieImg;
                    },
                    error: function (data) {
                        console.log("error");
                    }
                });
            }
            ;
            ImgZoom();

            function Load(id, img) {

                var options = {
                    aspectRatio: 16 / 9,
                    data: {
                        x: 640,
                        y: 60,
                        width: 640,
                        height: 360
                    },
                    autoCropArea: 0.6, // Center 60%
                    dragCrop: false,
                    modal: false,
                    autoCrop: false
                };
                $(id).cropper("destroy");
                $(id).attr('src', "data:image/jpeg;base64," + img);
                $(id).cropper(options).on({
                    "build.cropper": function (e) {
                        console.log("s" + e.type);
                    },
                    "built.cropper": function (e) {
                        console.log(e.type);
                    }
                });
            }

            function includes(container, value) {

                var returnValue = false;
                var pos = container.indexOf(value);
                if (pos >= 0) {
                    returnValue = true;
                }
                return returnValue;
            }

            function identityCopyImgZoom(src) {

                var merchantcode = $('#midView').val();

                $.ajax({
                    url: '${pageContext.request.contextPath}/getImageSRCMerchantMgt.action',
                    data: {merchantcode: merchantcode},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divDivmsg').empty();
                        var msg = data.message;

                        if (msg) {

                        } else {

                            if (src == "data:image/jpeg;base64," || includes(src, "resouces/images/")) {

                            } else {
                                $("#idCopyDialog").dialog({
                                    title: "Identity Copy Image",
                                    modal: true,
                                    dialogClass: "dialogclass",
                                    height: 450,
                                    minWidth: 450
                                });
                                $('#identityCopyView').attr('src', "data:image/jpeg;base64," + data.identityCopyImg);
                            }

                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });


            }

            function idCopyBackImgZoom(src) {

                var merchantcode = $('#midView').val();

                $.ajax({
                    url: '${pageContext.request.contextPath}/getImageSRCMerchantMgt.action',
                    data: {merchantcode: merchantcode},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divDivmsg').empty();
                        var msg = data.message;

                        if (msg) {

                        } else {

                            if (src == "data:image/jpeg;base64," || includes(src, "resouces/images/")) {

                            } else {
                                $("#idCopyBackDialog").dialog({
                                    title: "Identity Copy Back",
                                    modal: true,
                                    dialogClass: "dialogclass",
                                    height: 450,
                                    minWidth: 450
                                });

                                $('#idCopyBackView').attr('src', "data:image/jpeg;base64," + data.identityCopyBackImg);
                            }

                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });


            }

            function selfieImgZoom(src) {

                var merchantcode = $('#midView').val();

                $.ajax({
                    url: '${pageContext.request.contextPath}/getImageSRCMerchantMgt.action',
                    data: {merchantcode: merchantcode},
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        $('#divDivmsg').empty();
                        var msg = data.message;

                        if (msg) {

                        } else {

                            if (src == "data:image/jpeg;base64," || includes(src, "resouces/images/")) {

                            } else {
                                $("#selfieDialog").dialog({
                                    title: "Selfie Image",
                                    modal: true,
                                    dialogClass: "dialogclass",
                                    height: 450,
                                    minWidth: 450
                                });

                                $('#selfieView').attr('src', "data:image/jpeg;base64," + data.selfieImg);
                            }


                        }
                    },
                    error: function (data) {
                        window.location = "${pageContext.request.contextPath}/LogoutUserLogin.action?";
                    }
                });
            }
        </script>
    </head>
    <body>
        <s:hidden id="midView" name="merchantcode" ></s:hidden>
            <div class="space10"></div>
            <div class="row row_popup">
                <h6>Identity Type : <s:property value="identityType"/></h6>
        </div>
        <div class="space10"></div>
        <div class="row row_popup">
            <div class="horizontal_line_popup"></div>
        </div>
        <div class="space15"></div>
        <div class="row row_popup">

            <div class="col-sm-4 text-center">
                <div class="row">
                    <label>ID Copy Image</label>
                </div>
                <div class="row">
                    <img onclick="identityCopyImgZoom(this.src);
                            Load('#identityCopyView', identityCopyImg);" class="image_merchant" src="data:image/jpeg;base64,<s:property value="identityCopyImg"/>" id="identityCopy" name="identityCopy">
                </div>
            </div>

            <div class="col-sm-4 text-center"> 
                <div class="row">
                    <label>ID Back Image</label>
                </div>
                <div class="row">
                    <img onclick="idCopyBackImgZoom(this.src);
                            Load('#idCopyBackView', identityCopyBackImg);" class="image_merchant" src="data:image/jpeg;base64,<s:property value="identityCopyBackImg"/>" id="idCopyBack">  
                </div>
            </div>

            <div class="col-sm-4 text-center"> 
                <div class="row">
                    <label>User Image</label>
                </div>
                <div class="row">
                    <img onclick="selfieImgZoom(this.src);
                            Load('#selfieView', selfieImg);" class="image_merchant"  src="data:image/jpeg;base64,<s:property value="selfieImg"/>" id="userImage" >
                </div>
            </div>
        </div>
    </body>

    <!--    <div id="idCopyDialog" hidden="true">   
            <img id="identityCopyView" src="data:image/jpeg;base64,<s:property value="identityCopyImg"/>" style="width:400px;height:400px;" alt="Identity Copy">
        </div>
        <div id="idCopyBackDialog" hidden="true">
            <img id="idCopyBackView" src="data:image/jpeg;base64,<s:property value="identityCopyBackImg"/>" style="width:400px;height:400px;" alt="Identity Copy Back">
        </div>
        <div id="selfieDialog" hidden="true">
            <img id="selfieView" src="data:image/jpeg;base64,<s:property value="selfieImg"/>" style="width:400px;height:400px;" alt="Selfie Image">
        </div>-->
    <div id="idCopyDialog" hidden="true" class="text-center">

        <div class="container docs-overview">
            <div class="row">
                <div class="col-md-9 col-md-offset-1 kycImageview">
                    <div class="img-container"><img id="identityCopyView" src="data:image/jpeg;base64,<s:property value="identityCopyImg"/>" alt="User Image" ></div>
                    <div class="docs-toolbar">
                        <div class="btn-group">
                            <button class="btn btn-default btn-sm" id="identityCopyView_zoom_in" type="button" title="Zoom In">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Zoom In">
                                    <span class="glyphicon glyphicon-zoom-in"></span>
                                </span>
                            </button>
                            <button class="btn btn-warning btn-sm" id="identityCopyView_zoom_out" type="button" title="Zoom Out" style="border-right: 2px solid white">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Zoom Out">
                                    <span class="glyphicon glyphicon-zoom-out"></span>
                                </span>
                            </button>
                            <button class="btn btn-warning btn-sm" id="identityCopyView_rotate_left" type="button" title="Rotate Left">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Rotate Left">
                                    <span class="glyphicon glyphicon-share-alt docs-flip-horizontal"></span>
                                </span>
                            </button>
                            <button class="btn btn-default btn-sm" id="identityCopyView_rotate_right" type="button" title="Rotate Right">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Rotate Right">
                                    <span class="glyphicon glyphicon-share-alt"></span>
                                </span>
                            </button>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="idCopyBackDialog" hidden="true" class="text-center">   
        <div class="container docs-overview">
            <div class="row">
                <div class="col-md-9 col-md-offset-1 kycImageview">
                    <div class="img-container"><img id="idCopyBackView" src="data:image/jpeg;base64,<s:property value="identityCopyBackImg"/>" alt="User Image" ></div>
                    <div class="docs-toolbar">
                        <div class="btn-group">
                            <button class="btn btn-default btn-sm" id="idCopyBackView_zoom_in" type="button" title="Zoom In">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Zoom In">
                                    <span class="glyphicon glyphicon-zoom-in"></span>
                                </span>
                            </button>
                            <button class="btn btn-warning btn-sm" id="idCopyBackView_zoom_out" type="button" title="Zoom Out" style="border-right: 2px solid white">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Zoom Out">
                                    <span class="glyphicon glyphicon-zoom-out"></span>
                                </span>
                            </button>
                            <button class="btn btn-warning btn-sm" id="idCopyBackView_rotate_left" type="button" title="Rotate Left">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Rotate Left">
                                    <span class="glyphicon glyphicon-share-alt docs-flip-horizontal"></span>
                                </span>
                            </button>
                            <button class="btn btn-default btn-sm" id="idCopyBackView_rotate_right" type="button" title="Rotate Right">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Rotate Right">
                                    <span class="glyphicon glyphicon-share-alt"></span>
                                </span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="selfieDialog" hidden="true" class="text-center">
        <div class="container docs-overview">
            <div class="row">
                <div class="col-md-9 col-md-offset-1 kycImageview">
                    <div class="img-container"><img id="selfieView" src="data:image/jpeg;base64,<s:property value="selfieImg"/>" alt="User Image" ></div>
                    <div class="docs-toolbar">
                        <div class="btn-group">
                            <button class="btn btn-default btn-sm" id="selfieView_zoom_in" type="button" title="Zoom In">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Zoom In">
                                    <span class="glyphicon glyphicon-zoom-in"></span>
                                </span>
                            </button>
                            <button class="btn btn-warning btn-sm" id="selfieView_zoom_out" type="button" title="Zoom Out" style="border-right: 2px solid white">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Zoom Out">
                                    <span class="glyphicon glyphicon-zoom-out"></span>
                                </span>
                            </button>
                            <button class="btn btn-warning btn-sm" id="selfieView_rotate_left" type="button" title="Rotate Left">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Rotate Left">
                                    <span class="glyphicon glyphicon-share-alt docs-flip-horizontal"></span>
                                </span>
                            </button>
                            <button class="btn btn-default btn-sm" id="selfieView_rotate_right" type="button" title="Rotate Right">
                                <span class="docs-tooltip" data-toggle="tooltip" title="Rotate Right">
                                    <span class="glyphicon glyphicon-share-alt"></span>
                                </span>
                            </button>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</html>
