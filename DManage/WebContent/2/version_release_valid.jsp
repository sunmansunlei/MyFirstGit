<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "13#16";
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>���Լ���</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	VersionCR user = null;
	int i=0;
	
	try{	
		
		user = new VersionCR();
		String releaseid = request.getParameter("releaseid");	
		String groupid = request.getParameter("groupid");	
		System.out.println(groupid);
	  	i = user.mod(releaseid,userInfo.get("login").toString(),"13");
		String endtime=request.getParameter("endtime");
        String starttime=request.getParameter("starttime");
		String msg = null;
		if(i==1){
			msg = "����ɹ���";
		}else if(i==-1){
			msg="�汾���鲻���ڣ�";
		}else{
			msg="�����������Ժ����ԣ�";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="version_release.jsp?starttime=<%=starttime%>&endtime=<%=endtime%>";
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