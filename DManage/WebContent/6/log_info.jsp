<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=51;
%>
<%@ include file="./checkauth.jsp"%>
<%
	int pageSize = Integer.parseInt(Tools.getProperty("pagesize","20"));
	int pageNum = 1;
	String para = null;
	String startTime = "";
	String endTime = "";
	String menuid = "";
	
	menuid = request.getParameter("menuid");
	
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
		
		Vector optLogs = sq.getOptLog(menuid,startTime,endTime);
		Vector optLog = Tools.splitVector(optLogs,pageSize,pageNum);
	
	//给下页传参数
	para="starttime="+startTime+"&endtime="+endTime+"&menuid="+menuid;

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
	                  <td  class="title" >功能菜单名</td>
	                  <td  class="title" >操作表</td>
	                  <td  class="title" >操作员</td>
	                  <td class="title" >操作时间</td>	
	                  <td class="title" >操作记录</td>	                        
	                </tr>
	
					<%
					for (int i=0;i<optLog.size();i++){
						Hashtable ht = (Hashtable)optLog.elementAt(i);
						String menuname = (String)ht.get("menuname");
						String tablename = (String)ht.get("tablename");
						String modifier = (String)ht.get("modifier");
						String modifytime = (String)ht.get("modifytime");
						String events = (String)ht.get("events");
					%> 
	                <tr>
	                  <td ><%=menuname%></td>
	                  <td ><%=tablename%></td>
	                  <td ><%=modifier%></td>
	                  <td ><%=modifytime%></td>
	                  <td ><%=events%></td>
	                </tr>
	                <%
					}
					%> 
	                <tr>
	                	<td  colspan="5">
		                	<table  style="width:100%;">
			                	<tr>
					                <td>总条数:<%=optLogs.size()%>条</td>
					                <td>第<%=Tools.getPageString(optLogs.size(),pageSize,pageNum,"log_info.jsp?"+para+"&")%>页 </td>
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