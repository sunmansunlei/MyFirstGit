<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=34;
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>���Ʋ��Ժ�������ɾ��</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
    ConstraGrep user = null;
	int i=0;
	
	try{
		
		user = new ConstraGrep();
		String id=request.getParameter("id");
	    //String loginname=request.getParameter("loginname");
	    String city_type=request.getParameter("city_type");
	    String grouptype="1";
	    String school=request.getParameter("school");
	  	i = user.del(id,userInfo.get("login").toString(),"34");

		String msg = "";		
		if(i==1){
			msg = "ɾ���ɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ��ú������鲻���ڣ�";
		}else if(i==-6){
			msg = "ʧ�ܣ������в��Է���������ɾ��";
		}else{
			msg="�����������Ժ����ԣ�";
		}
%>
		<script language="JavaScript">
		alert("<%=msg%>");
		    window.parent.location="conStra_redlist.jsp?city_type=<%=city_type%>"+"&school=<%=school%>";
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