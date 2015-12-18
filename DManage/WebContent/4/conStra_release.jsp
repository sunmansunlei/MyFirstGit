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
    <title>���Ʋ��Է�����Ϣ</title>
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
        	
        	if(confirm("ȷ��ɾ���ÿ��Ʋ�����")){
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
            font:'Microsoft YaHei','����ϸ��','����',sans-serif;
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
		<td class="title">���</td>
	    <td class="title">����</td>
		<td class="title">��������</td>
		<td class="title">����ѧУ</td>
		<td class="title">��������</td>
		<td class="title">���Ʋ���</td>
		<td class="title">usb����</td>
		<td class="title">wifi����</td>
		<td class="title">��濪��</td>
		<td class="title">��������ؿ���</td>
		<td class="title">����ʧЧʱ��</td>
		<td class="title">����ʱ��</td>		
		<td class="title">����</td>		    	   	    
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
        	str_gtypename = "��������";
        }else if("2".equals(grouptype)){
        	str_gtypename = "��ͨ��";
        }
        
        String str_groupname = (String)ht.get("groupname");
        String str_schoolname = (String)ht.get("schoolname");
        String str_cityname = (String)ht.get("cityname");
        
        String str_conname = (String)ht.get("conname");
        
        String usb = "";
        if("0".equals((String)ht.get("usb"))){
        	usb="����";
        }else if("1".equals((String)ht.get("usb"))){
        	usb="����";
        }
        
        String wifi = "";
        if("0".equals((String)ht.get("wifi"))){
        	wifi="����";
        }else if("1".equals((String)ht.get("wifi"))){
        	wifi="����";
        }
        
        String ad = "";
        if("0".equals((String)ht.get("ad"))){
        	ad="����";
        }else if("1".equals((String)ht.get("ad"))){
        	ad="����";
        }
        
        String addl = "";
        if("0".equals((String)ht.get("cservice"))){
        	addl="����";
        }else if("1".equals((String)ht.get("cservice"))){
        	addl="����";
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
                    <td onclick="del(<%=i%>,'<%=releaseid%>')" align="center"><a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">ɾ��</a></td>
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
                <td class="b9" align="left" valign="middle" >�ܼ�¼:<%= vcs.size()%> ��</td>
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

