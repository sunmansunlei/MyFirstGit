<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.sun.entity.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	Hashtable userInfo=(Hashtable)session.getAttribute("userInfo");
	if (userInfo==null){
%>
<script language="JavaScript">
alert("连接超时！请重新登陆！");
top.document.location="./";
</script>
<%
	return;
}
	String mainTitle="四川电信校园网拨号器管理平台";
    int leftMenuWidth=178;
%>
