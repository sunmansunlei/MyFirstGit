<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "11";
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>版本分组删用户</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	VersionGrep user = null;
	int i=0;
	
	try{		
		user = new VersionGrep();
		String id=request.getParameter("ids");
	    String loginname = request.getParameter("loginname");
	    String city_type = request.getParameter("city_type");
        String grouptype = request.getParameter("group_type");
        String school = request.getParameter("school");
        String groupid = request.getParameter("id");
	  	i = user.delUser(id,userInfo.get("login").toString(),groupid, "11");
		
		String msg = null;
		if(i==1){
			msg = "删除成功！";
		}else if(i==-1){
			msg="失败！版本分组下面无用户！";
		}else if(i==-9){
            msg="失败！普通组或者红名单组必须有用户存在！";
        }else{
			msg="发生错误，请稍后再试！";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="version_grep.jsp?city_type=<%=city_type%>"+"&school=<%=school%>"+"&grouptype=<%=grouptype%>";
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