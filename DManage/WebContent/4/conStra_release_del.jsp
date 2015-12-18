<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "35";
%>
<%@ include file="./checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>删除</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
	ConStraCR user = null;
	int i=0;
	
	try{		
		
		user = new ConStraCR();
		String releaseid = request.getParameter("releaseid");
        String  str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);

        String grouptype=request.getParameter("grouptype");
		//System.out.println("-------releaseid------- "+releaseid);
        
        String starttime=request.getParameter("starttime");
        String endtime=request.getParameter("endtime");
	  	i = user.del(releaseid,userInfo.get("login").toString(),"35");
		
		String msg = null;
		if(i==1){
			msg = "删除成功！";
		}else if(i==-1){
			msg="控制策略不存在！";
		}else{
			msg="发生错误，请稍后再试！";
		}
%>
	<script language="JavaScript">
		alert("<%=msg%>");
	    window.parent.location="conStra_release.jsp?school_type=<%=str_school%>&grouptype=<%=grouptype%>&endtime=<%=endtime%>&starttime=<%=starttime%>";
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