<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId = 22;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>��Ϣ����---ɾ��</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	MessageCfg user = null;
	String startTime = "";
	String endTime = "";
	try{
	    startTime = request.getParameter("starttime");
	    endTime = request.getParameter("endtime");
	
	}catch(Exception e){
	    startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
	    endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
	}

	int i=0;
	try{
		
		user = new MessageCfg();
		String id = request.getParameter("id");
	  	i = user.del(id,userInfo.get("login").toString(),"22");
	  	
		String msg = null;
		if(i==1){
			msg = "ɾ���ɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ����ò����ڣ�";
		}else if(i==-6){
			msg = "ʧ�ܣ�����Ϣ�Ѿ�����������ɾ����";
		}else{
			msg="�����������Ժ����ԣ�";
		}
%>
<script language="JavaScript">
	alert("<%=msg%>");
    window.parent.location = "message_cfg.jsp?starttime=<%=startTime%>" + "&endtime=<%=endTime%>";
</script>
<%
    }catch(Exception e){
        i=0;
        e.printStackTrace();
    }finally{
    	user.close();
    }
%>
</body>
</html>