<%@page contentType="text/html;charset=GBK" session="true"%>
<%@ page isErrorPage="true" %>
<%
String errorMessage=null;
String myError="发生错误，请稍后再试！";
try{
	System.out.println(exception);
      errorMessage=exception.getMessage();
	if ("time_out".equals(errorMessage)){
		myError="连接超时！";
	}else if ("error_auth".equals(errorMessage)){
		myError="没有权限！";
	}else if ("error_load".equals(errorMessage)){
		myError="非法调用！";
	}else{
		exception.printStackTrace();
	}
}catch(Exception e){
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
alert("<%=myError%>");
</script>
<title>错误</title>
</head>
<body leftmargin="10" marginwidth="10" topmargin="10" marginheight="10">
</body>
</html>