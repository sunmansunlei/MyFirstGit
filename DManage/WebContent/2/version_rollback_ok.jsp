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
<title>�汾����</title>
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
			msg = "�鵵�ɹ���";
		}else if(i==-3){
			msg="ʧ�ܣ����������Ѿ�����һ���������ԣ����ܻ��ˡ�";
		}else{
			msg="�����������Ժ����ԣ�";
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