<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
int menuId=31;
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>���Ʋ��Է���---���</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	ConstraGrep user=null;
	int i=0;
	try{
		user=new ConstraGrep();
	    String city_type=request.getParameter("citycodea");
	    String grouptype=request.getParameter("group_type");
	    String goupname=request.getParameter("goupname");
	    String loginname=request.getParameter("loginname_add");
	    String school=request.getParameter("school_type");
	    String osid=request.getParameter("osid_id");
	    String accessid=request.getParameter("accessid_id");
	    i = user.add(city_type,loginname,goupname,userInfo.get("login").toString(),school,grouptype,"31");
	
		String msg = "";		
		if(i==1){
			msg = "�����ɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ��ú������鲻���ڣ�";
		}else if (i==-6){
            msg="ʧ�ܣ�һ��ѧУֻ�ܴ���һ��Default�����һ���������飡";
		}else if (i==-800){
            msg="ʧ�ܣ���ѡѧУ��Ӧ���������ظ�������������";
        }else{
			msg="�����������Ժ����ԣ�";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
		window.parent.location="conStra_grep.jsp?city_type=<%=city_type%>"+"&school=<%=school%>"+"&grouptype=<%=grouptype%>";
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