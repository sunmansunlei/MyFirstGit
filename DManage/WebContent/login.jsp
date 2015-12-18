<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@page import="java.util.*"%>
<html>
<head>
    <title>四川电信校园网拨号器管理平台</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/css.css" />
    <style type="text/css">
        .buttons {
            font-size: 12px; #border : 0px dashed;color : #005DA4;
            background-image: url( <%=request.getContextPath()%>/images/dl.jpg) ;
            width: 149px;
            height:33px ;
            padding-top: 3px ;
        }
    </style> 
    <script  src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    
</head>
<script type="text/javascript">


	$(window).load(function() {
	  
	});


    function checkForm(){
    	 
    	
        if (document.forms[0].elements["login"].value==""){
            alert("请输入登录名！！");
            document.forms[0].elements["login"].focus();
            return false;
        }
        
        
        
        document.forms[0].submit();
        return true;
    }
    
    
    function checkFormTwo(){
    		 
    	 var login = $("#login").val();

         var passwd =  $("#passwd").val();
 
		if(login==""){
			 alert("请输入登录名！！");
			 $("#login").focus();
			 return false;
		}else{ 
			 
			$('#formid').attr("action", 'login/login!checkLogin');   
			$('#formid').submit();
		}
    	 
    }
    
    function rest() {
        document.forms[0].reset();
    }
</script>
<body class="login_bg">
<div class="login_left">
    <form   method="post"  id="formid">
        <div class="login_right">
            <div class="login_logo"><img src="<%=request.getContextPath()%>/images/logo.png" alt="" width="255" height="125" /></div>
            <div class="login_margin"></div>
            <div class="login_bg2">
                <div class="login_co">
                    <div class="login_co1"><input name="login" id="login" class="login_input" type="text" /></div>
                    <div class="login_co1"><input name="passwd" id="passwd" class="login_input" type="password" /></div>
                </div>
                <div class="login_co2">
                    
                    <input type="submit" onclick="checkFormTwo();" style="border:none;background: url('<%=request.getContextPath()%>/images/dl.jpg') no-repeat;width:149px;height:33px;" value=""/>
                 
                    <input type="reset" style="border:none;background: url('<%=request.getContextPath()%>/images/cs.jpg') no-repeat;width:149px;height:33px;" value=""/>
					 <% 
					   String msg = (String)request.getAttribute("msg"); 
					   if(msg!=null) {
					     
					   %> 
					   <h3><%=msg %></h3>

					   <% } %>
                </div>
            </div>
            <div class="login_cp"><img src="<%=request.getContextPath()%>/images/mine.png" alt="" width="327"  /></div>
        </div>
    </form>
</div>
</body>
</html>