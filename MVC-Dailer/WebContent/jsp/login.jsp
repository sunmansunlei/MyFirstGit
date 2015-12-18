<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery-1.8.0.min.js"></script>  
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js"></script>    
<script type='text/javascript' src='<%=request.getContextPath()%>/js/login.js'></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/css.css" />


<meta http-equiv="Content-Type" content="text/html; charset=UF-8">
<title>四川电信校园网拨号器管理平台</title>
<style type="text/css">
        .buttons {
            font-size: 12px; #border : 0px dashed;color : #005DA4;
            background-image: url( <%=request.getContextPath()%>/images/dl.jpg) ;
            width: 149px;
            height:33px ;
            padding-top: 3px ;
        }
</style> 
</head>
<body class="login_bg" onkeypress="listenEnter(event,this);" >
<div class="login_left">
    <form   method="post"  id="formId">
        <div class="login_right">
            <div class="login_logo"><img src="<%=request.getContextPath()%>/images/logo.png" alt="" width="255" height="125" /></div>
            <div class="login_margin"></div>
            <div class="login_bg2">
                <div class="login_co">
                    <div class="login_co1"><input name="loginName" id="loginName" class="login_input" type="text" /></div>
                    <div class="login_co1"><input name="password" id="password" class="login_input" type="password" /></div>
                </div>
                <div class="login_co2">
                    
                    <input type="submit" onclick="checkForm();" style="border:none;background: url('<%=request.getContextPath()%>/images/dl.jpg') no-repeat;width:149px;height:33px;" value=""/>
                 
                    <input type="reset" style="border:none;background: url('<%=request.getContextPath()%>/images/cs.jpg') no-repeat;width:149px;height:33px;" value=""/>
					 <h3>${message}</h3>
                </div>
            </div>
            <div class="login_cp"><img src="<%=request.getContextPath()%>/images/mine.png" alt="" width="327"  /></div>
        </div>
    </form>
</div>

</body>
</html>