<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId = 22;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>消息配置---删除</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	MessageCfg user = null;
	String startTime = "";
	String endTime = "";
	try{
	    startTime = request.getParameter("starttime");
	    endTime = request.getParameter("endtime");
	
	}catch(Exception e){
	    startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
	    endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
	}

	int i=0;
	try{
		
		user = new MessageCfg();
		String id = request.getParameter("id");
	  	i = user.del(id,userInfo.get("login").toString(),"22");
	  	
		String msg = null;
		if(i==1){
			msg = "删除成功！";
		}else if(i==-1){
			msg="失败！配置不存在！";
		}else if(i==-6){
			msg = "失败！该消息已经发布，不能删除。";
		}else{
			msg="发生错误，请稍后再试！";
		}
%>
<script language="JavaScript">
	alert("<%=msg%>");
    window.parent.location = "message_cfg.jsp?starttime=<%=startTime%>" + "&endtime=<%=endTime%>";
</script>
<%
    }catch(Exception e){
        i=0;
        e.printStackTrace();
    }finally{
    	user.close();
    }
%>
</body>
</html>