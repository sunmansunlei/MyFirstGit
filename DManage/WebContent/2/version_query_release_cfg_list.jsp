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
    VersionCR user = null;
    String citycodes = "",school="",grouptype="",osid_id="",accessid_id="";
    
    try{	
    	
    	pageNum = Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
		para = request.getParameter("para");
		        
        osid_id = request.getParameter("osid");
        //System.out.println("-------osid_id-----  "+osid_id);
        
        accessid_id = request.getParameter("accessid");
       //System.out.println("-------accessid_id-----  "+accessid_id);
		
	}catch(Exception e){
		pageNum = 1;		
	}
    
    try{
        
    	user = new VersionCR();
        
        Vector qlists = user.getVerInfo(osid_id,accessid_id);
        Vector qlist = Tools.splitVector(qlists,pageSize,pageNum);
        para="grouptype="+grouptype+"&osid="+osid_id+"&accessid="+accessid_id;

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>客户端版本信息</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });


        var types=-1;
        function type1(myForm,i){
            if (types==i) return;
            types=i;
            var retur=document.forms[myForm].elements['cfg'+i].value;
			//alert(retur);
            if(confirm("确定选择该客户端版本?")) {
                parent.parent.parent.window.returnValue=retur;
                parent.parent.parent.window.close();
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
	    <td class="title">选择</td>
	    <td class="title">系统版本</td>
	    <td class="title">客户端类型</td>
	    <td class="title">标准版本号</td>
	    <td class="title">子版本号</td>
	    <td class="title">版本号简记</td>	    
	</tr>
	
    <form  method="post" target="actions" name="userlist">
<%
    for (int i=0;i<qlist.size();i++){
        Hashtable ht = (Hashtable)qlists.elementAt(i);
        String str_cfgid = (String)ht.get("id");
        String str_stdver = (String)ht.get("stdver");        
        String str_childver = (String)ht.get("childver");
        String str_vername = (String)ht.get("vername");
        String str_osname = (String)ht.get("osname");
        String str_accessname = (String)ht.get("accessname");
%>

    <tr bgcolor="#ffffff" >
        <td align="center" class="block" height="30"><input onclick="type1('userlist',<%=i%>)" type="radio" name="order" value="<%=str_cfgid%>"></td>  
        <input type="hidden" name="cfg<%=i%>" value="<%=str_cfgid%>">                
        <td align="center" class="block" height="30"><%=str_osname%></td>
        <td align="center" class="block" height="30"><%=str_accessname%></td>
        <td align="center" class="block" height="30"><%=str_stdver%></td>
        <td align="center" class="block" height="30"><%=str_childver%></td>
        <td align="center" class="block" height="30"><%=str_vername%></td>       
    </tr>

<%
    }
%>
    </form>
<tr bgcolor="#CCCCCC">
    <td  class="b9" colspan="7" height="20">
        <table width="100%" height="12">
            <tr>
                <td class="b9" align="left" valign="middle" >总记录:<%= qlists.size()%> 条</td>
                <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(qlists.size(),pageSize, pageNum,"version_query_release_cfg_list.jsp"+"?"+para+"&")%></td>
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
