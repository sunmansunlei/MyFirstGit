<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=32;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>���Ʋ�������---ɾ��</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	ConStraCfg user=null;
	int i=0;	
	String startTime = "",endTime = "";
    try{
        startTime = request.getParameter("starttime");
        endTime = request.getParameter("endtime");
    }catch(Exception e){
        startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
        endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
    }
	 System.out.println(startTime+"&"+endTime);
	try{
		
		user = new ConStraCfg();
		String id = request.getParameter("id");
	  	i = user.del(id,userInfo.get("login").toString(),"32");
	    	    
	    String msg = "";		
		if(i==1){
			msg = "ɾ���ɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ����Ʋ������ò����ڣ�";
		}else if(i==-6){
			msg = "ʧ�ܣ��ò����ѷ���������ɾ����";
		}else{
			msg="�����������Ժ����ԣ�";
		}
		
%>
<script language="JavaScript">
	alert("<%=msg%>");
    window.parent.location="conStra_cfg.jsp?starttime=<%=startTime%>"+"&endtime=<%=endTime%>";
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