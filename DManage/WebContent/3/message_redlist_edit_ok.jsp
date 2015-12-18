<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=24;
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>红名单消息分组修改</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
    MessageGrep user = null;
	int i=0;
	
	try {
		user = new MessageGrep();
		
		String id = request.getParameter("id");
	    String city_type = request.getParameter("city_type");
	    String goupname = request.getParameter("goupname");
	    //String loginname = request.getParameter("loginname");
	    String school = request.getParameter("school_type");
	    
	  	i = user.editRedList(city_type,goupname,userInfo.get("login").toString(),school,id,"24");
	  	
		String msg = "";		
		if(i==1){
			msg = "修改成功！";
		}else if(i==-1){
			msg="失败！该红名单组不存在！";
		}else if (i==-6){
			msg="失败！所选学校已有红名单组，修改失败！";
		}else{
			msg="发生错误，请稍后再试！";
		}
%>
<script language="JavaScript">
	alert("<%=msg%>");
	window.parent.location="message_redlist.jsp?city_type=<%=city_type%>"+"&school=<%=school%>";
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