<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String login=request.getParameter("login");	
	String passwd=request.getParameter("passwd");
	if ((login==null) ){
		response.sendRedirect("login.jsp");
		return;
	}
	int status = -1;
	Hashtable userInfo = null;
	User user = new User(null);
	
	try{
		
		userInfo = user.checkLogin(login,passwd);	
		status = Integer.parseInt((String)userInfo.get("status"));
		
	}catch(Exception e){
	  e.printStackTrace();
		status=-1;
	}finally{
		user.close();
	}
	if (status==-1){
%>
<script language="javascript">
alert("请输入正确的用户名/密码！");
</script>
<%@include file="login.jsp"%>
<%
}else{

		boolean first = (application.getAttribute("first")==null);
		String serverID = (String)application.getAttribute("serverid");
		if(serverID==null){
			serverID = Tools.getProperty("serverid","adsl");
			application.setAttribute("serverid",serverID);
		}
		session.setAttribute("userInfo",userInfo);

		application.setAttribute("first","first");
		response.sendRedirect("menu.jsp");
}
%>