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
<title>�汾����---ɾ��</title>
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
			msg = "ɾ���ɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ����ò����ڣ�";
		}else if(i==-6){
			msg = "ʧ�ܣ��ò����Ѿ�����������ɾ����";
		}else{
			msg="�����������Ժ����ԣ�";
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