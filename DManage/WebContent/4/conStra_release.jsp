<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "35";
%>
<%@ include file="./checkauth.jsp"%>
<%
	int pageSize = Integer.parseInt(Tools.getProperty("pagesize","15"));
	int pageNum = 1;
	String startTime = "";
	String endTime = "";
	ConStraCR user = null;
    String para = "",str_school="",str_grouptype="";
    String msgnames=request.getParameter("msgname");
	try{	
    	
		pageNum = Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
		para = request.getParameter("para");		
		
		str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);
                
        str_grouptype = request.getParameter("grouptype");
        //System.out.println("----str_grouptype--- "+str_grouptype);
               
        startTime = request.getParameter("starttime");
		endTime = request.getParameter("endtime");
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

    	user = new ConStraCR();
        Vector vcs = user.getConstraList(str_school, str_grouptype, startTime, endTime,msgnames);
        Vector vc = Tools.splitVector(vcs,pageSize,pageNum);
        para="school_type="+str_school+"&grouptype="+str_grouptype+"&starttime="+startTime+"&endtime="+endTime+"&msgname="+msgnames;

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>控制策略发布信息</title>
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
        	
        	if(confirm("确定删除该控制策略吗？")){
        		document.forms["mod"+i].action="conStra_release_del.jsp?releaseid="+releaseid+"&school_type=<%=str_school%>&grouptype=<%=str_grouptype%>&starttime=<%=startTime%>&endtime=<%=endTime%>";
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
	    <td class="title">分组</td>
		<td class="title">所属地区</td>
		<td class="title">所属学校</td>
		<td class="title">分组类型</td>
		<td class="title">控制策略</td>
		<td class="title">usb开关</td>
		<td class="title">wifi开关</td>
		<td class="title">广告开关</td>
		<td class="title">广告插件下载开关</td>
		<td class="title">策略失效时间</td>
		<td class="title">发布时间</td>		
		<td class="title">操作</td>		    	   	    
	</tr>
    
<%
    for (int i=0;i<vc.size();i++){
        Hashtable ht = (Hashtable)vcs.elementAt(i);
        String releaseid = (String)ht.get("id");
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
        
        String str_conname = (String)ht.get("conname");
        
        String usb = "";
        if("0".equals((String)ht.get("usb"))){
        	usb="禁用";
        }else if("1".equals((String)ht.get("usb"))){
        	usb="可用";
        }
        
        String wifi = "";
        if("0".equals((String)ht.get("wifi"))){
        	wifi="禁用";
        }else if("1".equals((String)ht.get("wifi"))){
        	wifi="可用";
        }
        
        String ad = "";
        if("0".equals((String)ht.get("ad"))){
        	ad="禁用";
        }else if("1".equals((String)ht.get("ad"))){
        	ad="可用";
        }
        
        String addl = "";
        if("0".equals((String)ht.get("cservice"))){
        	addl="禁用";
        }else if("1".equals((String)ht.get("cservice"))){
        	addl="可用";
        }
        
        String str_createtime = (String)ht.get("createtime");
        String str_endtime = (String)ht.get("endtime");
%>
<form  method="post" target="actions" name="mod<%=i%>">
    <tr bgcolor="#ffffff" >
        <td align="center" class="block" height="30"><input type="checkbox" name="order" value="<%=releaseid%>"><%=releaseid%></td>
        <td align="center" class="block" height="30"><%=str_groupname%></td>
        <td align="center" class="block" height="30"><%=str_cityname%></td>
        <td align="center" class="block" height="30"><%=str_schoolname%></td>
        <td align="center" class="block" height="30"><%=str_gtypename%></td>       
        <td align="center" class="block" height="30"><%=str_conname%></td>
        
        <td align="center" class="block" height="30"><%=usb%></td>
        <td align="center" class="block" height="30"><%=wifi%></td>
         <td align="center" class="block" height="30"><%=ad%></td>
         <td align="center" class="block" height="30"><%=addl%></td>
         
        <td align="center" class="block" height="30"><%=str_endtime%></td>
        <td align="center" class="block" height="30"><%=str_createtime%></td>
        <td align="center">
            <table width="100%">
                <tr>
                    <td onclick="del(<%=i%>,'<%=releaseid%>')" align="center"><a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">删除</a></td>
                </tr>
            </table>
        </td>
    </tr>

<%
    }
%>
    </form>
<tr bgcolor="#CCCCCC">
    <td  class="b9" colspan="13" height="20">
        <table width="100%" height="12">
            <tr>
                <td class="b9" align="left" valign="middle" >总记录:<%= vcs.size()%> 条</td>
                <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(vcs.size(),pageSize, pageNum,"conStra_release.jsp"+"?"+para+"&")%></td>
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

