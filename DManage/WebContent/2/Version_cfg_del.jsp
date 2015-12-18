<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=12;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>版本配置---删除</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	VersionCfg user = null;
	int i=0;
	
	try{
		user = new VersionCfg();
		String id = request.getParameter("id");
	    String osid = request.getParameter("osid");
	    String accessid = request.getParameter("accessid");
	    String stdver = request.getParameter("stdver");
	  	i = user.del(id,userInfo.get("login").toString(),"12");
	  	
		String msg = null;
		if(i==1){
			msg = "删除成功！";
		}else if(i==-1){
			msg="失败！配置不存在！";
		}else if(i==-6){
			msg = "失败！该策略已经发布，不能删除。";
		}else{
			msg="发生错误，请稍后再试！";
		}

%>
<script language="JavaScript">
	alert("<%=msg%>");
    window.parent.location="version_cfg.jsp?osid=<%=osid%>"+"&accessid=<%=accessid%>"+"&stdver=<%=stdver%>";
</script>
<%
    }catch(Exception e){
        i=0;
    }finally{
    	user.close();
    }
%>
</body>
</html>