<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
int menuId=21;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>消息分组---编辑</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
    MessageGrep user = null;
	int i=0;
	try{
		
		user=new MessageGrep();
		String id=request.getParameter("id");
	    String city_type=request.getParameter("city_type");
	    String grouptype=request.getParameter("group_type");
        String oldgrouptype=request.getParameter("oldgrouptype");
        String goupname=request.getParameter("goupname");
        String loginname=request.getParameter("loginname");
	    String school=request.getParameter("school_type");
	    String osid=request.getParameter("osid_id");
	    String accessid=request.getParameter("accessid_id");
	  	i=user.edit(city_type,loginname,oldgrouptype,goupname,userInfo.get("login").toString(),school,grouptype,id,"21");
		
		String msg = "";		
		if(i==1){
			msg = "修改消息分组成功！";
		}else if(i==-1){
			msg="失败！消息分组不存在！";
		}else if (i==-6){
			msg="失败！一个学校只能创建一个Default组或者一个红名单组。";
		}else if (i==-800){
            msg="失败！所选学校对应组名不能重复，不能修改。";
        }else{
			msg="发生错误，请稍后再试！";
		}
%>
	<script language="JavaScript">
	alert("<%=msg%>");
	window.parent.location="message_grep.jsp?city_type=<%=city_type%>"+"&school=<%=school%>"+"&grouptype=<%=grouptype%>";	
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