<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page import="com.jspsmart.upload.*" %>

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
<title>控制策略配置---添加</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
ConStraCfg user=null;
int ii=0;
String msg = null;
try{
	user=new ConStraCfg();
    String usb=request.getParameter("usb");
    String wifi=request.getParameter("wifi");
    String ad=request.getParameter("ad");
    String addl=request.getParameter("addl");
    String conname=request.getParameter("conname");
    String startTime = "";
    String endTime = "";
    try{
        startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
        endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");


    }catch(Exception e){
        startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
        endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
    }
        ii = user.add(conname,userInfo.get("login").toString(), usb, wifi,ad,addl,startTime,endTime);


	if(ii==1){
		msg = "添加成功！";
	}else{
		msg="发生错误，请稍后再试！";
	}
%>
	<script language="JavaScript">
	alert("<%=msg%>");
    window.parent.location="conStra_cfg.jsp?starttime=<%=startTime%>"+"&endtime=<%=endTime%>";
	</script>
<%
    }catch(Exception e){
        e.printStackTrace();
    }finally{
    }
%>
</body>
</html>