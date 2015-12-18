<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "14";
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>版本回退</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	VersionCR user = null;
	int i=0;
	
	try{		
		
		user = new VersionCR();
		String rollbackid = request.getParameter("rollbackid");	
		String groupid = request.getParameter("groupid");	
		//System.out.println("------------groupid------- "+groupid);
        String starttime = request.getParameter("starttime");
        String endtime = request.getParameter("endtime");
	  	i = user.delToRelease(rollbackid,groupid,userInfo.get("login").toString(),"14");
		
		String msg = null;
		if(i==1){
			msg = "归档成功！";
		}else if(i==-3){
			msg="失败！策略组现已经存在一条发布策略，不能回退。";
		}else{
			msg="发生错误，请稍后再试！";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="version_rollback.jsp?starttime=<%=starttime%>&endtime=<%=endtime%>";
	</script>
<%
    }catch(Exception e){
     	e.printStackTrace();
    }finally{
    	user.close();
    }
%>
</body>
</html>