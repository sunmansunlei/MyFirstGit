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
		<title>��Ϣ����</title>
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
			msg = "��ӳɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ��Ѿ�����һ����ͬ����Ϣ��";
		}else if(i==-2){
			msg="ʧ�ܣ�ͬһС��ֻ�ܷ���һ����Ϣ��";
		}else{
			msg="�����������Ժ����ԣ�";
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