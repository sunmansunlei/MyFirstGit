<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
    int menuId = 23;
%>
<%@ include file="./checkauth.jsp" %>
<%
	ConStraCR user = null;
	int pageSize = Integer.parseInt(Tools.getProperty("pagesize","15"));
	int pageNum = 1;	
    String para = "",str_school="",str_grouptype="";
    
    try{	
    	
    	pageNum = Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
		para = request.getParameter("para");		
		
		str_school = request.getParameter("school_type");
        //System.out.println("----str_school--- "+str_school);
                
        str_grouptype = request.getParameter("grouptype");
        //System.out.println("----str_grouptype--- "+str_grouptype);
        		
	}catch(Exception e){
		pageNum = 1;		
	}

    try {

    	user = new ConStraCR();    
        Vector cfgcon = user.getConInfo();
        Vector grepInfos = user.getConGroup(str_school, str_grouptype);
        Vector grepInfo = Tools.splitVector(grepInfos,pageSize,pageNum);
        para="school_type="+str_school+"&grouptype="+str_grouptype; 
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>消息策略配置</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.easyui-linkbutton').linkbutton();
        });

		function add(i,groupid) {
        	
			var vconid = document.forms["add"+i].elements['conid'].options[document.forms["add"+i].elements['conid'].selectedIndex].value;
			if(vconid==""){
                alert("请选择控制策略进行配置！");
                return false;
            }
			
			if(!confirm("确定新增策略吗？")){
                return;
            }
        	document.forms["add"+i].action="conStra_release_add_ok.jsp?conid="+vconid+"&groupid="+groupid+"&school_type=<%=str_school%>&grouptype=<%=str_grouptype%>";
            document.forms["add"+i].submit();
        }

    </script>
    <style type="text/css">
        .blue_24_b {
            color: #005dc6;
            font-weight: bold;
            font-size: 24px;
            font: 'Microsoft YaHei', '华文细黑', '宋体', sans-serif;
            line-height: 160%;
        }

        .center {
            text-align: center;
        }
    </style>
</head>

<body style="padding-top: 10px">

<table width="90%" align="center" border="0" cellpadding="0" cellspacing="1" class="tableform">

    <tr>
        <td class="title">分组名</td>
	    <td class="title">所属地区</td>
	    <td class="title">所属学校</td>
	    <td class="title">分组类型</td>
		<td class="title">选择控制策略</td>
        <td class="title">操作</td>
    </tr>
    
	<%
	    for (int i=0;i<grepInfo.size();i++){
	        Hashtable ht = (Hashtable)grepInfos.elementAt(i);
	        String str_groupid = (String)ht.get("id");
	        String str_grouptype2 = (String)ht.get("grouptype");
	        String str_gtypename = "";
	        
	        if("0".equals(str_grouptype2)){
	        	str_gtypename = "Default";
	        }else if("1".equals(str_grouptype2)){
	        	str_gtypename = "红名单组";
	        }else if("2".equals(str_grouptype2)){
	        	str_gtypename = "普通组";
	        }
	        
	        String str_groupname = (String)ht.get("groupname");
	        String str_schoolname = (String)ht.get("schoolname");
	        String str_cityname = (String)ht.get("cityname");
	%>  
	 <form method="post" target="actions" name="add<%=i%>">  
        <tr bgcolor="#ffffff">          
	        <td align="center" class="block" height="30"><%=str_groupname%></td>
	        <td align="center" class="block" height="30"><%=str_cityname%></td>
	        <td align="center" class="block" height="30"><%=str_schoolname%></td>
	        <td align="center" class="block" height="30"><%=str_gtypename%></td>
			
			<td  align="center" class="block" height="30">
	            <select name="conid" class="table_normal">
                    <%
                        for (int j = 0; j < cfgcon.size(); j++) {
                            Hashtable ht2 = (Hashtable) cfgcon.elementAt(j);
                            int con_id = Integer.parseInt((String) ht2.get("id"));
                            String con_name = (String) ht2.get("conname");
                            out.println("<option class='b9' value="+con_id+">" + con_name);
                        }
                    %>
	            </select>
        	</td>
            <td align="center" onclick="add(<%=i%>,'<%=str_groupid%>')"><a id="add" icon="icon-add" class="easyui-linkbutton" href="#">添加</a></td>          
        </tr>
     </form>
<%
    }
%>
    
    <tr bgcolor="#CCCCCC">
    <td  class="b9" colspan="6" height="20">
        <table width="100%" height="12">
            <tr>
                <td class="b9" align="left" valign="middle" >总记录:<%= grepInfos.size()%> 条</td>
                <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(grepInfos.size(),pageSize, pageNum,"conStra_release_add.jsp"+"?"+para+"&")%></td>
            </tr>
        </table>
    </td>
</tr>
</table>

<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
</body>
</html>
<%
    }catch(Exception ex){
    	ex.printStackTrace();
    }finally {
        user.close();
    }
%>