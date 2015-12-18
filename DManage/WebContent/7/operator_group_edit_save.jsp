<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
int menuId=62;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>操作员组管理</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
int i=0;
int id=Integer.parseInt(request.getParameter("id"));

String name=request.getParameter("name");
String[] acl=request.getParameterValues("acl");


User user=new User(userInfo);
try{
	i=user.modGroup(id,name,acl);
}catch(Exception e){
	i=0;
}finally{
	user.close();
}
String msg=null;
int ref=0;
switch(i){
	case 1:
		msg="修改操作员组成功！";
		ref=1;
		break;
	case -1:
		msg="操作员组已存在！";
		ref=0;
		break;
	case -2:
		msg="操作员组不存在！";
		ref=0;
		break;
	default:
		msg="发生错误，请稍后再试！";
		ref=0;
}
%>
<script language="JavaScript">
alert("<%=msg%>");
if(1==<%=ref%>){
    window.parent.parent.document.location="operator_grep.jsp";
}
</script>
</body>
</html>
