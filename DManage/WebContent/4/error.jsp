<%@page contentType="text/html;charset=GBK" session="true"%>
<%@ page isErrorPage="true" %>
<%
String errorMessage=null;
String myError="�����������Ժ����ԣ�";
try{
	System.out.println(exception);
      errorMessage=exception.getMessage();
	if ("time_out".equals(errorMessage)){
		myError="���ӳ�ʱ��";
	}else if ("error_auth".equals(errorMessage)){
		myError="û��Ȩ�ޣ�";
	}else if ("error_load".equals(errorMessage)){
		myError="�Ƿ����ã�";
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
<title>����</title>
</head>
<body leftmargin="10" marginwidth="10" topmargin="10" marginheight="10">
</body>
</html>