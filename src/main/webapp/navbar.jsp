<div class="row">
    <div class="col-sm-12">
        <ol class="breadcrumb">
            <li class="active">


                <h> ${CURRENTSECTION}</h> 
                <% if (session.getAttribute("CURRENTSECTION") != null && !session.getAttribute("CURRENTSECTION").equals("")) 
                {%>
                &nbsp;<b>&raquo;</b>&nbsp;

                <% }%>
                <h>${CURRENTPAGE}</h>


            </li>				
        </ol>
<!--        <div class="page-header">
            <small>${CURRENTPAGE}</small>
        </div>-->
    </div>
</div>