<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=16;
%>
<%@ include file="checkauth.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language=JavaScript src="operator.js"></script>
		<link rel="stylesheet" type="text/css" href="adsl.css">
		<title>版本发布</title>
	</head>
	
	<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
	<%
	
	VersionCR user = null;
	int i=0;
	
	try{
		
		user = new VersionCR();    
	    String cfgid =request.getParameter("cfgid");
	    //System.out.println("----cfgid--- "+cfgid);
	    
	    String groupid =request.getParameter("groupid");
	    //System.out.println("----groupid--- "+groupid);
	     String school_type=request.getParameter("school_type");

        String  osid = request.getParameter("osid");
        //System.out.println("----str_osid--- "+str_osid);

        String accessid = request.getParameter("accessid");
	    i = user.addRelease(cfgid,groupid,userInfo.get("login").toString(),"16");
		
		String msg = null;
		if(i==1){
			msg = "添加成功！";
		}else if(i==-1){
			msg="失败！已经存在一条相同的策略。";
		}else if(i==-2){
			msg="失败！同一小组只能发布一条策略。";
		}else{
			msg="发生错误，请稍后再试！";
		}
	%>
		<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="version_release_add.jsp?school_type=<%=school_type%>&accessid=<%=accessid%>&osid=<%=osid%>";
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