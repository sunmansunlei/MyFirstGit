<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "25";
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>ɾ��</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	MessageCR user = null;
	int i=0;
	
	try{		
		
		user = new MessageCR();
		String pushid = request.getParameter("pushid");
        String  str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);

        String  startTime = request.getParameter("starttime");
        //System.out.println("----startTime--- "+startTime);

        String  endTime = request.getParameter("endtime");
	  	i = user.del(pushid,userInfo.get("login").toString(),"25");
		
		String msg = null;
		if(i==1){
			msg = "ɾ���ɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ��汾���鲻���ڣ�";
		}else{
			msg="�����������Ժ����ԣ�";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="message_push.jsp?school_type=<%=str_school%>&starttime=<%=startTime%>&endtime=<%=endTime%>";
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