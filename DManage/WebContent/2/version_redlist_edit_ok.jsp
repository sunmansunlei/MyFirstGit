<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId = 15;
%>
<%@ include file="./checkauth.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language=JavaScript src="operator.js"></script>
		<link rel="stylesheet" type="text/css" href="adsl.css">
		<title>���������޸�</title>	
	</head>
	
	<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
	<%
	
	VersionGrep user = null;
	int i=0;
	
	try{
		
		user = new VersionGrep();
		String id = request.getParameter("id");
		//System.out.println("---------id--------- "+id);
		
	    String city_type = request.getParameter("city_type");
	    //System.out.println("---------city_type--------- "+city_type);
	    
	    String grouptype = request.getParameter("group_type");
	    //System.out.println("---------grouptype--------- "+grouptype);
	    
	    String goupname = request.getParameter("goupname");
	    //System.out.println("---------goupname--------- "+goupname);
	    
	    //String loginname = request.getParameter("loginname");
	    //System.out.println("---------loginname--------- "+loginname);
	    
	    String school = request.getParameter("school_type");
	    //System.out.println("---------school--------- "+school);
	    
	    String osid = request.getParameter("osid_id");
	    //System.out.println("---------osid--------- "+osid);
	    
	    String accessid = request.getParameter("accessid_id");
	    //System.out.println("---------accessid--------- "+accessid);
	    
	    String goupid = request.getParameter("goupid");
	    //System.out.println("---------goupid--------- "+goupid);
	    
	  	i = user.editRedlist(goupid,city_type,goupname,userInfo.get("login").toString(),school,osid,accessid,id,"15");
	  	
		String msg = "";		
		if(i==1){
			msg = "�޸ĳɹ���";
		}else if(i==-1){
			msg="ʧ�ܣ��������鲻���ڣ�";
		}else if (i==-6){
			msg="ʧ�ܣ���ѡϵͳ�汾+�ͻ������������к������飬�����޸ġ�";
		}else{
			msg="�����������Ժ����ԣ�";
		}
		
	%>
	<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="version_redlist.jsp?city_type=<%=city_type%>"+"&school=<%=school%>";
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