<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=65;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>����Ա����</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	User user = new User(userInfo);
	int i = 0;
	
	try{
		String name=request.getParameter("name");
		String login=request.getParameter("login");
		String password=request.getParameter("password");
		int group=Integer.parseInt(request.getParameter("group"));
		int state=Integer.parseInt(request.getParameter("state"));
		i = user.addUser(name,login,password,group,state);
	}catch(Exception e){
		i=0;
	}finally{
		user.close();
	}
	
	String msg = "";
	int ref=0;
	switch(i){
		case 1:
			msg="��������Ա�ɹ���";
			ref=1;
			break;
		case -1:
			msg="����Ա�Ѿ����ڣ�";
			ref=0;
			break;
		default:
			msg="�����������Ժ����ԣ�";
			ref=0;
	}
%>
<script language="JavaScript">
	alert("<%=msg%>");
	if(1==<%=ref%>){
		window.parent.location="operator_add.jsp";
	}
</script>
</body>
</html>