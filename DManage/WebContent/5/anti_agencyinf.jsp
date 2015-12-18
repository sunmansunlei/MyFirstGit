<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=41;
%>
<%@ include file="./checkauth.jsp"%>
<%
	int pageSize=Integer.parseInt(Tools.getProperty("pagesize","20"));
	int pageNum=1;
	String para = null;
	String startTime="";
	String endTime="";
	
	try{
		pageNum = Integer.parseInt(request.getParameter("page"));
		para = request.getParameter("para");
		startTime = request.getParameter("starttime");
		endTime = request.getParameter("endtime");
	}catch(Exception e){
		pageNum = 1;
		startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
		endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
	}

	
	Query sq = new Query();
	
	try{
		
		Vector agentLogs = sq.getAgencyLog(startTime,endTime);
		Vector agentLog = Tools.splitVector(agentLogs,pageSize,pageNum);
	
	//给下页传参数
	para="starttime="+startTime+"&endtime="+endTime;

%>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
	<title></title>
	</head>
	
	<body style="padding:10px;">
	<center>
	<table style="width:100%;">
	
	</table>
	
	        <table style="width:100%;">
	          <tr>
	
	<td>
	              <table class="tableform" border="0" cellpadding="4" cellspacing="1"  style="width:100%;">
	                <tr > 
	                  <td  class="title" >代理类型</td>
	                  <td  class="title" >代理名称</td>
	                  <td  class="title" >标签</td>
	                  <td class="title" >上报时间</td>	                  
	                </tr>
	
	<%
	for (int i=0;i<agentLog.size();i++){
		Hashtable ht=(Hashtable)agentLog.elementAt(i);
		String agenttype = (String)ht.get("agenttype");
		String agentname = (String)ht.get("agentname");
		String agenticon = (String)ht.get("agenticon");
		String opetime = (String)ht.get("opetime");
	%> 
	                <tr>
	                  <td ><%=agenttype%></td>
	                  <td   ><%=agentname%></td>
	                  <td  ><%=agenticon%></td>
	                  <td  ><%=opetime%></td>
	                </tr>
	                <%
	}
	%> 
	                <tr >
	                <td  colspan="4">
	                <table  style="width:100%;">
	                <tr>
	                <td  >
	                总条数:<%=agentLogs.size()%>条
	                </td>
	                <td>
	                第<%=Tools.getPageString(agentLogs.size(),pageSize,pageNum,"anti_agencyinf.jsp?"+para+"&")%>页
	                </td>
	                </tr>
	                </table>
	                </td>
	                </tr>
	              </table>
	</td>
	</tr>
	</table>
	
	
	</center>
	</body>
</html>
<%
}catch(Exception e){
	e.printStackTrace();
}finally{
	sq.close();
}
%>