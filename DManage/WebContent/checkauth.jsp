<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="java.util.*"%>
<%@page import="com.sun.entity.*"%>
<%@page import="com.sun.util.*"%>
<%
Hashtable userInfo=(Hashtable)session.getValue("userInfo");
if ((userInfo==null) ||(!Tools.fromMySite(request))){
	throw new Exception("time_out");
}
String ACL=(String)userInfo.get("ACL");
StringTokenizer st = new StringTokenizer(ACL,"#");
int menuACLCount=0;
while (st.hasMoreTokens()) {
	if (ACL.indexOf("#"+st.nextToken()+"#")!=-1){
		menuACLCount=1;
		break;
	}
}
if (menuACLCount==0){
	throw new Exception("error_auth");
}
%>