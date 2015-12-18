<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "34";
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>修改红名单组用户</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	ConstraGrep user = null;
	int i=0;
	
	try{		
		
		user = new ConstraGrep();
		String id=request.getParameter("id");
	    String loginname=request.getParameter("loginname");
        String city_type=request.getParameter("city_type");
        //String grouptype = request.getParameter("grouptype");
        String school = request.getParameter("school");
        
	  	i = user.modUser(id,userInfo.get("login").toString(),loginname,"34");
		
		String msg = null;
		if(i==1){
			msg = "编辑成功！";
		}else if(i==-1){
			msg="控制策略分组下面没有用户不存在！";
		}else{
			msg="发生错误，请稍后再试！";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
        window.parent.location="conStra_redlist.jsp?city_type=<%=city_type%>"+"&school=<%=school%>";
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