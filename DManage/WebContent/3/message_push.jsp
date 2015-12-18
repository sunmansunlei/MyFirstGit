<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=25;
%>
<%@ include file="./checkauth.jsp"%>
<%
	int pageSize = Integer.parseInt(Tools.getProperty("pagesize","15"));
	int pageNum = 1;
	String startTime = "";
	String endTime = "";
	MessageCR user = null;
    String para = "",str_school="",str_grouptype="",str_msgsendtype = "",str_msgtype="";
    String msgnames=request.getParameter("msgname");
	try{	
    	
		pageNum = Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
		para = request.getParameter("para");		
		
		str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);
                
        str_grouptype = request.getParameter("grouptype");
        //System.out.println("----str_grouptype--- "+str_grouptype);
        
        str_msgsendtype = request.getParameter("msgsendtype");
        //System.out.println("----str_msgsendtype--- "+str_msgsendtype);
        
        str_msgtype = request.getParameter("msgtype");
        //System.out.println("----str_msgtype--- "+str_msgtype);
        
        startTime = request.getParameter("starttime");
        //System.out.println("----startTime--- "+startTime);
        
		endTime = request.getParameter("endtime");
		//System.out.println("----endTime--- "+endTime);
		
		if(startTime==null && endTime==null){
            startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
            endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
        }
		
	}catch(Exception e){
		pageNum = 1;		
		startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
		endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
	}
    
    try{

    	user = new MessageCR();
        Vector vcs = user.getMsgPushList(str_school, str_grouptype, str_msgsendtype, str_msgtype, startTime, endTime,msgnames);
        Vector vc = Tools.splitVector(vcs,pageSize,pageNum);
        para="school_type="+str_school+"&grouptype="+str_grouptype+"&msgsendtype="+str_msgsendtype+"&msgtype="+str_msgtype+"&starttime="+startTime+"&endtime="+endTime+"&msgname="+msgnames;

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>版本发布信息</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });
        
        function del(i,releaseid) {
        	
        	if(confirm("确定删除该消息推送吗？")){
        		document.forms["mod"+i].action="message_push_del.jsp?pushid="+releaseid+"&school_type=<%=str_school%>&starttime=<%=startTime%>&endtime=<%=endTime%>";
                document.forms["mod"+i].submit();
            }else{
            	return;
            }
        	
        }


    </script>
    <style type="text/css">
        .blue_24_b {
            color:#005dc6;
            font-weight:bold;
            font-size:24px;
            font:'Microsoft YaHei','华文细黑','宋体',sans-serif;
            line-height:160%;
        }
        .center {
            text-align:center;
        }
    </style>
</head>

<body style="padding-left: 5px;padding-top: 5px">

<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="tableform">

	<tr>
		<td class="title">编号</td>
	    <td class="title">分组名</td>
		<td class="title">所属地区</td>
		<td class="title">所属学校</td>
		<td class="title">分组类型</td>
		<td class="title">消息名</td>
		<td class="title">消息内容类型</td>
		<td class="title">消息弹出类型</td>
		<td class="title">消息失效时间</td>
		<td class="title">策略创建时间</td>		
		<td class="title">操作</td>		    	   	    
	</tr>
    
<%
    for (int i=0;i<vc.size();i++){
        Hashtable ht = (Hashtable)vcs.elementAt(i);
        String pushid = (String)ht.get("id");
        //String str_groupid = (String)ht.get("groupid");
        String grouptype = (String)ht.get("grouptype");
        String str_gtypename = "";     
        if("0".equals(grouptype)){
        	str_gtypename = "Default";
        }else if("1".equals(grouptype)){
        	str_gtypename = "红名单组";
        }else if("2".equals(grouptype)){
        	str_gtypename = "普通组";
        }
        
        String str_groupname = (String)ht.get("groupname");
        String str_schoolname = (String)ht.get("schoolname");
        String str_cityname = (String)ht.get("cityname");
        String str_msgname = (String)ht.get("msgname");
        
        String msgsendtype = "";
        if("1".equals((String)ht.get("msgsendtype"))){
        	msgsendtype="tips";
        }else if("2".equals((String)ht.get("msgsendtype"))){
        	msgsendtype="message";
        }
        
        String msgtype = "";
        if("1".equals((String)ht.get("msgtype"))){
        	msgtype="URL";
        }else if("2".equals((String)ht.get("msgtype"))){
        	msgtype="图片";
        }else if("3".equals((String)ht.get("msgtype"))){
        	msgtype="文字";
        }
        
        String str_createtime = (String)ht.get("createtime");
        String str_endtime = (String)ht.get("endtime");
%>
<form  method="post" target="actions" name="mod<%=i%>">
    <tr bgcolor="#ffffff" >
        <td align="center" class="block" height="30"> <input type="checkbox" name="order" value="<%=pushid%>"><%=pushid%></td>
        <td align="center" class="block" height="30"><%=str_groupname%></td>
        <td align="center" class="block" height="30"><%=str_cityname%></td>
        <td align="center" class="block" height="30"><%=str_schoolname%></td>
        <td align="center" class="block" height="30"><%=str_gtypename%></td>
        
        <td align="center" class="block" height="30"><%=str_msgname%></td>
        
        <td align="center" class="block" height="30"><%=msgtype%></td>
        <td align="center" class="block" height="30"><%=msgsendtype%></td>
        <td align="center" class="block" height="30"><%=str_endtime%></td>
        <td align="center" class="block" height="30"><%=str_createtime%></td>
        <td align="center">
            <table width="100%">
                <tr>
                    <td onclick="del(<%=i%>,'<%=pushid%>')" align="center"><a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">删除</a></td>
                </tr>
            </table>
        </td>
    </tr>

<%
    }
%>
    </form>
<tr bgcolor="#CCCCCC">
    <td  class="b9" colspan="11" height="20">
        <table width="100%" height="12">
            <tr>
                <td class="b9" align="left" valign="middle" >总记录:<%= vcs.size()%> 条</td>
                <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(vcs.size(),pageSize, pageNum,"message_push.jsp"+"?"+para+"&")%></td>
            </tr>
        </table>
    </td>
</tr>
</table>

<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
</body>
</html>
<%
    }finally{
    	user.close();
    }
%>