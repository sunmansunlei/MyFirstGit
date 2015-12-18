<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "13#16";
%>
<%@ include file="./checkauth.jsp"%>
<%
	int pageSize = Integer.parseInt(Tools.getProperty("pagesize","20"));
	int pageNum = 1;
	String para = "";
	String startTime = "";
	String endTime = "";
    VersionCR user = null;
    String groupid = "", state = "",cfgid = "";
    
	try{	
    	
    	pageNum = Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
		para = request.getParameter("para");
		
		groupid = request.getParameter("groupid");
        //System.out.println("-------groupid-----  "+groupid);
        
        state = request.getParameter("state");
        //System.out.println("-------state-----  "+state);
	
        cfgid = request.getParameter("cfgid");
        //System.out.println("-------cfgid-----  "+cfgid);
        
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
    	
    	user = new VersionCR();
        Vector vcs = user.getReleaseList(groupid, cfgid, state, startTime, endTime);
        Vector vc = Tools.splitVector(vcs,pageSize,pageNum);
        para="groupid="+groupid+"&state="+state+"&starttime="+startTime+"&endtime="+endTime+"&cfgid="+cfgid;

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

        function del(i,releaseid,groupid){
        	
        	var a="";

                w_option = "dialogWidth:320px;dialogHeight:200px;help:No;resizable:No;status:No";
                a = window.showModalDialog("version_reason_frame.jsp", 0, w_option);
                if (a == null)  {
                  alert("请先填写归档原因！！");
                    return false;
                }
            	
            if(a!=""){
                if(confirm("确定要执行归档操作么？")){
                	document.forms["mod"+i].action="version_release_del.jsp?releaseid="+releaseid+"&groupid="+groupid+"&reason="+a+"&starttime=<%=startTime%>&endtime=<%=endTime%>";
                    document.forms["mod"+i].submit();
                }
            }
            
        }
        
        function mod(i,releaseid,groupid) {
        	
        	if(confirm("确定激活该策略吗？")){
        		document.forms["mod"+i].action="version_release_valid.jsp?releaseid="+releaseid+"&groupid="+groupid+"&starttime=<%=startTime%>&endtime=<%=endTime%>";
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
	    <td class="title">版本分组名</td>
		<td class="title">所属地区</td>
		<td class="title">所属学校</td>
		<td class="title">分组类型</td>
		<td class="title">系统版本</td>
		<td class="title">客户端类型</td>
		<td class="title">标准版本号</td>
		<td class="title">版本子编号</td>
		<td class="title">创建时间</td>
		<td class="title">操作</td>
		    	   	    
	</tr>

<%
    for (int i=0;i<vc.size();i++){
        Hashtable ht = (Hashtable)vcs.elementAt(i);
        String releaseid = (String)ht.get("id");
        String str_groupid = (String)ht.get("groupid");
        String str_grouptype = (String)ht.get("grouptype");
        String str_gtypename = "";     
        if("0".equals(str_grouptype)){
        	str_gtypename = "Default";
        }else if("1".equals(str_grouptype)){
        	str_gtypename = "红名单组";
        }else if("2".equals(str_grouptype)){
        	str_gtypename = "普通组";
        }
        String str_groupname = (String)ht.get("name");
        String str_osname = (String)ht.get("osname");
        String str_accessname = (String)ht.get("accessname");
        String str_schoolname = (String)ht.get("schoolname");
        String str_cityname = (String)ht.get("cityname");
        String str_stdver = (String)ht.get("stdver");
        String str_childver = (String)ht.get("childver");
        String str_createtime = (String)ht.get("createtime");
        String str_state = (String)ht.get("state");
%>
    <form  method="post" target="actions" name="mod<%=i%>">
    <tr bgcolor="#ffffff" >
        <td align="center" class="block" height="30"><%=releaseid%></td>              
        <td align="center" class="block" height="30"><%=str_groupname%></td>
        <td align="center" class="block" height="30"><%=str_cityname%></td>
        <td align="center" class="block" height="30"><%=str_schoolname%></td>
        <td align="center" class="block" height="30"><%=str_gtypename%></td>
        <td align="center" class="block" height="30"><%=str_osname%></td>
        <td align="center" class="block" height="30"><%=str_accessname%></td>
        <td align="center" class="block" height="30"><%=str_stdver%></td>
        <td align="center" class="block" height="30"><%=str_childver%></td>
        <td align="center" class="block" height="30"><%=str_createtime%></td>
        <td align="center">
            <table width="100%">
                <tr>
                	<%
                	if("0".equals(str_state)){
                	%>
                    <td onclick="mod('<%=i%>','<%=releaseid%>','<%=str_groupid%>')" align="center"><a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">激活</a></td>
                    <% 
                   }
                    %>
                    <td onclick="del('<%=i%>','<%=releaseid%>','<%=str_groupid%>')" align="center"><a id="del" icon="icon-remove"  class="easyui-linkbutton" href="#">发布归档</a></td>
                </tr>
            </table>
        </td>
    </tr>
    </form>
<%
    }
%>

<tr bgcolor="#CCCCCC">
    <td  class="b9" colspan="11" height="20">
        <table width="100%" height="12">
            <tr>
                <td class="b9" align="left" valign="middle" >总记录:<%= vcs.size()%> 条</td>
                <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(vcs.size(),pageSize, pageNum,"version_release.jsp"+"?"+para+"&")%></td>
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
