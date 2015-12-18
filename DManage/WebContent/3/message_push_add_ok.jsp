<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=23;
%>
<%@ include file="checkauth.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language=JavaScript src="operator.js"></script>
		<link rel="stylesheet" type="text/css" href="adsl.css">
		<title>消息发布</title>
	</head>
	
	<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
	<%
	
	MessageCR user = null;
	int i=0;
	
	try{
		
		user = new MessageCR();    
	    String msgid =request.getParameter("msgid");
	    //System.out.println("----cfgid--- "+cfgid);
	    
	    String groupid =request.getParameter("groupid");
	    //System.out.println("----groupid--- "+groupid);
        String  str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);
        String msgsendtype = request.getParameter("msgsendtype");
        //System.out.println("----str_msgsendtype--- "+str_msgsendtype);

        String  msgtype = request.getParameter("msgtype");
        String grouptype=request.getParameter("grouptype");

	    i = user.addMsgPush(msgid,groupid,userInfo.get("login").toString(),"23");
		
		String msg = null;
		if(i==1){
			msg = "添加成功！";
		}else if(i==-1){
			msg="失败！已经存在一条相同的消息。";
		}else if(i==-2){
			msg="失败！同一小组只能发布一条消息。";
		}else{
			msg="发生错误，请稍后再试！";
		}
	%>
		<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="message_push_add.jsp?school_type=<%=str_school%>&grouptype=<%=grouptype%>&msgtype=<%=msgtype%>&msgsendtype=<%=msgsendtype%>";
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