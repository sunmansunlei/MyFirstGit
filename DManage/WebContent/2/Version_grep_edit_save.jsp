<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "11";
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>版本分组---编辑</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
VersionGrep user=null;
int i=0;
try{
	user=new VersionGrep();
	String id=request.getParameter("id");
    String city_type=request.getParameter("city_type");
    String grouptype=request.getParameter("group_type");
    String oldgrouptype=request.getParameter("oldgrouptype");
    String goupname=request.getParameter("goupname");
    String loginname=request.getParameter("loginname");
    String school=request.getParameter("school_type");
    String osid=request.getParameter("osid_id");
    String accessid=request.getParameter("accessid_id");

  	i=user.edit(city_type,loginname,oldgrouptype,goupname,userInfo.get("login").toString(),school,grouptype,osid,accessid,id,"11");

  	String msg = "";		
	if(i==1){
		msg = "修改成功！";
	}else if(i==-1){
		msg="失败！版本分组不存在！";
	}else if (i==-800){
        msg="失败！所选学校+系统版本+客户端类型组名不能重复，不能修改。";
    }else if (i==-6){
		msg="失败！所选系统版本+客户端类型下已有红名单组或 Default组，不能修改。";
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