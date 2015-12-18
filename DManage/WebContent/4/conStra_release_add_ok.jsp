<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=33;
%>
<%@ include file="checkauth.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language=JavaScript src="operator.js"></script>
		<link rel="stylesheet" type="text/css" href="adsl.css">
		<title>控制策略发布</title>
	</head>
	
	<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
	<%
	
	ConStraCR user = null;
	int i=0;
	
	try{
		
		user = new ConStraCR();    
	    String conid = request.getParameter("conid");
	    //System.out.println("----cfgid--- "+cfgid);
	    
	    String groupid =request.getParameter("groupid");
	    //System.out.println("----groupid--- "+groupid);
        String  str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);

        String grouptype=request.getParameter("grouptype");
	    i = user.addConStra(conid,groupid,userInfo.get("login").toString(),"33");
		
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
        window.parent.location="conStra_release_add.jsp?school_type=<%=str_school%>&grouptype=<%=grouptype%>";
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