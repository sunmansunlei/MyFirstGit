<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.sun.entity.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	Hashtable userInfo=(Hashtable)session.getAttribute("userInfo");
	if (userInfo==null){
%>
<script language="JavaScript">
alert("���ӳ�ʱ�������µ�½��");
top.document.location="./";
</script>
<%
	return;
}
	String mainTitle="�Ĵ�����У԰������������ƽ̨";
    int leftMenuWidth=178;
%>
