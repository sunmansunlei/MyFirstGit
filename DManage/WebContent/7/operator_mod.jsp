<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=61;
%>
<%@ include file="checkauth.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language=JavaScript src="operator.js"></script>
		<link rel="stylesheet" type="text/css" href="adsl.css">
		<title>����Աά��---�޸�</title>
	</head>

	<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
	<%
		User user = new User(userInfo);
		int i=0;
		try{
			String login=request.getParameter("login");
			String password=request.getParameter("password");
			int group=Integer.parseInt(request.getParameter("group"));
			int state=Integer.parseInt(request.getParameter("state"));
			i = user.modUser(login,password,group,state);
			
		}catch(Exception e){
			i=0;
			e.printStackTrace();
		}finally{
			user.close();
		}
		
		String msg=null;
		int ref=0;
		switch(i){
			case 1:
				msg="�޸Ĳ���Ա�ɹ���";
				ref=1;
				break;
			case -1:
				msg="����Ա�����ڣ�";
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
		window.parent.location="operator.jsp";
	}
	</script>
	</body>
</html>